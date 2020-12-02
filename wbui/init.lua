local gui = {}

gui.require = ...
gui.path = gui.require:gsub("%.", "/")
function gui.initialize(tbl)
	tbl = tbl or {}
	local default = (tbl.fonts or {}).default or love.graphics.newFont(11)
	gui.fonts = {
		default = default,
		windowTitle = default
	}
	for k, v in pairs(tbl.fonts or {}) do
		gui.fonts[k] = v
	end
	gui.fonts.__index = gui.fonts
	gui.colors = {
		text = {0, 0, 0},
		frameBackground = {0.831, 0.816, 0.784},
		frameHighlight = {1, 1, 1},
		frameHighlight2 = {0.831, 0.816, 0.784},
		frameShadow = {0.52, 0.52, 0.52},
		frameShadow2 = {0.251, 0.251, 0.251},
		windowTitle = {0.039, 0.141, 0.416},
		windowTitle2 = {0.651, 0.792, 0.941},
		windowTitleText = {1, 1, 1},
		windowTitleInactive = {0.502, 0.502, 0.502},
		windowTitleInactive2 = {0.753, 0.753, 0.753},
		windowTitleTextInactive = {0.831, 0.816, 0.784},
		buttonBackground = {0.831, 0.816, 0.784},
		buttonHighlight = {1, 1, 1},
		buttonHighlight2 = {0.831, 0.816, 0.784},
		buttonShadow = {0.52, 0.52, 0.52},
		buttonShadow2 = {0.251, 0.251, 0.251},
		buttonText = {0, 0, 0},
	}
	for k, v in pairs(tbl.colors or {}) do
		gui.colors[k] = v
	end
	gui.colors.__index = gui.colors
	gui.cursors = {
		default = false,
		arrow = false,
		text = love.mouse.getSystemCursor("ibeam"),
		wait = love.mouse.getSystemCursor("wait"),
		waitbg = love.mouse.getSystemCursor("waitarrow"),
		precise = love.mouse.getSystemCursor("crosshair"),
		link = love.mouse.getSystemCursor("hand"),
		resizeLR = love.mouse.getSystemCursor("sizewe"),
		resizeTB = love.mouse.getSystemCursor("sizens"),
		resizeTLBR = love.mouse.getSystemCursor("sizenwse"),
		resizeTRBL = love.mouse.getSystemCursor("sizenesw"),
		move = love.mouse.getSystemCursor("sizeall"),
		unavailable = love.mouse.getSystemCursor("no")
	}
	for k, v in pairs(tbl.cursors or {}) do
		gui.cursors[k] = v
	end
	gui.cursors.__index = gui.cursors
	for _, widget in ipairs(tbl.classes or {
		"frame",
		"button",
		"imagebutton",
		"window",
		"label"
	}) do
		gui.classes[widget] = require(gui.require..".widgets."..widget)(gui)
	end
	gui.root = setmetatable({
		x = 0,
		y = 0,
		w = love.graphics.getWidth(),
		h = love.graphics.getHeight(),
		children = {},
		visible = true
	}, gui.classbase)
	function gui.root:mouseUp(button, x, y, presses, touch)
		if gui.mouseDown then
			local el = gui.mouseDown:mouseUp(button, x, y, presses, touch)
			if el then
				return el
			end
		end
		return gui.classbase.mouseUp(self, button, x, y, presses, touch)
	end
	function gui.root:mouseMoved(x, y, dx, dy, touch)
		if gui.mouseDown then
			local el = gui.mouseDown:mouseMoved(x, y, dx, dy, touch)
			if el then
				return el
			end
		end
		return gui.classbase.mouseMoved(self, x, y, dx, dy, touch)
	end
end

gui.classbase = {
	name = "element",
	new = function(self, ...)
		local element = setmetatable({
			children = {},
			visible = true
		}, self)
		element:initialize(...)
		return element
	end,
	initialize = function(self, x, y)
		self.x = x or 0
		self.y = y or 0
	end,
	append = function(self, child, i)
		child.parent = self
		if i then
			table.insert(self.children, i, child)
		else
			table.insert(self.children, child)
		end
	end,
	remove = function(self)
		if self.parent then
			for i, child in pairs(self.parent.children) do
				if child == self then
					table.remove(self.parent.children, i)
					self.parent = nil
					return true
				end
			end
		end
	end,
	update = function(self, dt)
		for i, child in pairs(self.children) do
			child:update(dt)
		end
	end,
	draw = function(self)
		for i, child in ipairs(self.children) do
			if child.visible then
				love.graphics.push("all")
					love.graphics.translate(child.x, child.y)
					child:draw()
				love.graphics.pop()
			end
		end
	end,
	mouseDown = function(self, button, x, y, presses, touch)
		local len = #self.children
		if len == 0 then
			return false
		end
		for i=len, 1, -1 do
			local child = self.children[i]
			if
				child.visible and
				x >= child.x+(self.ix or 0) and
				x < child.x+child.w+(self.ix or 0) and
				y >= child.y+(self.iy or 0) and
				y < child.y+child.h+(self.iy or 0)
			then
				local el = child:mouseDown(button, x-child.x+(self.ix or 0), y-child.y+(self.ix or 0), presses, touch)
				if el then
					return el
				end
			end
		end
	end,
	mouseUp = function(self, button, x, y, presses, touch)
		local len = #self.children
		if len == 0 then
			return false
		end
		for i=len, 1, -1 do
			local child = self.children[i]
			if
				child ~= gui.mouseDown and
				x >= child.x+(self.ix or 0) and
				x < child.x+child.w+(self.ix or 0) and
				y >= child.y+(self.iy or 0) and
				y < child.y+child.h+(self.iy or 0)
			then
				local el = child:mouseUp(button, x-child.x+(self.ix or 0), y-child.y+(self.ix or 0), presses, touch)
				if el then
					return el
				end
			end
		end
	end,
	mouseMoved = function(self, x, y, dx, dy, touch)
		local len = #self.children
		if len == 0 then
			return false
		end
		local ret
		for i=len, 1, -1 do
			local child = self.children[i]
			if
				child.visible and
				child ~= gui.mouseDown and
				x >= child.x+(self.ix or 0) and
				x < child.x+child.w+(self.ix or 0) and
				y >= child.y+(self.iy or 0) and
				y < child.y+child.h+(self.iy or 0)
			then
				child:mouseMoved(x-child.x+(self.ix or 0), y-child.y+(self.ix or 0), dx, dy, presses, touch)
				ret = child
				break
			end
		end
		if ret ~= self.hover then
			if self.hover then
				self.hover.hover = false
				self.hover:mouseLeave(x, y, dx, dy, touch)
			end
			if ret then
				ret.hover = true
				ret:mouseEnter(x, y, dx, dy, touch)
			end
			self.hover = ret
		end
		return ret
	end,
	mouseEnter = function(self, x, y, dx, dy, touch) end,
	mouseLeave = function(self, x, y, dx, dy, touch) end
}
gui.classbase.__index = gui.classbase
function gui.class(name, extends)
	local class = {
		name = name
	}
	class.__index = class
	return setmetatable(class, extends or gui.classbase)
end

gui.classes = {}
function gui.new(name, ...)
	return gui.classes[name]:new(...)
end

return gui
