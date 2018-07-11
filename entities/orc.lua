local anim8 = require('anim8')
local world = require('world')
local image = love.graphics.newImage('images/orc.png')
local grid = anim8.newGrid(64, 64, image:getWidth(), image:getHeight())
local entity = {}
entity.image = image
entity.sprites = {}
entity.sprites.move_down = anim8.newAnimation(grid('1-9', 9), 0.25     )
entity.sprites.move_left = anim8.newAnimation(grid('1-9', 10), 0.25)
entity.sprites.move_right = anim8.newAnimation(grid('1-9', 11), 0.25)
entity.sprites.move_up = anim8.newAnimation(grid('1-9', 12), 0.25)
entity.sprites.stand_down = anim8.newAnimation(grid(1, 9), 0.25)
entity.sprites.stand_left = anim8.newAnimation(grid(1, 10), 0.25)
entity.sprites.stand_right = anim8.newAnimation(grid(1, 11), 0.25)
entity.sprites.stand_up = anim8.newAnimation(grid(1, 12), 0.25)
entity.x = 10
entity.y = 200
entity.body = love.physics.newBody(world, entity.x, entity.y, 'dynamic')
entity.body:setFixedRotation(true)
entity.shape = love.physics.newRectangleShape(32, 46, 32, 32)
entity.fixture = love.physics.newFixture(entity.body, entity.shape)
entity.direction_timer = 0

entity.active_sprite = entity.sprites.stand_down
return entity
