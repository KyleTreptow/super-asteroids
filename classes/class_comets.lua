local comet = {}

for i = -10, 10, 4 do
	table.insert(comet, i)
end

function comet:new()

	self.e = true

	self.dx = self[math.random(#self)]
	self.dy = self[math.random(#self)]

	if math.random(2) > 1 then

		self.x = winWidth/2 - self.dx/math.abs(self.dx) * mapWidth/2
		self.y = math.random(0, mapHeight)
	else

		self.x = math.random(0, mapWidth)
		self.y = mapHeight/2 - self.dy/math.abs(self.dy) * mapHeight/2
	end
end

function comet:update(dt)

	self.x = self.x + self.dx * dt * 0x40
	self.y = self.y + self.dy * dt * 0x40

	if self.x < - mapWidth	or self.x > mapWidth * 2
	or self.y < - mapWidth	or self.y > mapHeight * 2 then

		self.e = nil
	end
end

function comet:draw()

	for i = 16, 1, -1 do

		local c = 0x80/i

		love.graphics.setColor(0xff, 0xff, 0xff, c)

		love.graphics.line(
			self.x, self.y,
			self.x - i * self.dx, self.y - i * self.dy
		)
	end
end

return comet
