-- fireproximityprompt.lua
-- © 2026 MrY7zz (ISC License)

local ProximityPrompt = Instance.new("ProximityPrompt")

local __Index
local __newIndex

xpcall(function()
	return game[{}]
end, function()
	__Index = debug.info(2, "f")
end)

xpcall(function()
	game[{}] = {}
end, function()
	__newIndex = debug.info(2, "f")
end)

local InputHoldBegin = __Index(ProximityPrompt, "InputHoldBegin")
local InputHoldEnd = __Index(ProximityPrompt, "InputHoldEnd")

local math_huge = math.huge

@native
function fireproximityprompt(prompt: ProximityPrompt): nil
	local HoldDuration = __Index(prompt, "HoldDuration")
	local MaxActivationDistance = __Index(prompt, "MaxActivationDistance")
	local RequiresLineOfSight = __Index(prompt, "RequiresLineOfSight")
	local Enabled = __Index(prompt, "Enabled")

	__newIndex(prompt, "Enabled", true)
	__newIndex(prompt, "MaxActivationDistance", math_huge)
	__newIndex(prompt, "RequiresLineOfSight", false)
	__newIndex(prompt, "HoldDuration", 0)

	wait() --// Does not work with task.wait, I tried.
	InputHoldBegin(prompt)
	InputHoldEnd(prompt)
	__newIndex(prompt, "HoldDuration", HoldDuration)
	__newIndex(prompt, "MaxActivationDistance", MaxActivationDistance)
	__newIndex(prompt, "RequiresLineOfSight", RequiresLineOfSight)
	__newIndex(prompt, "Enabled", Enabled)
end

--[=[
Usage:

local prompt = workspace.Part.ProximityPrompt

fireproximityprompt(prompt) --// It gets fired!
]=]
