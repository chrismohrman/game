

return function(xpos, ypos)
  local anim8 = require('anim8')
  local state = require('state')
  local image = love.graphics.newImage('images/orc.png')
  local grid = anim8.newGrid(64, 64, image:getWidth(), image:getHeight())
  local orc_update_velocity = require('systems/orc-update-velocity')
  local orc_update_sprite = require('systems/orc-update-sprite')
  local entity = {}
  entity.update = function(entity, dt)
      orc_update_sprite(entity, dt)
      orc_update_velocity(entity, dt)
  end
  entity.image = image
  entity.class = 'monster'
  entity.sprites = {}
  entity.sprites.move_down = anim8.newAnimation(grid('1-9', 11), 0.25     )
  entity.sprites.move_left = anim8.newAnimation(grid('1-9', 10), 0.25)
  entity.sprites.move_right = anim8.newAnimation(grid('1-9', 12), 0.25)
  entity.sprites.move_up = anim8.newAnimation(grid('1-9', 9), 0.25)
  entity.sprites.stand_down = anim8.newAnimation(grid(1, 9), 0.25)
  entity.sprites.stand_left = anim8.newAnimation(grid(1, 10), 0.25)
  entity.sprites.stand_right = anim8.newAnimation(grid(1, 11), 0.25)
  entity.sprites.stand_up = anim8.newAnimation(grid(1, 12), 0.25)
  entity.body = love.physics.newBody(state.world, xpos, ypos, 'dynamic')
  entity.body:setFixedRotation(true)
  entity.shape = love.physics.newRectangleShape(32, 46, 32, 32)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
  entity.fixture:setUserData(entity)
  entity.direction_timer = 0
  entity.active_sprite = entity.sprites.stand_down
  return entity
end

