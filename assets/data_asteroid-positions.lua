-- -- -- -- -- -- -- -- -- -- -- --
-- Data: Asteroid Positions
-- -- -- -- -- -- -- -- -- -- -- --
local mapWidth = mapWidth
local mapHeight = mapHeight

local asteroidPositionData = {
  ["n"] = {
    x = mapWidth/2,
    y = -200,
    vx = 0,
    vy = 64
  },
  ["s"] = {
    x = mapWidth/2,
    y = mapHeight + 200,
    vx = 0,
    vy = -64
  },
  ["e"] = {
    x = mapWidth + 200,
    y = mapHeight/2,
    vx = -64,
    vy = 0
  },
  ["w"] = {
    x = -200,
    y = mapHeight/2,
    vx = 64,
    vy = 0
  },
  ["ne"] = {
    x = mapWidth +200,
    y = -200,
    vx = -32,
    vy = 32
  },
  ["nw"] = {
    x = -200,
    y = -200,
    vx = 32,
    vy = 32
  },
  ["se"] = {
    x = mapWidth+200,
    y = mapHeight+200,
    vx = -32,
    vy = -32
  },
  ["sw"] = {
    x = -200,
    y = mapHeight+200,
    vx = 32,
    vy = -32
  }
}

return asteroidPositionData
