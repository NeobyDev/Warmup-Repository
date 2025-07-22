local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local ProfileService = require(ServerScriptService.Server.Services.ProfileService)

local function onPlayerAdded(player: Player)
	ProfileService.loadProfile(player)
end

local function onPlayerRemoving(player: Player)
	ProfileService.saveProfile(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end
