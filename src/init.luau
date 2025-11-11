local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local Players = game:GetService('Players')

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Classes
local KeyClass = require(script.Classes.Key)
local KeysGuiClass = require(script.Classes.KeysGui)

local keysGui = KeysGuiClass.new()
keysGui.Parent = PlayerGui

local Config = {
	Sizes = {
		UnPressed = UDim2.new(1, 0,0.137, 0),
		Pressed = UDim2.new(0.85, 0,0.137, 0)
	},

	IconColors = {
		Pressed = Color3.fromRGB(59, 59, 59),
		UnPressed = Color3.fromRGB(255, 255, 255)
	}
}

local activeBinds = {}
local sharedConnection = nil
local pressedKeys = {} -- Cache for pressed key states
local lastFramePressed = {} -- Track previous frame state for change detection

local Keybinds = {}
Keybinds.__index = Keybinds

-- Optimized shared update function
local function updateAllKeybinds()
	-- Cache frequently accessed values
	local sizesPressed = Config.Sizes.Pressed
	local sizesUnPressed = Config.Sizes.UnPressed
	local colorPressed = Config.IconColors.Pressed
	local colorUnPressed = Config.IconColors.UnPressed
	local lerpSpeed = 0.65

	-- Update pressed key cache only for keys that changed
	for name, bind in pairs(activeBinds) do
		local keyCode = bind.KeyCode
		local isPressed = UserInputService:IsKeyDown(keyCode)
		local wasPressed = lastFramePressed[keyCode]

		-- Only update if state changed or if currently pressed (for smooth lerping)
		if isPressed ~= wasPressed or isPressed then
			pressedKeys[keyCode] = isPressed
			lastFramePressed[keyCode] = isPressed

			local key = bind.Key
			local icon = bind.Icon

			if key and icon then
				if isPressed then
					key.Size = key.Size:Lerp(sizesPressed, lerpSpeed)
					icon.BackgroundColor3 = colorPressed
				else
					key.Size = key.Size:Lerp(sizesUnPressed, lerpSpeed)
					icon.BackgroundColor3 = colorUnPressed
				end
			end
		end
	end
end

-- Start or stop the shared connection based on active binds
local function manageSharedConnection()
	local hasActiveBinds = next(activeBinds) ~= nil

	if hasActiveBinds and not sharedConnection then
		-- Start shared connection
		sharedConnection = RunService.RenderStepped:Connect(updateAllKeybinds)
	elseif not hasActiveBinds and sharedConnection then
		-- Stop shared connection and clean up
		sharedConnection:Disconnect()
		sharedConnection = nil
		table.clear(pressedKeys)
		table.clear(lastFramePressed)
	end
end

-- Create a new keybind for visual feedback
--[[
	
	name : string
	key : Enum.KeyCode
	description : string
	position : string  'Bottom Left', 'Bottom Right', 'Top Left', 'Top Right'. Defaults to 'Bottom Left'
	parent : Instance?
	
]]
function Keybinds.new(name: string, key: Enum.KeyCode, description: string, position:string, parent: Instance?)
	
	position = position or 'Bottom Left'
	
	-- Early returns for optimization
	local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled
	if isMobile then
		return nil
	end

	if activeBinds[name] then
		warn("Keybind already exists: " .. name)
		return activeBinds[name]
	end

	local self = setmetatable({}, Keybinds)

	self.Name = name
	self.Key = KeyClass.new(key, description)
	self.Icon = self.Key.Icon
	self.TextLabel = self.Key.TextLabel
	self.KeyCode = key
	self.Description = description
	self.Parent = parent or keysGui.Base:FindFirstChild(position)

	-- Set positions
	if position == 'Bottom Left' then
		self.Icon.LayoutOrder = 1
		self.TextLabel.LayoutOrder = 2
		self.TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		self.Key.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	elseif position == 'Bottom Right' then
		self.Icon.LayoutOrder = 2
		self.TextLabel.LayoutOrder = 1
		self.TextLabel.TextXAlignment = Enum.TextXAlignment.Right
		self.Key.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	elseif position == 'Top Left' then
		self.Icon.LayoutOrder = 1
		self.TextLabel.LayoutOrder = 2
		self.TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		self.Key.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	elseif position == 'Top Right' then
		self.Icon.LayoutOrder = 2
		self.TextLabel.LayoutOrder = 1
		self.TextLabel.TextXAlignment = Enum.TextXAlignment.Right
		self.Key.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	end

	-- Parent the key to the specified parent
	self.Key.Parent = self.Parent

	-- Add to active binds
	activeBinds[self.Name] = self

	-- Initialize key state
	pressedKeys[key] = false
	lastFramePressed[key] = false

	-- Manage shared connection
	manageSharedConnection()

	return self
