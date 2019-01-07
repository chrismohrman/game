--- A wrapper for the love global so that we can mock it in specs

if love then
  return love
end

local love = {}

assert(jit ~= nil, '"jit" global not found. Is this LuaJIT?')
local Base64 = require 'src/services/base64'
local is_windows = jit.os == 'Windows'

love.filesystem = {}
love.filesystem.getDirectoryItems = function(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile
  if is_windows then
    pfile = popen('dir "'..directory..'" /b /ad')
  else
    pfile = popen('ls -a "'..directory..'"')
  end
  for filename in pfile:lines() do
      i = i + 1
      t[i] = filename
  end
  pfile:close()
  return t
end
love.filesystem.read = function(file_path)
  local file = io.open(file_path, "r")
  local content = file:read('*all')
  file:close()
  return content
end

love.graphics = {}
love.graphics.draw = function() end
love.graphics.getDimensions = function()
  return 512, 512
end
love.graphics.newImage = function()
  return {
    getHeight = function()
      return 512
    end,
    getWidth = function()
      return 512
    end
  }
end
love.graphics.newQuad = function()
  return {
    getViewport = function()
      return nil, nil, 32, 32
    end
  }
end
love.graphics.newShader = function()
  return {}
end
love.graphics.polygon = function()
  return true
end
love.graphics.push = function() end
love.graphics.rotate = function() end
love.graphics.scale = function() end
love.graphics.setColor = function()
  return true
end
love.graphics.setDefaultFilter = function() end
love.graphics.translate = function() end

love.math = {}
-- TODO, implement real decompression
love.math.decompress = function()
  -- Ascii representation of the decompressed byte string
  return Base64.decode('pAAAAKQAAACkAAAAoQAAAA==')
end

love.physics = {}
love.physics.newBody = function()
  return 'body'
end
love.physics.newFixture = function(body, shape)
  return {
    body = body,
    getBody = function()
      return body
    end,
    getShape = function()
      return shape
    end,
    setGroupIndex = function() end,
    shape = shape
  }
end
love.physics.newPolygonShape = function()
  return 'polygon'
end
love.physics.newRectangleShape = function()
  return 'rectangle'
end
love.physics.newWorld = function()
  local world = {}
  function world:setCallbacks()
    return self
  end
  function world:setContactFilter()
    return self
  end
  return world
end
love.physics.setMeter = function() end

return love
