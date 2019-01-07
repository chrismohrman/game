--- RegisterSprites
-- Load graphics for spawning sprites

local System = require 'lib/system'

local Anim8 = require 'lib/anim8'
local Love = require 'src/services/love'

local components = {
  '_entity',
  '=sprites'
}

local system = function(entity, sprites)
  local sprite_config = require('src/components/sprites/' .. sprites)
  local loaded_set = {}
  loaded_set.image = Love.graphics.newImage(sprite_config.path)
  loaded_set.actions = {}
  loaded_set.offset_x = sprite_config.offset_x
  loaded_set.offset_y = sprite_config.offset_y
  local img_w = loaded_set.image:getWidth()
  local img_h = loaded_set.image:getHeight()

  for key, sprite_action in pairs(sprite_config.actions) do
    local grid = Anim8.newGrid(
      sprite_action.width or sprite_config.width,
      sprite_action.height or sprite_config.height,
      img_w,
      img_h,
      sprite_action.x or sprite_config.x or 0,
      sprite_action.y or sprite_config.y or 0,
      sprite_action.gap or sprite_config.gap or 0
    )

    local frames = sprite_action.frames or sprite_config.frames or { 1, 1 }

    loaded_set.actions[key] = Anim8.newAnimation(
      grid:getFrames(unpack(frames)),
      sprite_action.duration or sprite_config.duration or 1,
      sprite_action.on_loop or sprite_config.on_loop or nil
    )
    -- I know we don't own this table but
    -- what's the worst that could happen...
    loaded_set.actions[key].offset_x = sprite_action.offset_x
    loaded_set.actions[key].offset_y = sprite_action.offset_y
  end

  -- Initialize the default sprite
  entity.sprite = loaded_set.actions.default:clone()

  return loaded_set
end

return System(components, system)
