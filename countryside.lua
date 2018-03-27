BackgroundImage = love.graphics.newImage("images/countryside.png")
local tileW = 32
local tileH = 32
g = love.graphics.newQuad(0, 0, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
b = love.graphics.newQuad(32, 0, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
f = love.graphics.newQuad(0, 32, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
t = love.graphics.newQuad(32, 32, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())

return {
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g}
}
