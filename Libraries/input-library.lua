-- input-library.lua
-- © 2026 MrY7zz (MIT License)

local VirtualInputManager = VirtualInputManager or Instance.new("VirtualInputManager")
local UserInputService = UserInputService or game:GetService("UserInputService")

--// Cache Methods
local SendKeyEvent = VirtualInputManager.SendKeyEvent
local SendMouseButtonEvent = VirtualInputManager.SendMouseButtonEvent
local SendMouseMoveEvent = VirtualInputManager.SendMouseMoveEvent
local SendMouseMoveDeltaEvent = VirtualInputManager.SendMouseMoveDeltaEvent
local SendScroll = VirtualInputManager.SendScroll
local SendTextInputCharacterEvent = VirtualInputManager.SendTextInputCharacterEvent
local SendTouchEvent = VirtualInputManager.SendTouchEvent
local HandleGamepadConnect = VirtualInputManager.HandleGamepadConnect
local HandleGamepadDisconnect = VirtualInputManager.HandleGamepadDisconnect
local HandleGamepadButtonInput = VirtualInputManager.HandleGamepadButtonInput
local HandleGamepadAxisInput = VirtualInputManager.HandleGamepadAxisInput
local SendAccelerometerEvent = VirtualInputManager.SendAccelerometerEvent
local SendGravityEvent = VirtualInputManager.SendGravityEvent
local SendGyroscopeEvent = VirtualInputManager.SendGyroscopeEvent
local WaitForInputEventsProcessed = VirtualInputManager.WaitForInputEventsProcessed
local GetMouseLocation = UserInputService.GetMouseLocation

local VirtualKeys = {
	[0x08] = Enum.KeyCode.Backspace,
	[0x09] = Enum.KeyCode.Tab,
	[0x0D] = Enum.KeyCode.Return,
	[0x10] = Enum.KeyCode.LeftShift,
	[0x11] = Enum.KeyCode.LeftControl,
	[0x12] = Enum.KeyCode.LeftAlt,
	[0x14] = Enum.KeyCode.CapsLock,
	[0x1B] = Enum.KeyCode.Escape,
	[0x20] = Enum.KeyCode.Space,
	[0x21] = Enum.KeyCode.PageUp,
	[0x22] = Enum.KeyCode.PageDown,
	[0x23] = Enum.KeyCode.End,
	[0x24] = Enum.KeyCode.Home,
	[0x25] = Enum.KeyCode.Left,
	[0x26] = Enum.KeyCode.Up,
	[0x27] = Enum.KeyCode.Right,
	[0x28] = Enum.KeyCode.Down,
	[0x2D] = Enum.KeyCode.Insert,
	[0x2E] = Enum.KeyCode.Delete,
	[0x30] = Enum.KeyCode.Zero,
	[0x31] = Enum.KeyCode.One,
	[0x32] = Enum.KeyCode.Two,
	[0x33] = Enum.KeyCode.Three,
	[0x34] = Enum.KeyCode.Four,
	[0x35] = Enum.KeyCode.Five,
	[0x36] = Enum.KeyCode.Six,
	[0x37] = Enum.KeyCode.Seven,
	[0x38] = Enum.KeyCode.Eight,
	[0x39] = Enum.KeyCode.Nine,
	[0x41] = Enum.KeyCode.A,
	[0x42] = Enum.KeyCode.B,
	[0x43] = Enum.KeyCode.C,
	[0x44] = Enum.KeyCode.D,
	[0x45] = Enum.KeyCode.E,
	[0x46] = Enum.KeyCode.F,
	[0x47] = Enum.KeyCode.G,
	[0x48] = Enum.KeyCode.H,
	[0x49] = Enum.KeyCode.I,
	[0x4A] = Enum.KeyCode.J,
	[0x4B] = Enum.KeyCode.K,
	[0x4C] = Enum.KeyCode.L,
	[0x4D] = Enum.KeyCode.M,
	[0x4E] = Enum.KeyCode.N,
	[0x4F] = Enum.KeyCode.O,
	[0x50] = Enum.KeyCode.P,
	[0x51] = Enum.KeyCode.Q,
	[0x52] = Enum.KeyCode.R,
	[0x53] = Enum.KeyCode.S,
	[0x54] = Enum.KeyCode.T,
	[0x55] = Enum.KeyCode.U,
	[0x56] = Enum.KeyCode.V,
	[0x57] = Enum.KeyCode.W,
	[0x58] = Enum.KeyCode.X,
	[0x59] = Enum.KeyCode.Y,
	[0x5A] = Enum.KeyCode.Z,
	[0x5B] = Enum.KeyCode.LeftSuper,
	[0x5C] = Enum.KeyCode.RightSuper,
	[0x60] = Enum.KeyCode.KeypadZero,
	[0x61] = Enum.KeyCode.KeypadOne,
	[0x62] = Enum.KeyCode.KeypadTwo,
	[0x63] = Enum.KeyCode.KeypadThree,
	[0x64] = Enum.KeyCode.KeypadFour,
	[0x65] = Enum.KeyCode.KeypadFive,
	[0x66] = Enum.KeyCode.KeypadSix,
	[0x67] = Enum.KeyCode.KeypadSeven,
	[0x68] = Enum.KeyCode.KeypadEight,
	[0x69] = Enum.KeyCode.KeypadNine,
	[0x6A] = Enum.KeyCode.KeypadMultiply,
	[0x6B] = Enum.KeyCode.KeypadPlus,
	[0x6D] = Enum.KeyCode.KeypadMinus,
	[0x6E] = Enum.KeyCode.KeypadPeriod,
	[0x6F] = Enum.KeyCode.KeypadDivide,
	[0x70] = Enum.KeyCode.F1,
	[0x71] = Enum.KeyCode.F2,
	[0x72] = Enum.KeyCode.F3,
	[0x73] = Enum.KeyCode.F4,
	[0x74] = Enum.KeyCode.F5,
	[0x75] = Enum.KeyCode.F6,
	[0x76] = Enum.KeyCode.F7,
	[0x77] = Enum.KeyCode.F8,
	[0x78] = Enum.KeyCode.F9,
	[0x79] = Enum.KeyCode.F10,
	[0x7A] = Enum.KeyCode.F11,
	[0x7B] = Enum.KeyCode.F12,
}

