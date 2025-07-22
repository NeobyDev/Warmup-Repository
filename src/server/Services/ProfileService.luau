local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local DATASTORE_NAME = "Production"
if RunService:IsStudio() then
	DATASTORE_NAME = "Development"
end

local ProfileTemplete = require(script.Parent.ProfileTemplete)
local dataStore = DataStoreService:GetDataStore(DATASTORE_NAME)
local profilesInCache = {}

local module = {}

function module.loadProfile(player: Player)
	local success, profile = pcall(function()
		return dataStore:GetAsync(player.UserId)
	end)

	if not success then
		player:Kick("Seu Perfil não foi carregado corretamente.")
		return
	end

	if not profile then
		print("novo perfil")
		profile = ProfileTemplete
	end

	profilesInCache[player] = profile

	if typeof(profile.Shadows) == "boolean" then
		Lighting.GlobalShadows = profile.Shadows
	end

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local updateUIEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("UpdateShadowsUI")
	updateUIEvent:FireClient(player, profile.Shadows)

	print(profile)
end

function module.getProfile(player: Player)
	return profilesInCache[player]
end

function module.saveProfile(player: Player)
	local profile = profilesInCache[player]
	if not profile then
		return
	end

	local success, errorMsg = pcall(function()
		dataStore:SetAsync(player.UserId, profile)
	end)

	if not success then
		warn(errorMsg)
	end
end

function module.removeProfile(player: Player)
	profilesInCache[player] = nil
end

return module
