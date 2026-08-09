-- gethui.lua
-- © 2026 MrY7zz (ISC License)

local SafeScreenGui, ChosenGuiService = Instance.new("ScreenGui"), cloneref and cloneref(game:FindFirstChildOfClass("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")) or game:FindFirstChildOfClass("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
SafeScreenGui.Name = game:GetService("HttpService"):GenerateGUID(false)
pcall(function()
	SafeScreenGui.RobloxLocked = true
end)
SafeScreenGui.Parent = ChosenGuiService

function gethui()
	return SafeScreenGui
end

--[=[
Usage:

local UNSAFEScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui")) --// "Unsafe and detectable" -UNC™
local SAFEScreenGui = Instance.new("ScreenGui", gethui()) --// Safer, somehow
]=]
