local Engine2D = require(game.StarterPlayer.StarterPlayerScripts.ModuleScript)

-- TEST Instances

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

local Frame = Instance.new("Frame")
Frame.Position = UDim2.new(0,1,0,1)
Frame.Size = UDim2.new(0, 100, 0 ,100)
Frame.Parent = ScreenGui

local Folder = Instance.new("Folder")
Folder.Parent = ScreenGui

for i = 1, 30 do
	local platform = Instance.new("Frame")
	platform.Name = "Frame" .. i
	platform.Parent = Folder
	platform.Size = UDim2.new(0, 70, 0, 1)
	platform.Position = UDim2.new(0, math.random(0, 900), 0, math.random(300, 400))
end

-- TEST CODE

local engineInstance = Engine2D.new()
engineInstance.Frame = Frame
engineInstance.Holders = Folder

engineInstance:StartEngine()