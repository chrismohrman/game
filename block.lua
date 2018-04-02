local image = love.graphics.newImage("images/slack-imgs.png")
local quad = love.graphics.newQuad(0, 0, 32, 32, image:getWidth(), image:getHeight())

local world = require('world')
local xposition = 200
local yposition = 300
local body = love.physics.newBody(world, xposition, yposition, 'static')

local shape = love.physics.newRectangleShape(32, 32)
local fixture = love.physics.newFixture(body, shape)

function draw()
  love.graphics.draw(image, quad , xposition, yposition )
  love.graphics.setColor(160, 72, 14, 255)
  love.graphics.polygon('line', body:getWorldPoints(shape:getPoints()))
  love.graphics.setColor(255, 255, 255, 255)
end

return {draw = draw}
