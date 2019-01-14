-- CallOnBeginContact
-- If the entity has a list of on_begin_contact callbacks, invoke them.

local System = require 'lib/system'

local components = {
  '_entity',
  'on_begin_contact'
}

local system = function(entity, on_begin_contact, other_entity, collision)
  for _, callback in ipairs(on_begin_contact) do
    callback(entity, other_entity, collision)
  end
end

return System(components, system)
