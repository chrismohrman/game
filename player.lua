local anim8 = require 'anim8'
local image = love.graphics.newImage("images/Character.png")
local grid = anim8.newGrid(64, 64, image:getWidth(), image:getHeight())
local player = {
  image = image,
  sprites = {
    down = anim8.newAnimation(grid('1-9', 11), 0.25                 ),
    left = anim8.newAnimation(grid('1-9', 10), 0.25        ),
    right = anim8.newAnimation(grid('1-9', 12), 0.25       ),
    up = anim8.newAnimation(grid('1-9', 9), 0.25      )
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
player.sprite = player.sprites.down
return player
