local FONT = Enum.Font.Arimo
local LONG_KEYS = {
	Enum.KeyCode.Backspace,
	Enum.KeyCode.LeftShift,
	Enum.KeyCode.LeftControl,
	Enum.KeyCode.RightShift,
	Enum.KeyCode.RightControl,
} 

 function enumToText(key: Enum.KeyCode)
	local keyMap = {
		[Enum.KeyCode.Backspace] = "BACKSPACE",
		[Enum.KeyCode.Tab] = "TAB",
		[Enum.KeyCode.Clear] = "CLEAR",
		[Enum.KeyCode.Return] = "ENTER",
		[Enum.KeyCode.Pause] = "PAUSE",
		[Enum.KeyCode.Escape] = "ESC",
		[Enum.KeyCode.Space] = "SPACE",
		[Enum.KeyCode.LeftShift] = "LSHIFT",
		[Enum.KeyCode.RightShift] = "RSHIFT",
		[Enum.KeyCode.LeftControl] = "LCTRL",
		[Enum.KeyCode.RightControl] = "RCTRL",
		[Enum.KeyCode.LeftAlt] = "LALT",
		[Enum.KeyCode.RightAlt] = "RALT",
		[Enum.KeyCode.LeftSuper] = "LSUPER",
		[Enum.KeyCode.RightSuper] = "RSUPER",
		[Enum.KeyCode.CapsLock] = "CAPS",
		[Enum.KeyCode.NumLock] = "NUMLOCK",
		[Enum.KeyCode.ScrollLock] = "SCROLL",
		[Enum.KeyCode.Insert] = "INS",
		[Enum.KeyCode.Delete] = "DEL",
		[Enum.KeyCode.Home] = "HOME",
		[Enum.KeyCode.End] = "END",
		[Enum.KeyCode.PageUp] = "PGUP",
		[Enum.KeyCode.PageDown] = "PGDN",
		[Enum.KeyCode.Up] = "UP",
		[Enum.KeyCode.Down] = "DOWN",
		[Enum.KeyCode.Left] = "LEFT",
		[Enum.KeyCode.Right] = "RIGHT",
		[Enum.KeyCode.F1] = "F1",
		[Enum.KeyCode.F2] = "F2",
		[Enum.KeyCode.F3] = "F3",
		[Enum.KeyCode.F4] = "F4",
		[Enum.KeyCode.F5] = "F5",
		[Enum.KeyCode.F6] = "F6",
		[Enum.KeyCode.F7] = "F7",
		[Enum.KeyCode.F8] = "F8",
		[Enum.KeyCode.F9] = "F9",
		[Enum.KeyCode.F10] = "F10",
		[Enum.KeyCode.F11] = "F11",
		[Enum.KeyCode.F12] = "F12",
		[Enum.KeyCode.A] = "A",
		[Enum.KeyCode.B] = "B",
		[Enum.KeyCode.C] = "C",
		[Enum.KeyCode.D] = "D",
		[Enum.KeyCode.E] = "E",
		[Enum.KeyCode.F] = "F",
		[Enum.KeyCode.G] = "G",
		[Enum.KeyCode.H] = "H",
		[Enum.KeyCode.I] = "I",
		[Enum.KeyCode.J] = "J",
		[Enum.KeyCode.K] = "K",
		[Enum.KeyCode.L] = "L",
		[Enum.KeyCode.M] = "M",
		[Enum.KeyCode.N] = "N",
		[Enum.KeyCode.O] = "O",
		[Enum.KeyCode.P] = "P",
		[Enum.KeyCode.Q] = "Q",
		[Enum.KeyCode.R] = "R",
		[Enum.KeyCode.S] = "S",
		[Enum.KeyCode.T] = "T",
		[Enum.KeyCode.U] = "U",
		[Enum.KeyCode.V] = "V",
		[Enum.KeyCode.W] = "W",
		[Enum.KeyCode.X] = "X",
		[Enum.KeyCode.Y] = "Y",
		[Enum.KeyCode.Z] = "Z",
		[Enum.KeyCode.Zero] = "0",
		[Enum.KeyCode.One] = "1",
		[Enum.KeyCode.Two] = "2",
		[Enum.KeyCode.Three] = "3",
		[Enum.KeyCode.Four] = "4",
		[Enum.KeyCode.Five] = "5",
		[Enum.KeyCode.Six] = "6",
		[Enum.KeyCode.Seven] = "7",
		[Enum.KeyCode.Eight] = "8",
		[Enum.KeyCode.Nine] = "9",
		[Enum.KeyCode.KeypadZero] = "KP0",
		[Enum.KeyCode.KeypadOne] = "KP1",
		[Enum.KeyCode.KeypadTwo] = "KP2",
		[Enum.KeyCode.KeypadThree] = "KP3",
		[Enum.KeyCode.KeypadFour] = "KP4",
		[Enum.KeyCode.KeypadFive] = "KP5",
		[Enum.KeyCode.KeypadSix] = "KP6",
		[Enum.KeyCode.KeypadSeven] = "KP7",
		[Enum.KeyCode.KeypadEight] = "KP8",
		[Enum.KeyCode.KeypadNine] = "KP9",
		[Enum.KeyCode.KeypadPeriod] = "KP.",
		[Enum.KeyCode.KeypadDivide] = "KP/",
		[Enum.KeyCode.KeypadMultiply] = "KP*",
		[Enum.KeyCode.KeypadMinus] = "KP-",
		[Enum.KeyCode.KeypadPlus] = "KP+",
		[Enum.KeyCode.KeypadEnter] = "KPENTER",
		[Enum.KeyCode.KeypadEquals] = "KP=",
		[Enum.KeyCode.Minus] = "-",
		[Enum.KeyCode.Equals] = "=",
		[Enum.KeyCode.LeftBracket] = "[",
		[Enum.KeyCode.RightBracket] = "]",
		[Enum.KeyCode.Semicolon] = ";",
		[Enum.KeyCode.Quote] = "'",
		[Enum.KeyCode.Comma] = ",",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Slash] = "/",
		[Enum.KeyCode.Unknown] = "UNKNOWN",
	}
	return keyMap[key] or tostring(key):gsub("Enum.KeyCode.", "")
