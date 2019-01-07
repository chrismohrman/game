--- MoveDownFinish - generic entity movement

local System = require 'lib/system'

local components = {
  '!dead',
  '=input',
  '=sprite',
  'sprites'
}

local system = function(input, _, sprites)
  input.down = false
  if input.up then
    return input, sprites.actions.move_up:clone()
  elseif input.left and not input.right then
    return input, sprites.actions.move_left:clone()
  elseif input.right and not input.left then
    return input, sprites.actions.move_right:clone()
  end
  return input, sprites.actions.default:clone()
end

return System(components, system)
