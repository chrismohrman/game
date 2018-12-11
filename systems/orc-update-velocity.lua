return function(entity, dt)
  local player = require('entities/entities')[1]
  entity.active_sprite:update(dt)
  local player_y = player.body:getY()
  local player_x = player.body:getX()
  local entity_y = entity.body:getY()
  local entity_x = entity.body:getX()

  local difference_x = player_x - entity_x
  local difference_y = player_y - entity_y

  local vel_x = 0
  local vel_y = 0

  entity.direction_timer = entity.direction_timer + dt

  if entity.direction_timer >= 1.5 then
    entity.direction_timer = entity.direction_timer - 1.5
    if math.abs(difference_x) > math.abs(difference_y) then
      if difference_x > 0 then vel_x = 30
      end
      if difference_x < 0 then vel_x = -30
      end
    else
      if difference_y > 0 then vel_y = 30
      end
      if difference_y < 0 then vel_y = -30
      end
    end
    entity.body:setLinearVelocity(vel_x, vel_y)
  end
end
