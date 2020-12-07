return function(gui)
	local elclass = gui.class("dropdown")
	elclass.w = 229
	elclass.h = 23
	elclass.tx = 5
	elclass.ty = 4
	elclass.rx = 0
	elclass.ry = elclass.h
	elclass.rh = 15
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
		love.graphics.setColor(unpack(self.colors.dropdownBackground))
		love.graphics.rectangle("fill", 0, 0, self.w, self.h)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle("rough")
		love.graphics.setColor(unpack(self.colors.dropdownHighlight2))
		love.graphics.line(self.w-1.5, 0.5, self.w-1.5, self.h-1.5, 1.5, self.h-1.5)
		love.graphics.setColor(unpack(self.colors.dropdownHighlight))
		love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5)
		love.graphics.setColor(unpack(self.colors.dropdownShadow))
		love.graphics.line(self.w-0.5, 0.5, 0.5, 0.5, 0.5, self.h-1.5)
		love.graphics.setColor(unpack(self.colors.dropdownShadow2))
		love.graphics.line(self.w-1.5, 1.5, 1.5, 1.5, 1.5, self.h-2.5)
		if self.selectedstr then
			love.graphics.setColor(unpack(self.colors.dropdownText))
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
	function elclass:mouseDown(button, x, y)
		if button ~= 1 then
			return
		end
		if self.enabled then
			self:onClick()
		end
		self.active = self.enabled
		self.button.active = self.enabled
		gui.mouseDown = self
		return self
	end
	function elclass:mouseUp(button, x, y)
		if button ~= 1 or gui.mouseDown ~= self then
			return
		end
		self.active = false
		self.button.active = false
		gui.mouseDown = nil
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
	function elclass:onClick()
		self.open = not self.open
		if self.open then
			self.list:focus()
		end
	end
	return elclass
end
