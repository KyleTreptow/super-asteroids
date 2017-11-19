-- -- -- -- -- -- -- -- -- -- -- --
-- Class: Asteroid
-- -- -- -- -- -- -- -- -- -- -- --

local asteroidShapeData = require("assets/data_asteroid-polygons")
local asteroidPositionData = require("assets/data_asteroid-positions")

local t = {}

function t:new(obj)
  obj = obj or {}
  obj.angV = lume.random(-2, 2)
  local positions = asteroidPositionData
  local pos = lume.randomchoice({"n", "s", "e", "w", "ne", "nw", "se", "sw"})
  obj.posX = positions[pos].x + lume.random(-32, 32)
  obj.posY = positions[pos].y + lume.random(-32, 32)
  obj.body = love.physics.newBody(world, obj.posX, obj.posY, "dynamic")
  obj.isOverlapping = false
  obj.body:setUserData(obj)
  obj.vx = positions[pos].vx + lume.random(-16, 16)
  obj.vy = positions[pos].vy + lume.random(-16, 16)

  local poly = lume.randomchoice({"a", "b", "c", "d", "e"})

  obj.polygonPoints = asteroidShapeData[poly]
  obj.polygonOrigin = { obj.polygonPoints[1], obj.polygonPoints[2] } -- get first point...
  obj.asteroidTriangles = love.math.triangulate(obj.polygonPoints)

  obj.shapes = {}
  for i, v in ipairs(obj.asteroidTriangles) do
    table.insert(obj.shapes, love.physics.newPolygonShape(v))
  end

  obj.fixtures = {}
  for i, v in pairs(obj.shapes) do
    obj.fixtures[i] = love.physics.newFixture(obj.body, v, 1)
    obj.fixtures[i]:setRestitution(0.9)
    obj.fixtures[i]:setUserData(v)
    obj.fixtures[i]:setCategory( 2 )
  end
  setmetatable(obj, self)
  self.__index = self

  return obj

end

function t:update(dt, objects)
  local asteroidKill = {}
  for i, v in ipairs(objects.asteroids) do
    if v.body:getX() < -500
      or v.body:getX() > winWidth+500
      or v.body:getY() < -500
      or v.body:getY() > winHeight+500 then
        table.insert(asteroidKill, i)
    end
    v.body:setAngularVelocity( v.angV )
    v.body:applyForce(v.vx, v.vy)
  end
  for i, v in ipairs(asteroidKill) do
    table.remove(objects.asteroids, v)
  end
end

return t
