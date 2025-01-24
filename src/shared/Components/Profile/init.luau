local TweenService = game:GetService("TweenService")
local Roact = require(game.ReplicatedStorage.Shared.Roact)
local Components = game.ReplicatedStorage.Shared.Components
local Signals = game.ReplicatedStorage.Endpoints
local ClickSound: Sound = game.ReplicatedStorage.Sounds.Client.UIClick
local BorderComponent = require(Components.Border)

function candidacy_toggle(toggle: boolean)
  ClickSound:Play()

  if not toggle then
    Signals.CandidateOff:FireServer()
  else
    Signals.CandidateOn:FireServer()
  end
end

function ToggleButton(initial_toggle: boolean, callback: () -> ())
  print("Initial toggle:", initial_toggle)

  local button_ref: Roact.Ref = Roact.createRef()
  local circle_ref: Roact.Ref = Roact.createRef()

  return Roact.createElement("TextButton", {
    Size = UDim2.new(0, 42, .55, 0),
    Text = "",
    BackgroundColor3 = if not initial_toggle then Color3.fromHex("#7e1818") else Color3.fromHex("#3d7f00"),

    [Roact.Event.MouseButton1Click] = function()
      print(not initial_toggle)

      TweenService:Create(circle_ref:getValue(), TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        Position = UDim2.fromScale(if initial_toggle then 0 else 1, .5)
      }):Play()

      TweenService:Create(button_ref:getValue(), TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        BackgroundColor3 = if initial_toggle then Color3.fromHex("#7e1818") else Color3.fromHex("#3d7f00"),
      }):Play()

      initial_toggle = not initial_toggle

      callback(initial_toggle)
    end,

    [Roact.Ref] = button_ref
  }, {
    Radius = Roact.createElement("UICorner", {CornerRadius = UDim.new(1, 0)}),
    Circle = Roact.createElement("Frame", {
      AnchorPoint = Vector2.new(.5, .5),
      Size = UDim2.new(0, 26, 1, 5),
      BackgroundColor3 = Color3.fromHex("#ffffff"),
      Position = UDim2.fromScale(if initial_toggle then 1 else 0, .5),

      [Roact.Ref] = circle_ref
    }, {Radius = Roact.createElement("UICorner", {CornerRadius = UDim.new(1, 0)})})
  })
end

function InfoLabel(text: string, toggle_callback: () -> ()?)
  if toggle_callback then
    print("Callback")

    return Roact.createElement("Frame", {
      Size = UDim2.new(1, 0, 0, 40),
      BackgroundTransparency = 1,
    }, {
      Layout = Roact.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.Name,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 10)
      }),

      Toggle = ToggleButton(true, candidacy_toggle),

      Label = Roact.createElement("TextLabel", {
        Text = text,
        Size = UDim2.new(.35, 0, 0, 25),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextScaled = true,
        TextColor3 = Color3.fromHex("#ffffff"),
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        BackgroundTransparency = 1
      }), --> Too lazy to write the same thing srry
    })
  else
    return Roact.createElement("Frame", {
      Size = UDim2.new(1, 0, 0, 40),
      BackgroundTransparency = 1
    }, {
      Layout = Roact.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.Name,
        VerticalAlignment = Enum.VerticalAlignment.Center
      }),

      Label = Roact.createElement("TextLabel", {
        Text = text,
        Size = UDim2.new(.75, 0, 0, 25),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextScaled = true,
        TextColor3 = Color3.fromHex("#ffffff"),
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        BackgroundTransparency = 1
      })
    })
  end
end

