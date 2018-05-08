return function(entity, dt)
  -- Synchronize the sprite animation using delta time
  entity.sprite:update(dt)

   -- Change the body velocity to match the player's current actions
  local vel_x = 0
  local vel_y = 0


  if entity.actions.up == entity.actions.down then
    vel_y = 0
  elseif entity.actions.up then
    vel_y = -100
  elseif entity.actions.down == true then
    vel_y = 100
  else
    vel_y = 0
  end

  if entity.actions.left == entity.actions.right then
    vel_x = 0
  elseif entity.actions.left == true then
    vel_x = -100
  elseif entity.actions.right == true then
    vel_x = 100
  else
    vel_x = 0
  end

  entity.body:setLinearVelocity(vel_x, vel_y)
end
