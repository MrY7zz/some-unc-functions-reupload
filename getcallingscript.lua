-- getcallingscript.lua
-- © 2026 MrY7zz (ISC License)

-- // Caching
local DescendantRemoving = game.DescendantRemoving
local DescendantAdded = game.DescendantAdded
local GetDescendants = game.GetDescendants
local Connect = DescendantRemoving.Connect
local GetFullName = game.GetFullName
local table = table
local table_insert = table.insert
local math_huge = math.huge

local debug_info = debug.info
local debug_traceback = debug.traceback
local string_find   = string.find
local string_sub   = string.sub
local string_match   = string.match
local IsA  = game.IsA
local RunContextClient = Enum.RunContext.Client

-- // Allows for more instances to be captured.
-- // Earlier this starts = more chance (of course if the instances are LocalScripts etc..)
local LocalScripts = {}
local nilpaths = {}

local __Index
xpcall(
	function() return game[{}] end,
	function() __Index = debug_info(2, "f") end
)

Connect(DescendantRemoving, function(d)
	if d and (IsA(d, "LocalScript") or IsA(d, "ModuleScript") or (IsA(d, "Script") and __Index(d, "RunContext") == RunContextClient)) then
		table_insert(LocalScripts, d)
		local path = GetFullName(d)
		nilpaths[path] = d
		nilpaths["game." .. path] = d
	end
end)

Connect(DescendantAdded, function(d)
	if d and (IsA(d, "LocalScript") or (IsA(d, "ModuleScript")) or (IsA(d, "Script") and __Index(d, "RunContext") == RunContextClient)) then
		table_insert(LocalScripts, d)
	end
end)
for i, v in ipairs(GetDescendants(game)) do
	if v and (IsA(v, "LocalScript") or (IsA(v, "ModuleScript")) or (IsA(v, "Script") and __Index(v, "RunContext") == RunContextClient)) then
		table_insert(LocalScripts, v)
	end
end

@native
local function getInstance(path)
	if path == "game" then
		return game
	end

	local opath = path
	local current = game

	if string_sub(path, 1, 5) == "game." then
		path = string_sub(path, 6)
	end

	local function resolve(parent, rest)
		if rest == "" then
			return __Index(parent, "") or nilpaths[opath]
		end

		local dot = string_find(rest, ".", 1, true)

		while dot do
			local left = string_sub(rest, 1, dot - 1)
			local right = string_sub(rest, dot + 1)

			local child = __Index(parent, left)
			if child then
				local found = resolve(child, right)
				if found then
					return found
				end
			end

			dot = string_find(rest, ".", dot + 1, true)
		end

		return __Index(parent, rest) or nilpaths[opath]
	end

	return resolve(current, path)
end

--// Main function
@native
function getcallingscript()
	for i = 2, math_huge do 
		local src, f = debug_info(i, "sf")
		if not src then break end

		local inst = getInstance(src)
		if inst then
			return inst
		end

		if f then
			local env = getfenv(f)
			local s = rawget(env, "script")
			if typeof(s) == "Instance" and IsA(s, "LuaSourceContainer") and (__Index(s, "ClassName") ~= "Script" or __Index(s, "RunContext") == RunContextClient) then
				return s
			end
		end
	end

	local tb = debug_traceback()
	local path = string_match(tb, "([%w%._%-]+):%d+")
	if path then
		local inst = getInstance(path)
		if inst then
			return inst
		end

		for _, v in ipairs(LocalScripts) do
			if GetFullName(v) == path then
				return v
			end
		end
	end
end

--[=[
Usage:

local userdata = newproxy(true)
getmetatable(userdata).__index = function(self, key)
	if key == "KeyThatPrints" then
		print(tostring(getcallingscript()) .. " has the key that prints.")
	end
end

local access = userdata.KeyThatPrints
]=]

