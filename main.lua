local player = require('player')
local world = require('world')
local countryside = require('countryside')
local block = require('block')

function love.draw()
  for rowindex in ipairs(countryside) do
    local row = countryside[rowindex]
    for tileindex in ipairs(row) do
      local tile = row[tileindex]
      love.graphics.draw(BackgroundImage, tile, (tileindex - 1) * 32, (rowindex - 1) * 32)
    end
  end

  block.draw()
  player.draw()
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
    if player.ismoving() == false then player.sprite = player.sprites.upstand
    end
  elseif released_key == 'down' then
    player.actions.down = false
    if player.ismoving() == false then player.sprite = player.sprites.downstand
    end
  elseif released_key == 'right' then
    player.actions.right = false
    if player.ismoving() == false then player.sprite = player.sprites.rightstand
    end
  elseif released_key == 'left' then
    player.actions.left = false
    if player.ismoving() == false then player.sprite = player.sprites.leftstand
    end
  end
end
--dt = delta time is the amount of time that has passed in game
function love.update(dt)
  --io.write(dt)
  --io.write('\n')
player.update(dt)
  world:update(dt)
end
