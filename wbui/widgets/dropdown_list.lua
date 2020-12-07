return function(gui)
	local elclass = gui.class('dropdown_list')
	elclass.tx = 3
	function elclass:initialize(parent, highlighted)
		self.colors = setmetatable({}, gui.colors)
		self.fonts = setmetatable({}, gui.fonts)
		self.dfparent = parent -- de facto parent
		self.highlighted = highlighted
		gui.root:append(self)
		self.visible = false
	end
	function elclass:focus()
		local parent = self.dfparent
		self.x, self.y = parent:getAbsolutePosition()
		self.x = self.x+parent.rx
		self.y = self.y+parent.ry
		self.w = parent.rw or parent.w
		self.th = parent.rh or parent.h
		self.h = self.th*#parent.values
		local children = self.parent.children
		local maxindex = #children
		for i, child in pairs(children) do
			if child == self then
				if i ~= maxindex then
					table.remove(children, i)
					children[maxindex] = self
				end
				break
			end
		end
		gui.modal = self
		self.visible = true
	end
	function elclass:unfocus()
		gui.modal = nil
		self.visible = false
		self.dfparent.open = false
	end
	elclass.onModalExit = elclass.unfocus
	function elclass:mouseDown(button, x, y)
		if button ~= 1 then
			return
		end
		self.dfparent:select(math.ceil(y/self.th))
	end
	elclass.mouseUp = elclass.mouseDown
	function elclass:mouseMoved(x, y)
		self.highlighted = math.ceil(y/self.th)
	end
	function elclass:mouseExit()
		self.highlighted = nil
	end
	function elclass:draw()
		local ax, ay = self:getAbsolutePosition()
		love.graphics.setScissor(ax, ay, self.w, self.h)
			love.graphics.setColor(self.colors.dropdownListBackground)
			love.graphics.rectangle('fill', 0, 0, self.w, self.h)
			local th = self.th
			for i, v in pairs(self.dfparent.values) do
				local y = (i-1)*th
				if i == self.highlighted then
					love.graphics.setColor(self.colors.dropdownListHighlightedBackground)
					love.graphics.rectangle('fill', 0, y, self.w, th)
					love.graphics.setColor(self.colors.dropdownListHighlightedForeground)
				else
					love.graphics.setColor(self.colors.dropdownListForeground)
				end
				love.graphics.print(v, self.tx, y)
			end
			love.graphics.setColor(self.colors.dropdownListBorder)
			love.graphics.rectangle('line', 0.5, 0.5, self.w-1, self.h-1)
		love.graphics.setScissor()
	end
	return elclass
end
