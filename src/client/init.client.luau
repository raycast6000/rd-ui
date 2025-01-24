local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Components = ReplicatedStorage.Shared.Components
local Player = game.Players.LocalPlayer
local Roact = require(game.ReplicatedStorage.Shared.Roact)
local TopBarComponent = require(Components.TopBar)
local CountdownComponent = require(Components.Countdown)
local StatsComponent = require(Components.Stats)
local LeftBarComponent = require(Components.LeftBar)
local PartiesGuiComponent = require(Components.Parties)
local ProfileGuiComponent = require(Components.Profile)

local toggle
local handle: Roact.Tree? = nil
local References = {
  PartiesGui = Roact.createRef(),
  ProfileGui = Roact.createRef()
}

local Hud = {
  TopBar = TopBarComponent(),
  Countdown = CountdownComponent(),
  Stats = StatsComponent(),
  LeftBar = LeftBarComponent(References),
  PartiesGui = PartiesGuiComponent(References.PartiesGui),
  ProfileGui = ProfileGuiComponent(References.ProfileGui)
};

local App;
App = Roact.createElement("ScreenGui", {IgnoreGuiInset = true}, Hud);

handle = Roact.mount(App, Player.PlayerGui, game:GetService("HttpService"):GenerateGUID(false));