local ContentProvider = game:GetService("ContentProvider")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local players = game:GetService("Players")

ReplicatedFirst:RemoveDefaultLoadingScreen()

local loadingGui = script.LoadingGUI

local player = players.LocalPlayer
local playerGui = player.PlayerGui
local MainMenuGUI = StarterGui:WaitForChild("MainMenu")

local gui = loadingGui:clone()
gui.Parent = playerGui
local MenuGUI = MainMenuGUI:clone()
MenuGUI.Parent = playerGui

local canvasGroup = gui.CanvasGroup
local loadingText = canvasGroup.Content.LoadingText

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local assets = workspace:GetDescendants()
local totalassets = #assets

for i, asset in assets do
	ContentProvider:PreloadAsync({ asset })
	loadingText.Text = "Loading."
	wait(1)
	loadingText.Text = "Loading.."
	wait(1)
	loadingText.Text = "Loading..."
	wait()
end

local fadeOut = TweenService:Create(canvasGroup, TweenInfo.new(1), {
	GroupTransparency = 1,
})

fadeOut:play()
MenuGUI.Enabled = true
fadeOut.Completed:Wait()

gui:destroy()
