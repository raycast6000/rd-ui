local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components

return function (gui: Roact.Ref)
  local Component = Roact.Component:extend("Parties")

  function Component:init(props)
    
  end

  function Component:render()
    return Roact.createElement("Frame", {
      Size = UDim2.fromOffset(200, 200),
      BackgroundColor3 = Color3.fromRGB(0, 0, 0),
      BackgroundTransparency = .55,
      Position = UDim2.new(0, 0, 0, 0),
      Name = "5",

      [Roact.Ref] = gui
    })
  end

  function Component:didMount()
     
  end

  return Roact.createElement(Component)
end