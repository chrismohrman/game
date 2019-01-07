--- RegisterPlayer
-- Let GameState be aware of this player

local GameState = require 'src/services/game-state'
local System = require 'lib/system'

local components = {
  '_entity',
  'player_id'
}

local system = function(entity, player_id)
  GameState.set_player(player_id, entity)
end

return System(components, system)
