return function(xpos, ypos)
  local anim8 = require('anim8')
  local player_update = require('systems/player-update')
  local state = require('state')
  local image = love.graphics.newImage("images/Character.png")
  local grid = anim8.newGrid(64, 64, image:getWidth(), image:getHeight())
  local player = {
    update = player_update,
    image = image,
    class = 'player',
    sprites = {
      move_down = anim8.newAnimation(grid('1-9', 11), 0.25                 ),
      move_left = anim8.newAnimation(grid('1-9', 10), 0.25        ),
      move_right = anim8.newAnimation(grid('1-9', 12), 0.25       ),
      move_up = anim8.newAnimation(grid('1-9', 9), 0.25      ),
      stand_down = anim8.newAnimation(grid(1, 11), 0.25),
      stand_left = anim8.newAnimation(grid(1, 10), 0.25),
      stand_right = anim8.newAnimation(grid(1, 12), 0.25),
      stand_up = anim8.newAnimation(grid(1, 9), 0.25)
    },
    actions = {
      up = false,
      down = false,
      right = false,
      left = false
    }
  }

  player.body = love.physics.newBody(state.world, xpos, ypos, 'dynamic')
  player.body:setFixedRotation(true)
  player.shape = love.physics.newRectangleShape(32, 46, 32, 32)
  player.fixture = love.physics.newFixture(player.body, player.shape)
  player.fixture:setUserData(player)

  function player.ismoving()
    if player.actions.move_up == true then return true
    elseif player.actions.move_down == true then return true
    elseif player.actions.move_left == true then return true
    elseif player.actions.move_right == true then return true
    end
    return false
  end





  player.keyreleased = function(released_key)
    if released_key == 'up' then
      player.actions.move_up = false
      if player.ismoving() == false then player.active_sprite = player.sprites.stand_up
      end
    elseif released_key == 'down' then
      player.actions.move_down = false
      if player.ismoving() == false then player.active_sprite = player.sprites.stand_down
      end
    elseif released_key == 'right' then
      player.actions.move_right = false
      if player.ismoving() == false then player.active_sprite = player.sprites.stand_right
      end
    elseif released_key == 'left' then
      player.actions.move_left = false
      if player.ismoving() == false then player.active_sprite = player.sprites.stand_left
      end
    end
  end

  player.keypressed = function(pressed_key)
    if pressed_key == 'up' then
      player.actions.move_up = true
      player.active_sprite = player.sprites.move_up
    elseif pressed_key == 'down' then
      player.actions.move_down = true
      player.active_sprite = player.sprites.move_down
    elseif pressed_key == 'right' then
      player.actions.move_right = true
      player.active_sprite = player.sprites.move_right
    elseif pressed_key == 'left' then
      player.actions.move_left = true
      player.active_sprite = player.sprites.move_left
    elseif pressed_key == 'escape' then
      love.event.quit()
    end
  end

  player.active_sprite = player.sprites.stand_down
  return player

end
