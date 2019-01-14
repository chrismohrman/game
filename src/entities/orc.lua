-- orc

-- Main player

return function()
  return {
    direction_timer = 0,
    acceleration = 140,
    body = {},
    damage = 100,
    defense = 1,
    fixture = {
      category = tonumber('0000000000000100', 2),
      density = 10,
      friction = 0,
      mask = tonumber('1111111111110011', 2)
    },
    health = 100,
    max_speed = 120,
    on_begin_contact = {
      'update-health',
      'flash-damage'
    },
    on_death = {
      'fall-over',
    },

    on_update = {'orc-move'},

    shape = {
      height = 32,
      offset_x = 32,
      offset_y = 46,
      width = 28,
      type = 'rectangle'
    },
    sprites = 'orc'
  }
end
