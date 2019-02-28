--- This is the main Love file, containing all the pieces of the game loop.

-- Services
local Args = require 'src/services/args'
local Camera = require 'src/services/camera'
local Entity = require 'src/services/entity'
local Input = require 'src/services/input'
local Love = require 'src/services/love'
local Map = require 'src/services/map'
local Menu = require 'src/services/menu'
local Shader = require 'src/services/shader'
local Timer = require 'lib/timer'
local World = require 'src/services/world'

-- Systems
local CallOnUpdate = require 'src/systems/call-on-update'
local DestroyEntity = require 'src/systems/destroy-entity'
local UpdateCamera = require 'src/systems/update-camera'
local UpdateEntityAnimation = require 'src/systems/update-entity-animation'
local UpdateEntityVelocity = require 'src/systems/update-entity-velocity'
local UpdateInputVelocity = require 'src/systems/update-input-velocity'
local UpdateEntityBoundaries = require 'src/systems/update-entity-boundaries'

-- Functions to initialize on game boot
Love.load = function(args)
  Args.load(args)
  Shader.index()
  Menu.index()
  -- Load game's main menu
  Menu.load('main')
  -- Or just jump straight into the game
  -- Map.load('simple')
end

-- Functions to run on re-draw
function Love.draw()
  Camera.set()
  Menu.draw()
  Map.draw()
  -- TODO - this could be an entity
  if Input.is_paused() then
    Love.graphics.print('-paused-', Camera.get_position())
  end
  Camera.unset()
end

-- Gamepad/Joystick dpad button press event
-- joystick (joystick table) https://love2d.org/wiki/Joystick
-- button (string)
Love.gamepadpressed = function(_, button)
  Input.call_key_press(button)
end

-- Gamepad/Joystick dpad button release event
-- joystick (joystick table) https://love2d.org/wiki/Joystick
-- button (string)
Love.gamepadreleased = function(_, button)
  Input.call_key_release(button)
end

-- All active callbacks for pressing a key
-- pressedKey (string)
Love.keypressed = function(pressed_key)
  -- Press esc to close game. This will eventually
  -- be a reserved shortcut for debug mode.
  if pressed_key == 'escape' then
    Love.event.quit()
  end
  Input.call_key_press(pressed_key)
end

-- All active callbacks for releasing a key
-- releasedKey (string)
Love.keyreleased = function(released_key)
  Input.call_key_release(released_key)
end

-- Calculations to re-run on going through another loop
-- dt (integer) delta time (in seconds)
Love.update = function(dt)
  if Input.is_paused() then
    return
  end

  Timer.update(dt)

  local i = 1
  while i <= #Entity.list do
    local entity = Entity.list[i]
    DestroyEntity(entity)
    if entity.destroyed then
      -- Stay on the same index
      table.remove(Entity.list, i)
    else
      UpdateCamera(entity)
      UpdateEntityVelocity(entity)
      UpdateInputVelocity(entity)
      UpdateEntityBoundaries(entity)
      UpdateEntityAnimation(entity, dt)
      CallOnUpdate(entity, dt)
      i = i + 1
    end
  end

  World:update(dt)
end
