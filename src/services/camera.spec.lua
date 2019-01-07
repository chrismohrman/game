describe('services/camera', function()

  local service

  -- Tear down stateful service between tests
  before_each(function()
    service = require 'src/services/camera'
  end)
  after_each(function()
    service = nil
    package.loaded['src/services/camera'] = nil
  end)

  describe('set_position and get_position', function()
    it('should exist', function()
      assert.equal('function', type(service.set_position))
      assert.equal('function', type(service.get_position))
    end)

    it('should should retain the state of the given positions', function()
      local pos_x, pos_y = 12, 45
      service.set_position(pos_x, pos_y)
      local result_pos_x, result_pos_y = service.get_position()
      assert.equal(pos_x, result_pos_x)
      assert.equal(pos_y, result_pos_y)
    end)
  end)

end)
