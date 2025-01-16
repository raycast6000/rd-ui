local UserInputService = game:GetService("UserInputService")
local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components
local NutritionComponent = require(Components.Nutrition)

return function ()
  local IsMobile = UserInputService.TouchEnabled

  return Roact.createElement("Frame", {
    AnchorPoint = if not IsMobile then Vector2.new(0, 1) else Vector2.new(1,0),
    Position = if not IsMobile then UDim2.new(0, 20, 1, -20) else UDim2.new(1, 0, 0.175, 0),
    Size = UDim2.fromOffset((if not IsMobile then 350 else 300), 200),
    BackgroundTransparency = 1
  }, {
    Layout = Roact.createElement("UIListLayout", {VerticalAlignment = if not IsMobile then Enum.VerticalAlignment.Bottom else Enum.VerticalAlignment.Top}),
    NutritionStat = NutritionComponent()
  })
end