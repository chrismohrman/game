return function(entity, dt)
  -- Synchronize the sprite animation using delta time
  entity.active_sprite:update(dt)

   -- Change the body velocity to match the player's current actions
  local vel_x = 0
  local vel_y = 0


  if entity.actions.move_up == entity.actions.move_down then
    vel_y = 0
  elseif entity.actions.move_up then
    vel_y = -100
  elseif entity.actions.move_down == true then
    vel_y = 100
  else
    vel_y = 0
  end

  if entity.actions.move_left == entity.actions.move_right then
    vel_x = 0
  elseif entity.actions.move_left == true then
    vel_x = -100
  elseif entity.actions.move_right == true then
    vel_x = 100
  else
    vel_x = 0
  end

  entity.body:setLinearVelocity(vel_x, vel_y)
end
