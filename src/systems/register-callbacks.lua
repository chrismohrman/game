--- RegisterCallbacks
-- Look for event callbacks the given entity wants to use

local System = require 'lib/system'

local components = { '_entity' }

local system = function(entity)

  local systems_dir = 'src/systems/actions/'

  local on_begin_contact = {}
  local on_death = {}
  local on_end_contact = {}
  local on_post_contact = {}
  local on_pre_contact = {}
  local on_spawn = {}
  local on_update = {}

  if entity.on_begin_contact then
    for _, value in ipairs(entity.on_begin_contact) do
      table.insert(on_begin_contact, require(systems_dir .. value))
    end
    entity.on_begin_contact = on_begin_contact
  end

  if entity.on_death then
    for _, value in ipairs(entity.on_death) do
      table.insert(on_death, require(systems_dir .. value))
    end
    entity.on_death = on_death
  end

  if entity.on_end_contact then
    for _, value in ipairs(entity.on_end_contact) do
      table.insert(on_end_contact, require(systems_dir .. value))
    end
    entity.on_end_cotact = on_end_contact
  end

  if entity.on_post_contact then
    for _, value in ipairs(entity.on_post_contact) do
      table.insert(on_post_contact, require(systems_dir .. value))
    end
    entity.on_post_contact = on_post_contact
  end

  if entity.on_pre_contact then
    for _, value in ipairs(entity.on_pre_contact) do
      table.insert(on_pre_contact, require(systems_dir .. value))
    end
    entity.on_pre_contact = on_pre_contact
  end

  if entity.on_spawn then
    for _, value in ipairs(entity.on_spawn) do
      table.insert(on_spawn, require(systems_dir .. value))
    end
    entity.on_spawn = on_spawn
  end

  if entity.on_update then
    for _, value in ipairs(entity.on_update) do
      table.insert(on_update, require(systems_dir .. value))
    end
    entity.on_update = on_update
  end
end

return System(components, system)
