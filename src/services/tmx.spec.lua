describe('services/tmx', function()

  local Base64 = require 'src/services/base64'
  local Tmx

  -- Mock Love dependency
  before_each(function()
    local love_mock = {
      math = {
        decompress = function()
          -- Ascii representation of the decompressed byte string
          return Base64.decode('pAAAAKQAAACkAAAAoQAAAA==')
        end
      }
    }
    package.loaded['src/services/love'] = love_mock
  end)
  after_each(function()
    package.loaded['src/services/love'] = nil
  end)

  before_each(function()
    Tmx = require 'src/services/tmx'
  end)
  after_each(function()
    package.loaded['src/services/tmx'] = nil
    Tmx = nil
  end)

  describe('parse', function()
    it('should exist', function()
      assert.equal('function', type(Tmx.parse))
    end)

    it('should parse tilesets', function()
      local test_tmx = [[
        <?xml version="1.0" encoding="UTF-8"?>
        <map
          version="1.0"
          orientation="orthogonal"
          renderorder="right-down"
          width="2"
          height="2"
          tilewidth="32"
          tileheight="32"
          nextobjectid="1">

          <tileset
            firstgid="1"
            name="general"
            tilewidth="32"
            tileheight="32"
            tilecount="256"
            columns="16">

            <image source="../../img/general.png" trans="ffffff" width="512" height="512"/>
          </tileset>
          <tileset firstgid="257" name="countryside" tilewidth="24" tileheight="24" tilecount="4" columns="2">
            <image source="../../img/countryside.png" trans="000000" width="64" height="64"/>
          </tileset>
        </map>
      ]]

      local results = Tmx.parse('foo', test_tmx)
      assert.equal(2, results.columns)

      assert.equal('table', type(results.tilesets))
      assert.equal(2, #results.tilesets)

      local tileset1 = results.tilesets[1]
      assert.equal(16, tileset1.columns)
      assert.equal('img/general.png', tileset1.source)
      assert.equal(256, tileset1.tile_count)
      assert.equal(32, tileset1.tile_height)
      assert.equal(32, tileset1.tile_width)
      assert.equal('ffffff', tileset1.transparency)

      local tileset2 = results.tilesets[2]
      assert.equal(2, tileset2.columns)
      assert.equal('img/countryside.png', tileset2.source)
      assert.equal(4,tileset2.tile_count)
      assert.equal(24,tileset2.tile_height)
      assert.equal(24,tileset2.tile_width)
      assert.equal('000000', tileset2.transparency)
    end)

    it('should parse xml-format tile layers', function()
      local test_tmx = [[
        <?xml version="1.0" encoding="UTF-8"?>
        <map
          version="1.0"
          orientation="orthogonal"
          renderorder="right-down"
          width="2"
          height="2"
          tilewidth="32"
          tileheight="32"
          nextobjectid="1">
          <tileset firstgid="1" name="general" tilewidth="32" tileheight="32" tilecount="256" columns="16">
            <image source="../../img/general.png" trans="ffffff" width="512" height="512"/>
          </tileset>
          <layer name="Tile Layer 1" width="2" height="2">
            <data>
              <tile gid="1"/>
              <tile gid="2"/>
              <tile gid="17"/>
              <tile gid="18"/>
            </data>
          </layer>
        </map>
      ]]

      local results = Tmx.parse('foo', test_tmx)
      assert.equal(2, results.columns)
      assert.equal(1, #results.layers)
      assert.equal(4, #results.layers[1].data)
      assert.equal(1, results.layers[1].data[1])
      assert.equal(2, results.layers[1].data[2])
      assert.equal(17, results.layers[1].data[3])
      assert.equal(18, results.layers[1].data[4])

      assert.equal('orthogonal', results.orientation)
      assert.equal('right-down', results.render_order)
      assert.equal(2, results.rows)
      assert.equal(32, results.tile_height)
      assert.equal(32, results.tile_width)

      assert.equal('table', type(results.tilesets))
      assert.equal(1, #results.tilesets)

      local tileset = results.tilesets[1]
      assert.equal(16, tileset.columns)
      assert.equal('img/general.png', tileset.source)
      assert.equal(256, tileset.tile_count)
      assert.equal(32, tileset.tile_height)
      assert.equal(32, tileset.tile_width)
      assert.equal('ffffff', tileset.transparency)
    end)

    it('should parse csv-format tile layers', function()
      local test_tmx = [[
        <?xml version="1.0" encoding="UTF-8"?>
        <map
          version="1.0"
          orientation="orthogonal"
          renderorder="right-down"
          width="2"
          height="2"
          tilewidth="32"
          tileheight="32"
          nextobjectid="1">

          <tileset
            firstgid="1"
            name="general"
            tilewidth="32"
            tileheight="32"
            tilecount="256"
            columns="16">

            <image source="../../img/general.png" trans="ffffff" width="512" height="512"/>
          </tileset>
          <layer name="My base layer" width="2" height="2">
            <data encoding="csv">
              1,2,
              17,18
            </data>
          </layer>
        </map>
      ]]

      local results = Tmx.parse('foo', test_tmx)
      assert.equal(2, results.columns)
      assert.equal(1, #results.layers)
      assert.equal(4, #results.layers[1].data)
      assert.equal(1, results.layers[1].data[1])
      assert.equal(2, results.layers[1].data[2])
      assert.equal(17, results.layers[1].data[3])
      assert.equal(18, results.layers[1].data[4])

      assert.equal('orthogonal', results.orientation)
      assert.equal('right-down', results.render_order)
      assert.equal(2, results.rows)
      assert.equal(32, results.tile_height)
      assert.equal(32, results.tile_width)

      assert.equal('table', type(results.tilesets))
      assert.equal(1, #results.tilesets)

      local tileset = results.tilesets[1]
      assert.equal(16, tileset.columns)
      assert.equal('img/general.png', tileset.source)
      assert.equal(256, tileset.tile_count)
      assert.equal(32,tileset.tile_height)
      assert.equal(32, tileset.tile_width)
      assert.equal('ffffff', tileset.transparency)
    end)

    it('should parse gzip-compressed tile layers', function()
      local test_tmx = [[
        <?xml version="1.0" encoding="UTF-8"?>
        <map
          version="1.0"
          orientation="orthogonal"
          renderorder="right-down"
          width="2"
          height="2"
          tilewidth="32"
          tileheight="32"
          nextobjectid="2">

          <tileset
            firstgid="1"
            name="general"
            tilewidth="32"
            tileheight="32"
            tilecount="256"
            columns="16">

            <image source="../../img/general.png" trans="ffffff" width="512" height="512"/>
          </tileset>
          <layer name="My base layer" width="2" height="2">
            <data encoding="base64" compression="gzip">
              eJxbwsDAsASKFwIxABmkAo4=
            </data>
          </layer>
        </map>
      ]]

      local results = Tmx.parse('foo', test_tmx)
      assert.equal(2, results.columns)
      assert.equal(1, #results.layers)
      assert.equal(4, #results.layers[1].data)
      assert.equal(164, results.layers[1].data[1])
      assert.equal(164, results.layers[1].data[2])
      assert.equal(164, results.layers[1].data[3])
      assert.equal(161, results.layers[1].data[4])

      assert.equal('orthogonal', results.orientation)
      assert.equal('right-down', results.render_order)
      assert.equal(2, results.rows)
      assert.equal(32, results.tile_height)
      assert.equal(32, results.tile_width)

      assert.equal('table', type(results.tilesets))
      assert.equal(1, #results.tilesets)

      local tileset = results.tilesets[1]
      assert.equal(16, tileset.columns)
      assert.equal('img/general.png', tileset.source)
      assert.equal(256, tileset.tile_count)
      assert.equal(32, tileset.tile_height)
      assert.equal(32, tileset.tile_width)
      assert.equal('ffffff', tileset.transparency)
    end)

    it('should parse zlib-compressed tile layers', function()
      local love_mock = {
        math = {
          decompress = function()
            return Base64.decode('pAAAAKQAAACkAAAAoQAAAA==')
          end
        }
      }
      package.loaded['src/services/love'] = love_mock
      local test_tmx = [[
        <?xml version="1.0" encoding="UTF-8"?>
        <map
          version="1.0"
          orientation="orthogonal"
          renderorder="right-down"
          width="2"
          height="2"
          tilewidth="32"
          tileheight="32"
          nextobjectid="2">

          <tileset
            firstgid="1"
            name="general"
            tilewidth="32"
            tileheight="32"
            tilecount="256"
            columns="16">

            <image source="../../img/general.png" trans="ffffff" width="512" height="512"/>
          </tileset>
          <layer name="My base layer" width="2" height="2">
            <data encoding="base64" compression="zlib">
              eJxbwsDAsASKFwIxABmkAo4=
            </data>
          </layer>
          <objectgroup name="collision">
            <object id="1" name="lil grass box" type="cute" x="32" y="32" width="32" height="32">
              <properties>
                <property name="crazy" value="definitely"/>
              </properties>
            </object>
            <object id="28" name="Triangle" x="608" y="128">
              <polygon points="0,0 96,96 0,96"/>
            </object>
          </objectgroup>
        </map>
      ]]

      local results = Tmx.parse('foo', test_tmx)
      assert.equal(2, results.columns)
      assert.equal(2, #results.layers)

      local layer1 = results.layers[1]
      assert.equal('table', type(layer1))
      assert.equal('tiles', layer1.type)
      assert.equal('table', type(layer1.data))
      assert.equal(4, #layer1.data)
      assert.equal(164, layer1.data[1])
      assert.equal(164, layer1.data[2])
      assert.equal(164, layer1.data[3])
      assert.equal(161, layer1.data[4])

      local layer2 = results.layers[2]
      assert.equal('table', type(layer2))
      assert.equal('objects', layer2.type)
      assert.equal('table', type(layer2.objects))

      assert.equal('orthogonal', results.orientation)
      assert.equal('right-down', results.render_order)
      assert.equal(2, results.rows)
      assert.equal(32, results.tile_height)
      assert.equal(32, results.tile_width)

      assert.equal('table', type(results.tilesets))
      assert.equal(1, #results.tilesets)

      local tileset = results.tilesets[1]
      assert.equal(16, tileset.columns)
      assert.equal('img/general.png', tileset.source)
      assert.equal(256, tileset.tile_count)
      assert.equal(32, tileset.tile_height)
      assert.equal(32, tileset.tile_width)
      assert.equal('ffffff', tileset.transparency)
    end)

    it('should parse object layers', function()
      local test_tmx = [[
        <?xml version="1.0" encoding="UTF-8"?>
        <map
          version="1.0"
          orientation="orthogonal"
          renderorder="right-down"
          width="2"
          height="2"
          tilewidth="32"
          tileheight="32"
          nextobjectid="2">

          <tileset
            firstgid="1"
            name="general"
            tilewidth="32"
            tileheight="32"
            tilecount="256"
            columns="16">

            <image source="../../img/general.png" trans="ffffff" width="512" height="512"/>
          </tileset>
          <layer name="Tile Layer 1" width="2" height="2">
            <data>
              <tile gid="1"/>
              <tile gid="2"/>
             <tile gid="17"/>
             <tile gid="18"/>
            </data>
          </layer>
          <objectgroup name="collision">
            <object id="1" name="lil grass box" type="cute" x="32" y="32" width="32" height="32" rotation="-45">
              <properties>
                <property name="crazy" value="definitely"/>
              </properties>
            </object>
            <object id="28" name="Triangle" x="608" y="128">
              <polygon points="0,0 96,96 0,96"/>
            </object>
          </objectgroup>
        </map>
      ]]

      -- example object layer:
      -- {
      --   objects = {
      --     {
      --       crazy = 'definitely',
      --       height = 32,
      --       name = 'lil grass box',
      --       pos_x = 32,
      --       pos_y = 32,
      --       type = 'cute',
      --       width = 32
      --     },
      --     {
      --       name = 'Triangle',
      --       points = { 0, 0, 96, 96, 0, 96 },
      --       pos_x = 608,
      --       pos_y = 128
      --     }
      --   },
      --   type = 'objects'
      -- }

      local results = Tmx.parse('foo', test_tmx)

      assert.equal(2, #results.layers)

      local object_layer = results.layers[2]
      assert.equal('table', type(object_layer))
      assert.equal('objects', object_layer.type)
      assert.equal('table', type(object_layer.objects))

      local object1 = object_layer.objects[1]
      assert.equal('definitely', object1.crazy)
      assert.equal(32, object1.height)
      assert.equal('lil grass box', object1.name)
      assert.equal(32, object1.pos_x)
      assert.equal(32, object1.pos_y)
      -- Convert tiled rotation degrees to box2d radians
      assert.equal(math.rad(-45), object1.rotation)
      assert.equal('cute', object1.type)
      assert.equal(32, object1.width)

      local object2 = object_layer.objects[2]
      assert.equal('Triangle', object2.name)
      assert.equal('table', type(object2.points))
      assert.equal(6, #object2.points)
      assert.equal(0, object2.points[1])
      assert.equal(0, object2.points[2])
      assert.equal(96, object2.points[3])
      assert.equal(96, object2.points[4])
      assert.equal(0, object2.points[5])
      assert.equal(96, object2.points[6])
      assert.equal(608, object2.pos_x)
      assert.equal(128, object2.pos_y)
    end)
  end)

end)
