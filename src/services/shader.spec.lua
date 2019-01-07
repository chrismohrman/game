describe('services/shader', function()

  local service

  -- Tear down the stateful service between tests
  before_each(function()
    service = require 'src/services/shader'
  end)
  after_each(function()
    package.loaded['src/services/shader'] = nil
    service = nil
  end)

  describe('get', function()
    it('should exist', function()
      assert.equal('function', type(service.get))
    end)
  end)

  describe('index', function()
    it('should exist', function()
      assert.equal('function', type(service.index))
    end)
  end)

end)
