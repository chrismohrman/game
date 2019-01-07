describe('systems/call-on-update', function()

  local system = require 'src/systems/call-on-update'

  describe('it should be a function', function()
    assert.equal('function', type(system))
  end)

end)
