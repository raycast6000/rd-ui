local Roact = require(game.ReplicatedStorage.Shared.Roact)
local ClickSound = game.ReplicatedStorage.Sounds.Client.UIClick

return function (image: string, item_name: string, reference: Roact.Ref)
  return Roact.createElement("ImageButton", {
    Image = image,
    ZIndex = 3,
    BackgroundColor3 = Color3.fromHex("#5a5a5a"),

    [Roact.Event.MouseButton1Click] = function()
      print("Clicked!", item_name)

      ClickSound:Play();
      reference:getValue().Visible = not reference:getValue().Visible;
    end
  }, {
    BorderRadius = Roact.createElement("UICorner"),
    Border = Roact.createElement("Frame", {
      Size = UDim2.new(1, 4, 1, 4),
      AnchorPoint = Vector2.new(.5, .5),
      Position = UDim2.fromScale(.5,.5),
      ZIndex = 2,
      BackgroundColor3 = Color3.fromHex("#ffffff"),
      BorderSizePixel = 0
    }, {BorderRadius = Roact.createElement("UICorner")}),
    Label = Roact.createElement("TextLabel", {
      Text = item_name:upper(),
      AnchorPoint = Vector2.new(.5, 1),
      Position = UDim2.fromScale(.5, 1),
      ZIndex = 3,
      Size = UDim2.new(.9, 0, 0, 20),
      TextScaled = true,
      BackgroundTransparency = 1,
      FontFace = Font.new("rbxasset://fonts/families/JosefinSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
      TextColor3 = Color3.fromHex("#ffffff"),
      TextStrokeTransparency = 0
    })
  })
end