local System = require 'lib/system'
local game_state = require('src/services/game-state')
local components = {
  '!dead',
  '=input',
  'body',
  '=direction_timer'
}

local get_target_position = function(player)
  local player_x = player.body:getX()
  local player_y = player.body:getY()
  local velocity_x, velocity_y = player.body:getLinearVelocity()
  local target_x = player_x
  local target_y = player_y
  if velocity_x > 0 then target_x = velocity_x + 50 end
  if velocity_x < 0 then target_x = velocity_x - 50 end
  if velocity_y > 0 then target_y = velocity_y + 50 end
  if velocity_y < 0 then target_y = velocity_y - 50 end
  print(player.body:getLinearVelocity())
  return target_x, target_y
end

local system = function(input, body, direction_timer, dt)
  local players = game_state.get_players()
  local target_player = nil
  for _, player in ipairs(players) do
    target_player = player
  end
  if target_player then
    local orc_x = body:getX()
    local orc_y = body:getY()
    local target_x, target_y = get_target_position(target_player)
   --- local player_x = target_player.body:getX()
   --- local player_y = target_player.body:getY()
    local difference_x = target_x - orc_x
    local difference_y = target_y - orc_y
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
