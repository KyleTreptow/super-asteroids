-- -- -- -- -- -- -- -- -- -- -- --
-- Class: Bullet
-- -- -- -- -- -- -- -- -- -- -- --

local t = {}

function t:new(ship)

  local obj = {}
  shipAng = ship.body:getAngle()
  obj.body = love.physics.newBody(world, ship.body:getX(), ship.body:getY(), "dynamic")
  obj.body:setBullet(true)
  obj.vx = 200 * math.cos(shipAng)
  obj.vy = 200 * math.sin(shipAng)
  obj.shape = love.physics.newCircleShape(0, 0, 3)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape, 4)
  obj.fixture:setRestitution(0.9)
  obj.fixture:setCategory(4)
  obj.fixture:setMask(3)
  obj.fixture:setUserData(obj)
  setmetatable(obj, self)
  self.__index = self
  return obj

end

function t:update(dt, objects)
  local bulletKill = {}
  for i, v in ipairs(objects.bullets) do
    if v.body:getX() < 0
      or v.body:getX() > winWidth
      or v.body:getY() < 0
      or v.body:getY() > winHeight then
        table.insert(bulletKill, i)
    end
    v.body:applyForce(v.vx,v.vy)
  end
  for i, v in ipairs(bulletKill) do
    table.remove(objects.bullets, v)
  end
end

return t
