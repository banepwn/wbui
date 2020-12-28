return function(gui)
	local elclass = gui.class("imagebutton", gui.classes.button)
	function elclass:initialize(image, x, y, w, h)
		if type(image) == "string" then
			image = love.graphics.newImage(image)
		end
		self.image = image
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
	elclass.shader = love.graphics.newShader(gui.path.."/imagebutton.glsl")
	function elclass:draw()
		love.graphics.setColor(unpack(self.colors.buttonBackground))
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
		if self.image then
			local x = (self.ix or math.ceil((self.w-self.image:getWidth())/2-0.5))+(self.active and 1 or 0)
			local y = (self.iy or math.ceil((self.h-self.image:getHeight())/2-0.5))+(self.active and 1 or 0)
			if self.enabled then
				love.graphics.setColor(self.colors.buttonImage)
				love.graphics.draw(self.image, x, y)
			else
				love.graphics.setShader(self.shader)
					love.graphics.setColor(self.colors.buttonImageDisabledShadow)
					love.graphics.draw(self.image, x+1, y+1)
					love.graphics.setColor(self.colors.buttonImageDisabled)
					love.graphics.draw(self.image, x, y)
				love.graphics.setShader()
			end
		end
		gui.classbase.draw(self)
	end
	return elclass
end
