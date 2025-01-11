local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components

local gtoggle = false

function Toggle()
  local ToggleComponent = Roact.Component:extend("Toggle")

  function ToggleComponent:init()
    print("Component initialized.")

    self:setState({toggle = true})
  end

  function ToggleComponent:render()
    print("rendering nigga", self.props.toggle)

    return Roact.createElement("TextButton", {
      Size = UDim2.fromScale(1, 1),
      Text = ("Candidacy: %s"):format(tostring(self.state.toggle)),
      BackgroundTransparency = 1,
      TextColor3 = Color3.fromHex("#ffffff"),

      [Roact.Event.MouseButton1Click] = function(rbx)
        self:setState({toggle = not self.state.toggle})
      end
    })
  end

  return Roact.createElement(ToggleComponent, {toggle = true})
end

return function ()
  return Roact.createElement("Frame", {
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = .55,
  }, {
    CornerRadius = Roact.createElement("UICorner"),
    Button = Toggle()
  })
end