-- global vars
winWidth = 1200
winHeight = 675
-- utilities
lume = require("utilities/lume") -- global
local lurker = require("utilities/lurker")
-- classes
local Asteroid = require("classes/class_asteroid")
local Bullet = require("classes/class_bullet")
local Hero = require("classes/class_hero")
local Stars = require("classes/class_stars")
local Comets = require("classes/class_comets")
-- local vars
local globaldt = 0;
local cometSpawnInterval = 1 + lume.random(0, 3)
local cometSpawnDelta = 0
local asteroidSpawnInterval = 2
local asteroidSpawnDelta = 0

-- -- -- -- -- -- -- -- -- -- -- --
-- Gen Asteroids
-- -- -- -- -- -- -- -- -- -- -- --
function generateAsteroid()
  table.insert(objects.asteroids, Asteroid:new())
end
-- -- -- -- -- -- -- -- -- -- -- --
-- Fire Bullets
-- -- -- -- -- -- -- -- -- -- -- --
function pewPew(ship)
  table.insert(objects.bullets, Bullet:new(ship))
end
function love.keypressed(key)
  if key == "space" then
    pewPew(objects.hero)
  end
  if key == "escape" then
    love.event.quit()
  end
end
-- -- -- -- -- -- -- -- -- -- -- --
-- Booster Flame
-- -- -- -- -- -- -- -- -- -- -- --
function boosterFlame(ship)

end
-- -- -- -- -- -- -- -- -- -- -- --
-- Contact Handlers
-- -- -- -- -- -- -- -- -- -- -- --
function beginContact(a, b, coll)
  -- local x,y = coll:getNormal()
end

function endContact(a, b, coll)
  -- re-enable asteroid overlap mask
  if a:getCategory() == 2 and b:getCategory() == 2 then
    coll:setEnabled(true)
    a:getBody():getUserData().isOverlapping = false
    b:getBody():getUserData().isOverlapping = false
  end

end

function preSolve(a, b, coll)
  -- disable asteroid overlap mask
  if a:getCategory() == 2 and b:getCategory() == 2 then
    coll:setEnabled(false)
    a:getBody():getUserData().isOverlapping = true
    b:getBody():getUserData().isOverlapping = true
  end
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
  -- postSolve (resolves categories in order)
  if a:getCategory() == 2 and b:getCategory() == 4 then
    -- a:destroy()
    b:destroy()
  end
end
-- -- -- -- -- -- -- -- -- -- -- --
-- Bounding Box Checks
-- -- -- -- -- -- -- -- -- -- -- --

-- check if visible on screen
-- check if outisde bounding parimeter

-- -- -- -- -- -- -- -- -- -- -- --
-- Load
-- -- -- -- -- -- -- -- -- -- -- --
function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  -- love.graphics.setBackgroundColor(20,5,20)
  love.graphics.setBackgroundColor(22,2,22)
  love.window.setMode(winWidth, winHeight)
  -- love.window.setMode(winWidth, winHeight, {resizable=true, vsync=false, minwidth=winWidth/2, minheight=winHeight/2})
  -- objects
  objects = {}
  objects.asteroids = {}
  objects.bullets = {}
  objects.hero = Hero:new()
  -- more
end
-- -- -- -- -- -- -- -- -- -- -- --
-- Update
-- -- -- -- -- -- -- -- -- -- -- --
function love.update(dt)

  globaldt = dt
  world:update(dt) --this puts the world into motion
  lurker.update(dt)
  -- background:update
  Stars:update(dt)
  if Comets.e then
    Comets:update(dt)
  end
  cometSpawnDelta = dt + cometSpawnDelta
  if cometSpawnDelta > cometSpawnInterval then
    cometSpawnDelta = 0
    Comets:new()
  end
  -- hero:update
  Hero:update(dt, objects)
  -- asteroid:spawn
  asteroidSpawnDelta = dt + asteroidSpawnDelta
  if asteroidSpawnDelta > asteroidSpawnInterval then
    asteroidSpawnDelta = 0
    generateAsteroid()
  end
  -- asteroids:update & kill
  Asteroid:update(dt, objects)
  -- bullets:update & kill
  Bullet:update(dt, objects)

end
-- -- -- -- -- -- -- -- -- -- -- --
-- Glow Shape
-- -- -- -- -- -- -- -- -- -- -- --
function glowShape(r, g, b, type, ...)
  love.graphics.setColor(r, g, b, 15)

  for i = 9, 2, -1 do
    if i == 2 then
      i = 1
      love.graphics.setColor(r, g, b, 255)
    end

    love.graphics.setLineWidth(i)

    if type == "line" then
      love.graphics[type](...)
    else
      love.graphics[type]("line", ...)
    end
  end
end
-- -- -- -- -- -- -- -- -- -- -- --
-- Draw
-- -- -- -- -- -- -- -- -- -- -- --
function love.draw()
  -- background:draw
  Stars:draw()
  if Comets.e then
    Comets:draw()
  end
  -- hero:draw
  Hero:draw(objects)
  -- asteroids:draw
  for i, v in ipairs(objects.asteroids) do -- v is the asteroid value, iterated
    local r, g, b = 255, 255, 255
    -- love.graphics.setColor(255,255,255)
    for j, vF in ipairs(v.fixtures) do -- vF is the fixure value, iterated
      if vF:isDestroyed() then
        love.graphics.setColor(255,0,0,60) -- red for destroyed fixture
      else
        if v.isOverlapping then
          love.graphics.setColor(0,255,0,60) -- green for overlapping fixture
        else
          love.graphics.setColor(255,255,255,60)
        end
      end
     -- love.graphics.polygon("line", v.body:getWorldPoints(v.shapes[j]:getPoints()))
    end

    love.graphics.push()
       love.graphics.translate(v.body:getX(), v.body:getY())
       love.graphics.rotate(v.body:getAngle())
       -- love.graphics.setColor(255,255,255)
       local p = {}
       for i, _ in ipairs(v.polygonPoints) do
         table.insert(p, _)
       end
       table.insert(p, v.polygonOrigin[1]) -- add origin point x
       table.insert(p, v.polygonOrigin[2]) -- add origin point y
       love.graphics.setLineWidth(2)
       -- love.graphics.line(p)
       local r, g, b = 255, 255, 255
       if v.isOverlapping then
         r, g, b = 0, 255, 0 -- green for overlapping polygon
       end
       glowShape(r, g, b, "line", p)
    love.graphics.pop()

  end
  -- bullets:draw
  love.graphics.setColor(255,255,255)
  for i, v in ipairs(objects.bullets) do
    if v.fixture:isDestroyed() ~= true then
      love.graphics.circle("fill", v.body:getX(), v.body:getY(), 3)
    end
  end
  -- displayInfo:draw
  love.graphics.setColor(200,200,200)
  local major, minor, revision, codename = love.getVersion()
  local str = string.format("Version %d.%d.%d - %s", major, minor, revision, codename)
  love.graphics.print(str, 20, 20)
  love.graphics.print('Super Asteroids - Dev Build v0.1', 20, 40)
  local dimW, dimH = love.graphics:getDimensions()
  love.graphics.print('Window: ' .. dimW .. ' x ' .. dimH, 20, winHeight-50)
  love.graphics.print('Asteroid #: ' .. #objects.asteroids, 20, winHeight-30)
  love.graphics.print('Bullets #: ' .. #objects.bullets, winWidth/2, winHeight-30)
end
