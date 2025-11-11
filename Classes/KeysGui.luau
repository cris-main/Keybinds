local KeysGuiClass = {}

KeysGuiClass.new = function()
	local KeysGui = Instance.new("ScreenGui")
	KeysGui.DisplayOrder = 0
	KeysGui.IgnoreGuiInset = false
	KeysGui.ResetOnSpawn = false
	KeysGui.Name = "Keys"

	local BaseFrame = Instance.new("Frame")
	BaseFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	BaseFrame.BackgroundTransparency = 1
	BaseFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	BaseFrame.Size = UDim2.new(1, 0, 1, 0)
	BaseFrame.Name = "Base"
	BaseFrame.Parent = KeysGui

	------------------------------------------------------------------------------------
	local BottomLeftFrame = Instance.new("Frame")
	BottomLeftFrame.AnchorPoint = Vector2.new(0, 1)
	BottomLeftFrame.BackgroundTransparency = 1
	BottomLeftFrame.Position = UDim2.new(0.01, 0, 0.99, 0)
	BottomLeftFrame.Size = UDim2.new(0.188, 0, 0.279, 0)
	BottomLeftFrame.Name = "Bottom Left"
	BottomLeftFrame.Parent = BaseFrame

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = BottomLeftFrame
	UIListLayout.Padding = UDim.new(0.05, 0)
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Parent = BottomLeftFrame
	UIAspectRatioConstraint.AspectRatio = 1

	------------------------------------------------------------------------------------
	local BottomRightFrame = Instance.new("Frame")
	BottomRightFrame.AnchorPoint = Vector2.new(1, 1)
	BottomRightFrame.BackgroundTransparency = 1
	BottomRightFrame.Position = UDim2.new(0.99, 0, 0.99, 0)
	BottomRightFrame.Size = UDim2.new(0.188, 0, 0.279, 0)
	BottomRightFrame.Name = "Bottom Right"
	BottomRightFrame.Parent = BaseFrame

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = BottomRightFrame
	UIListLayout.Padding = UDim.new(0.05, 0)
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Parent = BottomRightFrame
	UIAspectRatioConstraint.AspectRatio = 1

	------------------------------------------------------------------------------------
	local TopLeftFrame = Instance.new("Frame")
	TopLeftFrame.AnchorPoint = Vector2.new(0, 0)
	TopLeftFrame.BackgroundTransparency = 1
	TopLeftFrame.Position = UDim2.new(0.01, 0, 0.01, 0)
	TopLeftFrame.Size = UDim2.new(0.188, 0, 0.279, 0)
	TopLeftFrame.Name = "Top Left"
	TopLeftFrame.Parent = BaseFrame

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = TopLeftFrame
	UIListLayout.Padding = UDim.new(0.05, 0)
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Parent = TopLeftFrame
	UIAspectRatioConstraint.AspectRatio = 1

	------------------------------------------------------------------------------------
	local TopRightFrame = Instance.new("Frame")
	TopRightFrame.AnchorPoint = Vector2.new(1, 0)
	TopRightFrame.BackgroundTransparency = 1
	TopRightFrame.Position = UDim2.new(0.99, 0, 0.01, 0)
	TopRightFrame.Size = UDim2.new(0.188, 0, 0.279, 0)
	TopRightFrame.Name = "Top Right"
	TopRightFrame.Parent = BaseFrame

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = TopRightFrame
	UIListLayout.Padding = UDim.new(0.05, 0)
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Parent = TopRightFrame
	UIAspectRatioConstraint.AspectRatio = 1

	return KeysGui
end

return KeysGuiClass
