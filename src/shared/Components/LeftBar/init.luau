local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components
local LBItem = require(script.LBItem)
local Player = game.Players.LocalPlayer

return function (References)
  local PlayerPicture = game.Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60)
  
  print(References)

  return Roact.createElement("Frame", {
    AnchorPoint = Vector2.new(0, .5),
    Size = UDim2.fromOffset(176, 326),
    Position = UDim2.new(0, 20, .5, 0),
    BackgroundTransparency = 1,
  }, {
    GridLayout = Roact.createElement("UIGridLayout", {CellSize = UDim2.fromOffset(80, 80), CellPadding = UDim2.fromOffset(10, 10)}),
    Profile = LBItem(PlayerPicture, "Profile", References.ProfileGui),
    Parties = LBItem("rbxassetid://135012791411331", "Parties", References.PartiesGui),
    -- Companies = LBItem("rbxassetid://0", "CORPO."),
  })
end