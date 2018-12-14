return function()
    local window_width, window_height = love.window.getMode()

    local entity = {}

    entity.draw = function(self)
        local state = require('state')
        local color = {1.0, 1.0, 1.0, 1.0}  -- white
        if state.game_over then
            love.graphics.print(
                {color, 'YOU DIED'},
                math.floor(window_width / 2) -50,
                math.floor(window_height / 2) - 50,
                0,
                2,
                2
        )
        end
    end

    return entity
end