local System = require 'lib/system'
local game_state = require('src/services/game-state')
local components = {
  '!dead',
  '=input',
  'body',
  '=direction_timer'
}

local system = function(input, body, direction_timer, dt)
  direction_timer = direction_timer + dt
  local players = game_state.get_players()
  local target_player = nil
  for _, player in ipairs(players) do
    target_player = player
  end
  if target_player then
    local skeleton_x = body:getX()
    local skeleton_y = body:getY()
    local player_x = target_player.body:getX()
    local player_y = target_player.body:getY()
    if direction_timer >= 1.5 then
      direction_timer = direction_timer - 1.5
      if skeleton_x > player_x then
        if skeleton_y > player_y then
          input = {up = true, left = true}
        else
          input = {down = true, left = true}
        end
      elseif
       skeleton_y < player_y then
        input = {down = true, right = true}
       else
        input = {up = true, right = true}
       end
    end
  end
  return input, direction_timer
end

return System(components, system)
