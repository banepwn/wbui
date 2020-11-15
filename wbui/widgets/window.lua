return function(gui)
	local elclass = gui.class("window", gui.classes.frame)
	function elclass:initialize(title, x, y, w, h)
		self.title = title or "Window"
		self.x = x
		self.y = y
		self.w = w
		self.h = h
		self:updateInnerDimensions()
		self.colors = setmetatable({}, gui.colors)
		self.fonts = setmetatable({}, gui.fonts)
		self:generateTitleBar()
		self.focus = true
		self.window = true
		self.maximized = false
	end
	function elclass:bringToFront()
		self.focus = true
		local i
		for j=1, #self.parent.children do
			local child = self.parent.children[j]
			if child == self then
				i = j
			elseif child.name == "window" then
				child.focus = false
			end
		end
		table.insert(self.parent.children, table.remove(self.parent.children, i))
	end
	function elclass:mouseDown(button, x, y)
		if button ~= 1 then
			return
		end
		self:bringToFront()
		local el = gui.classbase.mouseDown(self, button, x, y)
		if
			not el and
			x >= 3 and
			x < self.w-6 and
			y >= 3 and
			y < 21
		then
			gui.mouseDown = self
			return self
		else
			return el
		end
	end
	function elclass:mouseUp(button, x, y)
		if button ~= 1 then
			return
		end
		if gui.mouseDown == self then
			gui.mouseDown = nil
		else
			return gui.classbase.mouseUp(self, button, x, y)
		end
	end
	function elclass:mouseMoved(x, y, dx, dy, touch)
		self.x = self.x+dx
		self.y = self.y+dy
	end
	function elclass:close()
		if not self:onClose() then
			local parent = self.parent
			self:remove()
			if parent then
				for i=#parent.children, 1, -1 do
					local child = parent.children[i]
					if child.name == "window" then
						child.focus = true
						break
					end
				end
			end
		end
	end
	function elclass:onClose() end
	function elclass:toggleMaximized()
		self.maximized = not self.maximized
		if self.maximizebtn then
			self.maximizebtn.image = self.maximized and self.buttonIcons.unmaximize or self.buttonIcons.maximize
		end
	end
	function elclass:minimize() end
	function elclass:help() end
	elclass.buttonIcons = {
		close = love.graphics.newImage(gui.path.."/assets/close.png"),
		maximize = love.graphics.newImage(gui.path.."/assets/maximize.png"),
		unmaximize = love.graphics.newImage(gui.path.."/assets/unmaximize.png"),
		minimize = love.graphics.newImage(gui.path.."/assets/minimize.png"),
		help = love.graphics.newImage(gui.path.."/assets/help.png")
	}
	elclass.buttonClickHandlers = {
		close = function(self)
			self.parent:close()
		end,
		maximize = function(self)
			self.parent:toggleMaximized()
		end,
		minimize = function(self)
			self.parent:minimize()
		end,
		help = function(self)
			self.parent:help()
		end
	}
	function elclass:showButton(name, bool)
		local key = name.."btn"
		if bool and not self[key] then
			self[key] = gui.new("imagebutton", self.buttonIcons[name], self.w-25, -18, 16, 14)
			self[key].onClick = self.buttonClickHandlers[name]
			self:append(self[key])
		elseif not bool and self[key] then
			self[key]:remove()
			self[key] = nil
		end
		self:updateButtonPositions()
	end
	function elclass:updateButtonPositions()
		local x = self.w-25
		if self.closebtn then
			self.closebtn.x = x
			x = x-16-2
		end
		if self.maximizebtn then
			self.maximizebtn.x = x
			x = x-16
		end
		if self.minimizebtn then
			self.minimizebtn.x = x
			x = x-16
		end
		if self.helpbtn then
			self.helpbtn.x = x
			x = x-16
		end
		return x
	end
	function elclass:setIcon(image)
		if not image then
			self.icon = nil
			self.iconsx = nil
			self.iconsy = nil
			return
		elseif type(image) == "string" then
			image = love.graphics.newImage(image)
		end
		self.icon = image
		self.iconsx = 16/image:getWidth()
		self.iconsy = 16/image:getHeight()
	end
	function elclass:updateInnerDimensions()
		self.ix = 4
		self.iy = 4+18+1
		self.iw = self.w-self.ix-self.ix
		self.ih = self.h-self.iy-4
		self:updateButtonPositions()
	end
	function elclass:generateTitleBar()
		self.titlebar = love.graphics.newMesh({
			{0, 1, 0, 1, unpack(self.colors.windowTitle)},
			{0, 0, 0, 0, unpack(self.colors.windowTitle)},
			{1, 1, 1, 1, unpack(self.colors.windowTitle2)},
			{1, 0, 1, 0, unpack(self.colors.windowTitle2)}
		}, "strip", "static")
		self.titlebarInactive = love.graphics.newMesh({
			{0, 1, 0, 1, unpack(self.colors.windowTitleInactive)},
			{0, 0, 0, 0, unpack(self.colors.windowTitleInactive)},
			{1, 1, 1, 1, unpack(self.colors.windowTitleInactive2)},
			{1, 0, 1, 0, unpack(self.colors.windowTitleInactive2)}
		}, "strip", "static")
	end
	function elclass:draw()
		love.graphics.setColor(unpack(self.colors.frameBackground))
		love.graphics.rectangle("fill", 0, 0, self.w, self.h)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle("rough")
		love.graphics.setColor(unpack(self.colors.frameHighlight2))
		love.graphics.line(self.w-0.5, 0.5, 0.5, 0.5, 0.5, self.h-1.5)
		love.graphics.setColor(unpack(self.colors.frameHighlight))
		love.graphics.line(self.w-1.5, 1.5, 1.5, 1.5, 1.5, self.h-2.5)
		love.graphics.setColor(unpack(self.colors.frameShadow2))
		love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5)
		love.graphics.setColor(unpack(self.colors.frameShadow))
		love.graphics.line(self.w-1.5, 0.5, self.w-1.5, self.h-1.5, 1.5, self.h-1.5)
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(self.focus and self.titlebar or self.titlebarInactive, 3, 3, 0, (self.w-6)/1, 18/1)
		if self.icon then
			love.graphics.draw(self.icon, 5, 4, 0, self.iconsx, self.iconsy)
		end
		love.graphics.setColor(self.focus and self.colors.windowTitleText or self.colors.windowTitleTextInactive)
		love.graphics.setFont(self.fonts.windowTitle)
		love.graphics.print(self.title, self.icon and 23 or 5, 5)
		for i, child in pairs(self.children) do
			love.graphics.push("all")
				love.graphics.translate(child.x+self.ix, child.y+self.iy)
				child:draw()
			love.graphics.pop()
		end
	end
	return elclass
end
