local anim8 = require('anim8')
local world = require('world')
local entity = {}

entity.image = love.graphics.newImage("images/slack-imgs.png")
local grid = anim8.newGrid(32, 32, entity.image:getWidth(), entity.image:getHeight())
entity.sprite = anim8.newAnimation(grid(8, 11), 1)
local xposition = 200
local yposition = 300
entity.body = love.physics.newBody(world, xposition, yposition, 'dynamic')

entity.shape = love.physics.newRectangleShape(16, 16, 32, 32)
entity.fixture = love.physics.newFixture(entity.body, entity.shape)
entity.fixture:setDensity(1)
entity.fixture:setFriction(1)

return entity
