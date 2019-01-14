local System = require 'lib/system'
local game_state = require('src/services/game-state')
local components = {
  '!dead',
  '=input',
  'body',
  '=direction_timer'
}

local system = function(input, body, direction_timer, dt)
  local players = game_state.get_players()
  local target_player = nil
  for _, player in ipairs(players) do
    target_player = player
  end
  if target_player then
    local orc_x = body:getX()
    local orc_y = body:getY()
    local player_x = target_player.body:getX()
    local player_y = target_player.body:getY()
    local difference_x = player_x - orc_x
    local difference_y = player_y - orc_y
    direction_timer = direction_timer + dt
    if direction_timer >= 1.5 then
      direction_timer = direction_timer - 1.5
      if math.abs(difference_x) > math.abs(difference_y) then
        if difference_x > 0 then
          input = {right = true}
        elseif difference_x < 0 then
          input = {left = true}
        end
      else
        if difference_y > 0 then
          input = {down = true}
        elseif difference_y < 0 then
          input = {up = true}
        end
      end
    end
  end
  return input, direction_timer
end

return System(components, system)
