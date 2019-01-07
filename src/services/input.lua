--- Input service
-- Store and process callbacks for input actions

local Util = require 'src/services/util'

local service = {}

local key_map = {
  dpdown = 'down',
  dpleft = 'left',
  dpright = 'right',
  dpup = 'up',
  down = 'down',
  left = 'left',
  right = 'right',
  up = 'up',
  ['return'] = 'start',
  x = 'button1',
  c = 'button2'
}
-- Buffer key releases to trigger when unpausing
local pause_buffer
local press_callbacks = {
  down = {},
  left = {},
  up = {},
  right = {},
  start = {},
  shot1 = {},
  shot2 = {}
}
local release_callbacks = Util.copy(press_callbacks)

local call_key_press = function(pressed_key)
  -- Translate the pressed key into a game action
  local action = key_map[pressed_key]
  -- Ignore unmapped keys
  if not action then return end

  if service.is_paused() then
    -- Special exception for the pause key
    if action == 'start' then
      service.toggle_paused()
      return
    end
    -- Remove any buffered key releases because the player
    -- pressed the key back down while still paused.
    pause_buffer[action] = nil
    return
  end

  local array = press_callbacks[action]

  if array then
    local i = 1
    while array[i] do
      array[i]()
      i = i + 1
    end
  end
end

local call_key_release = function(released_key)
  -- Translate the pressed key into a game action
  local action = key_map[released_key]
  -- Ignore unmapped keys
  if not action then return end

  if service.is_paused() then
    pause_buffer[action] = true
    return
  end

  local array = release_callbacks[action]

  if (array) then
    local i = 1
    while array[i] do
      array[i]()
      i = i + 1
    end
  end
end

local get_actions = function()
  local actions = {}
  local n = 0

  for k in pairs(press_callbacks) do
    n = n + 1
    actions[n] = k
  end
  return actions
end

local is_paused = function()
  return type(pause_buffer) == 'table'
end

local register_key_press = function(key, fn)
  table.insert(press_callbacks[key], fn)
  return fn
end

local register_key_release = function(key, fn)
  table.insert(release_callbacks[key], fn)
  return fn
end

local toggle_paused = function()
  if is_paused() then
    -- Copy the pause buffer so we can go ahead
    -- and unpause the game by removing the buffer
    local pause_buffer_copy = Util.copy(pause_buffer)
    pause_buffer = nil
    -- Pause buffer removed, call any key releases
    for k, _ in pairs(pause_buffer_copy) do
      service.call_key_release(k)
    end
  else
    pause_buffer = {}
  end
end

local unregister_key_press = function(action, fn)
  local index_to_remove = nil
  for idx, value in ipairs(press_callbacks[action]) do
    if value == fn then
      index_to_remove = idx
    end
  end
  assert(
    index_to_remove ~= nil,
    'Key-press function to unregister does not exist!'
  )
  table.remove(press_callbacks[action], index_to_remove)
end

local unregister_key_release = function(action, fn)
  local index_to_remove = nil
  for idx, value in ipairs(release_callbacks[action]) do
    if value == fn then
      index_to_remove = idx
    end
  end
  assert(
    index_to_remove ~= nil,
    'Key-release function to unregister does not exist!'
  )
  table.remove(release_callbacks[action], index_to_remove)
end

service.call_key_press = call_key_press
service.call_key_release = call_key_release
service.get_actions = get_actions
service.is_paused = is_paused
service.register_key_press = register_key_press
service.register_key_release = register_key_release
service.unregister_key_press = unregister_key_press
service.unregister_key_release = unregister_key_release
service.toggle_paused = toggle_paused
return service
