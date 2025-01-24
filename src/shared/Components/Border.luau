local Roact = require(game.ReplicatedStorage.Shared.Roact)

return function (thickness: number, color: Color3)
  return Roact.createElement("Frame", {
    AnchorPoint = Vector2.new(.5, .5),
    BackgroundColor3 = color,
    Size = UDim2.new(1, thickness, 1, thickness),
    Position = UDim2.fromScale(.5, .5),
    ZIndex = 0
  }, {
    Radius = Roact.createElement("UICorner")
  })
end