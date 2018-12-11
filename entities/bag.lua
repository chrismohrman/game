local anim8 = require('anim8')
local world = require('world')

return function(xpos, ypos, color)
local entity = {}
entity.image = love.graphics.newImage("images/slack-imgs.png")
local grid = anim8.newGrid(32, 32, entity.image:getWidth(), entity.image:getHeight())
if color == 'green' then
    entity.active_sprite = anim8.newAnimation(grid(8, 11), 1)
elseif color == 'orange' then
    entity.active_sprite = anim8.newAnimation(grid(9, 11), 1)
else
    error('color not found')
end
entity.body = love.physics.newBody(world, xpos, ypos, 'dynamic')
entity.shape = love.physics.newRectangleShape(16, 16, 32, 32)
entity.fixture = love.physics.newFixture(entity.body, entity.shape)
entity.fixture:setDensity(1)
entity.fixture:setFriction(1)
return entity
end
