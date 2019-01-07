--- UpdateHealth
-- Process an entity's collision with another entity

local System = require 'lib/system'

local components = {
  '?defense',
  '=health'
}

local system = function(defense, health, other_entity, _)
  defense = defense or 1
  if other_entity.damage then
    health = health - (other_entity.damage / defense)
  end
  return health
end

return System(components, system)
