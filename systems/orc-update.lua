local player = require('player')
return function(entity, dt)
  entity.sprite:update(dt)
  local player_y = player.body:getY()
  local player_x = player.body:getX()
  local entity_y = entity.body:getY()
  local entity_x = entity.body:getX()
  local vel_x = 0
  local vel_y = 0
  if player_x > entity_x then vel_x = 30 end
  if player_x < entity_x then vel_x = -30 end
  if player_y > entity_y then vel_y = 30 end
  if player_y < entity_y then vel_y = -30 end
  entity.body:setLinearVelocity(vel_x, vel_y)
end
