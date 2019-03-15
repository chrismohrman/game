--- Map service
-- Store and decode maps as needed

local Entity = require 'src/services/entity'
local GameState = require 'src/services/game-state'
local Input = require 'src/services/input'
local Love = require 'src/services/love'
local Tmx = require 'src/services/tmx'
local Util = require 'src/services/util'
local Camera = require 'src/services/camera'

local CallOnBeginContact = require 'src/systems/call-on-begin-contact'
local CallOnEndContact = require 'src/systems/call-on-end-contact'
local CallOnDeath = require 'src/systems/call-on-death'
local CallOnPreContact = require 'src/systems/call-on-pre-contact'
local CallOnPostContact = require 'src/systems/call-on-post-contact'
local DrawEntity = require 'src/systems/draw-entity'

-- Creates table of map filenames as keys
-- and their contents as parsed tables:
local get_map_tables = function(map_directory, map_file_ext)
  local map_tables = {}
  local file_list = Love.filesystem.getDirectoryItems(map_directory)
  for _, file_name in ipairs(file_list) do
    local file_ext = string.sub(file_name, -string.len(map_file_ext))
    -- Only keep files matching the tiled file extension
    if file_ext == map_file_ext then
      -- ie., "src/maps/general.tmx"
      local file_path = map_directory .. '/' .. file_name
      -- ie., "general" for "general.tmx"
      local file_name_without_ext = file_name:match('(.+)%..+')
      local file_content = Love.filesystem.read(file_path)
      local parsed_content = Tmx.parse(file_name, file_content)
      map_tables[file_name_without_ext] = parsed_content
    end
  end

  return map_tables
end

local active_map
local map_directory = 'src/maps'
local map_file_ext = '.tmx'
local maps = get_map_tables(map_directory, map_file_ext)

local draw_tiles = function(layer, map)
  for i, tile in ipairs(layer.data) do
    -- Skip unset tiles
    if tile ~= 0 then
      local _, _, _, texture_height = map.quads[tile].quad:getViewport()
      local tile_pos_x = map.tile_width * ((i - 1) % map.columns)
      local tile_pos_y = map.tile_height * math.floor((i - 1) / map.columns)
      Love.graphics.draw(
        map.quads[tile].image,
        map.quads[tile].quad,
        tile_pos_x,
        -- Tiled counts image y position from bottom to top
        tile_pos_y - texture_height + map.tile_height
      )
    end
  end
end

local draw = function()
  -- We're probably on the menu screen
  -- if there isn't an active map
  if not active_map then
    return
  end
  for layer_idx, layer in ipairs(active_map.layers) do
    if layer.type == 'tiles' then
      draw_tiles(layer, active_map)
    else
      -- Draw each entity that belongs to this layer
      for _, entity in ipairs(Entity.get_entities()) do
        DrawEntity(entity, layer_idx)
      end
    end
  end
end

local generate_world = function()
  --- Set pixels per unit of length
  local meter = 32 -- (base tile size)
  Love.physics.setMeter(meter)

  -- If two fixtures are contacting but aren't colliding
  -- based off their category or mask, invoke this check.
  -- https://love2d.org/wiki/World:setContactFilter
  -- @param {fixture} fixture_a - fixture A
  -- @param {fixture} fixture_b - fixture B
  -- @return {boolean} true if the entities should collide
  local contact_filter = function(fixture_a, fixture_b)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    if entity_a.draw_layer == entity_b.draw_layer then
      return true
    end

    return false
  end

  -- Called at the beginning of one contact iteration.
  -- When sliding along an object, there may be several.
  -- https://love2d.org/wiki/Fixture
  -- https://love2d.org/wiki/Contact
  -- @param {fixture} fixture_a - first fixture object in the collision.
  -- @param {fixture} fixture_b - second fixture object in the collision.
  -- @param {contact} collision - world object created on and
  --                              at the point of contact
  local begin_contact = function(fixture_a, fixture_b, collision)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    CallOnBeginContact(entity_a, entity_b, collision)
    CallOnBeginContact(entity_b, entity_a, collision)
    CallOnDeath(entity_a, entity_b, collision)
    CallOnDeath(entity_b, entity_a, collision)
  end

  -- Called at the end of one contact iteration
  local end_contact = function(fixture_a, fixture_b, collision)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    CallOnEndContact(entity_a, entity_b, collision)
    CallOnEndContact(entity_b, entity_a, collision)
  end

  -- Called before contact is solved
  local pre_contact = function(fixture_a, fixture_b, collision)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    CallOnPreContact(entity_a, entity_b, collision)
    CallOnPreContact(entity_b, entity_a, collision)
  end

  -- Called after all contact is done
  -- fixture_a (fixture table) first fixture object in the collision.
  -- fixture_b (fixture table) second fixture object in the collision.
  -- collision (contact table) https://love2d.org/wiki/Contact
  --   world object created on and at the point of contact.
  -- n_impulse (?) amount of impulse applied along the normal
  --   of the first point of collision.
  -- t_impulse (?) amount of impulse applied along the tangent of the
  --  first point of collision.
  local post_contact = function(fixture_a, fixture_b, collision, n_impulse, t_impulse)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    CallOnPostContact(entity_a, entity_b, collision, n_impulse, t_impulse)
    CallOnPostContact(entity_b, entity_a, collision, n_impulse, t_impulse)
  end

  --- Create world gravity.
  -- @int x-axis gravity
  -- @int y-axis gravity
  -- @string skip sleeping entities
  local world = Love.physics.newWorld(0, 0, true)
  world:setCallbacks(begin_contact, end_contact, pre_contact, post_contact)
  world:setContactFilter(contact_filter)

  return world
