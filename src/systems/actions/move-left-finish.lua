--- MoveLeftFinish - generic entity movement

local System = require 'lib/system'

local components = {
  '!dead',
  '=input',
  '=sprite',
  'sprites'
}

local system = function(input, _, sprites)
  input.left = false
  if input.right then
    return input, sprites.actions.move_right:clone()
  elseif input.down and not input.up then
    return input, sprites.actions.move_down:clone()
  elseif input.up and not input.down then
    return input, sprites.actions.move_up:clone()
  end
  return input, sprites.actions.default:clone()
end

return System(components, system)
