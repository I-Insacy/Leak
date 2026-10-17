
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local lighting = game:GetService("Lighting")
local contextActionService = game:GetService("ContextActionService")
local httpService = game:GetService("HttpService")

local v1, v2 = pcall(function()
  local function f1()
    local v3, v4 = pcall(gethui)
    local playerGui

    if v3 and v4 then
      playerGui = v4
    end

    if not playerGui then
      local v5, v6 = pcall(function() return coreGui end)

      if v5 and v6 then
        playerGui = v6
      end
    end

    if not playerGui then
      local v7, v8 = pcall(function() return coreGui end)

      if v7 and v8 then
        playerGui = v8
      end
    end

    if not playerGui and players.LocalPlayer then
      playerGui = players.LocalPlayer:FindFirstChild("PlayerGui")
    end

    return playerGui
  end

  local v9 = f1()

  local v10, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19,
    f20, f21, f22, f23, localPlayer, v11, robotoMono, gothamBold, v12, f24, f25, v13, v14, f26,
    f27, f28, zentryxPanel, toastHolder, v15, f29, v16, v17, f30, f31, f32, mainPanel,
    colorDropdown, resizeHandle, v18, zero, zero2, v19, v20, v21, v22, vector, position,
    keyVerification, instance, instance2, textBox, textLabel, v23, v24, v25, f33, v26

  if not v9 then
    return
  else
    for index, value in ipairs(v9:GetChildren()) do
      if value.Name == "ZentryxHub_UI" or value.Name == "ZentryxHub_Reborn"
        or value.Name == "Zentryx_Panel" then
        value:Destroy()
      end
    end

    localPlayer = players.LocalPlayer
    local v27 = syn and syn.request or http and http.request or http_request or request

    if not localPlayer then
      local count = 0

      repeat
        task.wait(0.3)
        count = count + 1
        localPlayer = players.LocalPlayer
        v10 = localPlayer or count >= 15
      until v10

      if not localPlayer then
        return
      end
    end

    v11 = {
      BG = Color3.fromRGB(8, 11, 16),
      PANEL = Color3.fromRGB(12, 16, 24),
      CARD_BG = Color3.fromRGB(14, 18, 28),
      BORDER = Color3.fromRGB(25, 34, 48),
      BORDER_GLOW = Color3.fromRGB(0, 160, 255),
      BLUE_ACCENT = Color3.fromRGB(0, 160, 255),
      BLUE_HOVER = Color3.fromRGB(60, 190, 255),
      TEXT_WHITE = Color3.fromRGB(240, 245, 255),
      TEXT_MUTED = Color3.fromRGB(110, 125, 145),
      CHECK_OFF = Color3.fromRGB(22, 28, 40),
      CHECK_ON = Color3.fromRGB(0, 160, 255),
      SUCCESS = Color3.fromRGB(46, 213, 115),
      DANGER = Color3.fromRGB(255, 71, 87),
    }

    robotoMono = Enum.Font.RobotoMono
    gothamBold = Enum.Font.GothamBold
    v12 = {}

    function f2(p1)
      v11.BLUE_ACCENT = p1
      v11.BORDER_GLOW = p1
      v11.CHECK_ON = p1

      for index2, value2 in ipairs(v12) do
        pcall(value2, p1)
      end
    end

    function f24(p2)
      table.insert(v12, p2)
    end

    function f25(p3, p4, p5)
      local create = tweenService:Create(p3, TweenInfo.new(
        p5 or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out
      ), p4)

      create:Play()
      return create
    end

    v13 = {
      terminated = false,
      keyVerified = true,
      menuVisible = true,
      aimEnabled = true,
      aimRadius = 150,
      aimSpeed = 0.35,
      aimOnCursor = false,
      aimHasTarget = false,
      forceBodyAim = false,
      aimKeyType = "mouse",
      aimHoldKey = Enum.UserInputType.MouseButton2,
      aimHoldKeyStr = "MB2",
      aimKeyHeld = false,
      bhopEnabled = true,
      bhopHolding = false,
      bhopSpeed = 1.8,
      bhopJumpPower = 50,
      bhopBV = nil,
      spinbotEnabled = false,
      spinbotSpeed = 25,
      spinbotYaw = 0,
      espEnabled = true,
      espColor = Color3.fromRGB(255, 80, 80),
      espRange = 5000,
      teamFilter = true,
      viewAngles = true,
      viewAngleColor = Color3.fromRGB(255, 215, 0),
      fogEnabled = false,
      fogDensity = 0.45,
      fogDistance = 350,
      fogBrightness = 2,
      fogColor = Color3.fromRGB(180, 190, 210),
      fogAtmos = nil,
      antiFlash = true,
      antiSmoke = true,
      overlayOffset = Vector2.new(0, 0),
      myTeamName = nil,
      myTeamColor = nil,
      playerHighlights = {},
      viewAngleAdorns = {},
      deathConnections = {},
      espConnections = {},
    }

    function f3(p6)
      local v28, v29 = pcall(function() return p6.Team end)
      local v30 = v28 and v29
      local torsoColor

      if v30 then
        local v31, v32 = pcall(function() return v29.TeamColor.Color end)
        return v29.Name, v31 and v32 or Color3.fromRGB(200, 200, 200)
      else
        for index3, value3 in ipairs({ "Team", "TeamId", "TeamColor" }) do
          local findFirstChild = p6:FindFirstChild(value3)

          if findFirstChild and findFirstChild:IsA("IntValue") then
            local color = Color3.fromRGB(255, 80, 80)
            local color2 = Color3.fromRGB(80, 80, 255)
            local color3 = Color3.fromRGB(80, 255, 80)
            local color4 = Color3.fromRGB(255, 200, 50)

            return tostring(findFirstChild.Value), ({
              [0] = color,
              [1] = color2,
              [2] = color3,
              [3] = color4,
            })[findFirstChild.Value] or Color3.fromRGB(200, 200, 200)
          end
        end

        for index4, value4 in ipairs({ "Team", "TeamName" }) do
          local findFirstChild2 = p6:FindFirstChild(value4)

          if findFirstChild2 and findFirstChild2:IsA("StringValue")
            and findFirstChild2.Value ~= "" then
            return findFirstChild2.Value, Color3.fromRGB(200, 200, 200)
          end
        end

        local character = p6.Character

        if character then
          local bodyColors = character:FindFirstChild("BodyColors")

          if bodyColors then
            torsoColor = bodyColors:FindFirstChild("TorsoColor")

            if torsoColor then
              local v33, v34 = pcall(function() return BrickColor.new(torsoColor.Value).Color end)

              if v33 then
                return ("C_%.0f_%.0f_%.0f"):format(v34.R * 255, v34.G * 255, v34.B * 255), v34
              end

              return nil, nil
            end

            return nil, nil
          end

          return nil, nil
        end

        return nil, nil
      end
    end

    v14 = {}
    local myTeamName, myTeamColor = f3(localPlayer)

    v13.myTeamName = myTeamName
    v13.myTeamColor = myTeamColor

    if not v13.myTeamName then
      v13.teamFilter = false
    end

    function f26(p7)
      if not v13.teamFilter or not v13.myTeamName then
        return false
      end

      return f3(p7) == v13.myTeamName
    end

    function f27(p8)
      if not p8 or not p8.Parent then
        return false
      else
        local character2 = p8.Character

        if not character2 or not character2.Parent then
          return false
        else
          local humanoid = character2:FindFirstChildOfClass("Humanoid")

          if not humanoid then
            return false
          end

          return humanoid.Health > 0
        end
      end
    end

    function f28(p9)
      if not f27(p9) then
        return false
      else
        local character3 = p9.Character

        if character3:FindFirstChildOfClass("Humanoid"):GetState()
          == Enum.HumanoidStateType.Dead then
          return false
        end

        if not character3:FindFirstChild("HumanoidRootPart")
          and not character3:FindFirstChild("Head") then
          return false
        end

        return true
      end
    end

    zentryxPanel = Instance.new("ScreenGui")
    zentryxPanel.Name = "Zentryx_Panel"
    zentryxPanel.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    zentryxPanel.DisplayOrder = 999999
    zentryxPanel.ResetOnSpawn = false
    zentryxPanel.IgnoreGuiInset = true

    if syn and syn.protect_gui then
      syn.protect_gui(zentryxPanel)
    elseif protect_gui then
      protect_gui(zentryxPanel)
    end

    zentryxPanel.Parent = v9

    toastHolder = Instance.new("Frame")
    toastHolder.Name = "ToastHolder"
    toastHolder.Parent = zentryxPanel
    toastHolder.Size = UDim2.new(0, 240, 1, -20)
    toastHolder.Position = UDim2.new(1, -250, 0, 10)
    toastHolder.BackgroundTransparency = 1
    toastHolder.ZIndex = 600

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = toastHolder
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local udim = UDim.new(0, 6)

    function f4(text, text2, p10)
      local blueACCENT = p10 or v11.BLUE_ACCENT

      local frame = Instance.new("Frame")
      frame.Parent = toastHolder
      frame.Size = UDim2.new(1, 0, 0, 32)
      frame.BackgroundColor3 = v11.PANEL
      frame.BorderSizePixel = 0
      frame.BackgroundTransparency = 1
      frame.ZIndex = 601

      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

      local uiStroke = Instance.new("UIStroke")
      uiStroke.Parent = frame
      uiStroke.Color = blueACCENT
      uiStroke.Thickness = 1
      uiStroke.Transparency = 1

      local textLabel2 = Instance.new("TextLabel")
      textLabel2.Parent = frame
      textLabel2.Size = UDim2.new(1, -12, 1, 0)
      textLabel2.Position = UDim2.new(0, 8, 0, 0)
      textLabel2.BackgroundTransparency = 1
      textLabel2.Text = text .. ": " .. tostring(text2)
      textLabel2.Font = robotoMono
      textLabel2.TextSize = 11
      textLabel2.TextColor3 = v11.TEXT_WHITE
      textLabel2.TextXAlignment = Enum.TextXAlignment.Left
      textLabel2.TextTransparency = 1
      textLabel2.ZIndex = 602

      f25(frame, { BackgroundTransparency = 0 })
      f25(uiStroke, { Transparency = 0.2 })
      f25(textLabel2, { TextTransparency = 0 })

      task.delay(2.2, function()
        f25(frame, { BackgroundTransparency = 1 })
        f25(uiStroke, { Transparency = 1 })

        f25(textLabel2, { TextTransparency = 1 }).Completed:Connect(function()
          frame:Destroy()
        end)
      end)
    end

    uiListLayout.Padding = udim

    v15 = {}
    v15.circle = Instance.new("Frame")
    v15.circle.Parent = zentryxPanel
    v15.circle.Size = UDim2.new(0, v13.aimRadius * 2, 0, v13.aimRadius * 2)
    v15.circle.Position = UDim2.new(0.5, -v13.aimRadius, 0.5, -v13.aimRadius)
    v15.circle.BackgroundTransparency = 1
    v15.circle.BorderSizePixel = 0
    v15.circle.Visible = v13.aimEnabled
    v15.circle.ZIndex = 1
    v15.stroke = Instance.new("UIStroke")
    v15.stroke.Thickness = 1.2
    v15.stroke.Color = v11.BLUE_ACCENT
    v15.stroke.Transparency = v13.aimEnabled and 0 or 1
    v15.stroke.Parent = v15.circle

    local instance3 = Instance.new("UICorner", v15.circle)
    instance3.CornerRadius = UDim.new(1, 0)

    function f5(key)
      if not v13.viewAngles or not v13.espEnabled or not key or key == localPlayer then
        if v13.viewAngleAdorns[key] then
          v13.viewAngleAdorns[key].Visible = false
        end

        return
      else
        local character4 = key.Character

        if not character4 then
          return
        else
          local head = character4:FindFirstChild("Head")

          if not head then
            return
          else
            local viewAngle = v13.viewAngleAdorns[key]

            if not viewAngle or viewAngle.Parent ~= head then
              if viewAngle then
                viewAngle:Destroy()
              end

              viewAngle = Instance.new("CylinderHandleAdornment")
              viewAngle.Name = "ViewAngle"
              viewAngle.Adornee = head
              viewAngle.Height = 8.5
              viewAngle.Radius = 0.06
              viewAngle.CFrame = CFrame.new(0, 0, -4.25)
              viewAngle.Color3 = v13.viewAngleColor
              viewAngle.Transparency = 0.2
              viewAngle.AlwaysOnTop = true
              viewAngle.ZIndex = 5
              viewAngle.Parent = head

              v13.viewAngleAdorns[key] = viewAngle
            end

            local v35, v36 = f3(key)

            viewAngle.Color3 = v13.teamFilter and (v36 or v13.viewAngleColor)
              or v13.viewAngleColor

            viewAngle.Visible = f27(key)

            return
          end
        end
      end
    end

    function f6(key2)
      if v13.deathConnections[key2] then
        for index5, value5 in ipairs(v13.deathConnections[key2]) do
          local v37 = value5
          pcall(function() v37:Disconnect() end)
        end

        v13.deathConnections[key2] = nil
      end
    end

    function f29()
      if v13.aimOnCursor then
        local getMouseLocation = userInputService:GetMouseLocation()

        v15.circle.Position = UDim2.new(
          0, getMouseLocation.X - v13.aimRadius, 0, getMouseLocation.Y - v13.aimRadius
        )

        v15.circle.Size = UDim2.new(0, v13.aimRadius * 2, 0, v13.aimRadius * 2)

        return
      end

      v15.circle.Position = UDim2.new(
        0.5, -v13.aimRadius + v13.overlayOffset.X, 0.5, -v13.aimRadius + v13.overlayOffset.Y
      )

      v15.circle.Size = UDim2.new(0, v13.aimRadius * 2, 0, v13.aimRadius * 2)
    end

    function f7(key3)
      local v38

      if v13.playerHighlights[key3] then
        v38 = v13.playerHighlights[key3]

        pcall(function()
          if v38.highlight then
            v38.highlight:Destroy()
          end

          if v38.nametag then
            v38.nametag:Destroy()
          end
        end)

        v13.playerHighlights[key3] = nil
      end

      if v13.viewAngleAdorns[key3] then
        pcall(function() v13.viewAngleAdorns[key3]:Destroy() end)
        v13.viewAngleAdorns[key3] = nil
      end

      v16(key3)
    end

    v16 = f6

    function f8(key4)
      if not v13.espEnabled or not key4 or key4 == localPlayer then
        return
      end

      if not f27(key4) then
        return
      end

      local character5 = key4.Character

      if not character5 then
        return
      end

      f7(key4)

      pcall(function()
        local v39, v40 = f3(key4)

        local highlight = Instance.new("Highlight")
        highlight.Adornee = character5

        if v13.teamFilter and v40 then
          highlight.FillColor = v40
          highlight.OutlineColor = v40
        else
          highlight.FillColor = v13.espColor
          highlight.OutlineColor = v13.espColor
        end

        highlight.FillTransparency = 0.65
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = character5

        local head2 = character5:FindFirstChild("Head")
        local espName, textLabel3

        if head2 then
          espName = Instance.new("BillboardGui")
          espName.Name = "ESPName"
          espName.Adornee = head2
          espName.Size = UDim2.new(0, 140, 0, 30)
          espName.StudsOffset = Vector3.new(0, 2.5, 0)
          espName.AlwaysOnTop = true
          espName.Enabled = true

          local textLabel4 = Instance.new("TextLabel")
          textLabel4.Parent = espName
          textLabel4.Size = UDim2.new(1, 0, 0.6, 0)
          textLabel4.BackgroundTransparency = 1
          textLabel4.Text = key4.Name
          textLabel4.TextColor3 = v13.teamFilter and v40 or v13.espColor
          textLabel4.TextStrokeTransparency = 0.3
          textLabel4.Font = gothamBold
          textLabel4.TextSize = 12

          textLabel3 = Instance.new("TextLabel")
          textLabel3.Parent = espName
          textLabel3.Size = UDim2.new(1, 0, 0.4, 0)
          textLabel3.Position = UDim2.new(0, 0, 0.6, 0)
          textLabel3.BackgroundTransparency = 1
          textLabel3.Text = ""
          textLabel3.TextColor3 = Color3.fromRGB(220, 220, 220)
          textLabel3.TextStrokeTransparency = 0.5
          textLabel3.Font = robotoMono
          textLabel3.TextSize = 10

          espName.Parent = head2
        end

        v13.playerHighlights[key4] = {
          highlight = highlight,
          nametag = espName,
          distLabel = textLabel3,
          char = character5,
        }

        v17(key4)
        v16(key4)
        local v41 = {}
        local humanoid2 = character5:FindFirstChildOfClass("Humanoid")

        if humanoid2 then
          local died = humanoid2.Died
          table.insert(v41, died:Connect(function() f7(key4) end))
          local healthChanged = humanoid2.HealthChanged

          table.insert(v41, healthChanged:Connect(function(p11)
            if p11 <= 0 then
              f7(key4)
            end
          end))
        end

        local characterRemoving = key4.CharacterRemoving
        table.insert(v41, characterRemoving:Connect(function() f7(key4) end))
        local ancestryChanged = character5.AncestryChanged

        table.insert(v41, ancestryChanged:Connect(function(p12, p13)
          if not p13 then
            f7(key4)
          end
        end))

        v13.deathConnections[key4] = v41
      end)
    end

    v17 = f5

    function f9()
      local currentCamera = workspace.CurrentCamera

      if not currentCamera then
        return
      else
        local position2 = currentCamera.CFrame.Position

        for key5, value6 in pairs(v13.playerHighlights) do
          if not f27(key5) then
            f7(key5)
          else
            local character6 = key5.Character

            if character6 then
              local humanoidRootPart = character6:FindFirstChild("HumanoidRootPart")

              local head3 = humanoidRootPart
              head3 = humanoidRootPart or character6:FindFirstChild("Head")

              if head3 then
                local magnitude = (head3.Position - position2).Magnitude
                local v42 = magnitude <= v13.espRange

                if value6.highlight then
                  value6.highlight.FillTransparency = v42 and 0.65 or 1
                  value6.outlineTransparency = v42 and 0 or 1
                end

                if value6.nametag then
                  value6.nametag.Enabled = v42

                  if value6.distLabel and v42 then
                    value6.distLabel.Text = ("%d studs"):format(math.floor(magnitude))
                  end
                end

                v17(key5)
              end
            end
          end
        end

        return
      end
    end

    function f30()
      for key6, value7 in pairs(v13.playerHighlights) do
        f7(key6)
      end

      v13.playerHighlights = {}
      v13.viewAngleAdorns = {}

      for key7, value8 in pairs(v13.deathConnections) do
        v16(key7)
      end
    end

    function f11()
      f30()

      if not v13.espEnabled then
        return
      end

      for index6, value9 in ipairs(players:GetPlayers()) do
        if value9 ~= localPlayer and f27(value9) then
          f8(value9)
        end
      end

      f9()
    end

    function f10(key8)
      if key8 == localPlayer then
        return
      else
        if v13.espConnections[key8] then
          v13.espConnections[key8]:Disconnect()
        end

        local characterAdded = key8.CharacterAdded

        v13.espConnections[key8] = characterAdded:Connect(function()
          f7(key8)
          task.wait(0.3)

          if v13.espEnabled and f27(key8) then
            f8(key8)
          end
        end)

        return
      end
    end

    for index7, value10 in ipairs(players:GetPlayers()) do
      f10(value10)
    end

    players.PlayerAdded:Connect(function(player)
      f10(player)
      task.wait(0.3)

      if v13.espEnabled and f27(player) then
        f8(player)
      end
    end)

    players.PlayerRemoving:Connect(function(player2)
      if v13.espConnections[player2] then
        v13.espConnections[player2]:Disconnect()
        v13.espConnections[player2] = nil
      end

      f7(player2)
      v16(player2)
    end)

    task.spawn(function()
      while not v13.terminated and task.wait(1) do
        if v13.espEnabled then
          for key9, value11 in pairs(v13.playerHighlights) do
            if not f27(key9) then
              f7(key9)
            end
          end

          for index8, value12 in ipairs(players:GetPlayers()) do
            if value12 ~= localPlayer and f27(value12) and not v13.playerHighlights[value12] then
              f8(value12)
            end
          end
        end
      end
    end)

    function f31()
      if not v13.antiFlash then
        return
      else
        local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui2 then
          local blinded = playerGui2:FindFirstChild("Blinded")

          if blinded then
            if blinded:IsA("ScreenGui") and blinded.Enabled then
              blinded.Enabled = false
            end

            for index9, value13 in ipairs(blinded:GetDescendants()) do
              if value13:IsA("Frame") or value13:IsA("ImageLabel") then
                value13.Visible = false
                value13.BackgroundTransparency = 1
              end
            end
          end

          local gui = playerGui2:FindFirstChild("GUI")

          if gui then
            local flash = gui:FindFirstChild("Flash")

            if flash then
              flash.Visible = false
              flash.BackgroundTransparency = 1
            end

            local white = gui:FindFirstChild("White")

            if white then
              white.Visible = false
              white.BackgroundTransparency = 1
            end
          end
        end

        return
      end
    end

    function f32(p14)
      if not v13.antiSmoke then
        return
      end

      if p14:IsA("ParticleEmitter") or p14:IsA("Smoke") then
        p14.Enabled = false
        p14.Rate = 0
      elseif p14:IsA("BasePart") and not p14:FindFirstAncestorOfClass("Humanoid") then
        if p14.Name:lower():find("smoke")
          or p14.Parent and p14.Parent.Name:lower():find("smoke") then
          p14.Transparency = 1
        end
      end
    end

    workspace.DescendantAdded:Connect(function(descendant)
      if v13.antiSmoke then
        pcall(function()
          if descendant.Name:lower():find("smoke")
            or descendant.Parent and descendant.Parent.Name:lower():find("smoke") then
            f32(descendant)
          end
        end)
      end
    end)

    task.spawn(function()
      while not v13.terminated and task.wait(0.4) do
        if v13.antiSmoke then
          pcall(function()
            local rayIgnore = workspace:FindFirstChild("Ray_Ignore")

            if rayIgnore then
              local smokes = rayIgnore:FindFirstChild("Smokes")

              if smokes then
                for index10, value14 in ipairs(smokes:GetDescendants()) do
                  f32(value14)
                end
              end
            end
          end)
        end
      end
    end)

    mainPanel = Instance.new("Frame")
    mainPanel.Name = "MainPanel"
    mainPanel.Parent = zentryxPanel
    mainPanel.Size = UDim2.new(0, 680, 0, 490)
    mainPanel.Position = UDim2.new(0.5, -340, 0.5, -245)
    mainPanel.BackgroundColor3 = v11.BG
    mainPanel.BorderSizePixel = 0
    mainPanel.ClipsDescendants = false
    mainPanel.Active = true
    mainPanel.Visible = false
    mainPanel.ZIndex = 10

    Instance.new("UICorner", mainPanel).CornerRadius = UDim.new(0, 10)

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Parent = mainPanel
    topBar.Size = UDim2.new(1, 0, 0, 34)
    topBar.BackgroundTransparency = 1
    topBar.ZIndex = 11

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Parent = topBar
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0, 14, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "ZentryxHub"
    titleLabel.Font = gothamBold
    titleLabel.TextSize = 13
    titleLabel.TextColor3 = v11.TEXT_WHITE
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 12

    local windowControls = Instance.new("Frame")
    windowControls.Name = "WindowControls"
    windowControls.Parent = topBar
    windowControls.Size = UDim2.new(0, 64, 0, 14)
    windowControls.Position = UDim2.new(1, -76, 0.5, -7)
    windowControls.BackgroundTransparency = 1
    windowControls.ZIndex = 12

    local instance4 = Instance.new("UIListLayout", windowControls)
    instance4.FillDirection = Enum.FillDirection.Horizontal
    instance4.HorizontalAlignment = Enum.HorizontalAlignment.Right
    instance4.VerticalAlignment = Enum.VerticalAlignment.Center
    instance4.SortOrder = Enum.SortOrder.LayoutOrder
    instance4.Padding = UDim.new(0, 8)

    local textButton = Instance.new("TextButton")
    textButton.Parent = windowControls
    textButton.Size = UDim2.new(0, 12, 0, 12)
    textButton.BackgroundColor3 = Color3.fromRGB(39, 201, 63)
    textButton.BorderSizePixel = 0
    textButton.Text = ""
    textButton.LayoutOrder = 1
    textButton.ZIndex = 13

    Instance.new("UICorner", textButton).CornerRadius = UDim.new(1, 0)

    local textButton2 = Instance.new("TextButton")
    textButton2.Parent = windowControls
    textButton2.Size = UDim2.new(0, 12, 0, 12)
    textButton2.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
    textButton2.BorderSizePixel = 0
    textButton2.Text = ""
    textButton2.LayoutOrder = 2
    textButton2.ZIndex = 13

    Instance.new("UICorner", textButton2).CornerRadius = UDim.new(1, 0)

    local textButton3 = Instance.new("TextButton")
    textButton3.Parent = windowControls
    textButton3.Size = UDim2.new(0, 12, 0, 12)
    textButton3.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
    textButton3.BorderSizePixel = 0
    textButton3.Text = ""
    textButton3.LayoutOrder = 3
    textButton3.ZIndex = 13

    Instance.new("UICorner", textButton3).CornerRadius = UDim.new(1, 0)

    colorDropdown = Instance.new("Frame")
    colorDropdown.Name = "ColorDropdown"
    colorDropdown.Parent = mainPanel
    colorDropdown.Size = UDim2.new(0, 140, 0, 185)
    colorDropdown.Position = UDim2.new(1, -154, 0, 32)
    colorDropdown.BackgroundColor3 = v11.PANEL
    colorDropdown.BorderSizePixel = 0
    colorDropdown.Visible = false
    colorDropdown.ZIndex = 50

    Instance.new("UICorner", colorDropdown).CornerRadius = UDim.new(0, 8)

    local instance5 = Instance.new("UIStroke", colorDropdown)
    instance5.Color = v11.BORDER
    instance5.Thickness = 1

    local instance6 = Instance.new("UIListLayout", colorDropdown)
    instance6.SortOrder = Enum.SortOrder.LayoutOrder
    instance6.Padding = UDim.new(0, 4)

    local instance7 = Instance.new("UIPadding", colorDropdown)
    instance7.PaddingTop = UDim.new(0, 8)
    instance7.PaddingBottom = UDim.new(0, 8)
    instance7.PaddingLeft = UDim.new(0, 8)
    instance7.PaddingRight = UDim.new(0, 8)

    for index11, value15 in ipairs({
      { name = "Sky Blue", color = Color3.fromRGB(0, 160, 255) },
      { name = "Emerald", color = Color3.fromRGB(46, 213, 115) },
      { name = "Crimson", color = Color3.fromRGB(255, 71, 87) },
      { name = "Purple", color = Color3.fromRGB(168, 85, 247) },
      { name = "Amber", color = Color3.fromRGB(255, 175, 30) },
      { name = "Neon Pink", color = Color3.fromRGB(255, 95, 185) },
    }) do
      local v43 = value15

      local textButton4 = Instance.new("TextButton")
      textButton4.Parent = colorDropdown
      textButton4.Size = UDim2.new(1, 0, 0, 24)
      textButton4.BackgroundColor3 = v11.CARD_BG
      textButton4.BackgroundTransparency = 0.5
      textButton4.BorderSizePixel = 0
      textButton4.Text = ""
      textButton4.LayoutOrder = index11
      textButton4.ZIndex = 51

      Instance.new("UICorner", textButton4).CornerRadius = UDim.new(0, 5)

      local frame2 = Instance.new("Frame")
      frame2.Parent = textButton4
      frame2.Size = UDim2.new(0, 10, 0, 10)
      frame2.Position = UDim2.new(0, 6, 0.5, -5)
      frame2.BackgroundColor3 = v43.color
      frame2.BorderSizePixel = 0
      frame2.ZIndex = 52

      Instance.new("UICorner", frame2).CornerRadius = UDim.new(1, 0)

      local textLabel5 = Instance.new("TextLabel")
      textLabel5.Parent = textButton4
      textLabel5.Size = UDim2.new(1, -26, 1, 0)
      textLabel5.Position = UDim2.new(0, 22, 0, 0)
      textLabel5.BackgroundTransparency = 1
      textLabel5.Text = v43.name
      textLabel5.Font = robotoMono
      textLabel5.TextSize = 10
      textLabel5.TextColor3 = v11.TEXT_WHITE
      textLabel5.TextXAlignment = Enum.TextXAlignment.Left
      textLabel5.ZIndex = 52

      textButton4.MouseEnter:Connect(function()
        f25(textButton4, { BackgroundTransparency = 0.1 })
      end)

      textButton4.MouseLeave:Connect(function()
        f25(textButton4, { BackgroundTransparency = 0.5 })
      end)

      textButton4.MouseButton1Click:Connect(function()
        f2(v43.color)
        f4("Theme Accent", v43.name, v43.color)
        colorDropdown.Visible = false
      end)
    end

    textButton.MouseButton1Click:Connect(function()
      colorDropdown.Visible = not colorDropdown.Visible
    end)

    textButton2.MouseButton1Click:Connect(function()
      v13.menuVisible = false
      mainPanel.Visible = false
      colorDropdown.Visible = false
      f4("Zentryx Hub", "Hidden. Press Right Control to toggle", v11.BLUE_ACCENT)
    end)

    textButton3.MouseButton1Click:Connect(function()
      v13.terminated = true
      f30()

      if v13.bhopBV then
        v13.bhopBV:Destroy()
        v13.bhopBV = nil
      end

      if localPlayer.Character then
        local humanoid3 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid3 then
          humanoid3.AutoRotate = true
        end
      end

      zentryxPanel:Destroy()
    end)

    resizeHandle = Instance.new("TextButton")
    resizeHandle.Name = "ResizeHandle"
    resizeHandle.Parent = mainPanel
    resizeHandle.Size = UDim2.new(0, 18, 0, 18)
    resizeHandle.Position = UDim2.new(1, -18, 1, -18)
    resizeHandle.BackgroundTransparency = 1
    resizeHandle.Text = "◢"
    resizeHandle.Font = gothamBold
    resizeHandle.TextSize = 12
    resizeHandle.TextColor3 = v11.BLUE_ACCENT
    resizeHandle.ZIndex = 25

    f24(function(textColor3) resizeHandle.TextColor3 = textColor3 end)
    v18 = false
    zero = Vector2.zero
    zero2 = Vector2.zero

    resizeHandle.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        v18 = true
        zero = Vector2.new(input.Position.X, input.Position.Y)
        zero2 = mainPanel.AbsoluteSize
      end
    end)

    userInputService.InputChanged:Connect(function(input2)
      if v18
        and (input2.UserInputType == Enum.UserInputType.MouseMovement
          or input2.UserInputType == Enum.UserInputType.Touch) then
        local v44 = Vector2.new(input2.Position.X, input2.Position.Y) - zero
        local v45 = math.clamp(zero2.X + v44.X, 520, 1200)
        local v46 = math.clamp(zero2.Y + v44.Y, 360, 900)
        mainPanel.Size = UDim2.new(0, v45, 0, v46)
      end
    end)

    userInputService.InputEnded:Connect(function(input3)
      if input3.UserInputType == Enum.UserInputType.MouseButton1
        or input3.UserInputType == Enum.UserInputType.Touch then
        v18 = false
      end
    end)

    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Parent = mainPanel
    sidebar.Size = UDim2.new(0, 130, 1, -44)
    sidebar.Position = UDim2.new(0, 10, 0, 36)
    sidebar.BackgroundColor3 = v11.PANEL
    sidebar.BorderSizePixel = 0
    sidebar.ZIndex = 11

    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

    local instance8 = Instance.new("UIStroke", sidebar)
    instance8.Color = v11.BORDER
    instance8.Thickness = 1

    local instance9 = Instance.new("UIListLayout", sidebar)
    instance9.SortOrder = Enum.SortOrder.LayoutOrder
    instance9.Padding = UDim.new(0, 6)

    local instance10 = Instance.new("UIPadding", sidebar)
    instance10.PaddingTop = UDim.new(0, 10)
    instance10.PaddingBottom = UDim.new(0, 10)
    instance10.PaddingLeft = UDim.new(0, 8)
    instance10.PaddingRight = UDim.new(0, 8)

    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Parent = mainPanel
    contentArea.Size = UDim2.new(1, -158, 1, -44)
    contentArea.Position = UDim2.new(0, 148, 0, 36)
    contentArea.BackgroundTransparency = 1
    contentArea.ZIndex = 11

    v19 = "COMBAT"
    v20 = {}

    function f12(p15)
      v19 = p15

      for key10, value16 in pairs(v20) do
        local v47 = key10 == v19

        f25(value16.label, { TextColor3 = v47 and v11.TEXT_WHITE or v11.TEXT_MUTED })
        f25(value16.bg, { BackgroundTransparency = v47 and 0 or 1 })
        f25(value16.bar, { BackgroundTransparency = v47 and 0 or 1 })
      end

      for key11, value17 in pairs(v21) do
        value17.Visible = key11 == v19
      end
    end

    v21 = {}

    for index12, value18 in ipairs({ "COMBAT", "VISUALS", "MOVEMENT", "MISC" }) do
      local v48 = value18

      local textButton5 = Instance.new("TextButton")
      textButton5.Parent = sidebar
      textButton5.Size = UDim2.new(1, 0, 0, 34)
      textButton5.BackgroundColor3 = v11.CARD_BG
      textButton5.BackgroundTransparency = v48 == v19 and 0 or 1
      textButton5.BorderSizePixel = 0
      textButton5.Text = ""
      textButton5.LayoutOrder = index12
      textButton5.ZIndex = 12

      Instance.new("UICorner", textButton5).CornerRadius = UDim.new(0, 6)

      local frame3 = Instance.new("Frame")
      frame3.Parent = textButton5
      frame3.Size = UDim2.new(0, 3, 0, 16)
      frame3.Position = UDim2.new(0, 6, 0.5, -8)
      frame3.BackgroundColor3 = v11.BLUE_ACCENT
      frame3.BorderSizePixel = 0
      frame3.BackgroundTransparency = v48 == v19 and 0 or 1
      frame3.ZIndex = 13

      Instance.new("UICorner", frame3).CornerRadius = UDim.new(1, 0)

      local textLabel6 = Instance.new("TextLabel")
      textLabel6.Parent = textButton5
      textLabel6.Size = UDim2.new(1, -20, 1, 0)
      textLabel6.Position = UDim2.new(0, 16, 0, 0)
      textLabel6.BackgroundTransparency = 1
      textLabel6.Text = v48
      textLabel6.Font = robotoMono
      textLabel6.TextSize = 11
      textLabel6.TextColor3 = v48 == v19 and v11.TEXT_WHITE or v11.TEXT_MUTED
      textLabel6.TextXAlignment = Enum.TextXAlignment.Left
      textLabel6.ZIndex = 13

      f24(function(backgroundColor3) frame3.BackgroundColor3 = backgroundColor3 end)
      v20[v48] = { bg = textButton5, label = textLabel6, bar = frame3 }
      textButton5.MouseButton1Click:Connect(function() f12(v48) end)

      local scrollingFrame = Instance.new("ScrollingFrame")
      scrollingFrame.Name = "Page_" .. v48
      scrollingFrame.Parent = contentArea
      scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
      scrollingFrame.BackgroundTransparency = 1
      scrollingFrame.BorderSizePixel = 0
      scrollingFrame.ScrollBarThickness = 2
      scrollingFrame.ScrollBarImageColor3 = v11.BLUE_ACCENT
      scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
      scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
      scrollingFrame.Visible = v48 == v19
      scrollingFrame.ZIndex = 12

      f24(function(scrollBarImageColor3)
        scrollingFrame.ScrollBarImageColor3 = scrollBarImageColor3
      end)

      local instance11 = Instance.new("UIListLayout", scrollingFrame)
      instance11.SortOrder = Enum.SortOrder.LayoutOrder
      instance11.Padding = UDim.new(0, 10)

      Instance.new("UIPadding", scrollingFrame).PaddingRight = UDim.new(0, 6)
      v21[v48] = scrollingFrame
    end

    function f13(parent, text3, index13, index14, text4, text5, index15, p16)
      local frame4 = Instance.new("Frame")
      frame4.Parent = parent
      frame4.Size = UDim2.new(1, 0, 0, 26)
      frame4.BackgroundTransparency = 1
      frame4.ZIndex = 15

      local textLabel7 = Instance.new("TextLabel")
      textLabel7.Parent = frame4
      textLabel7.Size = UDim2.new(1, 0, 0, 14)
      textLabel7.BackgroundTransparency = 1
      textLabel7.Text = text3:upper() .. ": " .. tostring(text4) .. (text5 or "")
      textLabel7.Font = robotoMono
      textLabel7.TextSize = 9
      textLabel7.TextColor3 = v11.TEXT_MUTED
      textLabel7.TextXAlignment = Enum.TextXAlignment.Left
      textLabel7.ZIndex = 16

      local frame5 = Instance.new("Frame")
      frame5.Parent = frame4
      frame5.Size = UDim2.new(1, 0, 0, 4)
      frame5.Position = UDim2.new(0, 0, 0, 18)
      frame5.BackgroundColor3 = v11.CHECK_OFF
      frame5.BorderSizePixel = 0
      frame5.ZIndex = 16

      Instance.new("UICorner", frame5).CornerRadius = UDim.new(1, 0)
      local v49 = math.clamp((text4 - index13) / (index14 - index13), 0, 1)

      local frame6 = Instance.new("Frame")
      frame6.Parent = frame5
      frame6.Size = UDim2.new(v49, 0, 1, 0)
      frame6.BackgroundColor3 = v11.BLUE_ACCENT
      frame6.BorderSizePixel = 0
      frame6.ZIndex = 17

      Instance.new("UICorner", frame6).CornerRadius = UDim.new(1, 0)
      f24(function(backgroundColor32) frame6.BackgroundColor3 = backgroundColor32 end)
      local v50 = false
      local v51 = text4

      local function f34(x)
        local x2 = frame5.AbsolutePosition.X
        local x3 = frame5.AbsoluteSize.X

        if x3 <= 0 then
          return
        else
          local v52 = index13 + math.clamp((x - x2) / x3, 0, 1) * (index14 - index13)

          if index15 then
            v52 = math.floor(v52 / index15 + 0.5) * index15
          end

          v51 = index15 and index15 < 1 and tonumber(string.format("%.2f", v52))
            or math.floor(v52)

          local v53 = math.clamp((v51 - index13) / (index14 - index13), 0, 1)
          frame6.Size = UDim2.new(v53, 0, 1, 0)
          textLabel7.Text = text3:upper() .. ": " .. tostring(v51) .. (text5 or "")

          if p16 then
            p16(v51)
          end

          return
        end
      end

      local textButton6 = Instance.new("TextButton")
      textButton6.Parent = frame4
      textButton6.Size = UDim2.new(1, 0, 1, 0)
      textButton6.BackgroundTransparency = 1
      textButton6.Text = ""
      textButton6.ZIndex = 18

      textButton6.MouseButton1Down:Connect(function()
        v50 = true
        f34(userInputService:GetMouseLocation().X)
      end)

      userInputService.InputEnded:Connect(function(input4)
        if input4.UserInputType == Enum.UserInputType.MouseButton1
          or input4.UserInputType == Enum.UserInputType.Touch then
          v50 = false
        end
      end)

      userInputService.InputChanged:Connect(function(input5)
        if v50
          and (input5.UserInputType == Enum.UserInputType.MouseMovement
            or input5.UserInputType == Enum.UserInputType.Touch) then
          f34(input5.Position.X)
        end
      end)
    end

    function f16(parent2, text6, text7, p17)
      local frame7 = Instance.new("Frame")
      frame7.Parent = parent2
      frame7.Size = UDim2.new(1, 0, 0, 20)
      frame7.BackgroundTransparency = 1
      frame7.ZIndex = 15

      local textLabel8 = Instance.new("TextLabel")
      textLabel8.Parent = frame7
      textLabel8.Size = UDim2.new(1, -75, 1, 0)
      textLabel8.BackgroundTransparency = 1
      textLabel8.Text = text6:upper()
      textLabel8.Font = robotoMono
      textLabel8.TextSize = 10
      textLabel8.TextColor3 = v11.TEXT_MUTED
      textLabel8.TextXAlignment = Enum.TextXAlignment.Left
      textLabel8.ZIndex = 16

      local textButton7 = Instance.new("TextButton")
      textButton7.Parent = frame7
      textButton7.Size = UDim2.new(0, 68, 0, 20)
      textButton7.Position = UDim2.new(1, -68, 0.5, -10)
      textButton7.BackgroundColor3 = v11.CARD_BG
      textButton7.BorderSizePixel = 0
      textButton7.Text = "[" .. text7 .. "]"
      textButton7.Font = robotoMono
      textButton7.TextSize = 10
      textButton7.TextColor3 = v11.BLUE_ACCENT
      textButton7.ZIndex = 16

      Instance.new("UICorner", textButton7).CornerRadius = UDim.new(0, 5)
      f24(function(textColor32) textButton7.TextColor3 = textColor32 end)
      local v54 = false

      textButton7.MouseButton1Click:Connect(function()
        if v54 then
          return
        end

        v54 = true

        textButton7.Text = "[...]"
        textButton7.TextColor3 = v11.TEXT_WHITE

        task.wait(0.05)

        local connect = nil

        connect = userInputService.InputBegan:Connect(function(input6)
          if input6.UserInputType == Enum.UserInputType.Keyboard then
            local gsub = tostring(input6.KeyCode):gsub("Enum.KeyCode.", "")

            textButton7.Text = "[" .. gsub .. "]"
            textButton7.TextColor3 = v11.BLUE_ACCENT

            v54 = false
            connect:Disconnect()

            if p17 then
              p17("keyboard", input6.KeyCode, gsub)
            end
          elseif input6.UserInputType == Enum.UserInputType.MouseButton2 then
            textButton7.Text = "[MB2]"
            textButton7.TextColor3 = v11.BLUE_ACCENT

            v54 = false
            connect:Disconnect()

            if p17 then
              p17("mouse", Enum.UserInputType.MouseButton2, "MB2")
            end
          elseif input6.UserInputType == Enum.UserInputType.MouseButton1 then
            textButton7.Text = "[MB1]"
            textButton7.TextColor3 = v11.BLUE_ACCENT

            v54 = false
            connect:Disconnect()

            if p17 then
              p17("mouse", Enum.UserInputType.MouseButton1, "MB1")
            end
          end
        end)
      end)
    end

    function f14(parent3, text8, p18, p19, p20, p21)
      local frame8 = Instance.new("Frame")
      frame8.Parent = parent3
      frame8.Size = UDim2.new(1, 0, 0, 0)
      frame8.AutomaticSize = Enum.AutomaticSize.Y
      frame8.BackgroundColor3 = v11.PANEL
      frame8.BorderSizePixel = 0
      frame8.ZIndex = 13

      Instance.new("UICorner", frame8).CornerRadius = UDim.new(0, 8)

      local instance12 = Instance.new("UIStroke", frame8)
      instance12.Color = v11.BORDER
      instance12.Thickness = 1

      local instance13 = Instance.new("UIPadding", frame8)
      instance13.PaddingTop = UDim.new(0, 10)
      instance13.PaddingBottom = UDim.new(0, 10)
      instance13.PaddingLeft = UDim.new(0, 12)
      instance13.PaddingRight = UDim.new(0, 12)

      local instance14 = Instance.new("UIListLayout", frame8)
      instance14.SortOrder = Enum.SortOrder.LayoutOrder
      instance14.Padding = UDim.new(0, 8)

      local frame9 = Instance.new("Frame")
      frame9.Parent = frame8
      frame9.Size = UDim2.new(1, 0, 0, 22)
      frame9.BackgroundTransparency = 1
      frame9.LayoutOrder = 1
      frame9.ZIndex = 14

      local textLabel9 = Instance.new("TextLabel")
      textLabel9.Parent = frame9
      textLabel9.Size = p21 and UDim2.new(1, -48, 1, 0) or UDim2.new(1, -130, 1, 0)
      textLabel9.BackgroundTransparency = 1
      textLabel9.Text = text8:upper()
      textLabel9.Font = gothamBold
      textLabel9.TextSize = 11
      textLabel9.TextColor3 = p18 and v11.TEXT_WHITE or v11.TEXT_MUTED
      textLabel9.TextXAlignment = Enum.TextXAlignment.Left
      textLabel9.ZIndex = 14

      local textButton8 = Instance.new("TextButton")
      textButton8.Parent = frame9
      textButton8.Size = UDim2.new(0, 36, 0, 18)
      textButton8.Position = UDim2.new(1, -36, 0.5, -9)
      textButton8.BackgroundColor3 = p18 and v11.CHECK_ON or v11.CHECK_OFF
      textButton8.BorderSizePixel = 0
      textButton8.Text = ""
      textButton8.ZIndex = 15

      Instance.new("UICorner", textButton8).CornerRadius = UDim.new(1, 0)

      local frame10 = Instance.new("Frame")
      frame10.Parent = textButton8
      frame10.Size = UDim2.new(0, 12, 0, 12)
      frame10.Position = p18 and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
      frame10.BackgroundColor3 = v11.TEXT_WHITE
      frame10.BorderSizePixel = 0
      frame10.ZIndex = 16

      Instance.new("UICorner", frame10).CornerRadius = UDim.new(1, 0)
      local v55 = p18

      local function f35(p22, p23)
        v55 = p22

        f25(textLabel9, { TextColor3 = v55 and v11.TEXT_WHITE or v11.TEXT_MUTED })
        f25(textButton8, { BackgroundColor3 = v55 and v11.CHECK_ON or v11.CHECK_OFF })

        f25(frame10, {
          Position = v55 and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        })

        if not p23 and p20 then
          p20(v55)
        end
      end

      f24(function(backgroundColor33)
        if v55 then
          textButton8.BackgroundColor3 = backgroundColor33
        end
      end)

      textButton8.MouseButton1Click:Connect(function() f35(not v55) end)
      local keyCode, gsub2, v56, textButton9, v57

      if not p21 then
        keyCode = p19
        gsub2 = p19 and tostring(p19):gsub("Enum.KeyCode.", "") or "NONE"
        v56 = false

        textButton9 = Instance.new("TextButton")
        textButton9.Parent = frame9
        textButton9.Size = UDim2.new(0, 68, 0, 20)
        textButton9.Position = UDim2.new(1, -114, 0.5, -10)
        textButton9.BackgroundColor3 = v11.CARD_BG
        textButton9.BorderSizePixel = 0
        textButton9.Text = "[" .. gsub2 .. "]"
        textButton9.Font = robotoMono
        textButton9.TextSize = 10
        textButton9.TextColor3 = v11.BLUE_ACCENT
        textButton9.ZIndex = 15

        local instance15 = Instance.new("UICorner", textButton9)
        instance15.CornerRadius = UDim.new(0, 5)

        v57 = false

        textButton9.MouseButton1Click:Connect(function()
          if v57 then
            return
          end

          v57 = true

          textButton9.Text = "[...]"
          textButton9.TextColor3 = v11.TEXT_WHITE

          task.wait(0.05)

          local connect2 = nil

          connect2 = userInputService.InputBegan:Connect(function(input7)
            if input7.UserInputType == Enum.UserInputType.Keyboard then
              if input7.KeyCode == Enum.KeyCode.Backspace
                or input7.KeyCode == Enum.KeyCode.Escape then
                keyCode = nil
                gsub2 = "NONE"
                v56 = false
              else
                keyCode = input7.KeyCode
                gsub2 = tostring(input7.KeyCode):gsub("Enum.KeyCode.", "")
                v56 = false
              end

              textButton9.Text = "[" .. gsub2 .. "]"
              textButton9.TextColor3 = v11.BLUE_ACCENT

              v57 = false
              connect2:Disconnect()
            elseif input7.UserInputType == Enum.UserInputType.MouseButton2 then
              keyCode = Enum.UserInputType.MouseButton2
              gsub2 = "MB2"
              v56 = true

              textButton9.Text = "[MB2]"
              textButton9.TextColor3 = v11.BLUE_ACCENT

              v57 = false
              connect2:Disconnect()
            end
          end)
        end)

        table.insert(v14, {
          name = text8,
          getKey = function() return keyCode end,
          getIsMouse = function() return v56 end,
          toggle = function()
            local v58 = not v55
            f35(v58)
            f4(text8, v58 and "ENABLED" or "DISABLED", v58 and v11.SUCCESS or v11.DANGER)
          end,
        })
      end

      local frame11 = Instance.new("Frame")
      frame11.Parent = frame8
      frame11.Size = UDim2.new(1, 0, 0, 0)
      frame11.AutomaticSize = Enum.AutomaticSize.Y
      frame11.BackgroundTransparency = 1
      frame11.LayoutOrder = 2
      frame11.ZIndex = 14

      local instance16 = Instance.new("UIListLayout", frame11)
      instance16.SortOrder = Enum.SortOrder.LayoutOrder
      instance16.Padding = UDim.new(0, 6)

      return {
        card = frame8,
        container = frame11,
        Set = f35,
        Get = function() return v55 end,
      }
    end

    function f17(parent4, text9, text10, p24)
      local frame12 = Instance.new("Frame")
      frame12.Parent = parent4
      frame12.Size = UDim2.new(1, 0, 0, 42)
      frame12.BackgroundColor3 = v11.PANEL
      frame12.BorderSizePixel = 0
      frame12.ZIndex = 13

      Instance.new("UICorner", frame12).CornerRadius = UDim.new(0, 8)

      local instance17 = Instance.new("UIStroke", frame12)
      instance17.Color = v11.BORDER
      instance17.Thickness = 1

      local textLabel10 = Instance.new("TextLabel")
      textLabel10.Parent = frame12
      textLabel10.Size = UDim2.new(1, -90, 1, 0)
      textLabel10.Position = UDim2.new(0, 12, 0, 0)
      textLabel10.BackgroundTransparency = 1
      textLabel10.Text = text9:upper()
      textLabel10.Font = gothamBold
      textLabel10.TextSize = 11
      textLabel10.TextColor3 = v11.TEXT_MUTED
      textLabel10.TextXAlignment = Enum.TextXAlignment.Left
      textLabel10.ZIndex = 14

      local textButton10 = Instance.new("TextButton")
      textButton10.Parent = frame12
      textButton10.Size = UDim2.new(0, 68, 0, 22)
      textButton10.Position = UDim2.new(1, -80, 0.5, -11)
      textButton10.BackgroundColor3 = v11.CARD_BG
      textButton10.BorderSizePixel = 0
      textButton10.Text = text10:upper()
      textButton10.Font = robotoMono
      textButton10.TextSize = 10
      textButton10.TextColor3 = v11.BLUE_ACCENT
      textButton10.ZIndex = 14

      local instance18 = Instance.new("UICorner", textButton10)
      instance18.CornerRadius = UDim.new(0, 5)

      textButton10.MouseButton1Click:Connect(function()
        if p24 then
          p24()
        end
      end)

      return frame12
    end

    function f15(parent5, text11, p25, p26)
      local frame13 = Instance.new("Frame")
      frame13.Parent = parent5
      frame13.Size = UDim2.new(1, 0, 0, 18)
      frame13.BackgroundTransparency = 1
      frame13.ZIndex = 15

      local frame14 = Instance.new("Frame")
      frame14.Parent = frame13
      frame14.Size = UDim2.new(0, 11, 0, 11)
      frame14.Position = UDim2.new(0, 0, 0.5, -5)
      frame14.BackgroundColor3 = p25 and v11.CHECK_ON or v11.CHECK_OFF
      frame14.BorderSizePixel = 0
      frame14.ZIndex = 16

      Instance.new("UICorner", frame14).CornerRadius = UDim.new(0, 3)

      local instance19 = Instance.new("UIStroke", frame14)
      instance19.Color = p25 and v11.BLUE_ACCENT or v11.BORDER
      instance19.Thickness = 1

      local textLabel11 = Instance.new("TextLabel")
      textLabel11.Parent = frame13
      textLabel11.Size = UDim2.new(1, -20, 1, 0)
      textLabel11.Position = UDim2.new(0, 18, 0, 0)
      textLabel11.BackgroundTransparency = 1
      textLabel11.Text = text11:upper()
      textLabel11.Font = robotoMono
      textLabel11.TextSize = 10
      textLabel11.TextColor3 = p25 and v11.TEXT_WHITE or v11.TEXT_MUTED
      textLabel11.TextXAlignment = Enum.TextXAlignment.Left
      textLabel11.ZIndex = 16

      local textButton11 = Instance.new("TextButton")
      textButton11.Parent = frame13
      textButton11.Size = UDim2.new(1, 0, 1, 0)
      textButton11.BackgroundTransparency = 1
      textButton11.Text = ""
      textButton11.ZIndex = 17

      local v59 = p25

      local function f36(p27)
        v59 = p27

        f25(frame14, { BackgroundColor3 = v59 and v11.CHECK_ON or v11.CHECK_OFF })
        f25(instance19, { Color = v59 and v11.BLUE_ACCENT or v11.BORDER })
        f25(textLabel11, { TextColor3 = v59 and v11.TEXT_WHITE or v11.TEXT_MUTED })

        if p26 then
          p26(v59)
        end
      end

      textButton11.MouseButton1Click:Connect(function() f36(not v59) end)
    end

    local combat = v21.COMBAT

    local v60 = f14(combat, "Aim Assist Master", v13.aimEnabled, nil, function(p28)
      v13.aimEnabled = p28
      v15.circle.Visible = p28

      local stroke = v15.stroke
      stroke.Transparency = p28 and 0 or 1

      f4("Aimbot", p28 and "ENABLED" or "DISABLED")
    end, true)

    f16(v60.container, "Aim Activation Key", v13.aimHoldKeyStr, function(aimKeyType, aimHoldKey, p29)
      v13.aimKeyType = aimKeyType
      v13.aimHoldKey = aimHoldKey
      v13.aimHoldKeyStr = p29

      f4("Aim Key", p29)
    end)

    f13(v60.container, "FOV Radius", 20, 300, v13.aimRadius, "px", 5, function(aimRadius)
      v13.aimRadius = aimRadius
      f29()
    end)

    f13(v60.container, "Smoothness / Speed", 0.05, 1, v13.aimSpeed, "", 0.05, function(aimSpeed)
      v13.aimSpeed = aimSpeed
    end)

    f15(v60.container, "Aim On Cursor Position", v13.aimOnCursor, function(aimOnCursor)
      v13.aimOnCursor = aimOnCursor
      f29()
    end)

    f14(combat, "Force Body Aim (Baim)", v13.forceBodyAim, nil, function(forceBodyAim)
      v13.forceBodyAim = forceBodyAim
    end)

    local visuals = v21.VISUALS

    local v61 = f14(visuals, "Player ESP Highlights", v13.espEnabled, Enum.KeyCode.H, function(p30)
      v13.espEnabled = p30

      if p30 then
        f11()
      else
        f30()
      end
    end)

    f13(v61.container, "ESP Render Distance", 100, 10000, v13.espRange, "m", 100, function(espRange)
      v13.espRange = espRange
      f9()
    end)

    f15(v61.container, "Team Filter (Ignore Allies)", v13.teamFilter, function(teamFilter)
      v13.teamFilter = teamFilter
      f11()
    end)

    f14(visuals, "View Look Angles", v13.viewAngles, nil, function(viewAngles)
      v13.viewAngles = viewAngles

      for key12, value19 in pairs(v13.playerHighlights) do
        v17(key12)
      end
    end)

    local v62 = f14(visuals, "Atmospheric Custom Fog", v13.fogEnabled, nil, function(fogEnabled)
      v13.fogEnabled = fogEnabled
    end)

    f13(
      v62.container, "Fog Max Distance", 40, 2000, v13.fogDistance, "", 20,
      function(fogDistance) v13.fogDistance = fogDistance end
    )

    f13(v62.container, "Fog Density", 0.05, 1, v13.fogDensity, "", 0.05, function(fogDensity)
      v13.fogDensity = fogDensity
    end)

    f13(
      v62.container, "Fog Brightness", 0.1, 5, v13.fogBrightness, "", 0.1,
      function(fogBrightness) v13.fogBrightness = fogBrightness end
    )

    local movement = v21.MOVEMENT

    local v63 = f14(
      movement, "Auto BunnyHop", v13.bhopEnabled, Enum.KeyCode.B,
      function(bhopEnabled) v13.bhopEnabled = bhopEnabled end
    )

    f13(v63.container, "Speed Multiplier", 1, 4, v13.bhopSpeed, "x", 0.1, function(bhopSpeed)
      v13.bhopSpeed = bhopSpeed
    end)

    f13(v63.container, "Jump Power", 30, 120, v13.bhopJumpPower, "", 5, function(bhopJumpPower)
      v13.bhopJumpPower = bhopJumpPower
    end)

    f13(f14(movement, "SpinBot", v13.spinbotEnabled, nil, function(p31)
      v13.spinbotEnabled = p31

      if not p31 and localPlayer.Character then
        local humanoid4 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid4 then
          humanoid4.AutoRotate = true
        end
      end
    end).container, "Rotation Speed", 1, 50, v13.spinbotSpeed, "x", 1, function(spinbotSpeed) v13.spinbotSpeed = spinbotSpeed end)

    local misc = v21.MISC

    f14(misc, "Anti-Flash Bang", v13.antiFlash, nil, function(antiFlash)
      v13.antiFlash = antiFlash
    end)

    f14(misc, "Clean Smoke Clouds", v13.antiSmoke, nil, function(antiSmoke)
      v13.antiSmoke = antiSmoke
    end)

    f17(misc, "Reset FOV Circle Offset", "RESET", function()
      v13.overlayOffset = Vector2.new(0, 0)
      f29()
      f4("Offset", "Centered (0,0)")
    end)

    v22 = false
    vector = nil
    position = nil

    topBar.InputBegan:Connect(function(input8)
      if input8.UserInputType == Enum.UserInputType.MouseButton1
        or input8.UserInputType == Enum.UserInputType.Touch then
        if not v18 then
          v22 = true
          vector = Vector2.new(input8.Position.X, input8.Position.Y)
          position = mainPanel.Position
        end
      end
    end)

    userInputService.InputChanged:Connect(function(input9)
      if v22
        and (input9.UserInputType == Enum.UserInputType.MouseMovement
          or input9.UserInputType == Enum.UserInputType.Touch) then
        local v64 = Vector2.new(input9.Position.X, input9.Position.Y) - vector

        mainPanel.Position = UDim2.new(
          position.X.Scale, position.X.Offset + v64.X, position.Y.Scale,
          position.Y.Offset + v64.Y
        )
      end
    end)

    userInputService.InputEnded:Connect(function(input10)
      if input10.UserInputType == Enum.UserInputType.MouseButton1
        or input10.UserInputType == Enum.UserInputType.Touch then
        v22 = false
      end
    end)

    keyVerification = Instance.new("Frame")
    keyVerification.Name = "KeyVerification"
    keyVerification.Parent = zentryxPanel
    keyVerification.Size = UDim2.new(0, 340, 0, 180)
    keyVerification.Position = UDim2.new(0.5, -170, 0.5, -90)
    keyVerification.BackgroundColor3 = v11.BG
    keyVerification.BorderSizePixel = 0
    keyVerification.Active = true
    keyVerification.ZIndex = 100

    

    Instance.new("UICorner", keyVerification).CornerRadius = UDim.new(0, 10)

    instance = Instance.new("UIStroke", keyVerification)
    instance.Color = v11.BORDER_GLOW
    instance.Thickness = 1.2

    local textLabel12 = Instance.new("TextLabel")
    textLabel12.Parent = keyVerification
    textLabel12.Size = UDim2.new(1, -20, 0, 24)
    textLabel12.Position = UDim2.new(0, 10, 0, 8)
    textLabel12.BackgroundTransparency = 1
    textLabel12.Text = "AUTHENTICATION // LICENSE"
    textLabel12.Font = robotoMono
    textLabel12.TextSize = 11
    textLabel12.TextColor3 = v11.TEXT_MUTED
    textLabel12.TextXAlignment = Enum.TextXAlignment.Left
    textLabel12.ZIndex = 101

    local frame15 = Instance.new("Frame")
    frame15.Parent = keyVerification
    frame15.Size = UDim2.new(1, -20, 0, 32)
    frame15.Position = UDim2.new(0, 10, 0, 42)
    frame15.BackgroundColor3 = v11.PANEL
    frame15.BorderSizePixel = 0
    frame15.ZIndex = 101

    Instance.new("UICorner", frame15).CornerRadius = UDim.new(0, 6)

    instance2 = Instance.new("UIStroke", frame15)
    instance2.Color = v11.BORDER
    instance2.Thickness = 1

    textBox = Instance.new("TextBox")
    textBox.Parent = frame15
    textBox.Size = UDim2.new(1, -12, 1, 0)
    textBox.Position = UDim2.new(0, 6, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.PlaceholderText = "ENTER KEY..."
    textBox.PlaceholderColor3 = v11.TEXT_MUTED
    textBox.Text = ""
    textBox.Font = robotoMono
    textBox.TextSize = 11
    textBox.TextColor3 = v11.TEXT_WHITE
    textBox.ClearTextOnFocus = false
    textBox.ZIndex = 102

    textLabel = Instance.new("TextLabel")
    textLabel.Parent = keyVerification
    textLabel.Size = UDim2.new(1, -20, 0, 18)
    textLabel.Position = UDim2.new(0, 10, 0, 82)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "Status: Waiting for license..."
    textLabel.Font = robotoMono
    textLabel.TextSize = 10
    textLabel.TextColor3 = v11.TEXT_MUTED
    textLabel.ZIndex = 101

    local textButton12 = Instance.new("TextButton")
    textButton12.Parent = keyVerification
    textButton12.Size = UDim2.new(0.5, -14, 0, 30)
    textButton12.Position = UDim2.new(0, 10, 0, 114)
    textButton12.BackgroundColor3 = v11.PANEL
    textButton12.BorderSizePixel = 0
    textButton12.Text = "SUBMIT"
    textButton12.Font = robotoMono
    textButton12.TextSize = 11
    textButton12.TextColor3 = v11.BLUE_ACCENT
    textButton12.ZIndex = 102

    Instance.new("UICorner", textButton12).CornerRadius = UDim.new(0, 6)

    local instance20 = Instance.new("UIStroke", textButton12)
    instance20.Color = v11.BORDER
    instance20.Thickness = 1

    local textButton13 = Instance.new("TextButton")
    textButton13.Parent = keyVerification
    textButton13.Size = UDim2.new(0.5, -14, 0, 30)
    textButton13.Position = UDim2.new(0.5, 4, 0, 114)
    textButton13.BackgroundColor3 = v11.PANEL
    textButton13.BorderSizePixel = 0
    textButton13.Text = "GET KEY"
    textButton13.Font = robotoMono
    textButton13.TextSize = 11
    textButton13.TextColor3 = v11.TEXT_WHITE
    textButton13.ZIndex = 102

    Instance.new("UICorner", textButton13).CornerRadius = UDim.new(0, 6)

    local instance21 = Instance.new("UIStroke", textButton13)
    instance21.Color = v11.BORDER

    function f18()
      v13.keyVerified = true

      textLabel.Text = "Access Granted! Loading..."
      textLabel.TextColor3 = v11.SUCCESS

      f25(instance, { Color = v11.SUCCESS })

      task.delay(0.35, function()
        keyVerification:Destroy()
        mainPanel.Visible = true
        f11()
        f4("Zentryx Hub", "Loaded Successfully", v11.SUCCESS)
      end)
    end

    
    keyVerification:Destroy()
    mainPanel.Visible = true
    f11()
    f4("Zentryx Hub", "Loaded Successfully", v11.SUCCESS)

    instance21.Thickness = 1

        function f19(key13, fn)
      task.wait(0.5)
      fn(true, "Access Granted (Bypassed)")
    end

    function f20(p32)
      local gsub3 = p32:gsub("%s+", "")

      if gsub3 == "" then
        textLabel.Text = "Please enter a key!"
        textLabel.TextColor3 = v11.DANGER
        return
      end

      textLabel.Text = "Verifying with Cloudflare KV..."
      textLabel.TextColor3 = v11.BLUE_ACCENT

      v23(gsub3, function(p33, text12)
        if p33 then
          pcall(function()
            if writefile then
              writefile("zentryx_key.txt", gsub3)
            end
          end)

          f18()
        else
          textLabel.Text = text12
          textLabel.TextColor3 = v11.DANGER
          f25(instance2, { Color = v11.DANGER })
        end
      end)
    end

    v23 = f19

    textButton13.MouseButton1Click:Connect(function()
      pcall(function()
        if setclipboard then
          setclipboard("https://discord.gg/zentryx")
        end
      end)

      textLabel.Text = "Link copied to clipboard!"
      textLabel.TextColor3 = v11.BLUE_ACCENT
    end)

    textButton12.MouseButton1Click:Connect(function() f20(textBox.Text) end)

    pcall(function()
      if readfile and isfile and isfile("zentryx_key.txt") then
        local gsub4 = readfile("zentryx_key.txt"):gsub("%s+", "")

        if #gsub4 > 0 then
          textBox.Text = gsub4
          f20(gsub4)
        end
      end
    end)

    userInputService.InputBegan:Connect(function(input11, p34)
      if input11.UserInputType == Enum.UserInputType.Keyboard
        and input11.KeyCode == Enum.KeyCode.RightControl then
        if v13.keyVerified then
          v13.menuVisible = not v13.menuVisible
          mainPanel.Visible = v13.menuVisible

          if not v13.menuVisible then
            colorDropdown.Visible = false
          end
        end
      end

      if input11.UserInputType == Enum.UserInputType.Keyboard
        and input11.KeyCode == Enum.KeyCode.Space then
        v13.bhopHolding = true
      end

      local v69 = false

      if v13.aimKeyType == "keyboard" and input11.UserInputType == Enum.UserInputType.Keyboard
        and input11.KeyCode == v13.aimHoldKey then
        v69 = true
      elseif v13.aimKeyType == "mouse" and input11.UserInputType == v13.aimHoldKey then
        v69 = true
      end

      if v69 then
        v13.aimKeyHeld = true
      end

      if p34 then
        return
      end

      for index16, value20 in ipairs(v14) do
      end
    end)


    local inputEnded = userInputService.InputEnded

    function f23(p35, p36)
      if p35.UserInputType == Enum.UserInputType.Keyboard and p35.KeyCode == Enum.KeyCode.Space then
        v13.bhopHolding = false
      end

      local v70 = false

      if v13.aimKeyType == "keyboard" and p35.UserInputType == Enum.UserInputType.Keyboard
        and p35.KeyCode == v13.aimHoldKey then
        v70 = true
      elseif v13.aimKeyType == "mouse" and p35.UserInputType == v13.aimHoldKey then
        v70 = true
      end

      if v70 then
        v13.aimKeyHeld = false
      end
    end

    function f21(index17)
      local character7 = localPlayer.Character

      if not character7 then
        return
      else
        local humanoid5 = character7:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart2 = character7:FindFirstChild("HumanoidRootPart")

        if not (humanoid5 and humanoidRootPart2 and humanoid5.Health > 0) then
          return
        end

        if v13.spinbotEnabled then
          humanoid5.AutoRotate = false

          v13.spinbotYaw = (v13.spinbotYaw + math.rad(v13.spinbotSpeed * 360 * index17))
            % (math.pi * 2)

          humanoidRootPart2.CFrame = CFrame.new(humanoidRootPart2.Position)
            * CFrame.Angles(0, v13.spinbotYaw, 0)
        elseif not humanoid5.AutoRotate then
          humanoid5.AutoRotate = true
        end

        return
      end
    end

    inputEnded:Connect(f23)

    pcall(function()
      contextActionService:BindActionAtPriority("Zentryx_SpaceHold", function(p37, p38)
        if p38 == Enum.UserInputState.Begin then
          v13.bhopHolding = true
        elseif p38 == Enum.UserInputState.End or p38 == Enum.UserInputState.Cancel then
          v13.bhopHolding = false
        end

        return Enum.ContextActionResult.Pass
      end, false, 3000, Enum.KeyCode.Space)
    end)

    function f22()
      local v71 = not v13.bhopEnabled
      local unit, humanoid6

      if v71 or not v13.bhopHolding then
        if v13.bhopBV then
          v13.bhopBV:Destroy()
          v13.bhopBV = nil
        end

        return
      else
        local character8 = localPlayer.Character

        if not character8 then
          return
        else
          humanoid6 = character8:FindFirstChildOfClass("Humanoid")
          local humanoidRootPart3 = character8:FindFirstChild("HumanoidRootPart")
          local currentCamera2 = workspace.CurrentCamera

          if not (humanoid6 and humanoidRootPart3 and currentCamera2) or humanoid6.Health <= 0 then
            if v13.bhopBV then
              v13.bhopBV:Destroy()
              v13.bhopBV = nil
            end

            return
          else
            local lookVector = currentCamera2.CFrame.LookVector
            local vector2 = Vector3.new(lookVector.X, 0, lookVector.Z)

            if vector2.Magnitude > 0.01 then
              unit = vector2.Unit
            else
              unit = Vector3.new(0, 0, -1)
            end

            if not v13.bhopBV or v13.bhopBV.Parent ~= humanoidRootPart3 then
              if v13.bhopBV then
                v13.bhopBV:Destroy()
              end

              v13.bhopBV = Instance.new("BodyVelocity")
              v13.bhopBV.MaxForce = Vector3.new(math.huge, 0, math.huge)
              v13.bhopBV.P = 1250
              v13.bhopBV.Parent = humanoidRootPart3
            end

            v13.bhopBV.Velocity = unit * (16 * v13.bhopSpeed)
            local getState = humanoid6:GetState()
            local y = humanoidRootPart3.Velocity.Y

            local v72 = (getState == Enum.HumanoidStateType.Running
                or getState == Enum.HumanoidStateType.RunningNoPhysics
                or getState == Enum.HumanoidStateType.Landed
                or getState == Enum.HumanoidStateType.Seated)
              and math.abs(y) < 3

            if not v72 and humanoid6.FloorMaterial ~= Enum.Material.Air then
              v72 = true
            end

            local v73 = tick()

            if v72 and v73 - v24 >= v25 then
              v24 = v73
              local velocity = humanoidRootPart3.Velocity

              humanoidRootPart3.Velocity = Vector3.new(
                velocity.X, v13.bhopJumpPower, velocity.Z
              )

              pcall(function() humanoid6:ChangeState(Enum.HumanoidStateType.Jumping) end)
              pcall(function() humanoid6.Jump = true end)
            end

            return
          end
        end
      end
    end

    v24 = 0
    v25 = 0.05

    function f33()
      local currentCamera3 = workspace.CurrentCamera
      local humanoidRootPart4

      if not currentCamera3 then
        return nil
      else
        local viewportSize = currentCamera3.ViewportSize

        local getMouseLocation2 = v13.aimOnCursor and userInputService:GetMouseLocation()
          or Vector2.new(viewportSize.X / 2, viewportSize.Y / 2) + v13.overlayOffset

        local aimRadius2 = v13.aimRadius
        local v74 = nil

        for index18, value21 in ipairs(players:GetPlayers()) do
          if value21 ~= localPlayer and f28(value21) and not (v13.teamFilter and f26(value21)) then
            local character9 = value21.Character

            if v13.forceBodyAim then
              humanoidRootPart4 = character9:FindFirstChild("HumanoidRootPart")
                or character9:FindFirstChild("Torso")
            else
              humanoidRootPart4 = character9:FindFirstChild("Head")
            end

            if not humanoidRootPart4 then
              humanoidRootPart4 = character9:FindFirstChild("Head")
                or character9:FindFirstChild("HumanoidRootPart")
            end

            if humanoidRootPart4 then
              local v75 = humanoidRootPart4.Position
                + (not v13.forceBodyAim and Vector3.new(0, 0.15, 0) or Vector3.zero)

              local v76, v77 = currentCamera3:WorldToViewportPoint(v75)

              if v77 then
                local magnitude2 = (Vector2.new(v76.X, v76.Y) - getMouseLocation2).Magnitude

                if magnitude2 < aimRadius2 then
                  aimRadius2 = magnitude2
                  v74 = { part = humanoidRootPart4, pos = v75 }
                end
              end
            end
          end
        end

        return v74
      end
    end

    v26 = 0

    runService.RenderStepped:Connect(function(delta)
      if v13.terminated then
        return
      else
        local currentCamera4 = workspace.CurrentCamera

        if not currentCamera4 then
          return
        end

        v26 = v26 + 1

        if v26 >= 15 then
          v26 = 0
          f9()
        end

        f22()
        f21(delta)
        f31()

        if v13.aimOnCursor and v13.aimEnabled then
          local getMouseLocation3 = userInputService:GetMouseLocation()

          v15.circle.Position = UDim2.new(
            0, getMouseLocation3.X - v13.aimRadius, 0, getMouseLocation3.Y - v13.aimRadius
          )
        end

        if not v13.aimEnabled or not v13.aimKeyHeld then
          v13.aimHasTarget = false
          return
        else
          local v78 = f33()

          if not v78 or not v78.pos then
            v13.aimHasTarget = false
            return
          end

          v13.aimHasTarget = true

          currentCamera4.CFrame = currentCamera4.CFrame:Lerp(CFrame.lookAt(
            currentCamera4.CFrame.Position, v78.pos
          ), math.clamp(
            v13.aimSpeed * delta * 60, 0, 1
          ))

          return
        end
      end
    end)

    localPlayer.CharacterAdded:Connect(function(character10)
      v13.spinbotYaw = 0
      local waitForChild = character10:WaitForChild("Humanoid", 5)

      if waitForChild and not v13.spinbotEnabled then
        waitForChild.AutoRotate = true
      end
    end)

    print("[+] Zentryx Hub Modular Interface v7.0 Initialized.")
    return
  end
end)

if not v1 then
  warn("[-] Error loading Zentryx Hub:", v2)
end


