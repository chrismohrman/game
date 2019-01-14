-- CallOnEndContact
-- If the entity has a list of on_end_contact callbacks, invoke them.

local System = require 'lib/system'

local components = {
  '_entity',
  'on_end_contact'
}

local system = function(entity, on_end_contact, other_entity, collision)
  for _, callback in ipairs(on_end_contact) do
    callback(entity, other_entity, collision)
  end
end

return System(components, system)
