local anim8 = require 'anim8'
local image = love.graphics.newImage("images/Character.png")
local grid = anim8.newGrid(64, 64, image:getWidth(), image:getHeight())
local player = {
  image = image,
  sprites = {
    down = anim8.newAnimation(grid('1-9', 11), 0.25                 ),
    left = anim8.newAnimation(grid('1-9', 10), 0.25        ),
    right = anim8.newAnimation(grid('1-9', 12), 0.25       ),
    up = anim8.newAnimation(grid('1-9', 9), 0.25      ),
    downstand = anim8.newAnimation(grid(1, 11), 0.25),
    leftstand = anim8.newAnimation(grid(1, 10), 0.25),
    rightstand = anim8.newAnimation(grid(1, 12), 0.25),
    upstand = anim8.newAnimation(grid(1, 9), 0.25)
  },
  x = 300,
  y = 200,
  actions = {
    up = false,
  down = false,
  right = false,
  left = false
}
}
function player.ismoving()
  if player.actions.up == true then return true
  elseif player.actions.down == true then return true
  elseif player.actions.left == true then return true
  elseif player.actions.right == true then return true
  end
  return false
end
player.sprite = player.sprites.downstand
return player
