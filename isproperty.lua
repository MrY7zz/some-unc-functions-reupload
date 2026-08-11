-- isproperty.lua
-- © 2026 MrY7zz (ISC License)

local GetPropertyChangedSignal = game.GetPropertyChangedSignal
local string_sub = string_sub or string.sub

function isproperty(instance: Instance, property: string): boolean
	local s, r = pcall(GetPropertyChangedSignal, instance, property)
	return s or string_sub(r, -29) == "is not a scriptable property."
end
print(isproperty(workspace.Baseplate, "NetworkOwnerV3"))

--[=[
Usage:

print(isproperty(workspace.Baseplate, "Parent"))         --> Output: "true"
print(isproperty(workspace.Baseplate, "NetworkOwnerV3")) --> Hidden property, still the correct output: "true"
print(isproperty(workspace.Baseplate, "Not a property")) --> Output: "false"
]=]
