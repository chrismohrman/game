describe('systems/register-callbacks', function()

  local system = require 'src/systems/register-callbacks'

  describe('it should be a function', function()
    assert.equal('function', type(system))
  end)

end)
