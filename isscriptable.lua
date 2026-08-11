-- isscriptable.lua
-- © 2026 MrY7zz (ISC License)

local GetPropertyChangedSignal = game.GetPropertyChangedSignal
local string_sub = string_sub or string.sub

@native
function isscriptable(instance: Instance, property: string): boolean
	local s, r = pcall(GetPropertyChangedSignal, instance, property)
	return s or string_sub(r, -29) ~= "is not a scriptable property." and string_sub(r, -29) ~= "is not a valid property name."
end

--[=[
Usage:

print(isscriptable(workspace.Baseplate, "NetworkOwnerV3")) --> Output: "false"
print(isscriptable(workspace.Baseplate, "Parent"))         --> Output: "true"
]=]
