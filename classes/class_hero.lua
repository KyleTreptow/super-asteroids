-- -- -- -- -- -- -- -- -- -- -- --
-- Class: Hero
-- -- -- -- -- -- -- -- -- -- -- --

local t = {}

function t:new(obj)

  obj = obj or {}
  obj.body = love.physics.newBody(world, winWidth/2, winHeight/2, "dynamic")
  obj.body:setUserData(obj)
  obj.shape = love.physics.newPolygonShape(-5,-10,-5,10,25,0)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
  obj.fixture:setUserData("Ship")
  obj.fixture:setRestitution(0.9)
  obj.body:setLinearDamping(0.6) -- linear friction
  obj.body:setAngularDamping(6) -- angular friction
  obj.fixture:setCategory(3)
  obj.fixture:setMask(4)
  obj.isFiring = false
  return obj

end

function t:update(dt, objects)
  local angle = objects.hero.body:getAngle()
  local vx = 32 * math.cos(angle)
  local vy = 32 * math.sin(angle)
  -- hero:keyEvents
  if love.keyboard.isDown("d") then
    objects.hero.body:setAngularVelocity(2)
  elseif love.keyboard.isDown("a") then
    objects.hero.body:setAngularVelocity(-2)
  elseif love.keyboard.isDown("w") then
    objects.hero.body:applyForce(vx, vy)
  end
  -- hero:teleportingEdges
  if objects.hero.body:getX() > winWidth then
    objects.hero.body:setPosition(0, objects.hero.body:getY())
  elseif objects.hero.body:getX() < 0 then
    objects.hero.body:setPosition(winWidth, objects.hero.body:getY())
  elseif objects.hero.body:getY() > winHeight then
    objects.hero.body:setPosition(objects.hero.body:getX(), 0)
  elseif objects.hero.body:getY() < 0 then
    objects.hero.body:setPosition(objects.hero.body:getX(), winHeight)
  end
end

function t:draw(objects)
  love.graphics.setColor(255,255,255)
  love.graphics.polygon("fill", objects.hero.body:getWorldPoints(objects.hero.shape:getPoints()))
end

return t
