# Landscape-Server

Hi, you will be building something called the 'Landscape-Server'. It will be written entirely in Ruby.

## Overview

This is a digital landscape composed of 100 cells. We'll imagine that it's shaped like a grid. Each cell will have a unique set of x and y coordinates ranging between 1 - 10. Each cell will also have a food count and a mineral count. The initial amounts of food and minerals in each cell will be randomly generated when the landscape is generated or regenerated.

Bots from something called the 'Bot-Server' will be interacting with your landscape. Bots can attempt to mine or harvest from any of your cells. Bots need minerals to prosper and to create more bots. Bots also need food in order to mine and harvest.

Each bot has a mining and harvesting experience (xp) level which increases every time they mine or harvest. When a bot harvests from a cell, the cell's food count decrements in proportion to the bot's harvesting_xp by a formula you will design. When a bot mines from a cell, both the food_count and mineral_count of the cell decrements in proportion to the bot's mining_xp, by a formula you will design. Mining is a destructive process which unfortunately destroys food in the cell.

## Database

You will have a database of cells, each one having x and y coords, and an initial amount of food and minerals. You can determine what this amount is -- but it should be random across cells.

## API

You will be building API endpoints for the Bot-Server to consume. You will have a POST '/mine' endpoint and a POST '/harvest' endpoint that allow bots to mine and harvest from any of your cells. They might be something like this:

```
- POST '/mine'
- description: at cell with specified coords, decreases food + mineral amount proportionately with bot's mining_xp. Returns number of minerals mined as 'minerals_mined'. If no minerals left, nothing happens and minerals_mined returned is 0.
- data:
    {
      "x_coordinate" : __,
      "y_coordinate" : __,
      "bot_mining_xp" : __
    }
- response:
    {
      "minerals_mined" : __
    }

- POST '/harvest'
- description: at given coords, decreases food amount proportionately with bot's harvesting_xp. returns number of food harvested as 'food_harvested'. if no food left, nothing happens and food-harvested is 0.
- data:
    {
      "x_coordinate" : __,
      "y_coordinate" : __,
      "bot_harvesting_xp" : __
    }
- response:
    {
      "food_harvested" : __
    }
```

You will also be building API endpoints for a 'Command-Station' to consume. You will have an endpoint which returns the current state of all cells -- their x and y coordinates, their food_count, and their mineral_count. You will also have an endpoint which returns the current state of a single cell with a specified set of coords. Finally, you will have a POST '/restart' route which will dump the current landscape, and generate a new landscape. These routes might look like this:

```
  - GET '/cells'
  - description: returns information about each cell
  - response:
    [
      {
        "x_coordinate" : __,
        "y_coordinate" : __,
        "food_count" : __,
        "mineral_count" : __
      },
      ...
    ]

  - GET '/cells/:x/:y'
  - description: returns information about cell with specified x and y coordinates
  - response:
    {
      "x_coordinate" : __,
      "y_coordinate" : __,
      "food_count" : __,
      "mineral_count" : __
    }

  - POST '/restart'
  - description: resets landscape. destroys current cells, creates 100 new cells, each one with a random amount of minerals and food.
```
