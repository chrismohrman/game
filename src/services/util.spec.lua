describe('services/util', function()

  local Util

  before_each(function()
    Util = require 'services/util'
  end)

  describe('angle', function()
    it('should exist', function()
      assert.equal('function', type(Util.angle))
    end)

    it('should return the arctangent radians between two vectors', function()
      local expectation = math.atan2(8 - 4, 6 - 2)
      assert.equal(expectation, Util.angle(2, 4, 6, 8))
      expectation = math.atan2(-32 - 14, 16 + 12)
      assert.equal(expectation, Util.angle(-12, 14, 16, -32))
    end)
  end)

  describe('copy', function()
    it('should exist', function()
      assert.equal('function', type(Util.copy))
    end)

    it('should return copies of tables with keys', function()
      local a = { foo = 'bar' }
      local b = a
      local c = Util.copy(a)
      a.foo = 'baz'
      assert.equal('baz', b.foo)
      assert.equal('bar', c.foo)
    end)

    it('should return copies of tables with indexes', function()
      local a = { 'foo', 'bar' }
      local b = a
      local c = Util.copy(a)
      a[1] = 'baz'
      assert.equal('baz', b[1])
      assert.equal('foo', c[1])
    end)

    it('should return deep copies of tables', function()
      local a = {
        foo = {
          bar = {
            'baz'
          }
        }
      }
      local b = Util.copy(a)
      assert.same(b, a)
    end)

    it('should return strings', function()
      local str = 'Foobar123'
      assert.equal('Foobar123', Util.copy(str))
    end)

    it('should return integers', function()
      local int = 7
      assert.equal(7, Util.copy(int))
    end)

    it('should return booleans', function()
      local bool = true
      assert.equal(true, Util.copy(bool))
    end)

    it('should return nils', function()
      assert.equal(nil, Util.copy(nil))
    end)
  end)

  describe('distance', function()
    it('should exist', function()
      assert.equal('function', type(Util.distance))
    end)

    it('should return the squared distance (pixels) between two points', function()
      assert.equal(8, Util.distance(0, 0, 2, 2))
      assert.equal(20, Util.distance(0, 0, 2, 4))
    end)

    it('should return the distance (pixels) between two points', function()
      assert.equal(2.8284271247461903, Util.distance(0, 0, 2, 2, false))
      assert.equal(4.47213595499958, Util.distance(0, 0, 2, 4, false))
    end)

    it('should return 0 for identical points', function()
      assert.equal(0, Util.distance(2, 4, 2, 4))
    end)
  end)

  describe('push', function()
    it('should exist', function()
      assert.equal('function', type(Util.push))
    end)

    it('should modify the given table', function()
      local t = { 1, 2 }
      Util.push(t, 3)
      assert.equal(1, t[1])
      assert.equal(2, t[2])
      assert.equal(3, t[3])
    end)

    it('should accept a list of elements to push', function()
      local t = { 1 }
      Util.push(t, 2, 3)
      assert.equal(1, t[1])
      assert.equal(2, t[2])
      assert.equal(3, t[3])
    end)

    it('should ignore nil values', function()
      local t = { 1 }
      Util.push(t, nil, 2)
      assert.equal(1, t[1])
      assert.equal(2, t[2])
      assert.equal(nil, t[3])
    end)
  end)

  describe('reduce', function()
    it('should exist', function()
      assert.equal('function', type(Util.reduce))
    end)

    it('should reduce an array to a combinator\'s value', function()
      local array = { 1, 2, 3 }
      local combinator = function(a, b)
        return a + b
      end

      assert.equal(6, Util.reduce(array, combinator))
      assert.equal(9, Util.reduce(array, combinator, 3))
    end)

    it('should throw an error if no values were passed in', function()
      local combinator = function(a, b)
        return a + b
      end

      assert.errors(function()
        Util.reduce()
      end)
      assert.errors(function()
        Util.reduce({}, combinator)
      end)
    end)
  end)

  describe('split', function()
    it('should exist', function()
      assert.equal('function', type(Util.split))
    end)

    it('should split a string with the given separator', function()
      local str = 'foo-bar-baz'
      local expectation = { 'foo', 'bar', 'baz' }
      assert.same(expectation, Util.split(str, '-'))
      str = 'foo bar baz'
      assert.same(expectation, Util.split(str, ' '))
      str = 'foo%bar%baz'
      assert.same(expectation, Util.split(str, '%'))
      str = 'foo$bar$baz'
      assert.same(expectation, Util.split(str, '$'))
    end)

    it('should split a string with a multi-character separator', function()
      local str = 'foo%%%bar%%%baz'
      local expectation = { 'foo', 'bar', 'baz' }
      assert.same(expectation, Util.split(str, '%%%'))
    end)

    it('should default to a whitespace separator if none is given', function()
      local str = 'foo bar baz'
      local expectation = { 'foo', 'bar', 'baz' }
      assert.same(expectation, Util.split(str))
    end)

    it('should assert that the separator is at least one character', function()
      local str = 'foo bar baz'
      assert.errors(function()
        Util.split(str, '')
      end)
    end)
  end)

end)
