--- UpdatePlayerBoundaries
-- Make sure players don't run off the map

local Map = require 'src/services/map'
local System = require 'lib/system'

local components = {
  '-player_id',
  'body',
  'sprite'
}

local system = function(body, sprite)
  local pos_x, pos_y = body:getPosition()
  local vel_x, vel_y = body:getLinearVelocity()
  local sprite_width, sprite_height = sprite:getDimensions()
  local map_width, map_height = Map.get_dimensions()

  --- TODO Use map boundaries instead of camera boundaries
  if pos_x <= 0 and vel_x < 0 then
    vel_x = 0
  elseif pos_x + sprite_width >= map_width and vel_x > 0 then
    vel_x = 0
  end

  if pos_y <= 0 and vel_y < 0 then
    vel_y = 0
  elseif pos_y + sprite_height >= map_height and vel_y > 0 then
    vel_y = 0
  end

  body:setLinearVelocity(vel_x, vel_y)
end

return System(components, system)
