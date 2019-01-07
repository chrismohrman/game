local btn_start = {
  color = { 192, 192, 192, 155 },
  text = 'Start',
  pos_x = 0.1,
  pos_y = 0.1,
  input_actions = {
    up = {
      key_press = { 'element-previous' }
    },
    down = {
      key_press = { 'element-next' }
    },
    button1 = {
      key_press = { 'game-start', 'menu-unload' }
    },
    start = {
      key_press = { 'game-start', 'menu-unload' }
    }
  }
}

local btn_quit = {
  color = { 192, 192, 192, 155 },
  text = 'Quit',
  pos_x = 0.1,
  pos_y = 0.3,
  input_actions = {
    up = {
      key_press = { 'element-previous' }
    },
    down = {
      key_press = { 'element-next' }
    },
    start = {
      key_press = { 'program-quit' }
    }
  }
}

return {
  elements = {
    btn_start,
    btn_quit
  }
}
