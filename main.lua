local player = require('player')
local countryside = require('countryside')

function love.draw()
  for rowindex in ipairs(countryside) do
    local row = countryside[rowindex]
    for tileindex in ipairs(row) do
      local tile = row[tileindex]
      love.graphics.draw(BackgroundImage, tile, tileindex * 32, rowindex * 32)
    end 
  end
    player.sprite:draw(player.image, player.x, player.y)
end

function love.keypressed(pressed_key)
  if pressed_key == 'up' then
    player.actions.up = true
    player.sprite = player.sprites.up
  elseif pressed_key == 'down' then
    player.actions.down = true
    player.sprite = player.sprites.down
  elseif pressed_key == 'right' then
    player.actions.right = true
    player.sprite = player.sprites.right
  elseif pressed_key == 'left' then
    player.actions.left = true
    player.sprite = player.sprites.left
  elseif pressed_key == 'escape' then
    love.event.quit()
  end
end

function love.keyreleased(released_key)
  if released_key == 'up' then
    player.actions.up = false
  elseif released_key == 'down' then
    player.actions.down = false
  elseif released_key == 'right' then
    player.actions.right = false
  elseif released_key == 'left' then
    player.actions.left = false
  end
end
--dt = delta time is the amount of time that has passed in game
function love.update(dt)
  --io.write(dt)
  --io.write('\n')
  player.sprite:update(dt)
  if player.actions.up == true then player.y = player.y - dt * 100
  elseif player.actions.down == true then player.y = player.y + dt * 100
  elseif player.actions.right == true then player.x = player.x + dt * 100
  elseif player.actions.left == true then player.x = player.x - dt * 100
  end
end
