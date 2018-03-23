BackgroundImage = love.graphics.newImage("images/countryside.png")
local tileW = 32
local tileH = 32
GrassQuad = love.graphics.newQuad(0, 0, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
BoxQuad = love.graphics.newQuad(32, 0, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
FlowerQuad = love.graphics.newQuad(0, 32, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())
BoxtopQuad = love.graphics.newQuad(32, 32, tileW, tileH, BackgroundImage:getWidth(), BackgroundImage:getHeight())

return {
  GrassQuad, BoxQuad, BoxtopQuad, FlowerQuad
}
