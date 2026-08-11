-- setnamecallmethod.lua
-- © 2026 MrY7zz (ISC License)

local _Object = newproxy(true)
rawset(getmetatable(_Object), "__namecall", function() end)
rawset(getmetatable(_Object), "__metatable", "Locked.")

@native
function setnamecallmethod(method: string): nil
	if type(method) ~= "string" then
		return error("invalid argument #1 to 'setnamecallmethod' (string expected, got " .. typeof(method) .. ")")
	end
	loadstring("(...):" .. method .. "()"), _Object
end

--[=[
Usage:

local _, namecall = xpcall(function()
	return game:__namecall()
end, function()
	return debug.info(2, "f")
end)

local patched__namecall = function(instance, method, ...)
	setnamecallmethod(method)

	return namecall(instance, ...)
end

print(patched__namecall(game, "FindFirstChild", "Workspace")) --> Output: Workspace

--> Or you can do this: <--

local _, namecall = xpcall(function()
	return game:__namecall()
end, function()
	return debug.info(2, "f")
end)

setnamecallmethod("FindFirstChild")

print(namecall(game, "Workspace"))
]=]

