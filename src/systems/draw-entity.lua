--- DrawEntity
-- Draw currently-visible entities on screen
-- or their hitbox (if in debug mode)

local Args = require 'src/services/args'
local Love = require 'src/services/love'
local System = require 'lib/system'

local components = {
  'body',
  'draw_layer',
  '?shader',
  '?shape',
  '?sprite',
  '?sprites'
}

local system = function(body, draw_layer, shader, shape, sprite, sprites, layer_idx)
  -- Don't draw the entity unless it belongs to the
  -- layer from which this system was invoked.
  if draw_layer ~= layer_idx then
    return
  end

  if sprite then
    local offset_x = sprite.offset_x or sprites.offset_x or 0
    local offset_y = sprite.offset_y or sprites.offset_y or 0

    Love.graphics.setShader(shader)
    sprite:draw(
      sprites.image,
      body:getX() + offset_x,
      body:getY() + offset_y,
      body:getAngle()
    )
    Love.graphics.setShader()
  end

  -- Draw fixture shape edges in debug mode
  if Args.get_arg('debug') and shape then
    Love.graphics.setColor(160, 72, 14, 255)
    Love.graphics.polygon(
      'line',
      body:getWorldPoints(shape:getPoints())
    )
    Love.graphics.setColor(255, 255, 255, 255)
  end
end

return System(components, system)
