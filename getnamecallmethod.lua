-- getnamecallmethod.lua
-- © 2026 MrY7zz (ISC License)

const string_sub = string.sub

const _, handler = xpcall(function()
	UDim2.new():__namecall()
end, function()
	return debug.info(2, "f")
end)

@native
function getnamecallmethod(): string -- | nil
	const _, r = pcall(handler)
	return r ~= "Argument 1 missing or nil" and string_sub(r, 1, -32) or "Lerp"
end

--[=[
Usage:

local userdata = newproxy(true)
getmetatable(userdata).__namecall = function(self, ...)
	print("__namecall method: " .. tostring(getnamecallmethod()))
end

userdata:HelloWorld() --> Output: "__namecall method: HelloWorld"
]=]
