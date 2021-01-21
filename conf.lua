function love.conf(t)
	t.window.title = "WBUI demo"
	t.window.width = 1024
	t.window.height = 768
	t.modules = {
		audio = false,
		data = false,
		event = true,
		font = true,
		graphics = true,
		image = true,
		joystick = false,
		keyboard = true,
		math = false,
		mouse = true,
		physics = false,
		sound = false,
		system = true,
		thread = false,
		timer = true,
		touch = true,
		video = false,
		window = true
	}
end