for _, keyCode in Enum.KeyCode:GetEnumItems() do
	VirtualKeys[keyCode.Name] = keyCode
end

@native
function keypress(key)
	SendKeyEvent(VirtualInputManager, true, VirtualKeys[key] or key, false, game)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function keyrelease(key)
	SendKeyEvent(VirtualInputManager, false, VirtualKeys[key] or key, false, game)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mouse1press()
	local position = GetMouseLocation(UserInputService)

	SendMouseButtonEvent(VirtualInputManager, math.floor(position.X), math.floor(position.Y), 0, true, game, 0)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mouse1release()
	local position = GetMouseLocation(UserInputService)

	SendMouseButtonEvent(VirtualInputManager, math.floor(position.X), math.floor(position.Y), 0, false, game, 0)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mouse1click()
	local position = GetMouseLocation(UserInputService)
	local x, y = math.floor(position.X), math.floor(position.Y)

	SendMouseButtonEvent(VirtualInputManager, x, y, 0, true, game, 0)
	SendMouseButtonEvent(VirtualInputManager, x, y, 0, false, game, 0)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mouse2press()
	local position = GetMouseLocation(UserInputService)

	SendMouseButtonEvent(VirtualInputManager, math.floor(position.X), math.floor(position.Y), 1, true, game, 0)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mouse2release()
	local position = GetMouseLocation(UserInputService)

	SendMouseButtonEvent(VirtualInputManager, math.floor(position.X), math.floor(position.Y), 1, false, game, 0)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mouse2click()
	local position = GetMouseLocation(UserInputService)
	local x, y = math.floor(position.X), math.floor(position.Y)

	SendMouseButtonEvent(VirtualInputManager, x, y, 1, true, game, 0)
	SendMouseButtonEvent(VirtualInputManager, x, y, 1, false, game, 0)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mousemoveabs(x, y)
	SendMouseMoveEvent(VirtualInputManager, x, y, game)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mousemoverel(dx, dy)
	SendMouseMoveDeltaEvent(VirtualInputManager, dx, dy, game)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function mousescroll(amount)
	local position = GetMouseLocation(UserInputService)

	SendScroll(VirtualInputManager, math.floor(position.X), math.floor(position.Y), 0, amount, {}, game)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function inputtext(text)
	SendTextInputCharacterEvent(VirtualInputManager, text, game)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function touchinput(touchId, state, x, y)
	SendTouchEvent(VirtualInputManager, touchId, state, x, y)
	WaitForInputEventsProcessed(VirtualInputManager)
end

@native
function gamepadconnect(deviceId)
	HandleGamepadConnect(VirtualInputManager, deviceId or 0)
end

@native
function gamepaddisconnect(deviceId)
	HandleGamepadDisconnect(VirtualInputManager, deviceId or 0)
end

@native
function gamepadbutton(deviceId, keyCode, state)
	HandleGamepadButtonInput(VirtualInputManager, deviceId or 0, VirtualKeys[keyCode] or keyCode, state)
end

@native
function gamepadaxis(deviceId, keyCode, x, y, z)
	HandleGamepadAxisInput(VirtualInputManager, deviceId or 0, VirtualKeys[keyCode] or keyCode, x or 0, y or 0, z or 0)
end

@native
function sendaccelerometer(x, y, z)
	SendAccelerometerEvent(VirtualInputManager, x or 0, y or 0, z or 0)
end

@native
function sendgravity(x, y, z)
	SendGravityEvent(VirtualInputManager, x or 0, y or 0, z or 0)
end

@native
function sendgyroscope(x, y, z, w)
	SendGyroscopeEvent(VirtualInputManager, x or 0, y or 0, z or 0, w or 1)
end

--[=[
Usage:

keypress(0x41)   --// Presses A
task.wait(0.1)
keyrelease(0x41) --// Releases A
]=]
