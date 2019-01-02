local state = {}
state.world = love.physics.newWorld(0, 0, true)
state.game_over = false
state.entities = {}

local begin_contact_callback = function(fixture_a, fixture_b)
local entity_a = fixture_a:getUserData()
local entity_b = fixture_b:getUserData()
  if entity_a.class == 'player' or entity_b.class == 'player' then
    state.game_over = true
  end
end
state.world:setCallbacks(begin_contact_callback)
return state
