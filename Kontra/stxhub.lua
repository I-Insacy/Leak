
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")
local httpService = game:GetService("HttpService")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local localPlayer = players.LocalPlayer
local a855F7 = Color3.fromHex("A855F7")
local color = Color3.fromHex("7C3AED")
local c4B5FD = Color3.fromHex("C4B5FD")
local color2 = Color3.fromHex("121212")
local color3 = Color3.fromHex("1A1A1A")
local color4 = Color3.fromHex("252525")
local color5 = Color3.fromHex("333333")
local ededed = Color3.fromHex("EDEDED")
local color6 = Color3.fromHex("8B8B8B")
local color7 = Color3.fromHex("3ECF8E")
local ef5350 = Color3.fromHex("EF5350")

local function f1()
  local v1, v2

  if gethui then
    local v3, v4 = pcall(gethui)

    if v3 and v4 then
      return v4
    end

    v2, v1 = pcall(function() return coreGui end)

    if v2 and v1 then
      return v1
    end

    return localPlayer:WaitForChild("PlayerGui")
  end

  v2, v1 = pcall(function() return coreGui end)

  if v2 and v1 then
    return v1
  end

  return localPlayer:WaitForChild("PlayerGui")
end

local parent = f1()

local function makeHighlight()
  local dist = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

  local stxHUBWindow = dist:CreateWindow({
    Title = "STX HUB",
    Author = "STX",
    Icon = "zap",
    Folder = "STXHub",
    Size = UDim2.fromOffset(620, 500),
    Theme = "Dark",
    OpenButton = {
      Title = "STX HUB",
      Icon = "zap",
      Color = ColorSequence.new(a855F7, color),
      CornerRadius = UDim.new(0, 12),
      StrokeThickness = 2,
      OnlyMobile = false,
      Enabled = true,
      Draggable = true,
    },
  })

  dist:Notify({ Title = "STX HUB", Content = "Authenticated — welcome!", Duration = 4 })

  local v8, v9 = pcall(function()
    local currentCamera = workspace.CurrentCamera
    local touchEnabled = userInputService.TouchEnabled
    local v10 = false
    local v11, v12 = pcall(function() return Drawing end)
    v10 = v11 and v12 and v12.new ~= nil
    local v13 = workspace:FindFirstChild("Characters") ~= nil
    local d8B4FE = Color3.fromHex("D8B4FE")
    local color8 = Color3.fromHex("4C1D95")

    local v14 = {
      ESP = false,
      Box = false,
      BoxColor = a855F7,
      Name = false,
      NameColor = c4B5FD,
      Distance = false,
      DistanceColor = d8B4FE,
      Tracer = false,
      TracerColor = a855F7,
      Highlight = false,
      HighlightColor = a855F7,
      MaxDistance = 1000,
      TeamCheck = true,
      VisibleCheck = true,
      IgnoreFF = true,
      Aim = false,
      AimAuto = touchEnabled,
      AimKey = Enum.KeyCode.E,
      AimFOV = touchEnabled and 350 or 200,
      AimSmooth = touchEnabled and 4 or 2,
      AimBone = "Head",
      AimMaxDist = 1500,
      AimPredict = true,
      AimPredAmt = 0.15,
      AimShowFOV = true,
      AimFOVColor = a855F7,
      AimFOVThick = touchEnabled and 3 or 1.5,
      GraceTime = 1.5,
      UseMouseLook = true,
      Gain = 1,
      InvertX = false,
      InvertY = false,
      UseCFrame = false,
    }

    local v15 = {}
    local v16 = {}
    local v17 = false
    local v18 = 0

    local v19 = rawget(getfenv(), "mousemoverel") or rawget(getfenv(), "mouse_move_rel")
      or rawget(getfenv(), "MouseMoveRel")

    local function f2(value)
      local humanoidRootPart = value:FindFirstChild("HumanoidRootPart")
        or value:FindFirstChild("UpperTorso") or value:FindFirstChild("Torso")
        or value.PrimaryPart

      if not humanoidRootPart then
        return nil
      else
        local huge = math.huge
        local v20 = -math.huge

        for index, value2 in ipairs(value:GetDescendants()) do
          if value2:IsA("BasePart") then
            local v21 = value2.Position.Y + value2.Size.Y * 0.5
            local v22 = value2.Position.Y - value2.Size.Y * 0.5

            if v21 > v20 then
              v20 = v21
            end

            if v22 < huge then
              huge = v22
            end
          end
        end

        if huge >= v20 then
          return nil
        end

        return Vector3.new(
          humanoidRootPart.Position.X, (v20 + huge) * 0.5, humanoidRootPart.Position.Z
        ), v20 - huge
      end
    end

    local v23 = type(v19)

    local function f3(p3)
      for index2, value3 in ipairs(players:GetPlayers()) do
        if value3 ~= localPlayer then
          if p3.Name == tostring(value3.UserId) or p3.Name == value3.Name then
            return value3
          elseif value3.Character == p3 then
            return value3
          end
        end
      end

      return nil
    end

    local v24 = v23 == "function"

    local function f4(p4)
      if not v14.VisibleCheck or not p4 then
        return true
      else
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = { localPlayer.Character }
        raycastParams.IgnoreWater = true

        local raycast = workspace:Raycast(
          currentCamera.CFrame.Position, p4.Position - currentCamera.CFrame.Position,
          raycastParams
        )

        if not raycast then
          return true
        end

        return raycast.Instance:IsDescendantOf(p4.Parent)
      end
    end

    local function f5(p5)
      local v25 = f3(p5)

      if not v25 then
        return true
      else
        local team = localPlayer:GetAttribute("Team")
        local team2 = v25:GetAttribute("Team")

        if team2 == nil or team2 == "Spectator" then
          return false
        end

        if team == nil then
          return true
        end

        return team ~= team2
      end
    end

    local function f6(value4)
      local v26 = f3(value4)

      if v26 then
        if v26.DisplayName ~= v26.Name then
          return v26.DisplayName .. " (@" .. v26.Name .. ")"
        end

        return v26.Name
      end

      return value4.Name
    end

    local function f7(p6)
      return p6:FindFirstChildOfClass("ForceField") ~= nil
    end

    local function f8(p7)
      for key, value5 in pairs(p7) do
        local v27 = value5

        if v27 then
          pcall(function() v27.Visible = false end)
        end
      end
    end

    local function f9(p8)
      if not p8 or not p8:IsA("Model") or p8 == localPlayer.Character then
        return false
      elseif p8:FindFirstChild("NameTag", true) then
        return false
      else
        local humanoid = p8:FindFirstChildOfClass("Humanoid")

        if humanoid and humanoid.Health <= 0 then
          return false
        end

        if v14.TeamCheck and not f5(p8) then
          return false
        end

        if v14.IgnoreFF and f7(p8) then
          return false
        end

        return true
      end
    end

    local function f10()
      local v28 = {}

      if v13 then
        local characters = workspace:FindFirstChild("Characters")

        if characters then
          for index3, value6 in ipairs(characters:GetChildren()) do
            if f9(value6) then
              table.insert(v28, value6)
            end
          end
        end
      else
        for index4, value7 in ipairs(players:GetPlayers()) do
          if value7 ~= localPlayer and value7.Character and f9(value7.Character) then
            table.insert(v28, value7.Character)
          end
        end
      end

      return v28
    end

    local function f11(key2)
      local v29 = v15[key2]

      if not v29 then
        return
      end

      for key3, value8 in pairs(v29) do
        local v30 = value8

        if v30 then
          pcall(function() v30:Remove() end)
        end
      end

      v15[key2] = nil
    end

    local function makeHighlight2(value9)
      if v16[value9] or not f9(value9) then
        return
      else
        local stxHL = Instance.new("Highlight")
        stxHL.Name = "STX_HL"
        stxHL.Adornee = value9
        stxHL.FillColor = v14.HighlightColor
        stxHL.OutlineColor = v14.HighlightColor
        stxHL.FillTransparency = 0.5
        stxHL.OutlineTransparency = 0
        stxHL.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        stxHL.Parent = value9

        v16[value9] = stxHL
        return
      end
    end

    local function f12(p9, p10)
      local v31

      if not v10 then
        return nil
      else
        local v32
        v32, v31 = pcall(Drawing.new, p9)

        if not v32 or not v31 then
          return nil
        end

        for key4, value10 in pairs(p10 or {}) do
          local v33 = key4
          local v34 = value10
          pcall(function() v31[v33] = v34 end)
        end

        return v31
      end
    end

    local function f13(key5)
      if v16[key5] then
        pcall(function() v16[key5]:Destroy() end)
        v16[key5] = nil
      end
    end

    local function f14(value11)
      if not v10 or v15[value11] or not value11:IsA("Model") then
        return
      else
        local boxOutline = f12("Square", {
          Color = color8,
          Thickness = 4,
          Filled = false,
          Visible = false,
        })

        local v35 = f12("Square", {
          Color = a855F7,
          Thickness = 2,
          Filled = false,
          Visible = false,
        })

        if not v35 then
          return
        end

        v15[value11] = {
          BoxOutline = boxOutline,
          Box = v35,
          Name = f12("Text", {
            Size = 13,
            Center = true,
            Outline = true,
            OutlineColor = color8,
            Font = 2,
            Visible = false,
          }),
          Dist = f12("Text", {
            Size = 12,
            Center = true,
            Outline = true,
            OutlineColor = color8,
            Font = 2,
            Visible = false,
          }),
          Tracer = f12("Line", { Thickness = 1, Visible = false }),
        }

        return
      end
    end

    local function f15()
      for key6 in pairs(v16) do
        f13(key6)
      end
    end

    local v36

    if v10 then
      v36 = f12("Circle", {
        Thickness = v14.AimFOVThick,
        Filled = false,
        Transparency = 0.35,
        Visible = false,
        NumSides = 64,
        Color = v14.AimFOVColor,
      })
    end

    local renderStepped = runService.RenderStepped
    local cameraType

    local function f16()
      if v17 then
        pcall(function()
          if currentCamera.CameraType == Enum.CameraType.Scriptable then
            currentCamera.CameraType = cameraType or Enum.CameraType.Custom
          end
        end)

        v17 = false
        cameraType = nil
      end
    end

    renderStepped:Connect(function()
      for key7 in pairs(v15) do
        if not key7.Parent then
          f11(key7)
        end
      end

      for key8 in pairs(v16) do
        if not key8.Parent then
          f13(key8)
        end
      end

      if not v14.ESP then
        for key9, value12 in pairs(v15) do
        end

        return
      else
        local viewportSize = currentCamera.ViewportSize
        local position = currentCamera.CFrame.Position
        local vector = Vector2.new(viewportSize.X / 2, viewportSize.Y)
        local v37 = f10()
        local v38 = {}

        for index5, value13 in ipairs(v37) do
          v38[value13] = true
        end

        for key10 in pairs(v15) do
          if not v38[key10] then
            f11(key10)
          end
        end

        for index6, value14 in ipairs(v37) do
          if not v15[value14] then
            f14(value14)
          end

          local v39 = v15[value14]

          if v39 then
            local v40, v41 = f2(value14)

            if not v40 then
              f8(v39)
            else
              local magnitude = (position - v40).Magnitude

              if magnitude > v14.MaxDistance then
                f8(v39)
              else
                local vector2 = Vector3.new(0, v41 / 2 + 0.2, 0)
                local vector3 = Vector3.new(0, v41 / 2 + 0.2, 0)
                local v42, v43 = currentCamera:WorldToViewportPoint(v40 + vector2)
                local v44 = not v43
                local v45, v46 = currentCamera:WorldToViewportPoint(v40 - vector3)

                if v44 and not v46 then
                  f8(v39)
                else
                  local v47 = math.max(math.abs(v45.Y - v42.Y), 10)
                  local v48 = math.max(v47 * 0.55, 6)
                  local v49 = v42.X - v48 / 2
                  local y = v42.Y

                  if v14.Box and v39.Box then
                    if v39.BoxOutline then
                      v39.BoxOutline.Size = Vector2.new(v48, v47)
                      v39.BoxOutline.Position = Vector2.new(v49, y)
                      v39.BoxOutline.Visible = true
                    end

                    v39.Box.Size = Vector2.new(v48, v47)
                    v39.Box.Position = Vector2.new(v49, y)
                    v39.Box.Color = v14.BoxColor
                    v39.Box.Visible = true
                  else
                    if v39.Box then
                      v39.Box.Visible = false
                    end

                    if v39.BoxOutline then
                      v39.BoxOutline.Visible = false
                    end
                  end

                  if v14.Name and v39.Name then
                    v39.Name.Text = f6(value14)
                    v39.Name.Position = Vector2.new(v42.X, y - 22)
                    v39.Name.Color = v14.NameColor
                    v39.Name.Visible = true
                  elseif v39.Name then
                    v39.Name.Visible = false
                  end

                  if v14.Distance and v39.Dist then
                    v39.Dist.Text = math.floor(magnitude) .. " studs"
                    v39.Dist.Position = Vector2.new(v42.X, y + v47 + 4)
                    v39.Dist.Color = v14.DistanceColor
                    v39.Dist.Visible = true
                  elseif v39.Dist then
                    v39.Dist.Visible = false
                  end

                  if v14.Tracer and v39.Tracer and v43 and v46 then
                    v39.Tracer.From = vector
                    v39.Tracer.To = Vector2.new(v42.X, y + v47)
                    v39.Tracer.Color = v14.TracerColor
                    v39.Tracer.Visible = true
                  elseif v39.Tracer then
                    v39.Tracer.Visible = false
                  end
                end
              end
            end
          end
        end

        return
      end
    end)

    task.spawn(function()
      while task.wait(0.5) do
        if v14.Highlight then
          local v50 = {}

          for index7, value15 in ipairs((f10())) do
            v50[value15] = true

            if not v16[value15] then
              makeHighlight2(value15)
            end
          end

          for key11 in pairs(v16) do
            if not v50[key11] or not key11.Parent then
              f13(key11)
            end
          end
        else
          f15()
        end
      end
    end)

    local function f17(index8, index9)
      if not v24 then
        return false
      else
        local v51 = index9 * v14.Gain
        local v52 = index8 * v14.Gain

        if v14.InvertX then
          v52 = -v52
        end

        if v14.InvertY then
          v51 = -v51
        end

        return pcall(v19, v52, v51)
      end
    end

    local function f18(part, aimPredAmt)
      if not part or not aimPredAmt or aimPredAmt <= 0 then
        return part and part.Position
      else
        local v53, v54 = pcall(function() return part.AssemblyLinearVelocity end)

        if not v53 or not v54 then
          return part.Position
        end

        return part.Position + v54 * aimPredAmt
      end
    end

    local f19

    local function f20()
      local position2 = currentCamera.CFrame.Position
      local viewportSize2 = currentCamera.ViewportSize
      local vector4 = Vector2.new(viewportSize2.X / 2, viewportSize2.Y / 2)
      local huge2 = math.huge
      local v55

      for index10, value16 in ipairs(f10()) do
        local v56 = f19(value16, v14.AimBone)

        if v56 then
          local aimPredict = v14.AimPredict and f18(v56, v14.AimPredAmt) or v56.Position
          local magnitude2 = (position2 - aimPredict).Magnitude

          if magnitude2 <= v14.AimMaxDist then
            local v57, v58 = currentCamera:WorldToViewportPoint(aimPredict)

            if v58 then
              if (Vector2.new(v57.X, v57.Y) - vector4).Magnitude <= v14.AimFOV and f4(v56) then
                if magnitude2 < huge2 then
                  huge2 = magnitude2
                  v55 = { model = value16, part = v56 }
                end
              end
            end
          end
        end
      end

      return v55
    end

    function f19(p11, p12)
      return p11:FindFirstChild(p12) or p11:FindFirstChild("Head")
        or p11:FindFirstChild("UpperTorso") or p11:FindFirstChild("HumanoidRootPart")
    end

    local f21

    local function f22()
      if not v14.Aim then
        return false
      end

      if v14.AimAuto then
        return true
      end

      return f21()
    end

    local function f23()
      if not v17 then
        cameraType = currentCamera.CameraType
        v17 = true
      end

      if currentCamera.CameraType ~= Enum.CameraType.Scriptable then
        pcall(function() currentCamera.CameraType = Enum.CameraType.Scriptable end)
      end
    end

    function f21()
      if v14.AimKey == nil then
        return false
      else
        local v59, v60 = pcall(function() return userInputService:IsKeyDown(v14.AimKey) end)
        return v59 and v60 or false
      end
    end

    local v61, lookVector, v62

    runService:BindToRenderStep("STXAimBind", Enum.RenderPriority.Last.Value, function()
      local viewportSize3 = currentCamera.ViewportSize
      local v63 = viewportSize3.Y / 2
      local v64 = viewportSize3.X / 2

      if v36 then
        if v14.Aim and v14.AimShowFOV then
          v36.Position = Vector2.new(v64, v63)
          v36.Radius = v14.AimFOV
          v36.Color = v14.AimFOVColor
          v36.Thickness = v14.AimFOVThick
          v36.Visible = true
        else
          v36.Visible = false
        end
      end

      if not v14.Aim then
        v62 = nil
        v61 = nil
        lookVector = nil
        v18 = 0
        f16()
        return
      else
        local v65 = false

        if v62 and v62.model and v62.model.Parent and v62.part and v62.part.Parent then
          local humanoid2 = v62.model:FindFirstChildOfClass("Humanoid")

          if humanoid2 and humanoid2.Health > 0 then
            v65 = true
          end
        end

        local v66 = f22()

        if v66 and not v65 then
          local v67 = f20()

          if v67 then
            v62 = v67
            v65 = true
            v18 = tick()
          end
        end

        if not v65 then
          if not (v62 and v66 and tick() - v18 < v14.GraceTime) then
            v62 = nil
            v61 = nil
            v18 = 0

            if not v66 then
              lookVector = nil
            end

            f16()
            return
          end
        end

        v61 = v62
        v18 = tick()
        local aimPredict2 = v14.AimPredict

        local v68 = aimPredict2
        v68 = aimPredict2 and f18(v61.part, v14.AimPredAmt)

        local position3 = v68
        position3 = v68 or v61.part.Position

        if v24 and v14.UseMouseLook then
          local worldToViewportPoint = currentCamera:WorldToViewportPoint(position3)
          local v69 = math.max(v14.AimSmooth, 1)

          if f17((worldToViewportPoint.X - v64) / v69, (worldToViewportPoint.Y - v63) / v69) then
            return
          end
        end

        if v14.UseCFrame then
          f23()
          local cframe = currentCamera.CFrame
          local v70 = position3 - cframe.Position

          if v70.Magnitude < 0.01 then
            return
          end

          local unit = v70.Unit

          if not lookVector then
            lookVector = cframe.LookVector
          end

          lookVector = lookVector:Lerp(unit, 1 / math.max(v14.AimSmooth, 1)).Unit
          currentCamera.CFrame = CFrame.lookAt(cframe.Position, cframe.Position + lookVector)
          return
        end

        return
      end
    end)

    local function f24(p13, p14)
      if not p13 then
        return nil
      else
        local v71 = {}

        for index11, value17 in ipairs(p14) do
          v71[value17] = p13[value17]
        end

        return v71
      end
    end

    local sky = lighting:FindFirstChildOfClass("Sky")
    local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")

    local sky2 = f24(sky, {
      "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp", "SunAngularSize",
      "MoonAngularSize", "StarCount",
    })

    local function makeSky()
      local stxSky = lighting:FindFirstChildOfClass("Sky")

      if not stxSky then
        stxSky = Instance.new("Sky")
        stxSky.Name = "STX_Sky"
        stxSky.Parent = lighting
      end

      return stxSky
    end

    local atmo = f24(atmosphere, { "Density", "Offset", "Color", "Decay", "Glare", "Haze" })

    local function makeBloomEffect()
      local stxBloom = lighting:FindFirstChildOfClass("BloomEffect")

      if not stxBloom then
        stxBloom = Instance.new("BloomEffect")
        stxBloom.Name = "STX_Bloom"
        stxBloom.Parent = lighting
      end

      return stxBloom
    end

    local v72 = {
      Ambient = lighting.Ambient,
      OutdoorAmbient = lighting.OutdoorAmbient,
      Brightness = lighting.Brightness,
      ClockTime = lighting.ClockTime,
      GeographicLatitude = lighting.GeographicLatitude,
      FogEnd = lighting.FogEnd,
      FogStart = lighting.FogStart,
      FogColor = lighting.FogColor,
      ExposureCompensation = lighting.ExposureCompensation,
      EnvironmentDiffuseScale = lighting.EnvironmentDiffuseScale,
      EnvironmentSpecularScale = lighting.EnvironmentSpecularScale,
      GlobalShadows = lighting.GlobalShadows,
      ShadowSoftness = lighting.ShadowSoftness,
      ColorShift_Top = lighting.ColorShift_Top,
      ColorShift_Bottom = lighting.ColorShift_Bottom,
      sky = sky2,
      atmo = atmo,
    }

    local function makeAtmosphere()
      local stxAtmosphere = lighting:FindFirstChildOfClass("Atmosphere")

      if not stxAtmosphere then
        stxAtmosphere = Instance.new("Atmosphere")
        stxAtmosphere.Name = "STX_Atmosphere"
        stxAtmosphere.Parent = lighting
      end

      return stxAtmosphere
    end

    local function makeColorCorrectionEffect()
      local stxCC = lighting:FindFirstChildOfClass("ColorCorrectionEffect")

      if not stxCC then
        stxCC = Instance.new("ColorCorrectionEffect")
        stxCC.Name = "STX_CC"
        stxCC.Parent = lighting
      end

      return stxCC
    end

    local color9 = Color3.fromRGB(199, 199, 199)
    local color10 = Color3.fromRGB(106, 112, 125)
    local color11 = Color3.fromRGB(60, 20, 120)
    local color12 = Color3.fromRGB(160, 100, 240)
    local color13 = Color3.fromRGB(120, 60, 200)
    local color14 = Color3.fromRGB(168, 85, 247)
    local color15 = Color3.fromRGB(76, 29, 149)
    local color16 = Color3.fromRGB(216, 180, 254)
    local color17 = Color3.fromRGB(90, 60, 140)
    local color18 = Color3.fromRGB(230, 200, 255)
    local color19 = Color3.fromRGB(90, 60, 140)
    local color20 = Color3.fromRGB(200, 150, 255)
    local color21 = Color3.fromRGB(220, 200, 255)
    local color22 = Color3.fromRGB(255, 140, 90)
    local color23 = Color3.fromRGB(255, 160, 110)
    local color24 = Color3.fromRGB(255, 220, 180)
    local color25 = Color3.fromRGB(20, 25, 45)
    local color26 = Color3.fromRGB(120, 140, 180)
    local color27 = Color3.fromRGB(170, 200, 255)
    local color28 = Color3.fromRGB(255, 80, 220)
    local color29 = Color3.fromRGB(255, 120, 255)
    local color30 = Color3.fromRGB(255, 180, 255)
    local color31 = Color3.fromRGB(80, 40, 140)
    local color32 = Color3.fromRGB(255, 100, 200)
    local color33 = Color3.fromRGB(220, 190, 255)
    local color34 = Color3.fromRGB(200, 220, 255)
    local color35 = Color3.fromRGB(70, 75, 90)
    local color36 = Color3.fromRGB(120, 130, 150)
    local color37 = Color3.fromRGB(180, 200, 220)

    local v73 = {
      Default = {
        Brightness = 2,
        ClockTime = 14,
        FogEnd = 100000,
        FogStart = 0,
        atmoDensity = 0.3,
        atmoColor = color9,
        atmoDecay = color10,
        bloomEnabled = false,
        ccEnabled = false,
      },
      Purple = {
        Ambient = color11,
        OutdoorAmbient = color12,
        Brightness = 2,
        ClockTime = 16.5,
        FogEnd = 800,
        FogStart = 60,
        FogColor = color13,
        ExposureCompensation = 0.3,
        ColorShift_Top = color14,
        ColorShift_Bottom = color15,
        atmoDensity = 0.45,
        atmoColor = color16,
        atmoDecay = color17,
        atmoGlare = 2,
        atmoHaze = 3,
        bloomEnabled = true,
        bloomIntensity = 1.8,
        bloomSize = 45,
        bloomThreshold = 0.6,
        ccEnabled = true,
        ccContrast = 0.2,
        ccSaturation = 0.4,
        ccTint = color18,
      },
      Vibe = {
        Brightness = 1.6,
        ClockTime = 17.8,
        FogEnd = 900,
        FogStart = 80,
        FogColor = color19,
        atmoDensity = 0.42,
        atmoColor = color20,
        atmoGlare = 1.2,
        atmoHaze = 2.5,
        bloomEnabled = true,
        bloomIntensity = 1.2,
        bloomSize = 40,
        bloomThreshold = 0.7,
        ccEnabled = true,
        ccContrast = 0.15,
        ccSaturation = 0.35,
        ccTint = color21,
      },
      Sunset = {
        Brightness = 2.4,
        ClockTime = 18.4,
        FogColor = color22,
        atmoColor = color23,
        atmoGlare = 2.5,
        atmoHaze = 4,
        bloomEnabled = true,
        bloomIntensity = 1.6,
        bloomSize = 60,
        bloomThreshold = 0.55,
        ccEnabled = true,
        ccSaturation = 0.3,
        ccTint = color24,
      },
      Midnight = {
        Brightness = 0.6,
        ClockTime = 0.5,
        FogEnd = 500,
        FogStart = 40,
        FogColor = color25,
        atmoColor = color26,
        atmoGlare = 0.6,
        atmoHaze = 1.5,
        bloomEnabled = true,
        bloomIntensity = 0.4,
        bloomSize = 20,
        bloomThreshold = 1.1,
        ccEnabled = true,
        ccSaturation = -0.1,
        ccTint = color27,
      },
      Neon = {
        Brightness = 2.5,
        ClockTime = 16,
        FogColor = color28,
        atmoColor = color29,
        atmoGlare = 4,
        atmoHaze = 3,
        bloomEnabled = true,
        bloomIntensity = 2.5,
        bloomSize = 50,
        bloomThreshold = 0.4,
        ccEnabled = true,
        ccSaturation = 0.6,
        ccTint = color30,
      },
      Cyberpunk = {
        Brightness = 2,
        ClockTime = 21,
        FogColor = color31,
        atmoColor = color32,
        atmoGlare = 3,
        atmoHaze = 5,
        bloomEnabled = true,
        bloomIntensity = 2,
        bloomSize = 48,
        bloomThreshold = 0.5,
        ccEnabled = true,
        ccContrast = 0.25,
        ccSaturation = 0.45,
        ccTint = color33,
      },
      ["Deep Space"] = {
        Brightness = 0,
        ClockTime = 0,
        EnvironmentDiffuseScale = 0,
        EnvironmentSpecularScale = 0,
        atmoDensity = 0,
        bloomEnabled = true,
        bloomIntensity = 1.5,
        bloomSize = 32,
        bloomThreshold = 0.8,
        ccEnabled = true,
        ccSaturation = 0.1,
        ccTint = color34,
      },
      Storm = {
        Brightness = 0.9,
        ClockTime = 15,
        FogEnd = 350,
        FogColor = color35,
        atmoColor = color36,
        atmoHaze = 6,
        ccEnabled = true,
        ccSaturation = -0.25,
        ccTint = color37,
      },
      Horror = {
        Brightness = 0.5,
        ClockTime = 0,
        FogEnd = 200,
        FogColor = Color3.fromRGB(50, 5, 5),
        atmoColor = Color3.fromRGB(120, 30, 30),
        atmoGlare = 1,
        atmoHaze = 8,
        bloomEnabled = true,
        bloomIntensity = 0.8,
        bloomSize = 28,
        ccEnabled = true,
        ccSaturation = -0.4,
        ccTint = Color3.fromRGB(255, 190, 190),
      },
      Tropical = {
        Brightness = 3,
        ClockTime = 13,
        FogEnd = 4000,
        FogColor = Color3.fromRGB(220, 230, 240),
        atmoColor = Color3.fromRGB(220, 230, 250),
        atmoGlare = 1.5,
        atmoHaze = 1,
        bloomEnabled = true,
        bloomIntensity = 1,
        bloomSize = 32,
        bloomThreshold = 0.65,
        ccEnabled = true,
        ccSaturation = 0.25,
        ccTint = Color3.fromRGB(255, 250, 230),
      },
    }

    local function f25(value18)
      local v74 = v73[value18]

      if not v74 then
        return
      end

      for key12, value19 in pairs(v74) do
        local v75 = key12
        local v76 = value19

        if v75 == "atmoDensity" then
          makeAtmosphere().Density = v76
        elseif v75 == "atmoColor" then
          makeAtmosphere().Color = v76
        elseif v75 == "atmoDecay" then
          makeAtmosphere().Decay = v76
        elseif v75 == "atmoGlare" then
          makeAtmosphere().Glare = v76
        elseif v75 == "atmoHaze" then
          makeAtmosphere().Haze = v76
        elseif v75 == "atmoOffset" then
          makeAtmosphere().Offset = v76
        elseif v75 == "bloomEnabled" then
          makeBloomEffect().Enabled = v76
        elseif v75 == "bloomIntensity" then
          makeBloomEffect().Intensity = v76
        elseif v75 == "bloomSize" then
          makeBloomEffect().Size = v76
        elseif v75 == "bloomThreshold" then
          makeBloomEffect().Threshold = v76
        elseif v75 == "ccEnabled" then
          makeColorCorrectionEffect().Enabled = v76
        elseif v75 == "ccBrightness" then
          makeColorCorrectionEffect().Brightness = v76
        elseif v75 == "ccContrast" then
          makeColorCorrectionEffect().Contrast = v76
        elseif v75 == "ccSaturation" then
          makeColorCorrectionEffect().Saturation = v76
        elseif v75 == "ccTint" then
          makeColorCorrectionEffect().TintColor = v76
        else
          pcall(function() lighting[v75] = v76 end)
        end
      end
    end

    local function f26()
      if not v72 then
        return
      else
        for key13, value20 in pairs(v72) do
          local v77 = key13
          local v78 = value20

          if v77 == "sky" and v78 then
            local sky3 = lighting:FindFirstChildOfClass("Sky")

            if sky3 then
              for key14, value21 in pairs(v78) do
                local v79 = key14
                local v80 = value21
                pcall(function() sky3[v79] = v80 end)
              end
            end
          elseif v77 == "atmo" and v78 then
            local atmosphere2 = lighting:FindFirstChildOfClass("Atmosphere")

            if atmosphere2 then
              for key15, value22 in pairs(v78) do
                local v81 = key15
                local v82 = value22
                pcall(function() atmosphere2[v81] = v82 end)
              end
            end
          else
            pcall(function() lighting[v77] = v78 end)
          end
        end

        local bloomEffect = lighting:FindFirstChildOfClass("BloomEffect")

        if bloomEffect then
          bloomEffect.Enabled = false
        end

        local colorCorrectionEffect = lighting:FindFirstChildOfClass("ColorCorrectionEffect")

        if colorCorrectionEffect then
          colorCorrectionEffect.Enabled = false
        end

        return
      end
    end

    local v83 = {}

    for key16 in pairs(v73) do
      table.insert(v83, key16)
    end

    table.sort(v83)

    local espTab = stxHUBWindow:Tab({ Title = "ESP", Icon = "eye" })
    espTab:Section({ Title = "Master" })

    espTab:Toggle({
      Title = "Enable ESP",
      Value = false,
      Callback = function(value23) v14.ESP = value23 end,
    })

    espTab:Slider({
      Title = "Max Distance",
      Step = 50,
      Value = { Min = 50, Max = 5000, Default = 1000 },
      Callback = function(value24) v14.MaxDistance = value24 end,
    })

    espTab:Section({ Title = "Visuals" })

    espTab:Toggle({
      Title = "Box",
      Value = false,
      Callback = function(value25) v14.Box = value25 end,
    })

    espTab:Colorpicker({
      Title = "Box Color",
      Default = a855F7,
      Callback = function(value26) v14.BoxColor = value26 end,
    })

    espTab:Toggle({
      Title = "Name",
      Value = false,
      Callback = function(value27) v14.Name = value27 end,
    })

    espTab:Colorpicker({
      Title = "Name Color",
      Default = c4B5FD,
      Callback = function(value28) v14.NameColor = value28 end,
    })

    espTab:Toggle({
      Title = "Distance",
      Value = false,
      Callback = function(value29) v14.Distance = value29 end,
    })

    espTab:Colorpicker({
      Title = "Distance Color",
      Default = d8B4FE,
      Callback = function(value30) v14.DistanceColor = value30 end,
    })

    espTab:Toggle({
      Title = "Tracers",
      Value = false,
      Callback = function(value31) v14.Tracer = value31 end,
    })

    espTab:Colorpicker({
      Title = "Tracer Color",
      Default = a855F7,
      Callback = function(value32) v14.TracerColor = value32 end,
    })

    espTab:Toggle({
      Title = "Highlight",
      Value = false,
      Callback = function(value33) v14.Highlight = value33 end,
    })

    espTab:Colorpicker({
      Title = "Highlight Color",
      Default = a855F7,
      Callback = function(value34)
        v14.HighlightColor = value34

        for key17, value35 in pairs(v16) do
          value35.FillColor = value34
          value35.OutlineColor = value34
        end
      end,
    })

    espTab:Section({ Title = "Filters" })

    espTab:Toggle({
      Title = "Team Check",
      Value = true,
      Callback = function(value36) v14.TeamCheck = value36 end,
    })

    espTab:Toggle({
      Title = "Visible Check",
      Value = true,
      Callback = function(value37) v14.VisibleCheck = value37 end,
    })

    espTab:Toggle({
      Title = "Ignore ForceField",
      Value = true,
      Callback = function(value38) v14.IgnoreFF = value38 end,
    })

    local aimbotTab = stxHUBWindow:Tab({ Title = "Aimbot", Icon = "crosshair" })
    aimbotTab:Section({ Title = "Master" })

    aimbotTab:Toggle({
      Title = "Enable Aimbot",
      Value = false,
      Callback = function(value39)
        v14.Aim = value39

        if not value39 then
          v62 = nil
          v61 = nil
          lookVector = nil
          v18 = 0
        end
      end,
    })

    aimbotTab:Toggle({
      Title = "Auto Aim (no key)",
      Value = touchEnabled,
      Callback = function(value40) v14.AimAuto = value40 end,
    })

    aimbotTab:Keybind({
      Title = "Aim Key (hold)",
      Value = "E",
      Callback = function(value41)
        local v84 = Enum.KeyCode[value41]

        if v84 then
          v14.AimKey = v84
        end
      end,
    })

    aimbotTab:Section({ Title = "Aim Method" })

    aimbotTab:Toggle({
      Title = "Use Mouse-Look",
      Value = true,
      Callback = function(value42) v14.UseMouseLook = value42 end,
    })

    aimbotTab:Toggle({
      Title = "Use CFrame (fallback)",
      Value = false,
      Callback = function(value43) v14.UseCFrame = value43 end,
    })

    aimbotTab:Toggle({
      Title = "Invert X",
      Value = false,
      Callback = function(value44) v14.InvertX = value44 end,
    })

    aimbotTab:Toggle({
      Title = "Invert Y",
      Value = false,
      Callback = function(value45) v14.InvertY = value45 end,
    })

    aimbotTab:Slider({
      Title = "Gain",
      Step = 0.1,
      Value = { Min = 0.2, Max = 5, Default = 1 },
      Callback = function(value46) v14.Gain = value46 end,
    })

    aimbotTab:Section({ Title = "Targeting" })

    aimbotTab:Dropdown({
      Title = "Bone",
      Values = { "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart" },
      Value = "Head",
      Callback = function(value47) v14.AimBone = value47 end,
    })

    aimbotTab:Slider({
      Title = "FOV Radius",
      Step = 5,
      Suffix = "px",
      Value = { Min = 20, Max = 800, Default = v14.AimFOV },
      Callback = function(value48) v14.AimFOV = value48 end,
    })

    aimbotTab:Slider({
      Title = "Max Distance",
      Step = 50,
      Suffix = "studs",
      Value = { Min = 50, Max = 5000, Default = 1500 },
      Callback = function(value49) v14.AimMaxDist = value49 end,
    })

    aimbotTab:Slider({
      Title = "Smoothing",
      Step = 0.5,
      Value = { Min = 1, Max = 20, Default = v14.AimSmooth },
      Callback = function(value50) v14.AimSmooth = value50 end,
    })

    aimbotTab:Slider({
      Title = "Sticky Lock (sec)",
      Step = 0.1,
      Suffix = "s",
      Value = { Min = 0.2, Max = 5, Default = 1.5 },
      Callback = function(value51) v14.GraceTime = value51 end,
    })

    local fovTab = stxHUBWindow:Tab({ Title = "FOV", Icon = "circle" })

    fovTab:Toggle({
      Title = "Show FOV Circle",
      Value = true,
      Callback = function(value52) v14.AimShowFOV = value52 end,
    })

    fovTab:Colorpicker({
      Title = "Circle Color",
      Default = a855F7,
      Callback = function(value53) v14.AimFOVColor = value53 end,
    })

    fovTab:Slider({
      Title = "Thickness",
      Step = 0.5,
      Value = { Min = 1, Max = 8, Default = v14.AimFOVThick },
      Callback = function(value54) v14.AimFOVThick = value54 end,
    })

    local skyTab = stxHUBWindow:Tab({ Title = "Sky", Icon = "cloud" })
    skyTab:Section({ Title = "Presets" })

    skyTab:Dropdown({
      Title = "Sky Preset",
      Values = v83,
      Value = "Default",
      Callback = function(value55)
        f25(value55)
        dist:Notify({ Title = "Sky", Content = "Applied: " .. value55, Duration = 2 })
      end,
    })

    skyTab:Button({ Title = "Purple Dream (STX)", Callback = function() f25("Purple") end })
    skyTab:Button({ Title = "Restore Original", Callback = function() f26() end })
    skyTab:Section({ Title = "Lighting" })

    skyTab:Colorpicker({
      Title = "Ambient",
      Default = lighting.Ambient,
      Callback = function(value56) lighting.Ambient = value56 end,
    })

    skyTab:Colorpicker({
      Title = "Outdoor Ambient",
      Default = lighting.OutdoorAmbient,
      Callback = function(value57) lighting.OutdoorAmbient = value57 end,
    })

    skyTab:Slider({
      Title = "Brightness",
      Step = 0.1,
      Value = { Min = 0, Max = 10, Default = lighting.Brightness },
      Callback = function(value58) lighting.Brightness = value58 end,
    })

    skyTab:Slider({
      Title = "Clock Time",
      Step = 0.5,
      Value = { Min = 0, Max = 24, Default = lighting.ClockTime },
      Callback = function(value59) lighting.ClockTime = value59 end,
    })

    skyTab:Slider({
      Title = "Fog End",
      Step = 100,
      Value = { Min = 0, Max = 100000, Default = lighting.FogEnd },
      Callback = function(value60) lighting.FogEnd = value60 end,
    })

    skyTab:Slider({
      Title = "Fog Start",
      Step = 10,
      Value = { Min = 0, Max = 100000, Default = lighting.FogStart },
      Callback = function(value61) lighting.FogStart = value61 end,
    })

    skyTab:Colorpicker({
      Title = "Fog Color",
      Default = lighting.FogColor,
      Callback = function(value62) lighting.FogColor = value62 end,
    })

    skyTab:Slider({
      Title = "Exposure",
      Step = 0.05,
      Value = { Min = -3, Max = 3, Default = lighting.ExposureCompensation },
      Callback = function(value63) lighting.ExposureCompensation = value63 end,
    })

    skyTab:Section({ Title = "Atmosphere" })

    skyTab:Slider({
      Title = "Density",
      Step = 0.01,
      Value = { Min = 0, Max = 1, Default = 0.3 },
      Callback = function(value64) makeAtmosphere().Density = value64 end,
    })

    skyTab:Slider({
      Title = "Haze",
      Step = 0.1,
      Value = { Min = 0, Max = 10, Default = 0 },
      Callback = function(value65) makeAtmosphere().Haze = value65 end,
    })

    skyTab:Slider({
      Title = "Glare",
      Step = 0.1,
      Value = { Min = 0, Max = 10, Default = 0 },
      Callback = function(value66) makeAtmosphere().Glare = value66 end,
    })

    skyTab:Colorpicker({
      Title = "Atmo Color",
      Default = Color3.fromRGB(199, 199, 199),
      Callback = function(value67) makeAtmosphere().Color = value67 end,
    })

    skyTab:Section({ Title = "Skybox" })

    skyTab:Slider({
      Title = "Star Count",
      Step = 100,
      Value = { Min = 0, Max = 30000, Default = 3000 },
      Callback = function(value68) makeSky().StarCount = value68 end,
    })

    skyTab:Slider({
      Title = "Sun Size",
      Step = 0.5,
      Value = { Min = 0, Max = 100, Default = 21 },
      Callback = function(value69) makeSky().SunAngularSize = value69 end,
    })

    skyTab:Slider({
      Title = "Moon Size",
      Step = 0.5,
      Value = { Min = 0, Max = 100, Default = 11 },
      Callback = function(value70) makeSky().MoonAngularSize = value70 end,
    })

    skyTab:Section({ Title = "Post-FX" })

    skyTab:Toggle({
      Title = "Bloom",
      Value = false,
      Callback = function(value71) makeBloomEffect().Enabled = value71 end,
    })

    skyTab:Slider({
      Title = "Bloom Intensity",
      Step = 0.1,
      Value = { Min = 0, Max = 5, Default = 0.5 },
      Callback = function(value72) makeBloomEffect().Intensity = value72 end,
    })

    skyTab:Slider({
      Title = "Bloom Size",
      Step = 1,
      Value = { Min = 0, Max = 100, Default = 24 },
      Callback = function(value73) makeBloomEffect().Size = value73 end,
    })

    skyTab:Toggle({
      Title = "Color Correction",
      Value = false,
      Callback = function(value74) makeColorCorrectionEffect().Enabled = value74 end,
    })

    skyTab:Slider({
      Title = "CC Brightness",
      Step = 0.05,
      Value = { Min = -1, Max = 1, Default = 0 },
      Callback = function(value75) makeColorCorrectionEffect().Brightness = value75 end,
    })

    skyTab:Slider({
      Title = "CC Contrast",
      Step = 0.05,
      Value = { Min = -1, Max = 1, Default = 0 },
      Callback = function(value76) makeColorCorrectionEffect().Contrast = value76 end,
    })

    skyTab:Slider({
      Title = "CC Saturation",
      Step = 0.05,
      Value = { Min = -1, Max = 1, Default = 0 },
      Callback = function(value77) makeColorCorrectionEffect().Saturation = value77 end,
    })

    skyTab:Colorpicker({
      Title = "CC Tint",
      Default = Color3.fromRGB(255, 255, 255),
      Callback = function(value78) makeColorCorrectionEffect().TintColor = value78 end,
    })

    _G.STXHub = {
      Stop = function()
        pcall(function() runService:UnbindFromRenderStep("STXAimBind") end)
        pcall(function() currentCamera.CameraType = cameraType or Enum.CameraType.Custom end)

        for key18 in pairs(v15) do
          f11(key18)
        end

        f15()

        if v36 then
          pcall(function() v36:Remove() end)
        end
      end,
      RestoreSky = f26,
      ApplySkyPreset = f25,
    }
  end)

  if not v8 then
    warn("[STX] Setup error:", v9)
  end
end

local v85 = true
makeHighlight()
stxAuth:Destroy()

print("[STX] Auth screen ready")


