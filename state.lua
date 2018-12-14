local player_factory = require('entities/player')
local bag_factory = require('entities/bag')
local orc_factory = require('entities/orc')
local skeleton_factory = require('entities/skeleton')
local game_over_factory = require('entities/game-over')


return {
    game_over = false,
    entities = {
    player_factory(300, 200),
    bag_factory(250, 400, 'orange'),
    bag_factory(275, 450, 'green'),
    orc_factory(10, 200),
    orc_factory(100, 200),
    skeleton_factory(45, 300),
    skeleton_factory(150, 375),
    game_over_factory()
    }
}