return function (gui: Roact.Ref)
  local player_avatar = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
  local toggle = true
  local description_ref = Roact.createRef()
  local cooldown = tick()
  local update_button_ref = Roact.createRef()

  return Roact.createElement("Frame", {
    AnchorPoint = Vector2.new(.5, .5),
    Size = UDim2.fromOffset(400, 500),
    BackgroundColor3 = Color3.fromHex("#5d5d5d"),
    Position = UDim2.fromScale(.5, .5),
    
    [Roact.Ref] = gui
  }, {
    BorderColor = BorderComponent(3, Color3.fromHex("#ffffff")),
    Radius = Roact.createElement("UICorner"),
    Top = Roact.createElement("Frame", {
      AnchorPoint = Vector2.new(.5, 0),
      Size = UDim2.new(1, -20, 0, 36),
      BackgroundTransparency = 1,
      Position = UDim2.new(.5, 0, 0, 8),
    }, {
      Close = Roact.createElement("TextButton", {
        Size = UDim2.new(0, 30, 1, 0),
        Position = UDim2.new(1, -30, 0, 0),
        BackgroundTransparency = 1,
        Text = "X",
        TextColor3 = Color3.fromHex("#ffffff"),
        TextSize = 20,
        TextScaled = true,
        Font = Enum.Font.SourceSans,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,

        [Roact.Event.MouseButton1Click] = function ()
          gui.current.Visible = not gui.current.Visible
        end
      }),
    }),
    Content = Roact.createElement("Frame", {
      Size = UDim2.fromScale(1, .92),
      Position = UDim2.new(0, 0, 0, 40),
      BackgroundTransparency = 1
    }, {
      Layout = Roact.createElement("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 24), HorizontalAlignment = Enum.HorizontalAlignment.Center}),

      PlayerAvatarContainer = Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(.5, 0),
        Size = UDim2.new(1, 0, 0, 130),
        BackgroundColor3 = Color3.fromHex("#ffffff"),
        Position = UDim2.new(.5, 0, .15, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 0
      }, {
        Avatar = Roact.createElement("ImageLabel", {
          AnchorPoint = Vector2.new(.5, .5),
          Size = UDim2.new(0, 130, 1, 0),
          Position = UDim2.fromScale(.5, .5),
          Image = player_avatar,
          BackgroundTransparency = 1
        }, {Border = Roact.createElement("UICorner", {CornerRadius = UDim.new(1, 0)})})
      }),

      Fields = Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(.5, 0),
        Size = UDim2.new(.9, 0, 0, 70),
        BackgroundTransparency = 1,
        LayoutOrder = 1
      }, {
        Layout = Roact.createElement("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3)}),
        CandidacyToggle = InfoLabel("Is candidate:", candidacy_toggle),
        CurrentParty = InfoLabel("Party: National Femboy Party"),
      }),

      Description = Roact.createElement("TextBox", {
        Size = UDim2.new(.9, 0, 0.250, 0),
        TextWrap = true,
        LayoutOrder = 2,
        BackgroundColor3 = Color3.fromRGB(110, 110, 110),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        Text = "",
        PlaceholderText = "Example: I am going to jail all bacon hairs..",
        ClearTextOnFocus = false,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextXAlignment = Enum.TextXAlignment.Left,
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        
        [Roact.Event.Changed] = function()
          local text = description_ref:getValue().Text;

          if #text > 120 then
            description_ref:getValue().Text = string.sub(text, 1, 120)
          end
        end,
        [Roact.Ref] = description_ref
      }, {
        Radius = Roact.createElement("UICorner"),
      }),

      UpdateButton = Roact.createElement("TextButton", {
        Text = "Update", 
        LayoutOrder = 3,
        TextSize = 22,
        Size = UDim2.new(.35, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(112, 112, 112),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),

        [Roact.Event.MouseButton1Click] = function()
          ClickSound:Play()

          local delta = tick()
          if (delta - cooldown) >= 1 and description_ref:getValue().Text ~= "" then
            Signals.UpdateCandidacyDesc:FireServer(description_ref:getValue().Text)

            local self: TextButton = update_button_ref:getValue()
          
            self.TextColor3 = Color3.fromHex("#00ff00"); 
            self.Text = "Updated!"

            task.delay(1, function()
              self.Text = "Update"
              self.TextColor3 = Color3.fromHex("#ffffff")
            end)

            cooldown = delta
          end
        end,

        [Roact.Ref] = update_button_ref
      }, {Radius = Roact.createElement("UICorner", {CornerRadius = UDim.new(1, 0)})})
    })
  })
end