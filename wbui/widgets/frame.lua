return function(gui)
	local elclass = gui.class("frame")
	function elclass:initialize(x, y, w, h)
		self.x = x
		self.y = y
		self.w = w
		self.h = h
		self.colors = setmetatable({}, gui.colors)
	end
	function elclass:draw()
		love.graphics.setColor(unpack(self.colors.frameBackground))
		love.graphics.rectangle("fill", 0, 0, self.w, self.h)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle("rough")
		love.graphics.setColor(unpack(self.colors.frameHighlight))
		love.graphics.line(self.w-0.5, 0.5, 0.5, 0.5, 0.5, self.h-1.5)
		love.graphics.setColor(unpack(self.colors.frameShadow2))
		love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5)
		love.graphics.setColor(unpack(self.colors.frameShadow))
		love.graphics.line(self.w-1.5, 0.5, self.w-1.5, self.h-1.5, 1.5, self.h-1.5)
		gui.classbase.draw(self)
	end
	return elclass
end
