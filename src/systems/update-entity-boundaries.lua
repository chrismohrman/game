--- UpdateEntityBoundaries
-- Make sure entities don't run off the map

local Map = require 'src/services/map'
local System = require 'lib/system'

local components = {
  'body',
  'shape'
}

local get_shape_points = function(body, shape)
  local pack = function(...)
    return { ... }
  end
  return pack(body:getWorldPoints(shape:getPoints()))
end

local system = function(body, shape)
  local vel_x, vel_y = body:getLinearVelocity()
  local map_width, map_height = Map.get_dimensions()

  local shape_points = get_shape_points(body, shape)
  local bottom_most_point = shape_points[2]
  local right_most_point = shape_points[1]
  local top_most_point = shape_points[2]
  local left_most_point = shape_points[1]
  for index, value in ipairs(shape_points) do
    if index % 2 == 0 then
      bottom_most_point = math.max(bottom_most_point, value)
      top_most_point = math.min(top_most_point, value)
    else
      right_most_point = math.max(right_most_point, value)
      left_most_point = math.min(left_most_point, value)
    end
  end

  --- TODO Use map boundaries instead of camera boundaries
  if left_most_point <= 0 and vel_x < 0 then
    vel_x = 0
  elseif right_most_point >= map_width and vel_x > 0 then
    vel_x = 0
  end

  if top_most_point <= 0 and vel_y < 0 then
    vel_y = 0
  elseif bottom_most_point >= map_height and vel_y > 0 then
    vel_y = 0
  end

  body:setLinearVelocity(vel_x, vel_y)
end

return System(components, system)
