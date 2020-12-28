return function(gui)
	local elclass = gui.class("dropdown")
	elclass.w = 229
	elclass.h = 23
	elclass.tx = 5
	elclass.ty = 4
	elclass.rx = 0
	elclass.ry = elclass.h
	elclass.rh = 15
	elclass.tabindex = true
	function elclass:initialize(values, x, y, w, h)
		self.values = values
		self.x = x
		self.y = y
		self.w = w or self.w
		self.h = h or self.h
		self.tw = self.w-25
		self.th = self.h-8
		self.ry = h or self.h
		self.button = gui.new("imagebutton", gui.images.dropdownArrow, self.w-18, 2, 16, 19)
		self.button.ix = 0
		self.button.iy = 0
		self.list = gui.new("dropdown_list", self)
		self.colors = setmetatable({}, gui.colors)
		self.fonts = setmetatable({}, gui.fonts)
		self.active = false
		self.hover = false
		self.enabled = true
		self.open = false
	end
	function elclass:select(index)
		self.selected = index
		local v = self.values[index]
		self.selectedstr = v
		self.list.highlighted = index
		self:onSelect(index, v)
	end
	function elclass:onSelect() end
	function elclass:draw()
		love.graphics.setColor(self.colors.dropdownBackground)
		love.graphics.rectangle("fill", 0, 0, self.w, self.h)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle("rough")
		love.graphics.setColor(self.colors.dropdownHighlight2)
		love.graphics.line(self.w-1.5, 0.5, self.w-1.5, self.h-1.5, 1.5, self.h-1.5)
		love.graphics.setColor(self.colors.dropdownHighlight)
		love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5)
		love.graphics.setColor(self.colors.dropdownShadow)
		love.graphics.line(self.w-0.5, 0.5, 0.5, 0.5, 0.5, self.h-1.5)
		love.graphics.setColor(self.colors.dropdownShadow2)
		love.graphics.line(self.w-1.5, 1.5, 1.5, 1.5, 1.5, self.h-2.5)
		if self.focus then
			love.graphics.setColor(self.colors.dropdownBackgroundFocus)
			love.graphics.rectangle("fill", 4, 4, self.w-24, self.h-8)
		end
		if self.selectedstr then
			love.graphics.setColor(self.focus and self.colors.dropdownTextFocus or self.colors.dropdownText)
			love.graphics.setFont(self.fonts.default)
			local ax, ay = self:getAbsolutePosition()
			love.graphics.setScissor(self.tx+ax, self.ty+ay, self.tw, self.th)
				love.graphics.print(self.selectedstr, self.tx, self.ty)
			love.graphics.setScissor()
		end
		local button = self.button
		love.graphics.translate(button.x, button.y)
		button:draw()
	end
	function elclass:onClick()
		self.open = not self.open
		if self.open then
			self:bringToFront()
			self.list:bringToFront()
		end
	end
	function elclass:mouseDown(button, x, y)
		if button ~= 1 then
			return
		end
		if self.enabled then
			self.active = true
			self.button.active = true
			self:onClick()
			gui.mouseDown = self
		end
		return self
	end
	function elclass:mouseUp(button, x, y)
		if button ~= 1 or gui.mouseDown ~= self then
			return
		end
		self.active = false
		self.button.active = false
		if gui.mouseDown == self then
			gui.mouseDown = nil
		end
		if not self.enabled then
			return
		end
		local list = self.list
		local px, py = self:getAbsolutePosition()
		local cx, cy = list:getAbsolutePosition()
		local rx, ry = x+px-cx, y+py-cy
		if rx >= 0 and ry >=0 and rx < list.w and ry < list.h then
			list:mouseDown(button, rx, ry)
			list:unfocus()
		end
		return self
	end
	function elclass:keyDown(key, scan, repeated)
		if not self.enabled then
			return
		elseif self.list.focus then
			return self.list:keyDown(key, scan, repeated)
		end
		if key == 'up' then
			self:select(self.selected and (self.selected-2)%#self.values+1 or #self.values)
		elseif key == 'down' then
			self:select(self.selected and self.selected%#self.values+1 or 1)
		elseif key == 'return' or key == 'space' then
			self:onClick()
		end
	end
	return elclass
end
