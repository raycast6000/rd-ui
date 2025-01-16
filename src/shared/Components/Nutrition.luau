local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components
local Signals = game.ReplicatedStorage.Endpoints
local Player = game.Players.LocalPlayer

return function ()
  local FillerComponent = Roact.Component:extend("Filler")
  
  function FillerComponent:init()
    self:setState({update = Player:GetAttribute("Hunger") / 100})

    local hunger_listener = Player:GetAttributeChangedSignal("Hunger"):Connect(function()
      local hunger: number = Player:GetAttribute("Hunger")

      self:setState({update = hunger / 100})
    end)

    self.listener = hunger_listener;
  end

  function FillerComponent:render()
    return Roact.createElement("Frame", {
      BackgroundColor3 = Color3.fromRGB(255, 177, 31),
      Size = UDim2.fromScale(self.state.update, 1),
      BorderSizePixel = 0
    })
  end

  function FillerComponent:willUnmount()
    self.listener:Disconnect()
  end

  return Roact.createElement("Frame", {
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundTransparency = 1
  }, {
    Layout = Roact.createElement("UIListLayout", {
      FillDirection = Enum.FillDirection.Horizontal,
      HorizontalFlex = Enum.UIFlexAlignment.None
    }),

    [2] = Roact.createElement("TextLabel", {
      Text = "🍞",
      Size = UDim2.new(0, 56, 1, 0),
      TextSize = 18,
      BackgroundTransparency = 1,
    }),

    [3] = Roact.createElement("Frame", {
      BackgroundColor3 = Color3.fromHex("#5a5a5a"),
      Size = UDim2.fromScale(1,1),
      BorderSizePixel = 0
    }, {
      Flex = Roact.createElement("UIFlexItem", {FlexMode = Enum.UIFlexMode.Fill}),
      Filler = Roact.createElement(FillerComponent, {})
    })
  })
end