--- CallOnUpdate
-- If the entity has an on_update callbacks, invoke them.

local System = require 'lib/system'

local components = {
  '_entity',
  'on_update'
}

local system = function(entity, on_update, dt)
  for _, callback in ipairs(on_update) do
    callback(entity, dt)
  end
end

return System(components, system)
