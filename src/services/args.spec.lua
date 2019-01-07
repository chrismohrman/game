describe('services/args', function()

  local service

  -- Tear down stateful service between tests
  before_each(function()
    service = require 'src/services/args'
  end)
  after_each(function()
    service = nil
    package.loaded['src/services/args'] = nil
  end)

  describe('load', function()
    it('should exist', function()
      assert.equal('function', type(service.load))
    end)

    it('should collect and return arguments', function()
      local args = { 'debug', 'foo' }
      service.load(args)
      assert.equal(true, service.get_arg('debug'))
      assert.equal(true, service.get_arg('foo'))
      assert.equal(false, service.get_arg('bar'))
    end)
  end)

end)
