BackgroundImage = love.graphics.newImage("images/countryside.png")
local tileW = 32
local tileH = 32
local g = love.graphics.newQuad(0, 0, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
local b = love.graphics.newQuad(32, 0, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
local f = love.graphics.newQuad(0, 32, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
local t = love.graphics.newQuad(32, 32, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())

return {
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, b, t, f, g, g, g, g, f, f, g, g, g, g, g, g, g, g, f, f, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, f, f, g, g, g, t, t, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, f, f, g, g, g, t, t, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, f, f, g, g, g, t, t, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, f, f, g, g, g, t, t, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, f, f, g, g, g, t, t, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, f, f, g, g, g, t, t, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g},
{g, g, g, g, g, f, f, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g},
{g, g, g, g, g, f, f, g, g, g, g, g, g, f, f, g, g, g, g, g, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, f, f, g, g, g, b, b, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, f, f, g, g, g, b, b, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g},
{g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g},
}
