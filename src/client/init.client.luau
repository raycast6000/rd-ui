local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Components = ReplicatedStorage.Shared.Components
local Player = game.Players.LocalPlayer
local Roact = require(game.ReplicatedStorage.Shared.Roact)
local TopBarComponent = require(Components.TopBar)

local App = Roact.createElement("ScreenGui", {IgnoreGuiInset = true}, {
  TopBar = TopBarComponent()
})

Roact.mount(App, Player.PlayerGui, game:GetService("HttpService"):GenerateGUID(false))