-- Reloads menu after player dies

local menu = require 'src/services/menu'
local System = require 'lib/system'
local map = require 'src/services/map'


local components = {
  '-player_id'
}

local system = function()
  map.unload()
  menu.load('main')
end

return System(components, system)
