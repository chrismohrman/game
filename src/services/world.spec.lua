describe('services/world', function()

  local Love = require 'src/services/love'

  it('should set the meter when required', function()
    spy.on(Love.physics, 'setMeter')
    require 'src/services/world'
    assert.spy(Love.physics.setMeter).called(1)
    assert.spy(Love.physics.setMeter).called_with(32)
    package.loaded['src/services/world'] = nil
  end)

  it('should create a new world when required', function()
    spy.on(Love.physics, 'newWorld')
    require 'src/services/world'
    assert.spy(Love.physics.newWorld).called(1)
    assert.spy(Love.physics.newWorld).called_with(0, 0, true)
    package.loaded['src/services/world'] = nil
  end)

  it('should return the world', function()
    local service = require 'src/services/world'
    assert.equal('function', type(service.setCallbacks))
  end)

end)
