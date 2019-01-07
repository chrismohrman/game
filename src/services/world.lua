local Love = require 'src/services/love'

--- Set pixels per unit of length
local meter = 32 -- (base tile size)
Love.physics.setMeter(meter)

-- If two fixtures are contacting but aren't colliding
-- based off their category or mask, invoke this check.
-- https://love2d.org/wiki/World:setContactFilter
-- @param {fixture} fixture_a - fixture A
-- @param {fixture} fixture_b - fixture B
-- @return {boolean} true if the entities should collide
local contact_filter = function(fixture_a, fixture_b)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()

  if entity_a.draw_layer == entity_b.draw_layer then
    return true
  end

  return false
end

-- Called at the beginning of one contact iteration.
-- When sliding along an object, there may be several.
-- https://love2d.org/wiki/Fixture
-- https://love2d.org/wiki/Contact
-- @param {fixture} fixture_a - first fixture object in the collision.
-- @param {fixture} fixture_b - second fixture object in the collision.
-- @param {contact} collision - world object created on and
--                              at the point of contact
local begin_contact = function(fixture_a, fixture_b, collision)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()

  if entity_a.on_begin_contact then
    for _, callback in ipairs(entity_a.on_begin_contact) do
      callback(entity_a, entity_b, collision)
    end
  end
  if entity_b.on_begin_contact then
    for _, callback in ipairs(entity_b.on_begin_contact) do
      callback(entity_b, entity_a, collision)
    end
  end
end

-- Called at the end of one contact iteration
local end_contact = function(fixture_a, fixture_b, collision)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()

  if entity_a.on_end_contact then
    for _, callback in ipairs(entity_a.on_end_contact) do
      callback(entity_a, entity_b, collision)
    end
  end
  if entity_b.on_end_contact then
    for _, callback in ipairs(entity_b.on_end_contact) do
      callback(entity_b, entity_a, collision)
    end
  end
end

-- Called before contact is solved
local pre_contact = function(fixture_a, fixture_b, collision)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()

  if entity_a.on_pre_contact then
    for _, callback in ipairs(entity_a.on_pre_contact) do
      callback(entity_a, entity_b, collision)
    end
  end
  if entity_b.on_pre_contact then
    for _, callback in ipairs(entity_b.on_pre_contact) do
      callback(entity_b, entity_a, collision)
    end
  end
end

-- Called after all contact is done
-- fixture_a (fixture table) first fixture object in the collision.
-- fixture_b (fixture table) second fixture object in the collision.
-- collision (contact table) https://love2d.org/wiki/Contact
--   world object created on and at the point of contact.
-- n_impulse (?) amount of impulse applied along the normal
--   of the first point of collision.
-- t_impulse (?) amount of impulse applied along the tangent of the
--  first point of collision.
local post_contact = function(fixture_a, fixture_b, collision, n_impulse, t_impulse)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()

  if entity_a.on_post_contact then
    for _, callback in ipairs(entity_a.on_post_contact) do
      callback(entity_a, entity_b, collision, n_impulse, t_impulse)
    end
  end
  if entity_b.on_post_contact then
    for _, callback in ipairs(entity_b.on_post_contact) do
      callback(entity_b, entity_a, collision, n_impulse, t_impulse)
    end
  end
end

--- Create world gravity.
-- @int x-axis gravity
-- @int y-axis gravity
-- @string skip sleeping entities
local world = Love.physics.newWorld(0, 0, true)
world:setCallbacks(begin_contact, end_contact, pre_contact, post_contact)
world:setContactFilter(contact_filter)

return world
