-- -- -- -- -- -- -- -- -- -- -- --
-- Data: Asteroid Positions
-- -- -- -- -- -- -- -- -- -- -- --

local asteroidPositionData = {
  ["n"] = {
    x = winWidth/2,
    y = -200,
    vx = 0,
    vy = 64
  },
  ["s"] = {
    x = winWidth/2,
    y = winHeight+200,
    vx = 0,
    vy = -64
  },
  ["e"] = {
    x = winWidth+200,
    y = winHeight/2,
    vx = -64,
    vy = 0
  },
  ["w"] = {
    x = -200,
    y = winHeight/2,
    vx = 64,
    vy = 0
  },
  ["ne"] = {
    x = winWidth+200,
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
    x = winWidth+200,
    y = winHeight+200,
    vx = -32,
    vy = -32
  },
  ["sw"] = {
    x = -200,
    y = winHeight+200,
    vx = 32,
    vy = -32
  }
}

return asteroidPositionData
