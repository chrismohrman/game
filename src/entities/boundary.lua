-- Special entity factory for the map boundaries

return function(boundary_object)
  local shape_type = nil
  local offset_x = 0
  local offset_y = 0
  if boundary_object.width then
    offset_x = boundary_object.width / 2
    offset_y = boundary_object.height / 2
    shape_type = 'rectangle'
  end
  return {
    body = {
      offset_x = offset_x,
      offset_y = offset_y,
      type = 'static'
    },
    fixture = {
      category = tonumber('1000000000000000', 2),
      mask = tonumber('1111111111111111', 2)
    },
    shape = {
      height = boundary_object.height,
      points = boundary_object.points,
      type = shape_type,
      width = boundary_object.width
    }
  }
end
