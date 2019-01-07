--- CallOnSpawn
-- Invoke any callacks registered to on_spawn

local System = require 'lib/system'

local components = {
  '_entity',
  'on_spawn'
}

local system = function(entity, on_spawn)
  for _, callback in ipairs(on_spawn) do
    callback(entity)
  end
end

return System(components, system)
