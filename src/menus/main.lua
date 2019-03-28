return function()
  local btn_start = {
    color = { 1, 1, 0, 0.8 },
    text = 'Start',
    pos_x = 0.4,
    pos_y = 0.3,
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
    color = { 1, 1, 0, 0.8 },
    text = 'Quit',
    pos_x = 0.4,
    pos_y = 0.5,
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

  local background = {
    file_name = 'img/title.png',
    pos_x = 0.31,
    pos_y = 0.1
  }

  return {
    background = background,
    elements = {
      btn_start,
      btn_quit
    }
  }
end