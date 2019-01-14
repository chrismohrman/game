-- Main player

return function()
  return {
    acceleration = 140,
    body = {},
    damage = 100,
    defense = 1,
    fixture = {
      category = tonumber('0000000000000001', 2),
      density = 10,
      friction = 0,
      mask = tonumber('1111111111111100', 2)
    },
    health = 100,
    input_actions = {
      down = {
        key_press = 'move-down-begin',
        key_release = 'move-down-finish'
      },
      left = {
        key_press = 'move-left-begin',
        key_release = 'move-left-finish'
      },
      right = {
        key_press = 'move-right-begin',
        key_release = 'move-right-finish'
      },
      up = {
        key_press = 'move-up-begin',
        key_release = 'move-up-finish'
      },
      start = {
        key_press = 'toggle-pause'
      },
      --button1 = {
        --key_press = 'player-jab'
      --}
    },
    max_speed = 120,
    on_begin_contact = {
      'update-health',
      'flash-damage'
    },
    on_death = {
      'fall-over',
      'unregister-player'
    },
    on_spawn = {
      'register-player'
    },
    player_id = 1,
    shape = {
      --points = {
        --12, 4,
        --20, 4,
        --24, 16,
        --20, 28,
        --12, 28,
        --8, 16
      --},
      --type = 'polygon'
      height = 32,
      offset_x = 32,
      offset_y = 46,
      width = 32,
      type = 'rectangle'
    },
    sprites = 'player'
  }
end
