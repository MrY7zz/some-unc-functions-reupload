-- gethiddenproperty.lua
-- © 2026 MrY7zz (ISC License)

--// This implementation can be detected, as it creates a service that
--// Isn't created by default.
local UGCValidationService = game:GetService("UGCValidationService")
local GetPropertyValue = UGCValidationService.GetPropertyValue
local GetPropertyChangedSignal = UGCValidationService.GetPropertyChangedSignal

local __Index
xpcall(function()
	return game[{}]
end, function()
	__Index = debug.info(2, "f")
end)

@native
function gethiddenproperty(instance: Instance, property: string): (any, boolean)
	--// First we try to get the property with UGCValidationService
	--// This won't work every time
	local success, result = pcall(GetPropertyValue, UGCValidationService, instance, property)
	if success and result ~= nil then
		return result, true
	else
		--// If it didn't return anything, or it didn't succeed,
		--// We try accessing it directly
		local s, r = pcall(GetPropertyChangedSignal, instance, property); if not s and string.sub(r, -29) == "is not a valid property name." then return nil end --// Prevent indexing an instance instead of a property
		local success2, result2 = pcall(__Index, instance, property)
		if success2 then
			return result2, false
		else
			return __Index(instance, property)
		end
	end
end

--[=[
Usage:

print(gethiddenproperty(Instance.new("Motor6D"), "ReplicateCurrentAngle6D"))
print(gethiddenproperty(workspace, "Parent")) -- Not hidden, still returns.
]=]
