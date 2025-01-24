local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components
local CountdownUpdate: RemoteEvent = ReplicatedStorage.Endpoints.Client.CountdownUpdate

return function ()
  local CountdownComponent = Roact.Component:extend("Countdown")

  function CountdownComponent:init()
    self:setState({countdown = "69:00"})
  end

  function CountdownComponent:render()
    return Roact.createElement("Frame", {
      AnchorPoint = Vector2.new(.5, .5),
      Position = UDim2.fromScale(.5, .1),
      Size = UDim2.fromScale(0.1, 0.075),
      BackgroundTransparency = 1
    }, {
      Label = Roact.createElement("TextLabel", {
        TextScaled = true,
        BackgroundTransparency = 1,
        TextStrokeTransparency = 0,
        TextColor3 = Color3.fromHex("#ffffff"),
        Size = UDim2.fromScale(1, 1),
        Text = self.state.countdown,
      })
    })
  end

  function CountdownComponent:didMount()
    self.connection = CountdownUpdate.OnClientEvent:Connect(function(countdownUpdate: string)
      self:setState({countdown = countdownUpdate})
    end)
  end

  function CountdownComponent:willUnmount()
    self.connection:Disconnect()
  end
  
  return Roact.createElement(CountdownComponent, {countdown = "1:00"})
end