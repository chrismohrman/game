local anim8 = require('anim8')
local world = require('world')
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

local body = love.physics.newBody(world, player.x, player.y, 'dynamic')
local shape = love.physics.newRectangleShape(64, 64)
local fixture = love.physics.newFixture(body, shape)

function player.ismoving()
  if player.actions.up == true then return true
  elseif player.actions.down == true then return true
  elseif player.actions.left == true then return true
  elseif player.actions.right == true then return true
  end
  return false
end
function player.draw()
  player.sprite:draw(player.image, player.x, player.y)
  love.graphics.setColor(160, 72, 14, 255)
  love.graphics.polygon('line', body:getWorldPoints(shape:getPoints()))
  love.graphics.setColor(255, 255, 255, 255)
end

player.update = function(dt)
  player.sprite:update(dt)
  if player.actions.up == true then player.y = player.y - dt * 100
  elseif player.actions.down == true then player.y = player.y + dt * 100
  elseif player.actions.right == true then player.x = player.x + dt * 100
  elseif player.actions.left == true then player.x = player.x - dt * 100
    end
    body:setPosition(player.x, player.y)
end

player.sprite = player.sprites.downstand
return player
