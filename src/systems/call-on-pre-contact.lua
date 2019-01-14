-- CallOnPreContact
-- If the entity has a list of on_pre_contact callbacks, invoke them.

local System = require 'lib/system'

local components = {
  '_entity',
  'on_pre_contact'
}

local system = function(entity, on_pre_contact, other_entity, collision)
  for _, callback in ipairs(on_pre_contact) do
    callback(entity, other_entity, collision)
  end
end

return System(components, system)
