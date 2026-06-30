local comlink = require("comlink")

local function shell_quote(value)
	return "'" .. tostring(value):gsub("'", "'\"'\"'") .. "'"
end

local function op_read(ref)
	local proc = assert(io.popen("opcache read " .. shell_quote(ref), "r"))
	local value = proc:read("*l")
	local ok, _, code = proc:close()

	assert(ok, "opcache failed for " .. ref .. " with code " .. tostring(code))
	return value
end

local conn = comlink.connect({
	server = "timculverhouse.com",
	user = "rockorager",
	nick = "rockorager",
	password = op_read("op://Private/76plh4kdmgqqvru6x3w4okrty4/password"),
	real_name = "Tim Culverhouse",
	tls = true,
})

comlink.bind("ctrl+c", "quit")
