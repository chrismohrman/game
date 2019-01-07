--- RegisterInput
-- Register entity's callbacks for key presses / key releases

local System = require 'lib/system'

local Input = require 'src/services/input'

local components = {
  '_entity',
  'input_actions'
}

local system = function(entity, input_actions)
  local systems_dir = 'src/systems/actions/'

  for key, action in pairs(input_actions) do

    if action.key_press then
      action.key_press = require(systems_dir .. action.key_press)
      Input.register_key_press(key, function()
        action.key_press(entity)
      end)
    end

    if action.key_release then
      action.key_release = require(systems_dir .. action.key_release)
      Input.register_key_release(key, function()
        action.key_release(entity)
      end)
    end

  end

end

return System(components, system)
