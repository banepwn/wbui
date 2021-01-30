return function(gui)
	local elclass = gui.class("textbox")
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
		self.tw = self.w-8
		self.th = self.h-8
		self.ry = h or self.h
		self.text = ""
		self.cursor = 1
		self.colors = setmetatable({}, gui.colors)
		self.fonts = setmetatable({}, gui.fonts)
		self.active = false
		self.hover = false
		self.enabled = true
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
	function elclass:onClick()
		self:bringToFront()
	end
	function elclass:onFocus()
		local ax, ay = self:getAbsolutePosition()
		love.keyboard.setTextInput(true, ax, ay, self.w, self.h)
	end
	function elclass:onFocusLost()
		love.keyboard.setTextInput(false)
	end
	function elclass:draw()
		love.graphics.setColor(self.colors.textboxBackground)
		love.graphics.rectangle("fill", 0, 0, self.w, self.h)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle("rough")
		love.graphics.setColor(self.colors.textboxHighlight2)
		love.graphics.line(self.w-1.5, 0.5, self.w-1.5, self.h-1.5, 1.5, self.h-1.5)
		love.graphics.setColor(self.colors.textboxHighlight)
		love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5)
		love.graphics.setColor(self.colors.textboxShadow)
		love.graphics.line(self.w-0.5, 0.5, 0.5, 0.5, 0.5, self.h-1.5)
		love.graphics.setColor(self.colors.textboxShadow2)
		love.graphics.line(self.w-1.5, 1.5, 1.5, 1.5, 1.5, self.h-2.5)
		love.graphics.setColor(self.colors.textboxText)
		local ax, ay = self:getAbsolutePosition()
		love.graphics.setScissor(self.tx+ax, self.ty+ay, self.tw, self.th)
			local font = self.fonts.default
			love.graphics.setFont(font)
			local tw = font:getWidth(self.text)
			love.graphics.print(self.text, self.tx-math.max(0, tw-self.w+9), self.ty)
			if self.focus and love.timer.getTime()%1 < 0.5 then
				local cx = math.min(self.tx+tw+1, self.w-3)
				love.graphics.line(cx, 3, cx, self.h-3)
			end
		love.graphics.setScissor()
	end
	function elclass:keyDown(key, scan, repeated)
		if not self.enabled then
			return
		end
		if key == 'left' then
			self.cursor = math.max(self.cursor-1, 1)
		elseif key == 'right' then
			self.cursor = math.min(self.cursor+1, math.max(#self.text, 1))
		elseif key == 'backspace' then
			self.text = self.text:sub(1, utf8.offset(self.text, -1)-1)
		end
	end
	function elclass:textInput(text)
		self.text = self.text..text
	end
	return elclass
end
