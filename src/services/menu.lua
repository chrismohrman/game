--- Menu service
-- Load and store menu settings

local Camera = require 'src/services/camera'
local Input = require 'src/services/input'
local Love = require 'src/services/love'
local Util = require 'src/services/util'

-- Keep track of the menu keys so we can unregister them when the menu unloads
local registered_key_press_callbacks = {}
local registered_key_release_callbacks = {}
-- This gets assigned when a menu is loaded
local active_menu
local menus = {
  main = require 'src/menus/main'
}
local menu_action_directory = 'src/menus/actions'
-- All available menu actions are mapped
-- within and handle by the menu service
local action_map = {}

-- Index the menu actions and map them to "action_map"
local index = function()
  local file_list = Love.filesystem.getDirectoryItems(menu_action_directory)
  for _, file_name in ipairs(file_list) do
    local lua_ext = '.lua'
    local file_ext = string.sub(file_name, -string.len(lua_ext))
    -- Ignore any non-lua files
    if file_ext == lua_ext then
      -- ie., "game-start" for "game-start.lua"
      local file_name_without_ext = file_name:match('(.+)%..+')
      -- ie., "src/menu/actions/game-start"
      local file_path = menu_action_directory .. '/' .. file_name_without_ext
      action_map[file_name_without_ext] = require(file_path)
    end
  end
end

local function draw()
  -- Probably in game at this point
  if not active_menu then
    return
  end

  local left, top = Camera.get_position()
  local window_width, window_height = Love.graphics:getDimensions()

  for idx, element in ipairs(active_menu.elements) do
    -- Don't mutate the element
    local color = {
      element.color[1],
      element.color[2],
      element.color[3],
      element.color[4] or 255
    }
    -- Increase the opacity if this is the main menu
    if idx == active_menu.active_element then
      color[4] = color[4] + 100
    end
    Love.graphics.print(
      { color, element.text },
      left + math.floor(element.pos_x * window_width),
      top + math.floor(element.pos_y * window_height)
    )
  end
end

local function get_key_press_callback(action)
  return function()
    local element = active_menu.elements[active_menu.active_element]
    local element_action = element.input_actions[action]
    if element_action and element_action.key_press then
      for _, key_press in ipairs(element_action.key_press) do
        -- The key_press function may be a navigation change,
        -- returning a value which sets a new active element.
        local results = key_press(active_menu.active_element)
        if results then
          -- Set the new active element, wrapping back around to the begnning
          -- or end if the index number provided is out of bounds.
          if results > #active_menu.elements then
            active_menu.active_element = 1
          elseif results < 1 then
            active_menu.active_element = #active_menu.elements
          else
            active_menu.active_element = results
          end
        end
      end
    end
  end
end

local function get_key_release_callback(action)
  return function()
    local element = active_menu.elements[active_menu.active_element]
    local element_action = element.input_actions[action]
    if element_action and element_action.key_release then
      for _, key_release in ipairs(element_action.key_release) do
        -- The key_press function may be a navigation change,
        -- returning a value which sets a new active element.
        local results = key_release(active_menu.active_element)
        if results then
          -- Set the new active element, wrapping back around to the begnning
          -- or end if the index number provided is out of bounds.
          if results > #active_menu.elements then
            active_menu.active_element = 1
          elseif results < 1 then
            active_menu.active_element = #active_menu.elements
          else
            active_menu.active_element = results
          end
        end
      end
    end
  end
end

local function load(menu_name)
  active_menu = Util.copy(menus[menu_name])
  active_menu.active_element = active_menu.active_element or 1
  for _, element in ipairs(active_menu.elements) do
    for _, action in pairs(element.input_actions) do
      for i = 1, #(action.key_press or {}) do
        --active_menu.elements[element_idx].input_actions[action_idx].key_press[i] = action_map[action.key_press[i]]
        action.key_press[i] = action_map[action.key_press[i]]
      end
      for i = 1, #(action.key_release or {}) do
        action.key_release[i] = action_map[action.key_release[i]]
      end
    end
  end
  -- Register callbacks for all the game inputs so that we
  -- can pipe the input events to the active menu element.
  for _, action in ipairs(Input.get_actions()) do
    local key_press_callback = get_key_press_callback(action)
    local key_release_callback = get_key_release_callback(action)
    registered_key_press_callbacks[action] = key_press_callback
    registered_key_release_callbacks[action] = key_release_callback
    Input.register_key_press(action, key_press_callback)
    Input.register_key_release(action, key_release_callback)
  end
end

local function unload()
  active_menu = nil
  for action, fn in pairs(registered_key_press_callbacks) do
    Input.unregister_key_press(action, fn)
  end
  for action, fn in pairs(registered_key_release_callbacks) do
    Input.unregister_key_release(action, fn)
  end
end

return {
  draw = draw,
  index = index,
  load = load,
  unload = unload
}
