--- FlashDamage
--Give the entity's sprite a swell of
--red hue to indicate it took damage.

local Shader = require 'src/services/shader'
local System = require 'lib/system'
local Timer = require 'lib/timer'

local components = {
  '_entity'
}

local system = function(entity)
  entity.shader = Shader.get('flash-damage')
  Timer.after(0.05, function()
    entity.shader = nil
  end)
end

return System(components, system)
