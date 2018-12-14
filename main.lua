local entity_draw = require('systems/entity-draw')
local state = require('state')
local world = require('world')
local countryside = require('countryside')

love.load = function()
  love.graphics.setDefaultFilter('nearest', 'nearest')
end

function love.draw()
  for rowindex in ipairs(countryside) do
    local row = countryside[rowindex]
    for tileindex in ipairs(row) do
      local tile = row[tileindex]
      love.graphics.draw(BackgroundImage, tile, (tileindex - 1) * 32, (rowindex - 1) * 32)
    end
  end

  for index, entity in ipairs(state.entities) do
    if entity.draw then entity:draw()
    else
      entity_draw(entity)
    end
  end
end -- end of love.draw function

function love.keypressed(pressed_key)
  local player = state.entities[1]
  player.keypressed(pressed_key)
end

function love.keyreleased(released_key)
  local player = state.entities[1]
  player.keyreleased(released_key)
end
--dt = delta time is the amount of time that has passed in game
function love.update(dt)
  for _ , entity in ipairs(state.entities) do
    if entity.update then
      entity.update(entity, dt)
    end
  end
  world:update(dt)
end
