local love = ... or _G.love
local ENV = love._lovemu_env

love.mouse = love.mouse or {}

function love.mouse.setPosition(x, y)
	window.SetMousePosition(Vec2(x, y))
end

function love.mouse.getPosition()
	return window.GetMousePosition():Unpack()
end

function love.mouse.getX()
	return window.GetMousePosition().x
end

function love.mouse.getY()
	return window.GetMousePosition().y
end

function love.mouse.setRelativeMode(b)

end

love.mouse.setGrabbed = love.mouse.setRelativeMode

local Cursor = lovemu.TypeTemplate("Cursor")
lovemu.RegisterType(Cursor)

function love.mouse.newCursor() -- partial
	local obj = lovemu.CreateObject("Cursor")
	return obj
end

function love.mouse.getCursor() -- partial
	local obj = lovemu.CreateObject("Cursor")

	obj.getType = function()
		return window.GetCursor()
	end

	return obj
end

function love.mouse.setCursor() -- partial
	--window.GetCursor()
end

function love.mouse.getSystemCursor() -- partial
	local obj = lovemu.CreateObject("Cursor")
	obj.getType = function()
		return window.GetCursor()
	end
	return obj
end

do
	ENV.mouse_visible = false

	function love.mouse.setVisible(bool) -- partial
		ENV.mouse_visible = bool
	end

	function love.mouse.getVisible(bool) -- partial
		return ENV.mouse_visible
	end
end

local mouse_keymap = {
	button_1 = "l",
	button_2 = "r",
	button_3 = "m",
	button_4 = "x1",
	button_5 = "x2",
	mwheel_up = "wd",
	mwheel_down = "wu",
}

local mouse_keymap_10 = {
	button_1 = 1,
	button_2 = 2,
	button_3 = 3,
	button_4 = 4,
	button_5 = 5,
}

local mouse_keymap_reverse = {}
for k,v in pairs(mouse_keymap) do
	mouse_keymap_reverse[v] = k
end

local mouse_keymap_10_reverse = {}
for k,v in pairs(mouse_keymap_10) do
	mouse_keymap_10_reverse[v] = k
end

function love.mouse.isDown(key)
	return input.IsMouseDown(mouse_keymap_10_reverse[key]) or input.IsMouseDown(mouse_keymap_reverse[key])
end

event.AddListener("MouseInput", "lovemu", function(key, press)
	local x, y = window.GetMousePosition():Unpack()

	if key == "mwheel_up" or key == "mwheel_down" then
		lovemu.CallEvent("wheelmoved", 0, key == "mwheel_up" and 1 or -1)
	end

	if press then
		if mouse_keymap[key] then
			lovemu.CallEvent("mousepressed", x, y, mouse_keymap[key])
		end

		if mouse_keymap_10[key] then
			lovemu.CallEvent("mousepressed", x, y, mouse_keymap_10[key])
		end
	else
		if mouse_keymap[key] then
			lovemu.CallEvent("mousereleased", x, y, mouse_keymap[key])
		end

		if mouse_keymap_10[key] then
			lovemu.CallEvent("mousereleased", x, y, mouse_keymap_10[key])
		end
	end
end)