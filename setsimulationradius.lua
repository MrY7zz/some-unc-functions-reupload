-- setsimulationradius.lua
-- © 2026 MrY7zz (ISC License)

local Players = game:GetService("Players")

local __newIndex
local __Index

--// Extracting __newindex
xpcall(function()
	game[{}] = {}
end, function()
	newIndex = debug.info(2, "f")
end)

--// Extracting __index
xpcall(function()
	return game[{}]
end, function()
	__Index = debug.info(2, "f")
end)


function setsimulationradius(Radius, maxRadius)
	local LocalPlayer = __Index(Players, "LocalPlayer")
	
	if maxRadius then
		__newIndex(LocalPlayer, "MaximumSimulationRadius", maxRadius)
	end
	__newIndex(LocalPlayer, "SimulationRadius", Radius)
end

--[=[
Usage:

local radius = 100 --// Let's take for example, 100, we will set the simulation radius to 100.
local maxradius = 150 --// Let's set the maximum radius to 150, for example.

setsimulationradius(radius, maxradius) --// Now the radius is 100, and the maximum radius is 150.

]=]
