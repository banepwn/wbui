function love.load()
	huge = love.graphics.newFont(48)
	
	wbui = require("wbui")
	wbui.initialize({})
	a = wbui.new("window", "focused window", 200, 200, 300, 50)
	a.focus = true
	wbui.root:append(a)
	e = wbui.new("window", "unfocused window", 200, 250, 300, 50)
	e.focus = false
	wbui.root:append(e)
	f = wbui.new("window", "window with icon", 200, 300, 300, 50)
	f:setIcon("calculator.png")
	wbui.root:append(f)
	g = wbui.new("window", "window with buttons", 200, 350, 300, 50)
	g:showButton("close", true)
	g:showButton("maximize", true)
	g:showButton("minimize", true)
	g:showButton("help", true)
	wbui.root:append(g)
	b = wbui.new("button", "normal", 200, 100)
	wbui.root:append(b)
	c = wbui.new("button", "hover", 200, 125)
	c.hover = true
	wbui.root:append(c)
	d = wbui.new("button", "active", 200, 150)
	d.active = true
	wbui.root:append(d)
	h = wbui.new("button", "click me", 300, 100, 100)
	function h:onClick()
		local n = (self.count or 0)+1
		self.count = n
		self.text = "clicked "..n.." time"..(n == 1 and "" or "s")
	end
	wbui.root:append(h)
end

function love.update(dt)
	wbui.root:update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(0.227, 0.431, 0.647)
	love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(huge)
	love.graphics.print("wbui demo", 32, 32)
	
	wbui.root:draw()
end

function love.mousepressed(x, y, button, touch, presses)
	wbui.root:mouseDown(button, x, y, presses, touch)
end

function love.mousereleased(x, y, button, touch, presses)
	wbui.root:mouseUp(button, x, y, presses, touch)
end

function love.mousemoved(x, y, dx, dy, touch)
	wbui.root:mouseMoved(x, y, dx, dy, touch)
end
