# Entity API

Entities are composed entirely from table properties (often called "aspects").
Rather than inheriting classes that contain functions and states, the functions are abstracted into modular systems and the entity will only hold its state. Below is a list of all possible aspects.

## Aspects

### acceleration (number)

The amount of velocity an entity gains each update.

### body (table)

Given an empty table, all the default values will be assumed.
Given a `nil` value instead of a table, the entity won't be given a body.

- `fixed_rotation` (boolean = true) Whether or not an entity should have rotation movement [[1](https://love2d.org/wiki/Body:setFixedRotation)].
- `offset_x` (number = 0) Add a positive/negative horizontal pixel offset from all of the entity's designated spawn points.
- `offset_y` (number = 0) Add a positive/negative vertical pixel offset from all of the entity's designated spawn points.
- `type` (string = 'dynamic') Set the Box2D body type. [[1](https://github.com/GuidebeeGameEngine/Box2D/wiki/Body-Types)]
  - `dynamic` - Body has a given mass and interactions with other bodies.
  - `kinematic` - Body interacts with dynamic bodies but cannot be moved by them.
  - `static` - Body interacts with dynamic bodies but cannot be moved by them and never has velocity.

### dead (true)

If value is present, the entity will be excluded from actions not allowed when dead, such as moving.

### damage (number = 0)

How much damage the entity will do to another entity on contact.

### defense (number = 1)

Divides the damage received from another entity:

`health = health - (other_entity.damage / defense)`

### destroyed (true)

When flag is present, entity will be cleaned up next game loop.

### fixture (table)

- category (number = 0) The collision category. Existing categories:
  - 32768: boundaries
  - 16384: not used
  - 8192: not used
  - 4096: not used
  - 2048: not used
  - 1024: not used
  - 512: not used
  - 256: not used
  - 128: not used
  - 64: not used
  - 32: not used
  - 16: not used
  - 8: enemy projectile
  - 4: enemy
  - 2: player projectile
  - 1: player
- density (number) The fixture density in kilograms per square meter (the definition of a meter is found in the world's service). [[1](https://love2d.org/wiki/Fixture:setDensity)]
- friction (number) Set the contact sliding friction. [[1](https://love2d.org/wiki/Fixture:setFriction)]
- mask (number = 0) Set which fixture categories are filtered from collision. Each category above can be expressed as a binary bit. For instance, `tonumber('1000000000000011', 2)` would include *only* boundaries, players, and player projectiles. In a decimal expression, that would be the same as adding all the categories together (which is `65535`) and subtract the categories you want to ignore from that. For instance, a player doesn't collide with players or player projectiles so the formula for that would be `65535 - 2 - 1`.

### health (number)

The entity's starting health.

### input_actions (table)

Each key in the table corresponds to an input action and the value corresponds to the action the entity wants to perform when that button/key is presset.
The inputs are typically registered to the input on spawn and unregistered on death.
Available actions: `up`, `down`, `left`, `right`, `start`, `button1`, `button2`
Example:

```lua
input_actions = {
  left = {
    key_press = 'move-left-begin',
    key_release = 'move-left-finish'
  },
  right = {
    key_press = 'move-right-begin',
    key_release = 'move-right-finish'
  }
}
```

### max_speed (number)

The maximum velocity an entity can travel.

### on_begin_contact (table)

An array of strings, each string being the name of a system to invoke when the entity begins contact with another entity.
The systems are passed one parameter, `entity`, being the entity's table.
The systems are invoked in order.
Example:

```lua
on_begin_contact = { 'update-health', 'flash-damage' }
```

### on_death (table)

An array of strings, each string being the name of a system to invoke when the entity's health reach zero or below.
The systems are passed one parameter, `entity`, being the entity's table.
The systems are invoked in order.

### on_update (table)

An array of strings, each string being the name of a system to invoke each game loop.
The systems are passed two parameters, `entity`, being the entity's table, and `dt` being the delta time since the previous update.
The systems are invoked in order.

### player_id (number)

If the spawned entity is a player, this is assigned automatically to determine which player number the entity is.

### shape (table)

The shape is attached to the fixture and determines the entity's hitbox.

- points (table) an array of number x and y coordinates indicating all the corners of the polygon. This is only used when the shape `type` is `polygon` (see below).
- type (string) Set the shape type. This will determine what other parameters are required to define the shape. [[1](https://love2d.org/wiki/ShapeType)].
  - `chain` - Similar to an `edge`, except that loops back to the first point.
  - `circle` - This will create a circular shape. Instead of defining a `points` table as you would with a `polygon` type shape, a `radius` is specified instead.
  - `edge` - A 2D shape defined by `points`. It does not have volume and can only collide with `circle` and `polygon` type shapes [[1](https://love2d.org/wiki/EdgeShape)].
  - `polygon` - Create a polygon based on defined `points` (as opposed to `radius` as with `circle` type shapes or `width` and `height` as with `rectangle` type shapes.)
  - `rectangle` - Instead of defining `points` or `radius` like you would with a polygon or circle, you would define the `height` and `width`. Box2D will create a shape with the resulting type of `polygon`, so this is just shorthand for not having to define 4 points everytime a rectangle is desired.

### sprites (string)

Name of a sprite component. A `nil` value means no sprite will be registered.
