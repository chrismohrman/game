--- Shader service
-- Load and store shaders

local Love = require 'src/services/love'

local shader_directory = 'src/components/shaders'
local shader_file_ext = '.glsl'
local shaders = {}

local get = function(name)
  return shaders[name]
end

local index = function()
  local file_list = Love.filesystem.getDirectoryItems(shader_directory)
  for _, file_name in ipairs(file_list) do
    local file_ext = string.sub(file_name, -string.len(shader_file_ext))
    -- Only keep files matching the shader file extension
    if (file_ext == shader_file_ext) then
      -- ie., "src/components/flash-damage.glsl"
      local file_path = shader_directory .. '/' .. file_name
      -- ie., "flash-damage" for "flash-damage.glsl"
      local file_name_without_ext = file_name:match('(.+)%..+')
      local file_content = Love.filesystem.read(file_path)
      local parsed_content = Love.graphics.newShader(file_content)
      shaders[file_name_without_ext] = parsed_content
    end
  end
end

return {
  get = get,
  index = index
}
