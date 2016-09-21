pcall(function()

jit.vmdef = require("jit.vmdef")
jit.util = require("jit.util")

local old = jit.util.funcinfo

function jit.util.funcinfo(...)
	local t = old(...)

	if t.loc and t.source and t.source:startswith("@") then
		t.loc = t.source:sub(2) .. ":" .. t.loc:match(".+:(.+)")
	end

	return t
end

jit.profiler = require("jit.profile")
jit.bc = require("jit.bc")
jit.v = require("jit.v")
jit.opt = require("jit.opt")
jit.dump = require("jit.dump")
jit.dis = require("jit.dis_x64")

end)

function jit.dumpinfo(cb, output)
	local old = jit.getoptions().hotloop
	jit.opt.start("hotloop=1")
	jit.dump.on("tbimrsXaT", output)
	local ok, err = pcall(function() cb()cb()cb()cb() end) -- uhhh
	jit.dump.off()
	jit.opt.start("hotloop="..old)
	if not ok then logn(err) end
end

function jit.dumpbytecode(func)
	local out = {
		write = function(t, ...) log(...) end,
		close = function(t) end,
		flush = function(t) end,
	}

	jit.bc.dump(func, out)
end

function jit.debug(b)
	if b then
		jit.v.on()
	else
		jit.v.off()
	end
end

do
	local current = {
		-- maximum number of traces in the cache
		-- default = 1000
		-- min = 1
		-- max = 65535
		maxtrace = 65535,

		-- maximum number of recorded IR instructions
		-- default = 4000
		maxrecord = 20000,

		-- maximum number of IR constants of a trace
		-- default = 500
		maxirconst = 2500,

		-- maximum number of side traces of a root trace
		-- default = 100
		maxside = 100,

		-- maximum number of snapshots for a trace
		-- default = 500
		maxsnap = 800,

		-- minimum number of IR ins for a stitched trace.
		-- default = 0
		minstitch = 0,

		-- number of iterations to detect a hot loop or hot call
		-- default = 56
		hotloop = 10000,

		-- number of taken exits to start a side trace
		-- default = 10
		hotexit = 10,

		-- number of attempts to compile a side trace
		-- default = 4
		tryside = 4,

		-- maximum unroll factor for instable loops
		-- default = 4
		instunroll = 4,

		-- maximum unroll factor for loop ops in side traces
		-- default = 15
		loopunroll = 15,

		-- maximum unroll factor for pseudo-recursive calls
		-- default = 3
		callunroll = 3,

		-- minimum unroll factor for true recursion
		-- default = 2
		recunroll = 2,

		-- maximum total size of all machine code areas in KBytes
		-- default = 512
		maxmcode = 8192,

		--sizemcode = X64 and 64 or 32, -- Size of each machine code area in KBytes (Windows: 64K)
	}

	function jit.getoptions()
		return current
	end

	local sshh
	local last = {}

	function jit.setoption(option, num)
		if not current[option] then error("not a valid option", 2) end

		current[option] = num

		if last[option] ~= num then
			local options = {}

			if not sshh then
				logn("jit option ", option, " = ", num)
			end

			for k, v in pairs(current) do
				table.insert(options, k .. "=" .. v)
			end

			jit.opt.start(unpack(options))
			jit.flush()

			last[option] = num
		end
	end
	sshh = true
	for k,v in pairs(current) do
		jit.setoption(k, v)
	end
	sshh = nil
end