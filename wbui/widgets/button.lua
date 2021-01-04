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
		self:setEnabled(true)
	end
	function elclass:setEnabled(bool)
		self.enabled = bool
		self.tabindex = bool
		if bool then
			if self.parent then
				self.parent:updateTabIndexes()
			end
		end
	end
	function elclass:draw()
		love.graphics.setColor(self.colors.buttonBackground)
		love.graphics.rectangle("fill", 0, 0, self.w, self.h)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle("rough")
		local o
		if self.focus then
			love.graphics.setColor(self.colors.buttonFocusOutline)
			love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5, 0.5, 0.5, self.w-0.5, 0.5)
			o = 1
		else
			o = 0
		end
		if self.active then
			love.graphics.setColor(self.colors.buttonHighlight)
			love.graphics.line(self.w-0.5-o, -0.5+o, self.w-0.5-o, self.h-0.5-o, 0.5+o, self.h-0.5-o)
			love.graphics.setColor(self.colors.buttonShadow2)
			love.graphics.line(self.w-0.5-o, 0.5+o, 0.5+o, 0.5+o, 0.5+o, self.h-1.5-o)
			love.graphics.setColor(self.colors.buttonShadow)
			love.graphics.line(self.w-1.5-o, 1.5+o, 1.5+o, 1.5+o, 1.5+o, self.h-2.5-o)
		else
			love.graphics.setColor(self.colors.buttonHighlight)
			love.graphics.line(self.w-0.5-o, 0.5+o, 0.5+o, 0.5+o, 0.5+o, self.h-1.5-o)
			love.graphics.setColor(self.colors.buttonShadow2)
			love.graphics.line(self.w-0.5-o, -0.5+o, self.w-0.5-o, self.h-0.5-o, 0.5+o, self.h-0.5-o)
			love.graphics.setColor(self.colors.buttonShadow)
			love.graphics.line(self.w-1.5-o, 0.5+o, self.w-1.5-o, self.h-1.5-o, 1.5+o, self.h-1.5-o)
		end
		if self.text then
			local x = (self.ix or math.ceil((self.w-gui.fonts.default:getWidth(self.text))/2-0.5))+(self.active and 1 or 0)
			local y = (self.iy or math.ceil((self.h-gui.fonts.default:getHeight())/2-0.5)-1)+(self.active and 1 or 0)
			love.graphics.setFont(self.fonts.default)
			if not self.enabled then
				love.graphics.setColor(self.colors.buttonTextDisabledShadow)
				love.graphics.print(self.text, x+1, y+1)
			end
			love.graphics.setColor(self.enabled and self.colors.buttonText or self.colors.buttonTextDisabled)
			love.graphics.print(self.text, x, y)
		end
		gui.classbase.draw(self)
	end
	function elclass:mouseDown(button, x, y)
		if button ~= 1 then
			return
		end
		if self.enabled then
			self.active = true
			if self.tabindex then
				self:bringToFront()
			end
			gui.mouseDown = self
		end
		return self
	end
	function elclass:mouseUp(button, x, y)
		if button ~= 1 or gui.mouseDown ~= self then
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
	function elclass:keyDown(key, scan, repeated)
		if key == 'return' or key == 'space' then
			self.active = true
			self:onClick()
		end
	end
	function elclass:keyUp(key, scan)
		if key == 'return' or key == 'space' then
			self.active = false
		end
	end
	return elclass
end
