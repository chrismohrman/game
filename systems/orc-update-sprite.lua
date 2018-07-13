return function(entity, dt)
  local vel_x, vel_y = entity.body:getLinearVelocity()

  print(vel_x, vel_y)

  if vel_x == 0 and vel_y == 0 then
    entity.active_sprite = entity.sprites.stand_down
  end

  if vel_x > 0 then
    entity.active_sprite = entity.sprites.move_right
    print('right')
  end
  if vel_x < 0 then
    entity.active_sprite = entity.sprites.move_left
    print('left')
  end
  if vel_y > 0 then
    entity.active_sprite = entity.sprites.move_down
    print('down')
  end
  if vel_y < 0 then
    entity.active_sprite = entity.sprites.move_up
    print('up')
  end
end