end

function Keybinds:Remove(name: string)
	local bindName = name or self.Name
	local bind = activeBinds[bindName]

	if not bind then
		warn("Keybind not found: " .. (bindName or "unknown"))
		return false
	end

	-- Clean up key state tracking
	if bind.KeyCode then
		pressedKeys[bind.KeyCode] = nil
		lastFramePressed[bind.KeyCode] = nil
	end

	-- Destroy the key GUI element
	if bind.Key then
		bind.Key:Destroy()
		bind.Key = nil
	end

	-- Remove from active binds
	activeBinds[bindName] = nil

	-- Clear references for garbage collection
	bind.Icon = nil
	bind.TextLabel = nil
	bind.Parent = nil
	bind.KeyCode = nil
	bind.Description = nil

	-- Manage shared connection
	manageSharedConnection()

	return true
end

-- Static method to remove by name
function Keybinds:RemoveByName(name: string)
	local bind = activeBinds[name]
	if bind then
		return bind:Remove(name)
	end
	return false
end

-- Method to get a keybind by name
function Keybinds:GetBind(name: string)
	return activeBinds[name]
end

-- Method to get all active binds (returns a copy to prevent external modification)
function Keybinds:GetAllBinds()
	local copy = {}
	for k, v in pairs(activeBinds) do
		copy[k] = v
	end
	return copy
end

-- Method to check if a keybind exists
function Keybinds:Exists(name: string)
	return activeBinds[name] ~= nil
end

-- Method to get the count of active binds
function Keybinds:GetCount()
	local count = 0
	for _ in pairs(activeBinds) do
		count = count + 1
	end
	return count
end

-- Method to update the key's parent
function Keybinds:SetParent(newParent: Instance)
	if self.Key then
		self.Key.Parent = newParent
		self.Parent = newParent
	end
end

-- Method to update the key code (recreates the visual)
function Keybinds:SetKey(newKey: Enum.KeyCode)
	if not self.Key then return end

	-- Clean up old key state
	if self.KeyCode then
		pressedKeys[self.KeyCode] = nil
		lastFramePressed[self.KeyCode] = nil
	end

	-- Destroy old key
	self.Key:Destroy()

	-- Create new key
	self.Key = KeyClass.new(newKey, self.Description)
	self.Icon = self.Key.Icon
	self.TextLabel = self.Key.TextLabel
	self.KeyCode = newKey
	-- Re-parent
	if self.Parent then
		self.Key.Parent = self.Parent
	end

	-- Initialize new key state
	pressedKeys[newKey] = false
	lastFramePressed[newKey] = false
end

-- Method to update the description
function Keybinds:SetDescription(newDescription: string)
	self.Description = newDescription
	if self.TextLabel then
		self.TextLabel.Text = newDescription
	end
end

-- Method to set the visibility of the key
function Keybinds:SetVisible(visible: boolean)
	if self.Key then
		self.Key.Visible = visible
	end
end

-- Method to set visibility of all keys
function Keybinds:SetAllVisible(visible: boolean)
	for _, bind in pairs(activeBinds) do
		bind:SetVisible(visible)
	end
end

-- Cleanup method to remove all active binds
function Keybinds:RemoveAll()
	-- Use pairs instead of next for cleaner iteration
	for name in pairs(activeBinds) do
		local bind = activeBinds[name]
		bind:Remove(name)
	end

	-- Force cleanup of shared connection
	if sharedConnection then
		sharedConnection:Disconnect()
		sharedConnection = nil
	end

	-- Clear all state
	table.clear(pressedKeys)
	table.clear(lastFramePressed)
end

-- Optional: Method to pause/resume all keybind updates
function Keybinds:SetUpdateEnabled(enabled: boolean)
	if enabled then
		manageSharedConnection()
	else
		if sharedConnection then
			sharedConnection:Disconnect()
			sharedConnection = nil
		end
	end
end

return Keybinds