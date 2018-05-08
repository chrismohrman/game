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
player.body = body
body:setFixedRotation(true)
local shape = love.physics.newRectangleShape(32, 46, 32, 32)
player.shape = shape
local fixture = love.physics.newFixture(body, shape)
player.fixture = fixture

function player.ismoving()
  if player.actions.up == true then return true
  elseif player.actions.down == true then return true
  elseif player.actions.left == true then return true
  elseif player.actions.right == true then return true
  end
  return false
end





player.keyreleased = function(released_key)
  if released_key == 'up' then
    player.actions.up = false
    if player.ismoving() == false then player.sprite = player.sprites.upstand
    end
  elseif released_key == 'down' then
    player.actions.down = false
    if player.ismoving() == false then player.sprite = player.sprites.downstand
    end
  elseif released_key == 'right' then
    player.actions.right = false
    if player.ismoving() == flase then player.sprite = player.sprites.rightstand
    end
  elseif released_key == 'left' then
    player.actions.left = false
    if player.ismoving() == false then player.sprite = player.sprites.leftstand
    end
  end
end

player.keypressed = function(pressed_key)
  if pressed_key == 'up' then
    player.actions.up = true
    player.sprite = player.sprites.up
  elseif pressed_key == 'down' then
    player.actions.down = true
    player.sprite = player.sprites.down
  elseif pressed_key == 'right' then
    player.actions.right = true
    player.sprite = player.sprites.right
  elseif pressed_key == 'left' then
    player.actions.left = true
    player.sprite = player.sprites.left
  elseif pressed_key == 'escape' then
    love.event.quit()
  end
end

player.sprite = player.sprites.downstand
return player
