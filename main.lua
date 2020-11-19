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
	i = wbui.new("label", "Greetz from WBUI", 2, 2, g.w-4)
	g:append(i)
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
	j = wbui.new("button", "dump root's kids", 300, 150, 100)
	function j:onClick()
		for k, v in ipairs(wbui.root.children) do
			print(k, v, v.title)
		end
	end
	wbui.root:append(j)
	
	-- in retrospect, i could have used a loop.
	cur_arrow = wbui.new("button", "arrow", 450, 100, 45, 45)
	cur_arrow.enabled = false
	cur_arrow.cursor = love.mouse.getSystemCursor("arrow")
	function cur_arrow:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_arrow:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_arrow)
	cur_ibeam = wbui.new("button", "ibeam", 500, 100, 45, 45)
	cur_ibeam.enabled = false
	cur_ibeam.cursor = love.mouse.getSystemCursor("ibeam")
	function cur_ibeam:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_ibeam:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_ibeam)
	cur_wait = wbui.new("button", "wait", 550, 100, 45, 45)
	cur_wait.enabled = false
	cur_wait.cursor = love.mouse.getSystemCursor("wait")
	function cur_wait:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_wait:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_wait)
	cur_waitarrow = wbui.new("button", "waitarrow", 600, 100, 45, 45)
	cur_waitarrow.enabled = false
	cur_waitarrow.cursor = love.mouse.getSystemCursor("waitarrow")
	function cur_waitarrow:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_waitarrow:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_waitarrow)
	cur_crosshair = wbui.new("button", "crosshair", 650, 100, 45, 45)
	cur_crosshair.enabled = false
	cur_crosshair.cursor = love.mouse.getSystemCursor("crosshair")
	function cur_crosshair:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_crosshair:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_crosshair)
	cur_hand = wbui.new("button", "hand", 700, 100, 45, 45)
	cur_hand.enabled = false
	cur_hand.cursor = love.mouse.getSystemCursor("hand")
	function cur_hand:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_hand:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_hand)
	cur_sizewe = wbui.new("button", "sizewe", 450, 150, 45, 45)
	cur_sizewe.enabled = false
	cur_sizewe.cursor = love.mouse.getSystemCursor("sizewe")
	function cur_sizewe:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_sizewe:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_sizewe)
	cur_sizens = wbui.new("button", "sizens", 500, 150, 45, 45)
	cur_sizens.enabled = false
	cur_sizens.cursor = love.mouse.getSystemCursor("sizens")
	function cur_sizens:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_sizens:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_sizens)
	cur_sizenesw = wbui.new("button", "sizenesw", 550, 150, 45, 45)
	cur_sizenesw.enabled = false
	cur_sizenesw.cursor = love.mouse.getSystemCursor("sizenesw")
	function cur_sizenesw:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_sizenesw:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_sizenesw)
	cur_sizenwse = wbui.new("button", "sizenwse", 600, 150, 45, 45)
	cur_sizenwse.enabled = false
	cur_sizenwse.cursor = love.mouse.getSystemCursor("sizenwse")
	function cur_sizenwse:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_sizenwse:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_sizenwse)
	cur_sizeall = wbui.new("button", "sizeall", 650, 150, 45, 45)
	cur_sizeall.enabled = false
	cur_sizeall.cursor = love.mouse.getSystemCursor("sizeall")
	function cur_sizeall:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_sizeall:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_sizeall)
	cur_no = wbui.new("button", "no", 700, 150, 45, 45)
	cur_no.enabled = false
	cur_no.cursor = love.mouse.getSystemCursor("no")
	function cur_no:mouseEnter()
		love.mouse.setCursor(self.cursor)
	end
	function cur_no:mouseLeave()
		love.mouse.setCursor()
	end
	wbui.root:append(cur_no)
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
