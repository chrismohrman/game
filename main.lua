local entity_draw = require('systems/entity-draw')
local entities = require('entities/entities')
local world = require('world')
local countryside = require('countryside')

function love.draw()
  for rowindex in ipairs(countryside) do
    local row = countryside[rowindex]
    for tileindex in ipairs(row) do
      local tile = row[tileindex]
      love.graphics.draw(BackgroundImage, tile, (tileindex - 1) * 32, (rowindex - 1) * 32)
    end
  end

  for index, entity in ipairs(entities) do
    entity_draw(entity)
  end
end

function love.keypressed(pressed_key)
  local player = require('entities/entities')[1]
  player.keypressed(pressed_key)
end

function love.keyreleased(released_key)
  local player = require('entities/entities')[1]
  player.keyreleased(released_key)
end
--dt = delta time is the amount of time that has passed in game
function love.update(dt)
  for _ , entity in ipairs(entities) do
    if entity.update then
      entity.update(entity, dt)
    end
  end
  world:update(dt)
end