end

local KeyClass = {}

KeyClass.new = function(key: Enum.KeyCode, description: string)
	local Key = Instance.new('Frame')
	Key.AnchorPoint = Vector2.new(0,0)
	Key.BackgroundColor3 = Color3.new(0.639216, 0.635294, 0.647059)
	Key.BackgroundTransparency = 1
	Key.Position = UDim2.new(0,0,0.863,0)
	Key.Size = UDim2.new(1,0,0.137,0)
	Key.Name = tostring(key)
	
	local UIAspectRatioConstraint_Key = Instance.new('UIAspectRatioConstraint')
	 UIAspectRatioConstraint_Key.Parent =  Key
	 UIAspectRatioConstraint_Key.AspectRatio = 7.65
	
	local UIListLayout = Instance.new('UIListLayout')
	 UIListLayout.Parent =  Key
	 UIListLayout.Padding = UDim.new(0.05,0)
	 UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	 UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	 UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	 UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	local Icon = Instance.new('ImageLabel')
	 Icon.AnchorPoint = Vector2.new(0.5,0.5)
	 Icon.BackgroundColor3 = Color3.new(1, 1, 1)
	 Icon.BackgroundTransparency = 0.001
	 Icon.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
	 Icon.Size = UDim2.new(1.1,0,1.1,0)
	 Icon.Name = 'Icon'
	 Icon.Parent =  Key
	
	local UIAspectRatioConstraint_Icon = Instance.new('UIAspectRatioConstraint')
	 UIAspectRatioConstraint_Icon.Parent =  Icon
	 UIAspectRatioConstraint_Icon.AspectRatio = if table.find(LONG_KEYS, key) then 2.1 else 1 -- 2.1 for long keys
	
	 local UICorner_Icon = Instance.new('UICorner')
	 UICorner_Icon.Parent =  Icon
	 UICorner_Icon.CornerRadius = UDim.new(0.15,0)
	
	local UIStroke_Icon = Instance.new('UIStroke')
	 UIStroke_Icon.Parent =  Icon
	 UIStroke_Icon.Thickness = 1.5
	 UIStroke_Icon.LineJoinMode = Enum.LineJoinMode.Round
	 UIStroke_Icon.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize
	 UIStroke_Icon.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	 UIStroke_Icon.Color = Color3.new(0.0352941, 0.0352941, 0.0352941)
	 UIStroke_Icon.Transparency = 0.7
	
	 local TextLabel_Icon = Instance.new('TextLabel')
	 TextLabel_Icon.BackgroundColor3 = Color3.new(0.639216, 0.635294, 0.647059)
	 TextLabel_Icon.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
	 TextLabel_Icon.Size = UDim2.new(3,0,0.55,0)
	 TextLabel_Icon.TextColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588)
	 TextLabel_Icon.TextScaled = true
	 TextLabel_Icon.BackgroundTransparency = 1
	 TextLabel_Icon.AnchorPoint = Vector2.new(0.5,0.5)
	 TextLabel_Icon.Position = UDim2.new(0.5,0,0.5,0)
	 TextLabel_Icon.Text = enumToText(key) -- Sets the text to the key name
	 TextLabel_Icon.Font = FONT -- Sets the font to the font variable
	 TextLabel_Icon.Parent =  Icon
	
	 local TextLabel_Description = Instance.new('TextLabel')
	 TextLabel_Description.BackgroundColor3 = Color3.new(0.639216, 0.635294, 0.647059)
	 TextLabel_Description.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
	 TextLabel_Description.Size = UDim2.new(3,0,0.58,0)
	 TextLabel_Description.TextColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588)
	 TextLabel_Description.TextScaled = true
	 TextLabel_Description.BackgroundTransparency = 1
	 TextLabel_Description.AnchorPoint = Vector2.new(0.5,0.5)
	 TextLabel_Description.Position = UDim2.new(0.5,0,0.5,0)
	 TextLabel_Description.Font = FONT -- Sets the font to the font variable
	 TextLabel_Description.Text = description -- Sets the text to the description
	 TextLabel_Description.Parent = Key
	return Key
end

return KeyClass