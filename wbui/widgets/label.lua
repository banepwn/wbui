return function(gui)
	local elclass = gui.class("label")
	function elclass:initialize(text, x, y, w, h)
		self.text = text or "Label"
		self.x = x
		self.y = y
		self.w = w
		self.h = h
		self.align = "left"
		self.fonts = setmetatable({}, gui.fonts)
		self.colors = setmetatable({}, gui.colors)
		if w and not h then
			self.h = self:calculateHeight()
		end
	end
	function elclass:calculateHeight(w)
		local font = self.font or self.fonts.default
		local width, wrapped = font:getWrap(self.text, w or self.w)
		return font:getHeight()*#wrapped
	end
	function elclass:draw()
		love.graphics.setFont(self.font or self.fonts.default)
		love.graphics.setColor(unpack(self.color or self.colors.text))
		love.graphics.printf(self.text, 0, 0, self.w, self.align)
	end
	function elclass:mouseDown()
		return self
	end
	return elclass
end
