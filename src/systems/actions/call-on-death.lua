--- CallOnDeath  \m/
-- Check if player's health is spent, and if so, trigger
-- on_death callbacks and destroy the entity.

local System = require 'lib/system'

local components = {
  '_entity',
  'health',
  '?on_death'
}

local system = function(entity, health, on_death)
  if health <= 0 then
    if on_death then
      for _, callback in ipairs(on_death) do
        callback(entity)
      end
    end
    entity.fixture:setFilterData(0, 0, -1)
    entity.dead = true
  end
end

return System(components, system)
