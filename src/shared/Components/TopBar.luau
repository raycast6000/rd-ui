local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components
local TopNavigationComponent = require(Components.TopNavigation)

return function ()
  return Roact.createElement("Frame", {
    AnchorPoint = Vector2.new(.5, .5),
    Position = UDim2.new(.5, 0, 0, 35),
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundTransparency = 1
  }, {
    TopNavigation = TopNavigationComponent()
  })
end