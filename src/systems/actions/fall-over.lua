--- Explode
-- Replace entity's sprite with an explosion.

local System = require 'lib/system'

local components = {
  '_entity',
  'input',
  '=sprite',
  'sprites'
}

local system = function(entity, input, _, sprites)
  input.down = false
  input.left = false
  input.right = false
  input.up = false

  local sprite = sprites.actions.fall_over:clone()
  sprite.onLoop = function(animation)
    animation:pause()
    entity.destroyed = true
  end
    -- Let the game loop remove this entity next go around
  return sprite
end

return System(components, system)
