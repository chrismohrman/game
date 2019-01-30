--- DestroyEntity
-- Clean up entities that have run off the map

local Map = require 'src/services/map'
local System = require 'lib/system'

local components = {
  '_entity',
  'body'
}

local system = function(entity, body)
  local pos_x, pos_y = body:getPosition()

  -- Do the quicker calculations first
  if pos_x < -2000 or pos_y < -2000 then
    entity.destroyed = true
    return
  end

  local map_width, map_height = Map.get_dimensions()

  -- Add 2000 pixels to the width until
  -- we settle on a map width/boundaries
  if pos_x > map_width + 2000 or pos_y > map_height + 2000 then
    entity.destroyed = true
  end
end

return System(components, system)
