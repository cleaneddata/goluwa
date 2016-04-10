local love = ... or _G.love
local ENV = love._lovemu_env

love.event = love.event or {}

ENV.event_queue = ENV.event_queue or {}

function love.event.clear()
	table.clear(ENV.event_queue)
end

function love.event.push(e, a, b, c, d) --partial
	table.insert(ENV.event_queue, {e, a, b, c, d})
end

function love.event.poll() --partial
	return function()
		return love.event.wait()
	end
end

function love.event.pump() --partial

end

function love.event.quit() --partial
	logn("love.event.quit")
end

function love.event.wait() --partial
	local val = table.remove(ENV.event_queue, 1)

	if val then
		return unpack(val)
	end
end

love.handlers = {}