local entity_draw = require('systems/entity-draw')
local entity_update = require('systems/entity-update')
local player = require('player')
local world = require('world')
local countryside = require('countryside')
local bag_1 = require('bag-1')
local bag_2 = require('bag-2')

function love.draw()
  for rowindex in ipairs(countryside) do
    local row = countryside[rowindex]
    for tileindex in ipairs(row) do
      local tile = row[tileindex]
      love.graphics.draw(BackgroundImage, tile, (tileindex - 1) * 32, (rowindex - 1) * 32)
    end
  end

  entity_draw(bag_1)
  entity_draw(bag_2)
  entity_draw(player)
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
  entity_update(player, dt)
  world:update(dt)
end
