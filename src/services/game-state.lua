--- GameState service
-- Hold the game's current state

-- Index of player entities
local players = {}

local get_players = function()
  return players
end

local set_player = function(id, entity)
  players[id] = entity
end

return {
  get_players = get_players,
  set_player = set_player
}
