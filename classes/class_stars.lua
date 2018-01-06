local stars = {}

function stars:new()
    local star_obj = {}
    for i = 1, 0x800 do
        star_obj[i] = {}
        star_obj[i].x, star_obj[i].y, star_obj[i].n =
						math.random(0, mapWidth),
						math.random(0, mapHeight),
            math.random(0, 0xff)
        end
    setmetatable(star_obj, self)
    self.__index = self
    return star_obj
end

for i = 1, 0x3333 do
	stars[i] = {}
	stars[i].x, stars[i].y, stars[i].n =
		math.random(0, mapWidth),
		math.random(0, mapHeight),
		math.random(0, 0xff)
end

function stars:update(dt)
	for k, _ in ipairs(self) do
		local m = math.random(-0x08, 0x08)
		self[k].n = self[k].n + m
		if self[k].n < 0x10 then
			self[k].n = 0x10
		elseif self[k].n > 0xff then
			self[k].n = 0xff
		end
	end
end

function stars:draw()
	for k, _ in ipairs(self) do
		local c = self[k].n
		love.graphics.setColor(0xff, 0xff, 0xff, c)
		love.graphics.points(self[k].x, self[k].y)
	end
end

return stars
