--- TogglePause - Alter the game loop to suspend game play

local Input = require 'src/services/input'
local System = require 'lib/system'

local components = {
  '-player_id'
}

local system = function()
  Input.toggle_paused()
end

return System(components, system)
