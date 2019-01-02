local entity_draw = require('systems/entity-draw')
local state = require('state')
local countryside = require('countryside')

love.load = function()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  local player_factory = require('entities/player')
  local bag_factory = require('entities/bag')
  local orc_factory = require('entities/orc')
  local skeleton_factory = require('entities/skeleton')
  local game_over_factory = require('entities/game-over')
  state.entities = {
    player_factory(300, 200),
    bag_factory(250, 400, 'orange'),
    bag_factory(275, 450, 'green'),
    orc_factory(10, 200),
    orc_factory(100, 200),
    skeleton_factory(45, 300),
    skeleton_factory(150, 375),
    game_over_factory()
  }


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
love.update = function(dt)
  if state.game_over == false then
    for _ , entity in ipairs(state.entities) do
      if entity.update then
        entity.update(entity, dt)
      end
    end
  state.world:update(dt)
  end
end
