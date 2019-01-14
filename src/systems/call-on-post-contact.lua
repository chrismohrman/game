-- CallOnPostContact
-- If the entity has a list of on_post_contact callbacks, invoke them.

local System = require 'lib/system'

local components = {
  '_entity',
  'on_post_contact'
}

local system = function(entity, on_post_contact, other_entity, collision, n_impulse, t_impulse)
  for _, callback in ipairs(on_post_contact) do
    callback(entity, other_entity, collision, n_impulse, t_impulse)
  end
end

return System(components, system)
