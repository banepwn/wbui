return function(gui)
	local elclass = gui.class("button")
	function elclass:initialize(text, x, y, w, h)
		self.text = text
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
		if self.text then
			love.graphics.setColor(unpack(self.colors.buttonText))
			love.graphics.setFont(self.fonts.default)
			local w = gui.fonts.default:getWidth(self.text)
			local h = gui.fonts.default:getHeight()
			love.graphics.print(
				self.text,
				math.ceil((self.w-w)/2-0.5)+(self.active and 1 or 0),
				math.ceil((self.h-h)/2-0.5)+(self.active and 1 or 0)-1
			)
		end
		gui.classbase.draw(self)
	end
	function elclass:mouseDown(button, x, y)
		if button ~= 1 then
			return
		end
		self.active = self.enabled
		gui.mouseDown = self
		return self
	end
	function elclass:mouseUp(button, x, y)
		if button ~= 1 then
			return
		end
		if self.enabled then
			self:onClick()
		end
		self.active = false
		gui.mouseDown = nil
		return self
	end
	function elclass:onClick() end
	return elclass
end
