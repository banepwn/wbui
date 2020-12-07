return function(gui)
	local elclass = gui.class("imagebutton", gui.classes.button)
	function elclass:initialize(image, x, y, w, h)
		if type(image) == "string" then
			image = love.graphics.newImage(image)
		end
		self.image = image
		self.x = x
		self.y = y
		self.w = w or 75
		self.h = h or 23
		self.colors = setmetatable({}, gui.colors)
		self.fonts = setmetatable({}, gui.fonts)
		self.active = false
		self.hover = false
		self.enabled = true
	end
	function elclass:draw()
		love.graphics.setColor(unpack(self.colors.buttonBackground))
		love.graphics.rectangle("fill", 0, 0, self.w, self.h)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle("rough")
		if self.active then
			love.graphics.setColor(unpack(self.colors.buttonHighlight))
			love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5)
			love.graphics.setColor(unpack(self.colors.buttonShadow2))
			love.graphics.line(self.w-0.5, 0.5, 0.5, 0.5, 0.5, self.h-1.5)
			love.graphics.setColor(unpack(self.colors.buttonShadow))
			love.graphics.line(self.w-1.5, 1.5, 1.5, 1.5, 1.5, self.h-2.5)
		else
			love.graphics.setColor(unpack(self.colors.buttonHighlight))
			love.graphics.line(self.w-0.5, 0.5, 0.5, 0.5, 0.5, self.h-1.5)
			love.graphics.setColor(unpack(self.colors.buttonShadow2))
			love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5)
			love.graphics.setColor(unpack(self.colors.buttonShadow))
			love.graphics.line(self.w-1.5, 0.5, self.w-1.5, self.h-1.5, 1.5, self.h-1.5)
		end
		if self.image then
			love.graphics.setColor(1, 1, 1)
			love.graphics.draw(
				self.image,
				(self.ix or math.ceil((self.w-self.image:getWidth())/2-0.5))+(self.active and 1 or 0),
				(self.iy or math.ceil((self.h-self.image:getHeight())/2-0.5))+(self.active and 1 or 0)
			)
		end
		gui.classbase.draw(self)
	end
	return elclass
end
