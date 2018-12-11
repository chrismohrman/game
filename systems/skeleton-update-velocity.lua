return function(entity, dt)
  local player = require('entities/entities')[1]
  local player_x = player.body:getX()
  local player_y = player.body:getY()
  local entity_x = entity.body:getX()
  local entity_y = entity.body:getY()

  local vel_x = 0
  local vel_y = 0

entity.direction_timer = entity.direction_timer + dt

  if entity.direction_timer >= 1.5 then
    entity.direction_timer = entity.direction_timer - 1.5
  -- up-left/down-left
    if entity_x > player_x then
        --up-left
      if entity_y > player_y then
        vel_x = -30
        vel_y = -30
        --down-left
      else
        vel_x = -30
        vel_y = 30
      end
      -- up-right/down-right
    else
      -- down-right
      if entity_y < player_y then
        vel_x = 30
        vel_y = 30
        -- up-right
      else
        vel_x = 30
        vel_y = -30
      end
    end
      entity.body:setLinearVelocity(vel_x, vel_y)
  end
end
