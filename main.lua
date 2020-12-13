local demo
function love.load()
	love.graphics.setBackgroundColor(0.227, 0.431, 0.647)
	wbui = require('wbui')
	wbui.initialize({})

	local root = wbui.root
	demo = wbui.new('window', "WBUI demo", 10, 10, 300, 200)
	demo:showButton('close', true)
	demo:showButton('maximize', true)
	demo:showButton('minimize', true)
	demo:showButton('help', true)
	local demo_label = wbui.new('label', "Greetings from WBUI", 3, 3, 294)
	demo:append(demo_label)
	local demo_button = wbui.new('button', "Click me!", 3, 18)
	function demo_button:onClick()
		local n = (self.n or 0)+1
		self.n = n
		self.text = "That's "..n.."!"
	end
	demo:append(demo_button)
	local demo_button2 = wbui.new('button', "Can't click this", 81, 18, 100)
	demo_button2.enabled = false
	demo:append(demo_button2)
	local demo_dropdown = wbui.new('dropdown', {
		"Alice",
		"Bob",
		"Charlie",
		"Really, "..string.rep("really, ", 10).."long string"
	}, 3, 43)
	demo:append(demo_dropdown)
	root:append(demo)
end

function love.update(dt)
	wbui.root:update(dt)
end

function love.draw()
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
