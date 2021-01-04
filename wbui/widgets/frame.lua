return function(gui)
	local elclass = gui.class('frame')
	function elclass:initialize(x, y, w, h)
		self.x = x
		self.y = y
		self.w = w
		self.h = h
		self.colors = setmetatable({}, gui.colors)
	end
	function elclass:draw()
		love.graphics.setColor(unpack(self.colors.frameBackground))
		love.graphics.rectangle('fill', 0, 0, self.w, self.h)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle('rough')
		love.graphics.setColor(unpack(self.colors.frameHighlight))
		love.graphics.line(self.w-0.5, 0.5, 0.5, 0.5, 0.5, self.h-1.5)
		love.graphics.setColor(unpack(self.colors.frameShadow2))
		love.graphics.line(self.w-0.5, -0.5, self.w-0.5, self.h-0.5, 0.5, self.h-0.5)
		love.graphics.setColor(unpack(self.colors.frameShadow))
		love.graphics.line(self.w-1.5, 0.5, self.w-1.5, self.h-1.5, 1.5, self.h-1.5)
		gui.classbase.draw(self)
	end
	function elclass:mouseDown(button, x, y, presses, touch)
		self:bringToFront()
		return gui.classbase.mouseDown(self, button, x, y, presses, touch) or self
	end
	function elclass:mouseDown()
		return self
	end
	function elclass:keyDown(key, scan, repeated)
		if key == 'tab' then
			local i = love.keyboard.isDown('lshift', 'rshift') and -1 or 1
			local j = self.focusedChildIndex
			local c = self.children
			local cc = #c
			local k = j and (j+i-1)%cc+1 or 1
			while k ~= j do
				local child = c[k]
				if child.tabindex then
					child:bringToFront()
					break
				end
				k = (k+i-1)%cc+1
			end
			return self
		elseif self.focusedChild then
			self.focusedChild:keyDown(key, scan, repeated)
		end
	end
	function elclass:keyUp(key, scan)
		local focusedChild = self.focusedChild
		if focusedChild then
			focusedChild:keyUp(key, scan)
		end
	end
	return elclass
end
