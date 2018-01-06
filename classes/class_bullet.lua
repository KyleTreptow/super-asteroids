-- -- -- -- -- -- -- -- -- -- -- --
-- Class: Bullet
-- -- -- -- -- -- -- -- -- -- -- --

local t = {}

function t:new(ship)

  local obj = {}
  local shipAng = ship.body:getAngle()
  local shipVX, shipVY = ship.body:getLinearVelocity()

  obj.body = love.physics.newBody(world, ship.body:getX(), ship.body:getY(), "dynamic")
  obj.body:setBullet(true)
  obj.body:setUserData(obj)
  -- obj.vx = shipVX + 50 * math.cos(shipAng)
  -- obj.vy = shipVY + 50 * math.sin(shipAng)
  obj.shape = love.physics.newCircleShape(0, 0, 3)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape, 4)
  obj.fixture:setRestitution(0.9)
  obj.fixture:setCategory(4)
  obj.fixture:setMask(3)
  obj.fixture:setUserData(obj)
  obj.body:applyForce(2000 * math.cos(shipAng), 2000 * math.sin(shipAng))
  setmetatable(obj, self)
  self.__index = self
  return obj

end

function t:update(dt, objects)
  local bulletKill = {}
  for i, v in ipairs(objects.bullets) do
    if v.body:getX() < 0
      or v.body:getX() > mapWidth
      or v.body:getY() < 0
      or v.body:getY() > mapHeight then
        table.insert(bulletKill, i)
    end
    -- v.body:applyForce(v.vx,v.vy)
  end
  for i, v in ipairs(bulletKill) do
    table.remove(objects.bullets, v)
    -- destroyBullet(v)
  end
end

return t