end

local get_active_map = function()
  return active_map
end

local get_dimensions = function()
  return active_map.pixel_width, active_map.pixel_height
end

local load = function(map_name)
  Camera.set_position(0, 0)
  GameState.world = generate_world()
  local load_quads = function(map)
    local quads = {}

    for _, tileset in ipairs(map.tilesets) do
      local image = Love.graphics.newImage(tileset.source)
      local quad_idx = tileset.first_gid
      local row_count = tileset.tile_count / tileset.columns
      for row = 1, row_count do
        for column = 1, tileset.columns do
          local tile_x = map.tile_width * (column - 1)
          local tile_y = map.tile_height * (row - 1)
          local quad = Love.graphics.newQuad(
            tile_x,
            tile_y,
            tileset.tile_width,
            tileset.tile_height,
            tileset.image_width,
            tileset.image_height
          )
          quads[quad_idx] = {
            image = image,
            quad = quad
          }
          quad_idx = quad_idx + 1
        end
      end
    end

    return quads
  end

  local load_fixtures = function(layer, layer_idx)
    local fixtures = {}
    for _, object in ipairs(layer.objects) do
      Entity.spawn(object, layer_idx)
      if object.type == 'boundary' then
        table.insert(fixtures, object.fixture)
      end
    end
    return fixtures
  end

  assert(
    type(map_name) == 'string',
    'Expected map_name string parameter. Got "' .. type(map_name) .. '".'
  )
  assert(
    maps[map_name] ~= nil,
    'Could not find indexed map "' .. map_name .. '".'
  )

  active_map = Util.copy(maps[map_name])

  assert(
    active_map.render_order == 'right-down',
    'Only "right-down" map render order supported, but found order set to "' ..
    active_map.render_order .. '" ' .. 'for map "' .. map_name .. '".'
  )

  active_map.quads = load_quads(active_map)

  for layer_idx, layer in ipairs(active_map.layers) do
    -- Apply collision fixtures
    if layer.type == 'objects' then
      active_map.layers[layer_idx].objects = load_fixtures(layer, layer_idx)
    end
  end

  return active_map
end

local unload = function()
  -- This is a brutal but quick way to delete all key bindings
  Input.unregister_everything()
  Entity.clear_entities()
  GameState.world:destroy()
  active_map = nil
end

return {
  --- Render a map on screen. Map names are based
  -- on the filename. For instance, "general.tmx"
  -- would have a map name of "general".
  -- @param {string} map_name - name of map to draw
  -- @return {nil}
  draw = draw,
  -- Returns the currently-active map
  get_active_map = get_active_map,
  -- Return active map's pixel dimensions
  -- @param {number} width
  -- @param {number} height
  get_dimensions = get_dimensions,
  load = load,
  --- Set loaded images and quads for a given map to nil.
  -- would have a map name of "general".
  -- @param {string} map_name - name of the tmx file to load
  -- @return {table} - parsed Tiled map data
  unload = unload
}
