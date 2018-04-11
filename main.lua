local player = require('player')
local world = require('world')
local countryside = require('countryside')
local block = require('block')

function love.draw()
  for rowindex in ipairs(countryside) do
    local row = countryside[rowindex]
    for tileindex in ipairs(row) do
      local tile = row[tileindex]
      love.graphics.draw(BackgroundImage, tile, (tileindex - 1) * 32, (rowindex - 1) * 32)
    end
  end

  block.draw()
  player.draw()
end

function love.keypressed(pressed_key)
  player.keypressed(pressed_key)
end

function love.keyreleased(released_key)
  player.keyreleased(released_key)
end
--dt = delta time is the amount of time that has passed in game
function love.update(dt)
  --io.write(dt)
  --io.write('\n')
player.update(dt)
  world:update(dt)
end
