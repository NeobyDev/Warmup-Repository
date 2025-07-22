local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local ProfileService = require(script.Parent.Parent.Server.Services.ProfileService)
local toggleEvent = ReplicatedStorage.Events:WaitForChild("ToggleShadows")
local updateUIEvent = ReplicatedStorage.Events:WaitForChild("UpdateShadowsUI")

toggleEvent.OnServerEvent:Connect(function(player)
	local profile = ProfileService.getProfile(player)
	if not profile then
		return
	end

	local current = profile.Shadows
	if current == nil then
		current = true
	end

	local newValue = not current
	profile.Shadows = newValue

	Lighting.GlobalShadows = newValue

	updateUIEvent:FireClient(player, newValue)
end)
