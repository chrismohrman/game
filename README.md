# game

[![License](https://img.shields.io/badge/License-LGPL%203.0-brightgreen.svg)](LICENSE)

- [Overview](#overview)
- [Running the game](#running-the-game)
- [Development](#development)
  - [Running the game from source](#running-the-game-from-source)
  - [Command line arguments](#command-line-arguments)
  - [Code testing](#testing)
  - [Distributing](#distributing)

## Overview

- This is a 2D, top-down, Robotron-like game written in [LÖVE](https://love2d.org/).
- It is being development purely for fun and to lean programming with Lua.
- The game structure is an ECS-inspired design with minimal outside dependencies. It uses LÖVE's built-in box2d physics.

## Running the game

Once the game is in beta, releases will be available from the [releases page](https://github.com/chrismohrman/game/releases).

## Development

### Running the game from source

1.) Install [LÖVE](https://love2d.org/). `conf.lua` specifies the recommended version of LÖVE to run.

2.) Run the command or create a shortcut.

On unix, you can change to the game directory run it like so:

```sh
love .
```

On Windows, you can create a shortcut with a path to Love and path to the game:

```
"C:/path/to/love.exe" "C:/path/to/game/directory"
```

For more detailed information see [this guide](https://rvagamejams.com/learn2love/pages/02-01-up-and-running.html).

### Command line arguments

`love . debug` - Run the game in debug mode to draw collision lines and log debug information.

### Code testing

1.) Install [Docker](https://www.docker.com/)

2.) Build and run the docker container from the Makefile command

```sh
make test
```

...And there you go. It should spit out linting errors and test results.

### Distributing

See the Love [wiki article](https://love2d.org/wiki/Game_Distribution) on creating executable binaries.
