local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components
local CandidacyToggleComponent = require(Components.CandidacyToggle)

return function ()
  if game:GetService("UserInputService").TouchEnabled then
    print("Mobile")

    return Roact.createElement("Frame", {
      AnchorPoint = Vector2.new(.5, 0),
      Position = UDim2.new(.5, 0, 0, 0),
      Size = UDim2.new(1/2, 0, 1, 0)
    }, {
      GridLayout = Roact.createElement("UIGridLayout", {HorizontalAlignment = Enum.HorizontalAlignment.Center, CellSize = UDim2.new(0, 100, 1, 0)}),
      CandidacyToggle = CandidacyToggleComponent(),
    })
  end
end