local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local lighting = game:GetService("Lighting")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local contentProvider = game:GetService("ContentProvider")
local workspaceService = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local waitForChild = replicatedStorage:WaitForChild("Time", 5)
local waitForChild2 = localPlayer:WaitForChild("GlobalTime", 5)

if waitForChild then
  waitForChild:WaitForChild("DayType", 5)
end

if waitForChild then
  waitForChild:WaitForChild("Wind", 5)
end

lighting:WaitForChild("Atmosphere")

local v1 = {
  SizeX = 350,
  SizeY = 350,
  OffsetX = 0,
  OffsetY = -40,
}

local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 0
blurEffect.Parent = lighting

local v2 = {
  Gotham = Enum.Font.GothamMedium,
  Montserrat = Enum.Font.Montserrat,
  Code = Enum.Font.Code,
  SourceSans = Enum.Font.SourceSansBold,
}

local v3 = {
  ["Impact Dark"] = {
    Header = Color3.fromRGB(20, 20, 24),
    HeaderTransparency = 0.3,
    WindowBG = Color3.fromRGB(12, 12, 14),
    WindowTransparency = 0.4,
    ElementBG = Color3.fromRGB(26, 26, 32),
    ElementTransparency = 0.05,
    Accent = Color3.fromRGB(255, 255, 255),
    Text = Color3.fromRGB(240, 240, 240),
    ActiveText = Color3.fromRGB(15, 15, 18),
    SubText = Color3.fromRGB(160, 160, 170),
  },
  ["Dark Purple"] = {
    Header = Color3.fromRGB(28, 20, 36),
    HeaderTransparency = 0.2,
    WindowBG = Color3.fromRGB(16, 12, 22),
    WindowTransparency = 0.35,
    ElementBG = Color3.fromRGB(34, 24, 44),
    ElementTransparency = 0.05,
    Accent = Color3.fromRGB(170, 85, 255),
    Text = Color3.fromRGB(240, 240, 240),
    ActiveText = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(170, 160, 190),
  },
  ["Midnight Blue"] = {
    Header = Color3.fromRGB(18, 28, 42),
    HeaderTransparency = 0.2,
    WindowBG = Color3.fromRGB(12, 18, 28),
    WindowTransparency = 0.35,
    ElementBG = Color3.fromRGB(22, 32, 48),
    ElementTransparency = 0.05,
    Accent = Color3.fromRGB(60, 150, 255),
    Text = Color3.fromRGB(240, 240, 240),
    ActiveText = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(150, 170, 200),
  },
  Emerald = {
    Header = Color3.fromRGB(18, 36, 26),
    HeaderTransparency = 0.2,
    WindowBG = Color3.fromRGB(12, 24, 18),
    WindowTransparency = 0.35,
    ElementBG = Color3.fromRGB(20, 40, 30),
    ElementTransparency = 0.05,
    Accent = Color3.fromRGB(45, 215, 125),
    Text = Color3.fromRGB(240, 240, 240),
    ActiveText = Color3.fromRGB(15, 25, 20),
    SubText = Color3.fromRGB(150, 190, 170),
  },
}

local gotham = v2.Gotham
local impactDark = v3["Impact Dark"]
local rightShift = Enum.KeyCode.RightShift
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = {}
local v8 = {}
local v9 = {}

local v10 = {
  Box = Color3.fromRGB(255, 255, 255),
  Chams = Color3.fromRGB(255, 80, 80),
  Name = Color3.fromRGB(255, 255, 255),
  Distance = Color3.fromRGB(200, 200, 200),
  Tools = Color3.fromRGB(255, 220, 100),
  Tracers = Color3.fromRGB(255, 255, 255),
  Arrows = Color3.fromRGB(255, 220, 50),
  FOV = Color3.fromRGB(75, 180, 255),
}

local function f1(p1, p2)
  local inputBegan = p1.InputBegan
  local v11, position, position2

  inputBegan:Connect(function(p3)
    if p3.UserInputType == Enum.UserInputType.MouseButton1 then
      v11 = true
      position = p3.Position
      position2 = p2.Position

      p3.Changed:Connect(function()
        if p3.UserInputState == Enum.UserInputState.End then
          v11 = false
        end
      end)
    end
  end)

  local v12

  p1.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
      v12 = input
    end
  end)

  local inputChanged = userInputService.InputChanged

  table.insert(v7, inputChanged:Connect(function(p4)
    if p4 == v12 and v11 then
      local v13 = p4.Position - position

      p2.Position = UDim2.new(
        position2.X.Scale, position2.X.Offset + v13.X, position2.Y.Scale,
        position2.Y.Offset + v13.Y
      )
    end
  end))
end

local spectreWatermark, keybindsPanel, frame, header, username, performance

local function f2()
  for index, value in ipairs(v4) do
    value.Header.BackgroundColor3 = impactDark.Header
    value.Header.BackgroundTransparency = impactDark.HeaderTransparency
    value.Main.BackgroundColor3 = impactDark.WindowBG
    value.Main.BackgroundTransparency = impactDark.WindowTransparency
  end

  if keybindsPanel and frame and header then
    frame.BackgroundColor3 = impactDark.WindowBG
    header.TextColor3 = impactDark.Text
    header.Font = gotham
  end

  if spectreWatermark then
    spectreWatermark.BackgroundColor3 = impactDark.WindowBG

    if username then
      username.Font = gotham
      username.TextColor3 = impactDark.Text
    end

    if performance then
      performance.Font = gotham
    end
  end

  for index2, value2 in ipairs(v6) do
    if value2 and value2.Parent then
      value2.Font = gotham
    end
  end

  for index3, value3 in ipairs(v5) do
    if value3.Type == "Toggle" then
      local btn = value3.Btn
      btn.BackgroundColor3 = value3.GetState() and impactDark.Accent or impactDark.ElementBG

      local btn2 = value3.Btn
      btn2.TextColor3 = value3.GetState() and impactDark.ActiveText or impactDark.Text
    elseif value3.Type == "Slider" then
      value3.Container.BackgroundColor3 = impactDark.ElementBG
      value3.Fill.BackgroundColor3 = impactDark.Accent
    elseif value3.Type == "Dropdown" then
      value3.Container.BackgroundColor3 = impactDark.ElementBG
    end
  end
end

local visible = true
local v14 = false

local function f3(textLabel, canvasGroup, p5, p6)
  local inputBegan2 = textLabel.InputBegan
  local v15, position3, size

  inputBegan2:Connect(function(p7)
    if p7.UserInputType == Enum.UserInputType.MouseButton1 then
      v15 = true
      position3 = p7.Position
      size = canvasGroup.Size

      p7.Changed:Connect(function()
        if p7.UserInputState == Enum.UserInputState.End then
          v15 = false
        end
      end)
    end
  end)

  local inputChanged2 = userInputService.InputChanged

  table.insert(v7, inputChanged2:Connect(function(p8)
    if v15 and p8.UserInputType == Enum.UserInputType.MouseMovement then
      local v16 = p8.Position - position3

      canvasGroup.Size = UDim2.new(
        0, math.max(p5 or 190, size.X.Offset + v16.X), 0,
        math.max(p6 or 130, size.Y.Offset + v16.Y)
      )
    end
  end))
end

local spectreWareImpactUI

local function makeTextButton(text, p9, p10)
  local canvasGroup2 = Instance.new("CanvasGroup")
  canvasGroup2.Name = text .. "Window"
  canvasGroup2.Size = UDim2.new(0, p10 or 210, 0, 310)
  canvasGroup2.Position = UDim2.new(0, p9, 0, 60)
  canvasGroup2.BackgroundTransparency = 1
  canvasGroup2.GroupTransparency = 1
  canvasGroup2.Visible = false
  canvasGroup2.Parent = spectreWareImpactUI

  local frame2 = Instance.new("Frame")
  frame2.Size = UDim2.new(1, 0, 1, 0)
  frame2.BackgroundColor3 = impactDark.WindowBG
  frame2.BackgroundTransparency = impactDark.WindowTransparency
  frame2.BorderSizePixel = 0
  frame2.Parent = canvasGroup2

  local uiCorner = Instance.new("UICorner")
  uiCorner.CornerRadius = UDim.new(0, 5)
  uiCorner.Parent = frame2

  local header2 = Instance.new("Frame")
  header2.Name = "Header"
  header2.Size = UDim2.new(1, 0, 0, 30)
  header2.BackgroundColor3 = impactDark.Header
  header2.BackgroundTransparency = impactDark.HeaderTransparency
  header2.BorderSizePixel = 0
  header2.Parent = frame2

  local uiCorner2 = Instance.new("UICorner")
  uiCorner2.CornerRadius = UDim.new(0, 5)
  uiCorner2.Parent = header2

  local textLabel2 = Instance.new("TextLabel")
  textLabel2.Size = UDim2.new(1, -30, 1, 0)
  textLabel2.Position = UDim2.new(0, 12, 0, 0)
  textLabel2.BackgroundTransparency = 1
  textLabel2.Text = text
  textLabel2.TextColor3 = impactDark.Text
  textLabel2.TextSize = 13
  textLabel2.Font = gotham
  textLabel2.TextXAlignment = Enum.TextXAlignment.Left
  textLabel2.Parent = header2

  table.insert(v6, textLabel2)

  local textButton = Instance.new("TextButton")
  textButton.Size = UDim2.new(0, 26, 1, 0)
  textButton.Position = UDim2.new(1, -26, 0, 0)
  textButton.BackgroundTransparency = 1
  textButton.Text = "▼"
  textButton.TextColor3 = impactDark.SubText
  textButton.TextSize = 11
  textButton.Font = gotham
  textButton.Parent = header2

  table.insert(v6, textButton)

  local container = Instance.new("ScrollingFrame")
  container.Name = "Container"
  container.Size = UDim2.new(1, -8, 1, -36)
  container.Position = UDim2.new(0, 4, 0, 32)
  container.BackgroundTransparency = 1
  container.BorderSizePixel = 0
  container.ScrollBarThickness = 3
  container.ScrollBarImageColor3 = impactDark.Accent
  container.Parent = frame2

  local uiListLayout = Instance.new("UIListLayout")
  uiListLayout.Parent = container
  uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout.Padding = UDim.new(0, 5)

  local uiPadding = Instance.new("UIPadding")
  uiPadding.PaddingTop = UDim.new(0, 4)
  uiPadding.PaddingBottom = UDim.new(0, 4)
  uiPadding.PaddingLeft = UDim.new(0, 4)
  uiPadding.PaddingRight = UDim.new(0, 4)
  uiPadding.Parent = container

  local textLabel3 = Instance.new("TextLabel")
  textLabel3.Size = UDim2.new(0, 14, 0, 14)
  textLabel3.Position = UDim2.new(1, -14, 1, -14)
  textLabel3.BackgroundTransparency = 1
  textLabel3.Text = "◢"
  textLabel3.TextColor3 = Color3.fromRGB(120, 120, 130)
  textLabel3.TextSize = 10
  textLabel3.Font = gotham
  textLabel3.ZIndex = 10
  textLabel3.Parent = frame2

  table.insert(v6, textLabel3)
  f1(header2, canvasGroup2)
  f3(textLabel3, canvasGroup2, 190, 120)

  table.insert(v4, {
    Group = canvasGroup2,
    Header = header2,
    Main = frame2,
    Container = container,
  })

  uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    container.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 8)
  end)

  local v17 = false
  local offset = 310

  textButton.MouseButton1Click:Connect(function()
    v17 = not v17
    textButton.Text = v17 and "▲" or "▼"

    if v17 then
      offset = canvasGroup2.Size.Y.Offset

      tweenService:Create(canvasGroup2, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
        Size = UDim2.new(0, canvasGroup2.Size.X.Offset, 0, 30),
      }):Play()
    else
      tweenService:Create(canvasGroup2, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
        Size = UDim2.new(0, canvasGroup2.Size.X.Offset, 0, offset),
      }):Play()
    end
  end)

  return container
end

local v18 = {}
local rows

local function makeTextLabel()
  if not rows then
    return
  else
    for index4, value4 in ipairs(rows:GetChildren()) do
      if value4:IsA("TextLabel") then
        value4:Destroy()
      end
    end

    local count = 0

    for index5, value5 in ipairs(v18) do
      if value5.Key then
        count = count + 1

        local textLabel4 = Instance.new("TextLabel")
        textLabel4.Name = "Bind_" .. value5.Name
        textLabel4.Size = UDim2.new(1, 0, 0, 22)
        textLabel4.BackgroundColor3 = impactDark.ElementBG
        textLabel4.BackgroundTransparency = 0
        textLabel4.BorderSizePixel = 0

        textLabel4.Text = string.format(
          "  %s     [%s]   %s", value5.Name, value5.Key.Name, value5.State and "ON" or "OFF"
        )

        textLabel4.TextColor3 = impactDark.SubText
        textLabel4.TextSize = 10
        textLabel4.Font = gotham
        textLabel4.TextXAlignment = Enum.TextXAlignment.Left
        textLabel4.TextTruncate = Enum.TextTruncate.AtEnd
        textLabel4.LayoutOrder = count
        textLabel4.ZIndex = 67
        textLabel4.Parent = rows

        local uiCorner3 = Instance.new("UICorner")
        uiCorner3.CornerRadius = UDim.new(0, 4)
        uiCorner3.Parent = textLabel4
      end
    end

    rows.Size = UDim2.new(1, -16, 0, count * 25)
    keybindsPanel.Size = UDim2.new(0, 220, 0, math.max(38, 36 + count * 25))

    local v19 = keybindsPanel
    v19.Visible = v14 and count > 0

    return
  end
end

local colorPickerPopup, colorBox, hueSlider, frame3, frame4

local function makeTextButton2()
  if spectreWareImpactUI then
    pcall(function() spectreWareImpactUI:Destroy() end)
  end

  v4 = {}
  v5 = {}
  v6 = {}

  spectreWareImpactUI = Instance.new("ScreenGui")
  spectreWareImpactUI.Name = "SpectreWareImpactUI"
  spectreWareImpactUI.ResetOnSpawn = false
  spectreWareImpactUI.IgnoreGuiInset = true

  pcall(function() spectreWareImpactUI.Parent = coreGui end)

  if not spectreWareImpactUI.Parent then
    spectreWareImpactUI.Parent = localPlayer:WaitForChild("PlayerGui")
  end

  colorPickerPopup = Instance.new("Frame")
  colorPickerPopup.Name = "ColorPickerPopup"
  colorPickerPopup.Size = UDim2.fromOffset(210, 175)
  colorPickerPopup.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
  colorPickerPopup.BorderSizePixel = 0
  colorPickerPopup.Visible = false
  colorPickerPopup.ZIndex = 200
  colorPickerPopup.Parent = spectreWareImpactUI

  local uiCorner4 = Instance.new("UICorner")
  uiCorner4.CornerRadius = UDim.new(0, 6)
  uiCorner4.Parent = colorPickerPopup

  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = Color3.fromRGB(60, 60, 75)
  uiStroke.Thickness = 1
  uiStroke.Parent = colorPickerPopup

  local frame5 = Instance.new("Frame")
  frame5.Size = UDim2.new(1, 0, 0, 24)
  frame5.BackgroundColor3 = Color3.fromRGB(26, 26, 34)
  frame5.BorderSizePixel = 0
  frame5.ZIndex = 201
  frame5.Parent = colorPickerPopup

  local uiCorner5 = Instance.new("UICorner")
  uiCorner5.CornerRadius = UDim.new(0, 6)
  uiCorner5.Parent = frame5

  local textLabel5 = Instance.new("TextLabel")
  textLabel5.Size = UDim2.new(1, -25, 1, 0)
  textLabel5.Position = UDim2.fromOffset(8, 0)
  textLabel5.BackgroundTransparency = 1
  textLabel5.Text = "Color Picker"
  textLabel5.TextColor3 = Color3.fromRGB(220, 220, 230)
  textLabel5.TextSize = 11
  textLabel5.Font = Enum.Font.GothamMedium
  textLabel5.TextXAlignment = Enum.TextXAlignment.Left
  textLabel5.ZIndex = 202
  textLabel5.Parent = frame5

  local textButton2 = Instance.new("TextButton")
  textButton2.Size = UDim2.fromOffset(24, 24)
  textButton2.Position = UDim2.new(1, -24, 0, 0)
  textButton2.BackgroundTransparency = 1
  textButton2.Text = ""
  textButton2.ZIndex = 202
  textButton2.Parent = frame5

  local frame6 = Instance.new("Frame")
  frame6.Size = UDim2.new(0, 10, 0, 2)
  frame6.AnchorPoint = Vector2.new(0.5, 0.5)
  frame6.Position = UDim2.new(0.5, 0, 0.5, 0)
  frame6.Rotation = 45
  frame6.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
  frame6.BorderSizePixel = 0
  frame6.ZIndex = 203
  frame6.Parent = textButton2

  local frame7 = Instance.new("Frame")
  frame7.Size = UDim2.new(0, 10, 0, 2)
  frame7.AnchorPoint = Vector2.new(0.5, 0.5)
  frame7.Position = UDim2.new(0.5, 0, 0.5, 0)
  frame7.Rotation = -45
  frame7.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
  frame7.BorderSizePixel = 0
  frame7.ZIndex = 203
  frame7.Parent = textButton2

  textButton2.MouseButton1Click:Connect(function() colorPickerPopup.Visible = false end)

  colorBox = Instance.new("TextButton")
  colorBox.Name = "ColorBox"
  colorBox.Size = UDim2.new(1, -16, 0, 105)
  colorBox.Position = UDim2.fromOffset(8, 32)
  colorBox.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
  colorBox.AutoButtonColor = false
  colorBox.Text = ""
  colorBox.BorderSizePixel = 0
  colorBox.ZIndex = 201
  colorBox.Parent = colorPickerPopup

  local uiCorner6 = Instance.new("UICorner")
  uiCorner6.CornerRadius = UDim.new(0, 4)
  uiCorner6.Parent = colorBox

  local uiGradient = Instance.new("UIGradient")

  uiGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
  })

  uiGradient.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 1))
  uiGradient.Parent = colorBox

  local frame8 = Instance.new("Frame")
  frame8.Size = UDim2.new(1, 0, 1, 0)
  frame8.BackgroundTransparency = 0
  frame8.BorderSizePixel = 0
  frame8.ZIndex = 202
  frame8.Parent = colorBox

  local uiCorner7 = Instance.new("UICorner")
  uiCorner7.CornerRadius = UDim.new(0, 4)
  uiCorner7.Parent = frame8

  local uiGradient2 = Instance.new("UIGradient")
  uiGradient2.Rotation = 90

  uiGradient2.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
  })

  uiGradient2.Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(0, 0, 0))
  uiGradient2.Parent = frame8

  frame3 = Instance.new("Frame")
  frame3.Size = UDim2.fromOffset(8, 8)
  frame3.AnchorPoint = Vector2.new(0.5, 0.5)
  frame3.BackgroundColor3 = Color3.new(1, 1, 1)
  frame3.BorderSizePixel = 0
  frame3.ZIndex = 203
  frame3.Parent = colorBox

  local uiCorner8 = Instance.new("UICorner")
  uiCorner8.CornerRadius = UDim.new(1, 0)
  uiCorner8.Parent = frame3

  local uiStroke2 = Instance.new("UIStroke")
  uiStroke2.Color = Color3.new(0, 0, 0)
  uiStroke2.Thickness = 1
  uiStroke2.Parent = frame3

  hueSlider = Instance.new("TextButton")
  hueSlider.Name = "HueSlider"
  hueSlider.Size = UDim2.new(1, -16, 0, 14)
  hueSlider.Position = UDim2.fromOffset(8, 146)
  hueSlider.BackgroundColor3 = Color3.new(1, 1, 1)
  hueSlider.AutoButtonColor = false
  hueSlider.Text = ""
  hueSlider.BorderSizePixel = 0
  hueSlider.ZIndex = 201
  hueSlider.Parent = colorPickerPopup

  local uiCorner9 = Instance.new("UICorner")
  uiCorner9.CornerRadius = UDim.new(0, 3)
  uiCorner9.Parent = hueSlider

  local uiGradient3 = Instance.new("UIGradient")

  uiGradient3.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
  })

  uiGradient3.Parent = hueSlider

  frame4 = Instance.new("Frame")
  frame4.Size = UDim2.fromOffset(4, 18)
  frame4.AnchorPoint = Vector2.new(0.5, 0.5)
  frame4.Position = UDim2.new(0, 0, 0.5, 0)
  frame4.BackgroundColor3 = Color3.new(1, 1, 1)
  frame4.BorderSizePixel = 0
  frame4.ZIndex = 202
  frame4.Parent = hueSlider

  local uiCorner10 = Instance.new("UICorner")
  uiCorner10.CornerRadius = UDim.new(0, 2)
  uiCorner10.Parent = frame4

  local uiStroke3 = Instance.new("UIStroke")
  uiStroke3.Color = Color3.new(0, 0, 0)
  uiStroke3.Thickness = 1
  uiStroke3.Parent = frame4

  spectreWatermark = Instance.new("Frame")
  spectreWatermark.Name = "SpectreWatermark"
  spectreWatermark.Size = UDim2.new(0, 300, 0, 44)
  spectreWatermark.Position = UDim2.new(1, -316, 0, 12)
  spectreWatermark.BackgroundColor3 = impactDark.WindowBG
  spectreWatermark.BackgroundTransparency = 0.04
  spectreWatermark.BorderSizePixel = 0
  spectreWatermark.Visible = visible
  spectreWatermark.ZIndex = 60
  spectreWatermark.Parent = spectreWareImpactUI

  local uiCorner11 = Instance.new("UICorner")
  uiCorner11.CornerRadius = UDim.new(0, 9)
  uiCorner11.Parent = spectreWatermark

  local uiStroke4 = Instance.new("UIStroke")
  uiStroke4.Color = Color3.fromRGB(58, 58, 66)
  uiStroke4.Thickness = 1
  uiStroke4.Transparency = 0.12
  uiStroke4.Parent = spectreWatermark

  local avatar = Instance.new("ImageLabel")
  avatar.Name = "Avatar"
  avatar.Size = UDim2.new(0, 34, 0, 34)
  avatar.Position = UDim2.new(0, 5, 0, 5)
  avatar.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
  avatar.BorderSizePixel = 0
  avatar.ScaleType = Enum.ScaleType.Crop
  avatar.ZIndex = 61
  avatar.Parent = spectreWatermark

  local uiCorner12 = Instance.new("UICorner")
  uiCorner12.CornerRadius = UDim.new(1, 0)
  uiCorner12.Parent = avatar

  local uiStroke5 = Instance.new("UIStroke")
  uiStroke5.Color = Color3.fromRGB(85, 85, 95)
  uiStroke5.Thickness = 1
  uiStroke5.Parent = avatar

  task.spawn(function()
    local v20, v21 = pcall(function()
      return players:GetUserThumbnailAsync(
        localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100
      )
    end)

    if v20 and v21 and avatar.Parent then
      avatar.Image = v21
    end
  end)

  username = Instance.new("TextLabel")
  username.Name = "Username"
  username.Size = UDim2.new(1, -50, 0, 18)
  username.Position = UDim2.new(0, 46, 0, 5)
  username.BackgroundTransparency = 1
  username.Text = localPlayer.Name
  username.TextColor3 = impactDark.Text
  username.TextSize = 12
  username.Font = gotham
  username.TextXAlignment = Enum.TextXAlignment.Left
  username.ZIndex = 61
  username.Parent = spectreWatermark

  performance = Instance.new("TextLabel")
  performance.Name = "Performance"
  performance.Size = UDim2.new(1, -50, 0, 15)
  performance.Position = UDim2.new(0, 46, 0, 23)
  performance.BackgroundTransparency = 1
  performance.Text = "FPS: --  |  PING: -- ms"
  performance.TextColor3 = Color3.fromRGB(190, 190, 200)
  performance.TextSize = 10
  performance.Font = gotham
  performance.TextXAlignment = Enum.TextXAlignment.Left
  performance.ZIndex = 61
  performance.Parent = spectreWatermark

  keybindsPanel = Instance.new("CanvasGroup")
  keybindsPanel.Name = "KeybindsPanel"
  keybindsPanel.Size = UDim2.new(0, 220, 0, 38)
  keybindsPanel.Position = UDim2.new(0, 18, 0, 90)
  keybindsPanel.BackgroundTransparency = 1
  keybindsPanel.GroupTransparency = 0.4
  keybindsPanel.Visible = false
  keybindsPanel.ZIndex = 65
  keybindsPanel.Parent = spectreWareImpactUI

  frame = Instance.new("Frame")
  frame.Size = UDim2.new(1, 0, 1, 0)
  frame.BackgroundColor3 = impactDark.WindowBG
  frame.BackgroundTransparency = 0.4
  frame.BorderSizePixel = 0
  frame.Parent = keybindsPanel

  local uiCorner13 = Instance.new("UICorner")
  uiCorner13.CornerRadius = UDim.new(0, 7)
  uiCorner13.Parent = frame

  local uiStroke6 = Instance.new("UIStroke")
  uiStroke6.Color = Color3.fromRGB(55, 55, 63)
  uiStroke6.Thickness = 1
  uiStroke6.Parent = frame

  header = Instance.new("TextLabel")
  header.Name = "Header"
  header.Size = UDim2.new(1, 0, 0, 28)
  header.Position = UDim2.new(0, 0, 0, 0)
  header.BackgroundTransparency = 1
  header.Text = "  Keybinds"
  header.TextColor3 = impactDark.Text
  header.TextSize = 12
  header.Font = gotham
  header.TextXAlignment = Enum.TextXAlignment.Left
  header.ZIndex = 66
  header.Parent = frame

  rows = Instance.new("Frame")
  rows.Name = "Rows"
  rows.Size = UDim2.new(1, -16, 0, 0)
  rows.Position = UDim2.new(0, 8, 0, 30)
  rows.BackgroundTransparency = 1
  rows.ZIndex = 66
  rows.Parent = frame

  local uiListLayout2 = Instance.new("UIListLayout")
  uiListLayout2.Padding = UDim.new(0, 3)
  uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout2.Parent = rows

  f1(spectreWatermark, spectreWatermark)
  f1(header, keybindsPanel)

  makeTextLabel()
end

makeTextButton2()

localPlayer.CharacterAdded:Connect(function(character)
  task.wait(0.8)

  if not spectreWareImpactUI or not spectreWareImpactUI.Parent then
    makeTextButton2()
  end
end)

local v22 = {}
local v23 = 0
local v24 = 1
local v25 = 1
local f4

local function f5()
  local color = Color3.fromHSV(v23, v24, v25)

  if f4 then
    f4(color)
  end
end

local v26 = false
local v27 = false

if colorBox then
  colorBox.MouseButton1Down:Connect(function() v26 = true end)
end

if hueSlider then
  hueSlider.MouseButton1Down:Connect(function() v27 = true end)
end

local inputChanged3 = userInputService.InputChanged

table.insert(v7, inputChanged3:Connect(function(p11)
  if p11.UserInputType == Enum.UserInputType.MouseMovement then
    local getMouseLocation = userInputService:GetMouseLocation()

    if v26 and colorBox then
      local absolutePosition = colorBox.AbsolutePosition
      local absoluteSize = colorBox.AbsoluteSize
      v24 = math.clamp((getMouseLocation.X - absolutePosition.X) / absoluteSize.X, 0, 1)
      v25 = math.clamp(1 - (getMouseLocation.Y - absolutePosition.Y) / absoluteSize.Y, 0, 1)

      if frame3 then
        frame3.Position = UDim2.new(v24, 0, 1 - v25, 0)
      end

      f5()
    elseif v27 and hueSlider then
      v23 = math.clamp((getMouseLocation.X - hueSlider.AbsolutePosition.X)
        / hueSlider.AbsoluteSize.X, 0, 1)

      if frame4 then
        frame4.Position = UDim2.new(v23, 0, 0.5, 0)
      end

      if colorBox then
        colorBox.BackgroundColor3 = Color3.fromHSV(v23, 1, 1)
      end

      f5()
    end
  end
end))

local inputEnded = userInputService.InputEnded

table.insert(v7, inputEnded:Connect(function(p12)
  if p12.UserInputType == Enum.UserInputType.MouseButton1 then
    v26 = false
    v27 = false
  end
end))

local v28

local function makeTextButton3(textButton3, color2, p13)
  local textButton4 = Instance.new("TextButton")
  textButton4.Size = UDim2.fromOffset(16, 16)
  textButton4.Position = UDim2.new(1, -22, 0.5, -8)
  textButton4.BackgroundColor3 = color2
  textButton4.BorderSizePixel = 0
  textButton4.Text = ""
  textButton4.ZIndex = 10
  textButton4.Parent = textButton3

  local uiCorner14 = Instance.new("UICorner")
  uiCorner14.CornerRadius = UDim.new(0, 3)
  uiCorner14.Parent = textButton4

  textButton4.MouseButton1Click:Connect(function()
    if colorPickerPopup.Visible and v28 == textButton4 then
      colorPickerPopup.Visible = false
      v28 = nil
    else
      local v29 = math.clamp(
        textButton4.AbsolutePosition.Y, 10, workspaceService.CurrentCamera.ViewportSize.Y - 190
      )

      colorPickerPopup.Position = UDim2.fromOffset(textButton4.AbsolutePosition.X + 25, v29)
      colorPickerPopup.Visible = true

      v28 = textButton4

      function f4(p14)
        textButton4.BackgroundColor3 = p14

        if p13 then
          p13(p14)
        end
      end

      local v30, v31
      v23, v30, v31 = color2:ToHSV()
      v24 = v30
      v25 = v31

      if colorBox then
        colorBox.BackgroundColor3 = Color3.fromHSV(v23, 1, 1)
      end

      if frame3 then
        frame3.Position = UDim2.new(v24, 0, 1 - v25, 0)
      end

      if frame4 then
        frame4.Position = UDim2.new(v23, 0, 0.5, 0)
      end
    end
  end)
end

function v22.AddToggle(parent, text2, p15, onChangeFunc, key)
  local textButton5 = Instance.new("TextButton")
  textButton5.Size = UDim2.new(1, 0, 0, 26)
  textButton5.BackgroundColor3 = p15 and impactDark.Accent or impactDark.ElementBG
  textButton5.BackgroundTransparency = p15 and 0 or impactDark.ElementTransparency
  textButton5.BorderSizePixel = 0
  textButton5.Text = "  > " .. text2
  textButton5.TextColor3 = p15 and impactDark.ActiveText or impactDark.Text
  textButton5.TextSize = 12
  textButton5.Font = gotham
  textButton5.TextXAlignment = Enum.TextXAlignment.Left
  textButton5.Parent = parent

  table.insert(v6, textButton5)

  local uiCorner15 = Instance.new("UICorner")
  uiCorner15.CornerRadius = UDim.new(0, 4)
  uiCorner15.Parent = textButton5

  local v32 = p15 or false
  local v33 = { Name = text2, Key = nil, State = v32 }
  table.insert(v18, v33)

  local textButton6 = Instance.new("TextButton")
  textButton6.Size = UDim2.new(0, 50, 0, 18)
  textButton6.Position = UDim2.new(1, key and -74 or -54, 0.5, -9)
  textButton6.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
  textButton6.BorderSizePixel = 0
  textButton6.Text = "[NONE]"
  textButton6.TextColor3 = impactDark.SubText
  textButton6.TextSize = 10
  textButton6.Font = gotham
  textButton6.Parent = textButton5

  local uiCorner16 = Instance.new("UICorner")
  uiCorner16.CornerRadius = UDim.new(0, 3)
  uiCorner16.Parent = textButton6

  if key then
    makeTextButton3(textButton5, v10[key] or Color3.new(1, 1, 1), function(p16)
      v10[key] = p16
    end)
  end

  local v34 = false

  textButton6.MouseButton1Click:Connect(function()
    v34 = true
    textButton6.Text = "[...]"
  end)

  local v35 = {
    Value = v32,
    OnChangeFunc = onChangeFunc,
    OnChanged = function(value6, onChangeFunc2) value6.OnChangeFunc = onChangeFunc2 end,
  }

  local inputBegan3 = userInputService.InputBegan
  local keyCode

  table.insert(v7, inputBegan3:Connect(function(text3, p17)
    if v34 then
      if text3.UserInputType == Enum.UserInputType.MouseButton1
        or text3.UserInputType == Enum.UserInputType.Keyboard
          and text3.KeyCode == Enum.KeyCode.Backspace then
        keyCode = nil
        v33.Key = nil
        textButton6.Text = "[NONE]"
        makeTextLabel()
        v34 = false
      elseif text3.UserInputType == Enum.UserInputType.Keyboard then
        keyCode = text3.KeyCode
        v33.Key = keyCode
        textButton6.Text = "[" .. text3.KeyCode.Name .. "]"
        makeTextLabel()
        v34 = false
      end
    elseif not p17 and keyCode and text3.UserInputType == Enum.UserInputType.Keyboard
      and text3.KeyCode == keyCode then
      v32 = not v32
      v35.Value = v32
      v33.State = v32
      makeTextLabel()

      tweenService:Create(textButton5, TweenInfo.new(0.15), {
        BackgroundColor3 = v32 and impactDark.Accent or impactDark.ElementBG,
        TextColor3 = v32 and impactDark.ActiveText or impactDark.Text,
      }):Play()

      if v35.OnChangeFunc then
        v35.OnChangeFunc(v32)
      end
    end
  end))

  table.insert(v5, {
    Type = "Toggle",
    Btn = textButton5,
    GetState = function() return v35.Value end,
  })

  textButton5.MouseButton1Click:Connect(function()
    if not v34 then
      v32 = not v32
      v35.Value = v32
      v33.State = v32
      makeTextLabel()

      tweenService:Create(textButton5, TweenInfo.new(0.15), {
        BackgroundColor3 = v32 and impactDark.Accent or impactDark.ElementBG,
        TextColor3 = v32 and impactDark.ActiveText or impactDark.Text,
      }):Play()

      if v35.OnChangeFunc then
        v35.OnChangeFunc(v32)
      end
    end
  end)

  return v35
end

function v22.AddSlider(parent2, text4, index6, index7, text5, onChangeFunc3)
  local frame9 = Instance.new("Frame")
  frame9.Size = UDim2.new(1, 0, 0, 38)
  frame9.BackgroundColor3 = impactDark.ElementBG
  frame9.BackgroundTransparency = impactDark.ElementTransparency
  frame9.BorderSizePixel = 0
  frame9.Parent = parent2

  local uiCorner17 = Instance.new("UICorner")
  uiCorner17.CornerRadius = UDim.new(0, 4)
  uiCorner17.Parent = frame9

  local textLabel6 = Instance.new("TextLabel")
  textLabel6.Size = UDim2.new(1, -10, 0, 16)
  textLabel6.Position = UDim2.new(0, 8, 0, 2)
  textLabel6.BackgroundTransparency = 1
  textLabel6.Text = "> " .. text4 .. ": " .. tostring(text5)
  textLabel6.TextColor3 = impactDark.SubText
  textLabel6.TextSize = 11
  textLabel6.Font = gotham
  textLabel6.TextXAlignment = Enum.TextXAlignment.Left
  textLabel6.Parent = frame9

  table.insert(v6, textLabel6)

  local frame10 = Instance.new("Frame")
  frame10.Size = UDim2.new(1, -16, 0, 5)
  frame10.Position = UDim2.new(0, 8, 0, 24)
  frame10.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
  frame10.BorderSizePixel = 0
  frame10.Parent = frame9

  local uiCorner18 = Instance.new("UICorner")
  uiCorner18.CornerRadius = UDim.new(0, 3)
  uiCorner18.Parent = frame10

  local frame11 = Instance.new("Frame")
  frame11.Size = UDim2.new((text5 - index6) / (index7 - index6), 0, 1, 0)
  frame11.BackgroundColor3 = impactDark.Accent
  frame11.BorderSizePixel = 0
  frame11.Parent = frame10

  local uiCorner19 = Instance.new("UICorner")
  uiCorner19.CornerRadius = UDim.new(0, 3)
  uiCorner19.Parent = frame11

  table.insert(v5, { Type = "Slider", Container = frame9, Fill = frame11 })

  local v36 = {
    Value = text5,
    OnChangeFunc = onChangeFunc3,
    OnChanged = function(value7, onChangeFunc4) value7.OnChangeFunc = onChangeFunc4 end,
  }

  local v37 = false

  local function f6(p18)
    local v38 = math.clamp(
      (p18.Position.X - frame10.AbsolutePosition.X) / frame10.AbsoluteSize.X, 0, 1
    )

    v36.Value = math.floor(index6 + (index7 - index6) * v38)
    frame11.Size = UDim2.new(v38, 0, 1, 0)
    textLabel6.Text = "> " .. text4 .. ": " .. tostring(v36.Value)

    if v36.OnChangeFunc then
      v36.OnChangeFunc(v36.Value)
    end
  end

  local inputBegan4 = frame10.InputBegan

  table.insert(v7, inputBegan4:Connect(function(p19)
    if p19.UserInputType == Enum.UserInputType.MouseButton1 then
      v37 = true
      f6(p19)
    end
  end))

  local inputChanged4 = userInputService.InputChanged

  table.insert(v7, inputChanged4:Connect(function(p20)
    if v37 and p20.UserInputType == Enum.UserInputType.MouseMovement then
      f6(p20)
    end
  end))

  local inputEnded2 = userInputService.InputEnded

  table.insert(v7, inputEnded2:Connect(function(p21)
    if p21.UserInputType == Enum.UserInputType.MouseButton1 then
      v37 = false
    end
  end))

  return v36
end

function v22.AddDropdown(parent3, text6, p22, p23, text7)
  local frame12 = Instance.new("Frame")
  frame12.Size = UDim2.new(1, 0, 0, 26)
  frame12.BackgroundColor3 = impactDark.ElementBG
  frame12.BackgroundTransparency = impactDark.ElementTransparency
  frame12.BorderSizePixel = 0
  frame12.ClipsDescendants = false
  frame12.ZIndex = 5
  frame12.Parent = parent3

  local uiCorner20 = Instance.new("UICorner")
  uiCorner20.CornerRadius = UDim.new(0, 4)
  uiCorner20.Parent = frame12

  table.insert(v5, { Type = "Dropdown", Container = frame12 })
  local v39 = text7 and {} or p22[1]

  local textButton7 = Instance.new("TextButton")
  textButton7.Size = UDim2.new(1, 0, 0, 26)
  textButton7.BackgroundTransparency = 1
  textButton7.Text = "  > " .. text6 .. ": " .. (text7 and "None" or tostring(v39))
  textButton7.TextColor3 = impactDark.Text
  textButton7.Font = gotham
  textButton7.TextSize = 12
  textButton7.TextXAlignment = Enum.TextXAlignment.Left
  textButton7.ZIndex = 6
  textButton7.Parent = frame12

  table.insert(v6, textButton7)

  local textLabel7 = Instance.new("TextLabel")
  textLabel7.Size = UDim2.new(0, 20, 0, 26)
  textLabel7.Position = UDim2.new(1, -20, 0, 0)
  textLabel7.BackgroundTransparency = 1
  textLabel7.Text = "▼"
  textLabel7.TextColor3 = impactDark.SubText
  textLabel7.Font = gotham
  textLabel7.TextSize = 9
  textLabel7.ZIndex = 6
  textLabel7.Parent = frame12

  table.insert(v6, textLabel7)

  local scrollingFrame = Instance.new("ScrollingFrame")
  scrollingFrame.Size = UDim2.new(1, 0, 0, 0)
  scrollingFrame.Position = UDim2.new(0, 0, 0, 28)
  scrollingFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
  scrollingFrame.BackgroundTransparency = 0.05
  scrollingFrame.BorderSizePixel = 0
  scrollingFrame.Visible = false
  scrollingFrame.ZIndex = 25
  scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
  scrollingFrame.ScrollBarThickness = 2
  scrollingFrame.Parent = frame12

  local uiListLayout3 = Instance.new("UIListLayout")
  uiListLayout3.Parent = scrollingFrame
  uiListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout3.Padding = UDim.new(0, 2)

  local uiCorner21 = Instance.new("UICorner")
  uiCorner21.CornerRadius = UDim.new(0, 4)
  uiCorner21.Parent = scrollingFrame

  local v40 = false

  local v41 = {
    Value = v39,
    Values = p22,
    SetValues = function(p24, values) p24.Values = values end,
  }

  local function f7()
    if text7 then
      local v42 = {}

      for key2, value8 in pairs(v39) do
        if value8 then
          table.insert(v42, key2)
        end
      end

      if #v42 == 0 then
        textButton7.Text = "  > " .. text6 .. ": None"
      else
        textButton7.Text = "  > " .. text6 .. ": " .. table.concat(v42, ", ")
      end
    else
      textButton7.Text = "  > " .. text6 .. ": " .. tostring(v39)
    end
  end

  local function makeTextButton4()
    for index8, value9 in ipairs(scrollingFrame:GetChildren()) do
      if value9:IsA("TextButton") then
        value9:Destroy()
      end
    end

    for index9, value10 in ipairs(v41.Values) do
      local v43 = value10
      local v44 = text7 and v39[v43] == true or v39 == v43

      local textButton8 = Instance.new("TextButton")
      textButton8.Size = UDim2.new(1, 0, 0, 22)
      textButton8.BackgroundColor3 = v44 and Color3.fromRGB(45, 45, 55) or impactDark.ElementBG
      textButton8.BackgroundTransparency = 0.2
      textButton8.BorderSizePixel = 0
      textButton8.Text = "     " .. tostring(v43)
      textButton8.TextColor3 = v44 and Color3.fromRGB(255, 255, 255) or impactDark.SubText
      textButton8.Font = gotham
      textButton8.TextSize = 11
      textButton8.TextXAlignment = Enum.TextXAlignment.Left
      textButton8.ZIndex = 26
      textButton8.Parent = scrollingFrame

      table.insert(v6, textButton8)

      local uiCorner22 = Instance.new("UICorner")
      uiCorner22.CornerRadius = UDim.new(0, 3)
      uiCorner22.Parent = textButton8

      textButton8.MouseButton1Click:Connect(function()
        if text7 then
          v39[v43] = not v39[v43]
          v41.Value = v39
        else
          v39 = v43
          v41.Value = v43
          v40 = false
          scrollingFrame.Visible = false
          textLabel7.Text = "▼"
        end

        f7()
        makeTextButton4()

        if p23 then
          p23(v41.Value)
        end
      end)
    end

    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #v41.Values * 24 + 4)
  end

  makeTextButton4()

  textButton7.MouseButton1Click:Connect(function()
    v40 = not v40
    textLabel7.Text = v40 and "▲" or "▼"
    scrollingFrame.Visible = v40

    if v40 then
      makeTextButton4()
      local v45 = math.min(#v41.Values * 24 + 4, 120)
      scrollingFrame.Size = UDim2.new(1, 0, 0, v45)
    else
      scrollingFrame.Size = UDim2.new(1, 0, 0, 0)
    end
  end)

  return v41
end

function v22.AddButton(parent4, text8, p25)
  local textButton9 = Instance.new("TextButton")
  textButton9.Size = UDim2.new(1, 0, 0, 26)
  textButton9.BackgroundColor3 = impactDark.ElementBG
  textButton9.BackgroundTransparency = impactDark.ElementTransparency
  textButton9.BorderSizePixel = 0
  textButton9.Text = "  [ " .. text8 .. " ]"
  textButton9.TextColor3 = impactDark.Text
  textButton9.TextSize = 12
  textButton9.Font = gotham
  textButton9.TextXAlignment = Enum.TextXAlignment.Center
  textButton9.Parent = parent4

  table.insert(v6, textButton9)

  local uiCorner23 = Instance.new("UICorner")
  uiCorner23.CornerRadius = UDim.new(0, 4)
  uiCorner23.Parent = textButton9

  textButton9.MouseButton1Click:Connect(function()
    if p25 then
      p25()
    end
  end)
end

local v46 = makeTextButton("Visuals", 20, 210)
local v47 = makeTextButton("World", 240, 210)
local v48 = makeTextButton("Combat", 460, 210)
local v49 = makeTextButton("Movement", 680, 210)
local v50 = makeTextButton("Settings", 900, 240)

local function f8()
  local v51 = {}
  local v52, v53 = pcall(function() return players:GetPlayers() end)

  if v52 and v53 then
    for index10, value11 in ipairs(v53) do
      if value11 ~= localPlayer then
        table.insert(v51, value11.Name)
      end
    end
  end

  if #v51 == 0 then
    table.insert(v51, "None")
  end

  return v51
end

v8.PlayerESP = v22.AddToggle(v46, "ESP Box", false, nil, "Box")
v8.Chams = v22.AddToggle(v46, "Chams", false, nil, "Chams")

v9.ChamsMode = v22.AddDropdown(v46, "Chams Mode", { "Highlight", "BoxHandle" }, function() end)

v8.ESPName = v22.AddToggle(v46, "Names", false, nil, "Name")
v8.ESPHP = v22.AddToggle(v46, "HP Text", false)
v8.ESPHPBar = v22.AddToggle(v46, "HP Bar", false)
v8.ESPTools = v22.AddToggle(v46, "Tools / Held Item", false, nil, "Tools")
v8.ESPDistance = v22.AddToggle(v46, "Distance", false, nil, "Distance")
v8.Tracers = v22.AddToggle(v46, "Tracers", false, nil, "Tracers")
v8.Arrows = v22.AddToggle(v46, "Offscreen Arrows", false, nil, "Arrows")

v9.ESPRefreshRate = v22.AddSlider(v46, "ESP Refresh Rate", 60, 144, 60)
v9.ESPDistanceLimit = v22.AddSlider(v46, "ESP Max Distance", 100, 5000, 2000)
v9.ESPWhitelist = v22.AddDropdown(v46, "ESP Whitelist", f8(), function() end, true)

v8.Crates = v22.AddToggle(v47, "Crates ESP", false)

v9.CratesFilter = v22.AddDropdown(
  v47, "Crates Type", { "Crate", "Locked Crate", "Military Crate" }, function() end, true
)

v8.Ores = v22.AddToggle(v47, "Ores & Cloth ESP", false)

v9.OresFilter = v22.AddDropdown(
  v47, "Ore / Cloth Type", { "Sulfur Ore", "Stone", "Metal Ore", "Cloth" }, function() end, true
)

v8.Boats = v22.AddToggle(v47, "Boats ESP", false)
v8.NPCs = v22.AddToggle(v47, "NPC ESP", false)
v8.AlwaysDay = v22.AddToggle(v47, "Always Day", false)
v8.FullBright = v22.AddToggle(v47, "Full Bright", false)
v8.XRay = v22.AddToggle(v47, "X-Ray (Structures)", false)

v9.XRayTrans = v22.AddSlider(v47, "X-Ray Transparency %", 10, 100, 65)

v8.AimAssist = v22.AddToggle(v48, "Aim Assist", false)
v8.DrawFOV = v22.AddToggle(v48, "Draw FOV Circle", false, nil, "FOV")

v9.CameraFOV = v22.AddSlider(v48, "Camera FOV", 60, 120, 70)

v9.AimPart = v22.AddDropdown(
  v48, "Target Part", { "Head", "UpperTorso", "HumanoidRootPart" }, function() end
)

v9.AimWhitelist = v22.AddDropdown(v48, "Aim Whitelist", f8(), function() end, true)
v9.AimDist = v22.AddSlider(v48, "Max Distance", 50, 2000, 500)
v9.AimFOV = v22.AddSlider(v48, "Aim FOV", 30, 500, 180)

v8.CustomCrosshair = v22.AddToggle(v48, "Enable Crosshair", false)

v9.CHColor = { Value = Color3.fromRGB(0, 255, 120) }
v9.CHLength = v22.AddSlider(v48, "CH Length", 2, 30, 8)
v9.CHWidth = v22.AddSlider(v48, "CH Width", 1, 5, 1)
v9.CHGap = v22.AddSlider(v48, "CH Gap", 0, 20, 4)

v8.InfJump = v22.AddToggle(v49, "Infinite Jump", false)
v8.Sprint = v22.AddToggle(v49, "Sprint (Shift)", false)

v9.SpeedValue = v22.AddSlider(v49, "Sprint Speed", 16, 100, 36)

v8.Noclip = v22.AddToggle(v49, "Noclip", false)
v8.Freecam = v22.AddToggle(v49, "Freecam", false)

v9.FreecamSpeed = v22.AddSlider(v49, "Freecam Speed", 10, 200, 50)

v22.AddDropdown(v50, "Theme", { "Impact Dark", "Dark Purple", "Midnight Blue", "Emerald" }, function(key3)
  if v3[key3] then
    impactDark = v3[key3]
    f2()
  end
end)

v22.AddDropdown(v50, "Font", { "Gotham", "Montserrat", "Code", "SourceSans" }, function(key4)
  if v2[key4] then
    gotham = v2[key4]
    f2()
  end
end)

v22.AddToggle(v50, "Watermark", true, function(p26)
  visible = p26

  if spectreWatermark then
    spectreWatermark.Visible = p26
  end
end)

v22.AddToggle(v50, "Keybinds List", false, function(p27)
  v14 = p27
  makeTextLabel()
end)

v22.AddButton(v50, "Unload Menu", function()
  for index11, value12 in ipairs(v7) do
    if value12 and typeof(value12) == "RBXScriptConnection" then
      value12:Disconnect()
    end
  end

  if blurEffect then
    blurEffect:Destroy()
  end

  if spectreWareImpactUI then
    spectreWareImpactUI:Destroy()
  end
end)

players.PlayerAdded:Connect(function()
  local v54 = f8()

  if v9.ESPWhitelist and v9.ESPWhitelist.SetValues then
    v9.ESPWhitelist:SetValues(v54)
  end

  if v9.AimWhitelist and v9.AimWhitelist.SetValues then
    v9.AimWhitelist:SetValues(v54)
  end
end)

players.PlayerRemoving:Connect(function()
  local v55 = f8()

  if v9.ESPWhitelist and v9.ESPWhitelist.SetValues then
    v9.ESPWhitelist:SetValues(v55)
  end

  if v9.AimWhitelist and v9.AimWhitelist.SetValues then
    v9.AimWhitelist:SetValues(v55)
  end
end)

local function f9(key5)
  local character2 = key5.Character

  if character2 then
    local tool = character2:FindFirstChildOfClass("Tool")

    if tool then
      return tool.Name
    end
  end

  local data = key5:FindFirstChild("Data")

  if data then
    local count2 = 0

    while true do
      count2 = 1 + count2

      if not (count2 <= 35) then
        break
      end

      local findFirstChild = data:FindFirstChild("Slot" .. count2)

      if findFirstChild then
        local itemName = findFirstChild:FindFirstChild("ItemName")

        if itemName and itemName.Value and tostring(itemName.Value) ~= ""
          and tostring(itemName.Value) ~= "None" then
          local amount = findFirstChild:FindFirstChild("Amount")
          local gunAmmo = findFirstChild:FindFirstChild("GunAmmo")
          local v56 = tostring(itemName.Value)

          if gunAmmo and gunAmmo.Value and gunAmmo.Value > 0 then
            v56 = v56 .. string.format(" [%d]", gunAmmo.Value)
          elseif amount and amount.Value and amount.Value > 1 then
            v56 = v56 .. string.format(" x%d", amount.Value)
          end

          return v56
        end
      end
    end

    return "None"
  end

  return "None"
end

local v57 = 0
local v58 = tick()
local v59 = 60
local renderStepped = runService.RenderStepped

table.insert(v7, renderStepped:Connect(function()
  v57 = v57 + 1

  if tick() - v58 >= 1 then
    v59 = v57
    v57 = 0
    v58 = tick()
  end

  local v60 = 0
  pcall(function() v60 = math.floor(localPlayer:GetNetworkPing() * 1000) end)

  if performance and performance.Parent then
    performance.Text = string.format("FPS: %d  |  PING: %d ms", v59, v60)
  end
end))

local renderStepped2 = runService.RenderStepped

table.insert(v7, renderStepped2:Connect(function()
  local currentCamera = workspaceService.CurrentCamera

  if currentCamera and v9.CameraFOV and v9.CameraFOV.Value then
    if currentCamera.FieldOfView ~= v9.CameraFOV.Value then
      currentCamera.FieldOfView = v9.CameraFOV.Value
    end
  end
end))

local v61 = {
  Brightness = lighting.Brightness,
  ClockTime = lighting.ClockTime,
  ExposureCompensation = lighting.ExposureCompensation,
  GlobalShadows = lighting.GlobalShadows,
  Ambient = lighting.Ambient,
  OutdoorAmbient = lighting.OutdoorAmbient,
}

local renderStepped3 = runService.RenderStepped

table.insert(v7, renderStepped3:Connect(function()
  if v8.FullBright and v8.FullBright.Value then
    lighting.Brightness = 3
    lighting.ExposureCompensation = 0.5
    lighting.GlobalShadows = false
    lighting.Ambient = Color3.fromRGB(190, 190, 190)
    lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
  else
    lighting.Brightness = v61.Brightness
    lighting.ExposureCompensation = v61.ExposureCompensation
    lighting.GlobalShadows = v61.GlobalShadows
    lighting.Ambient = v61.Ambient
    lighting.OutdoorAmbient = v61.OutdoorAmbient
  end
end))

local renderStepped4 = runService.RenderStepped

table.insert(v7, renderStepped4:Connect(function()
  if v8.AlwaysDay and v8.AlwaysDay.Value then
    lighting.ClockTime = 12
    lighting.Brightness = 3
    lighting.GlobalShadows = false
    lighting.FogEnd = 100000
  elseif waitForChild and waitForChild2 then
    if waitForChild2.Value then
      lighting.ClockTime = waitForChild.Value
    else
      lighting.ClockTime = 0
    end
  end
end))

task.spawn(function()
  local v62 = {}

  while true do
    local structures = workspaceService:FindFirstChild("PlayerBuiltStructures")
      and workspaceService.PlayerBuiltStructures:FindFirstChild("Structures")

    local value13 = v8.XRay and v8.XRay.Value
    local xrayTrans = v9.XRayTrans and v9.XRayTrans.Value / 100 or 0.65

    if structures then
      for index12, value14 in ipairs(structures:GetDescendants()) do
        if value14:IsA("BasePart") then
          if value13 then
            if not v62[value14] then
              v62[value14] = value14.Transparency
            end

            value14.Transparency = math.max(xrayTrans, v62[value14])
          elseif v62[value14] then
            value14.Transparency = v62[value14]
            v62[value14] = nil
          end
        end
      end
    end

    task.wait(1)
  end
end)

task.spawn(function()
  while true do
    local waitForChild3 = workspaceService:WaitForChild("GeneratedMonuments", 5)

    if waitForChild3 then
      local color3 = Color3.fromRGB(255, 220, 0)
      local color4 = Color3.fromRGB(0, 255, 80)
      local color5 = Color3.fromRGB(255, 140, 0)
      local color6 = Color3.fromRGB(0, 0, 0)
      local v63 = {}

      local function f10(p28)
        if p28:IsA("BasePart") then
          return p28
        end

        if p28:IsA("Model") then
          return p28.PrimaryPart or p28:FindFirstChildWhichIsA("BasePart", true)
        end

        return nil
      end

      local function f11(key6)
        local v64 = v63[key6]

        if not v64 then
          return
        end

        if v64.highlight then
          v64.highlight:Destroy()
        end

        if v64.billboard then
          v64.billboard:Destroy()
        end

        v63[key6] = nil
      end

      local function makeTextLabel2(value15)
        if v63[value15] then
          return
        end

        if not value15:IsA("Model") and not value15:IsA("BasePart") then
          return
        else
          local lower = value15.Name:lower()
          local v65 = lower == "locked crate"
          local v66 = not (lower == "crate")
          local v67 = lower == "military crate"

          if v66 and not v65 and not v67 then
            return
          else
            local v68 = f10(value15)

            if not v68 then
              return
            else
              local v69 = color3
              local v70 = "CRATE"

              if v65 then
                v69 = color4
                v70 = "LOCKED CRATE"
              elseif v67 then
                v69 = color5
                v70 = "MILITARY CRATE"
              end

              local crateESPHighlight = Instance.new("Highlight")
              crateESPHighlight.Name = "_CrateESP_Highlight"
              crateESPHighlight.Adornee = value15
              crateESPHighlight.FillColor = v69
              crateESPHighlight.OutlineColor = color6
              crateESPHighlight.FillTransparency = 0.3
              crateESPHighlight.OutlineTransparency = 0
              crateESPHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
              crateESPHighlight.Parent = value15

              local crateESPLabel = Instance.new("BillboardGui")
              crateESPLabel.Name = "_CrateESP_Label"
              crateESPLabel.Adornee = v68
              crateESPLabel.Size = UDim2.fromOffset(200, 42)
              crateESPLabel.StudsOffset = Vector3.new(0, 2.5, 0)
              crateESPLabel.AlwaysOnTop = true
              crateESPLabel.MaxDistance = 10000
              crateESPLabel.Parent = value15

              local info = Instance.new("TextLabel")
              info.Name = "Info"
              info.Size = UDim2.fromScale(1, 1)
              info.BackgroundTransparency = 1
              info.Text = v70 .. "\nDistance: ..."
              info.TextColor3 = v69
              info.TextStrokeColor3 = color6
              info.TextStrokeTransparency = 0
              info.TextScaled = true
              info.Font = Enum.Font.GothamBold
              info.Parent = crateESPLabel

              v63[value15] = {
                highlight = crateESPHighlight,
                billboard = crateESPLabel,
                label = info,
                adornee = v68,
                name = v70,
              }

              return
            end
          end
        end
      end

      for index13, value16 in ipairs(waitForChild3:GetDescendants()) do
        local lower2 = value16.Name:lower()

        if lower2 == "crate" or lower2 == "locked crate" or lower2 == "military crate" then
          makeTextLabel2(value16)
        end
      end

      local connect = waitForChild3.DescendantAdded:Connect(function(descendant)
        local lower3 = descendant.Name:lower()

        if lower3 == "crate" or lower3 == "locked crate" or lower3 == "military crate" then
          task.defer(makeTextLabel2, descendant)
        end
      end)

      local connect2 = waitForChild3.DescendantRemoving:Connect(function(descendant2)
        if v63[descendant2] then
          task.defer(function()
            if not descendant2:IsDescendantOf(waitForChild3) then
              f11(descendant2)
            end
          end)
        end
      end)

      while localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") do
        local value17 = v8.Crates and v8.Crates.Value
        local value18 = v9.CratesFilter and v9.CratesFilter.Value
        local humanoidRootPart = localPlayer.Character.HumanoidRootPart

        for key7, value19 in pairs(v63) do
          if not key7:IsDescendantOf(waitForChild3) or not value19.adornee
            or not value19.adornee.Parent then
            f11(key7)
          else
            local v71 = false

            if value17 and value18 and type(value18) == "table" then
              for key8, value20 in pairs(value18) do
                if value20 and value19.name:lower():find(key8:lower()) then
                  v71 = true
                  break
                end
              end
            end

            if value17 and v71 and humanoidRootPart then
              value19.highlight.Enabled = true
              value19.billboard.Enabled = true

              value19.label.Text = string.format([[
%s
Distance: %d studs]], value19.name, math.floor((humanoidRootPart.Position
                  - value19.adornee.Position).Magnitude
                + 0.5))
            else
              value19.highlight.Enabled = false
              value19.billboard.Enabled = false
            end
          end
        end

        task.wait(0.2)
      end

      connect:Disconnect()
      connect2:Disconnect()
    end

    task.wait(1)
  end
end)

task.spawn(function()
  while true do
    local waitForChild4 = localPlayer:WaitForChild("PlayerGui", 5)

    if waitForChild4 then
      local oreESPLabels = waitForChild4:FindFirstChild("OreESPLabels")

      if oreESPLabels then
        oreESPLabels:Destroy()
      end

      local oreESPLabels2 = Instance.new("Folder")
      oreESPLabels2.Name = "OreESPLabels"
      oreESPLabels2.Parent = waitForChild4

      local v72 = {
        ["sulfur ore"] = Color3.fromRGB(255, 220, 0),
        sulfur = Color3.fromRGB(255, 220, 0),
        stone = Color3.fromRGB(155, 155, 155),
        ["metal ore"] = Color3.fromRGB(165, 85, 45),
        metal = Color3.fromRGB(165, 85, 45),
        cloth = Color3.fromRGB(240, 240, 240),
      }

      local v73 = {}

      local function f12(key9)
        if key9:IsA("BasePart") then
          return key9
        end

        if key9:IsA("Model") then
          return key9.PrimaryPart or key9:FindFirstChildWhichIsA("BasePart", true)
        end

        return nil
      end

      local function f13(key10)
        local v74 = v73[key10]

        if not v74 then
          return
        end

        if v74.highlight then
          v74.highlight:Destroy()
        end

        if v74.label then
          v74.label:Destroy()
        end

        v73[key10] = nil
      end

      local function makeTextLabel3(value21)
        if v73[value21] then
          return
        end

        if not (value21:IsA("Model") or value21:IsA("BasePart")) then
          return
        else
          local lower4 = value21.Name:lower()
          local name = nil
          local v75 = nil

          if v72[lower4] then
            v75 = v72[lower4]
            name = value21.Name
          end

          if not name then
            return
          else
            local v76 = f12(value21)

            if not v76 then
              return
            else
              local localOreHighlight = Instance.new("Highlight")
              localOreHighlight.Name = "LocalOreHighlight"
              localOreHighlight.Adornee = value21
              localOreHighlight.FillColor = v75
              localOreHighlight.OutlineColor = Color3.new(0, 0, 0)
              localOreHighlight.FillTransparency = 0.45
              localOreHighlight.OutlineTransparency = 0
              localOreHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
              localOreHighlight.Parent = value21

              local oreDistanceLabel = Instance.new("BillboardGui")
              oreDistanceLabel.Name = "OreDistanceLabel"
              oreDistanceLabel.Adornee = v76
              oreDistanceLabel.Size = UDim2.fromOffset(230, 44)
              oreDistanceLabel.StudsOffset = Vector3.new(0, 3, 0)
              oreDistanceLabel.AlwaysOnTop = true
              oreDistanceLabel.MaxDistance = 100000
              oreDistanceLabel.Parent = oreESPLabels2

              local oreText = Instance.new("TextLabel")
              oreText.Name = "OreText"
              oreText.Size = UDim2.fromScale(1, 1)
              oreText.BackgroundTransparency = 1
              oreText.Font = Enum.Font.GothamBold
              oreText.TextSize = 14
              oreText.TextColor3 = v75
              oreText.TextStrokeColor3 = Color3.new(0, 0, 0)
              oreText.TextStrokeTransparency = 0
              oreText.Text = name .. "\nDistance: calculating..."
              oreText.Parent = oreDistanceLabel

              v73[value21] = {
                highlight = localOreHighlight,
                label = oreDistanceLabel,
                text = oreText,
                part = v76,
                type = name,
              }

              return
            end
          end
        end
      end

      local oreSpawns = workspaceService:FindFirstChild("OreSpawns")
      local treeSpawns = workspaceService:FindFirstChild("TreeSpawns")
      local grass = treeSpawns and treeSpawns:FindFirstChild("Grass")

      if oreSpawns then
        for index14, value22 in ipairs(oreSpawns:GetDescendants()) do
          makeTextLabel3(value22)
        end
      end

      if grass then
        for index15, value23 in ipairs(grass:GetDescendants()) do
          makeTextLabel3(value23)
        end
      end

      local v77 = {}

      if oreSpawns then
        local descendantAdded = oreSpawns.DescendantAdded

        table.insert(v77, descendantAdded:Connect(function(p29)
          task.defer(function() makeTextLabel3(p29) end)
        end))

        local descendantRemoving = oreSpawns.DescendantRemoving
        table.insert(v77, descendantRemoving:Connect(f13))
      end

      if grass then
        local descendantAdded2 = grass.DescendantAdded

        table.insert(v77, descendantAdded2:Connect(function(p30)
          task.defer(function() makeTextLabel3(p30) end)
        end))

        local descendantRemoving2 = grass.DescendantRemoving
        table.insert(v77, descendantRemoving2:Connect(f13))
      end

      while localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") do
        local value24 = v8.Ores and v8.Ores.Value
        local value25 = v9.OresFilter and v9.OresFilter.Value
        local humanoidRootPart2 = localPlayer.Character.HumanoidRootPart

        for key11, value26 in pairs(v73) do
          if not key11.Parent then
            f13(key11)
          else
            local v78 = f12(key11)

            if v78 then
              value26.part = v78
              value26.label.Adornee = v78
            end

            local v79 = false

            if value24 and value25 and type(value25) == "table" then
              for key12, value27 in pairs(value25) do
                if value27 and value26.type:lower():find(key12:lower()) then
                  v79 = true
                  break
                end
              end
            end

            if value24 and v79 and humanoidRootPart2 and value26.part
              and value26.part:IsDescendantOf(workspaceService) then
              value26.highlight.Enabled = true
              value26.label.Enabled = true

              value26.text.Text = string.format([[
%s
Distance: %d studs]], value26.type, math.floor((humanoidRootPart2.Position
                  - value26.part.Position).Magnitude
                + 0.5))
            else
              value26.highlight.Enabled = false
              value26.label.Enabled = false
            end
          end
        end

        task.wait(0.2)
      end

      for index16, value28 in ipairs(v77) do
      end
    end

    task.wait(1)
  end
end)

task.spawn(function()
  while true do
    local waitForChild5 = workspaceService:WaitForChild("BoatSpawns", 5)
    local waitForChild6 = localPlayer:WaitForChild("PlayerGui", 5)

    if waitForChild5 and waitForChild6 then
      local color7 = Color3.fromRGB(0, 220, 255)
      local v80 = {}
      local boatESPLabels = waitForChild6:FindFirstChild("BoatESPLabels")

      if boatESPLabels then
        boatESPLabels:Destroy()
      end

      local boatESPLabels2 = Instance.new("Folder")
      boatESPLabels2.Name = "BoatESPLabels"
      boatESPLabels2.Parent = waitForChild6

      local function f14(p31)
        return p31.Name == "Boat" and (p31:IsA("Model") or p31:IsA("BasePart"))
          and p31:IsDescendantOf(waitForChild5)
      end

      local function f15(key13)
        if key13:IsA("BasePart") then
          return key13
        end

        if key13:IsA("Model") then
          return key13.PrimaryPart or key13:FindFirstChildWhichIsA("BasePart", true)
        end

        return nil
      end

      local function f16(key14)
        local v81 = v80[key14]

        if not v81 then
          return
        end

        if v81.highlight then
          v81.highlight:Destroy()
        end

        if v81.label then
          v81.label:Destroy()
        end

        v80[key14] = nil
      end

      local function makeTextLabel4(key15)
        if v80[key15] or not f14(key15) then
          return
        else
          local v82 = f15(key15)

          if not v82 then
            return
          else
            local localBoatHighlight = Instance.new("Highlight")
            localBoatHighlight.Name = "LocalBoatHighlight"
            localBoatHighlight.Adornee = key15
            localBoatHighlight.FillColor = color7
            localBoatHighlight.OutlineColor = Color3.new(0, 0, 0)
            localBoatHighlight.FillTransparency = 0.5
            localBoatHighlight.OutlineTransparency = 0
            localBoatHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            localBoatHighlight.Parent = key15

            local boatDistanceLabel = Instance.new("BillboardGui")
            boatDistanceLabel.Name = "BoatDistanceLabel"
            boatDistanceLabel.Adornee = v82
            boatDistanceLabel.Size = UDim2.fromOffset(230, 44)
            boatDistanceLabel.StudsOffset = Vector3.new(0, 6, 0)
            boatDistanceLabel.AlwaysOnTop = true
            boatDistanceLabel.MaxDistance = 100000
            boatDistanceLabel.Parent = boatESPLabels2

            local boatText = Instance.new("TextLabel")
            boatText.Name = "BoatText"
            boatText.Size = UDim2.fromScale(1, 1)
            boatText.BackgroundTransparency = 1
            boatText.Font = Enum.Font.GothamBold
            boatText.TextSize = 16
            boatText.TextColor3 = color7
            boatText.TextStrokeColor3 = Color3.new(0, 0, 0)
            boatText.TextStrokeTransparency = 0

            boatText.Text = [[
Boat
Distance: calculating...]]

            boatText.Parent = boatDistanceLabel

            v80[key15] = {
              highlight = localBoatHighlight,
              label = boatDistanceLabel,
              text = boatText,
              part = v82,
            }

            return
          end
        end
      end

      for index17, value29 in ipairs(waitForChild5:GetDescendants()) do
        if value29.Name == "Boat" then
          makeTextLabel4(value29)
        end
      end

      local connect3 = waitForChild5.DescendantAdded:Connect(function(descendant3)
        if descendant3.Name == "Boat" then
          task.defer(function()
            if f14(descendant3) then
              makeTextLabel4(descendant3)
            end
          end)
        end
      end)

      local connect4 = waitForChild5.DescendantRemoving:Connect(function(descendant4)
        f16(descendant4)
      end)

      while localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") do
        local value30 = v8.Boats and v8.Boats.Value
        local humanoidRootPart3 = localPlayer.Character.HumanoidRootPart

        for key16, value31 in pairs(v80) do
          if not f14(key16) then
            f16(key16)
          else
            local v83 = f15(key16)

            if v83 then
              value31.part = v83
              value31.label.Adornee = v83
            end

            if value30 and humanoidRootPart3 and value31.part
              and value31.part:IsDescendantOf(workspaceService) then
              value31.highlight.Enabled = true
              value31.label.Enabled = true

              value31.text.Text = string.format([[
Boat
Distance: %d studs]], math.floor((humanoidRootPart3.Position
                  - value31.part.Position).Magnitude
                + 0.5))
            else
              value31.highlight.Enabled = false
              value31.label.Enabled = false
            end
          end
        end

        task.wait(0.25)
      end

      connect3:Disconnect()
      connect4:Disconnect()
    end

    task.wait(1)
  end
end)

task.spawn(function()
  while true do
    local color8 = Color3.fromRGB(0, 120, 255)
    local color9 = Color3.fromRGB(0, 0, 0)
    local v84 = {}

    local function f17(p32)
      return p32:FindFirstChild("HumanoidRootPart") or p32:FindFirstChild("Head")
        or p32.PrimaryPart or p32:FindFirstChildWhichIsA("BasePart", true)
    end

    local function f18(key17)
      local v85 = v84[key17]

      if not v85 then
        return
      end

      for index18, value32 in ipairs(v85.connections) do
        value32:Disconnect()
      end

      if v85.highlight then
        v85.highlight:Destroy()
      end

      if v85.billboard then
        v85.billboard:Destroy()
      end

      v84[key17] = nil
    end

    local function f19(key18)
      if not key18:IsA("Model") then
        return false
      elseif players:GetPlayerFromCharacter(key18) then
        return false
      else
        local v86 = false

        if key18.Name == "Scientist" or key18:FindFirstChildOfClass("Humanoid") then
          local generatedMonuments = workspaceService:FindFirstChild("GeneratedMonuments")
          local junkpiles = workspaceService:FindFirstChild("Junkpiles")

          if generatedMonuments and key18:IsDescendantOf(generatedMonuments) then
            local parent5 = key18.Parent

            while parent5 and parent5 ~= generatedMonuments do
              if parent5:IsA("Folder") and parent5.Name == "NPC" then
                v86 = true
                break
              end

              parent5 = parent5.Parent
            end
          elseif junkpiles and key18:IsDescendantOf(junkpiles) then
            v86 = true
          end
        end

        if not v86 then
          return false
        else
          local humanoid = key18:FindFirstChildOfClass("Humanoid")
          return humanoid ~= nil and humanoid.Health > 0
        end
      end
    end

    local function makeTextLabel5(key19)
      if v84[key19] or not f19(key19) then
        return
      else
        local humanoid2 = key19:FindFirstChildOfClass("Humanoid")
        local v87 = not humanoid2
        local v88 = f17(key19)

        if v87 or not v88 then
          return
        else
          local npcespHighlight = Instance.new("Highlight")
          npcespHighlight.Name = "_NPCESP_Highlight"
          npcespHighlight.Adornee = key19
          npcespHighlight.FillColor = color8
          npcespHighlight.OutlineColor = color9
          npcespHighlight.FillTransparency = 0.35
          npcespHighlight.OutlineTransparency = 0
          npcespHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
          npcespHighlight.Parent = key19

          local npcespLabel = Instance.new("BillboardGui")
          npcespLabel.Name = "_NPCESP_Label"
          npcespLabel.Adornee = v88
          npcespLabel.Size = UDim2.fromOffset(180, 44)
          npcespLabel.StudsOffset = Vector3.new(0, 2.5, 0)
          npcespLabel.AlwaysOnTop = true
          npcespLabel.MaxDistance = 10000
          npcespLabel.Parent = key19

          local info2 = Instance.new("TextLabel")
          info2.Name = "Info"
          info2.Size = UDim2.fromScale(1, 1)
          info2.BackgroundTransparency = 1

          info2.Text = [[
NPC
Distance: ...]]

          info2.TextColor3 = color8
          info2.TextStrokeColor3 = color9
          info2.TextStrokeTransparency = 0
          info2.TextScaled = true
          info2.Font = Enum.Font.GothamBold
          info2.Parent = npcespLabel

          local v89 = {}
          local died = humanoid2.Died
          table.insert(v89, died:Connect(function() f18(key19) end))

          v84[key19] = {
            highlight = npcespHighlight,
            billboard = npcespLabel,
            label = info2,
            adornee = v88,
            humanoid = humanoid2,
            connections = v89,
          }

          return
        end
      end
    end

    local function f20()
      for index19, value33 in ipairs(workspaceService:GetDescendants()) do
        if value33:IsA("Model") then
          makeTextLabel5(value33)
        end
      end

      for key20 in pairs(v84) do
        if not key20.Parent or not f19(key20) or v84[key20].humanoid.Health <= 0 then
          f18(key20)
        end
      end
    end

    f20()

    local connect5 = workspaceService.DescendantAdded:Connect(function(descendant5)
      if descendant5:IsA("Model") then
        task.defer(function() makeTextLabel5(descendant5) end)
      elseif descendant5:IsA("Humanoid") and descendant5.Parent
        and descendant5.Parent:IsA("Model") then
        task.defer(function() makeTextLabel5(descendant5.Parent) end)
      end
    end)

    local connect6 = workspaceService.DescendantRemoving:Connect(function(descendant6)
      if v84[descendant6] then
        task.defer(function() f18(descendant6) end)
      end
    end)

    while localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") do
      local value34 = v8.NPCs and v8.NPCs.Value
      local humanoidRootPart4 = localPlayer.Character.HumanoidRootPart

      for key21, value35 in pairs(v84) do
        if not key21.Parent or value35.humanoid.Health <= 0 or not value35.adornee.Parent then
          f18(key21)
        elseif value34 and humanoidRootPart4 then
          value35.highlight.Enabled = true
          value35.billboard.Enabled = true

          value35.label.Text = string.format([[
NPC
Distance: %d studs]], math.floor((humanoidRootPart4.Position
              - value35.adornee.Position).Magnitude
            + 0.5))
        else
          value35.highlight.Enabled = false
          value35.billboard.Enabled = false
        end
      end

      task.wait(0.3)
    end

    connect5:Disconnect()
    connect6:Disconnect()
    task.wait(1)
  end
end)

task.spawn(function()
  while true do
    local v90 = {}

    local function makeFrame(parent6, backgroundColor3, p33)
      local frame13 = Instance.new("Frame")
      frame13.BorderSizePixel = 0
      frame13.BackgroundColor3 = backgroundColor3
      frame13.ZIndex = p33 or 2
      frame13.Parent = parent6

      return frame13
    end

    local spectrewarePlayerESP

    local function makeTextLabel6(value36)
      if value36 == localPlayer or not spectrewarePlayerESP then
        return
      else
        if v90[value36] then
          pcall(function()
            if v90[value36].Box then
              v90[value36].Box:Destroy()
            end

            if v90[value36].Label then
              v90[value36].Label:Destroy()
            end

            if v90[value36].HealthBack then
              v90[value36].HealthBack:Destroy()
            end

            if v90[value36].Highlight then
              v90[value36].Highlight:Destroy()
            end

            if v90[value36].Adornments then
              for key22, value37 in pairs(v90[value36].Adornments) do
                value37:Destroy()
              end
            end
          end)
        end

        local frame14 = Instance.new("Frame")
        frame14.BackgroundTransparency = 1
        frame14.Visible = false
        frame14.Parent = spectrewarePlayerESP

        local v91 = {}

        for i = 1, 4 do
          v91[i] = makeFrame(frame14, v10.Box, 3)
        end

        local textLabel8 = Instance.new("TextLabel")
        textLabel8.BackgroundTransparency = 1
        textLabel8.TextColor3 = Color3.new(1, 1, 1)
        textLabel8.TextStrokeColor3 = Color3.new(0, 0, 0)
        textLabel8.TextStrokeTransparency = 0
        textLabel8.Font = Enum.Font.Code
        textLabel8.TextSize = 12
        textLabel8.Visible = false
        textLabel8.Parent = spectrewarePlayerESP

        local v92 = makeFrame(spectrewarePlayerESP, Color3.fromRGB(15, 15, 15), 2)
        v92.Visible = false

        local v93 = makeFrame(v92, Color3.fromRGB(50, 220, 80), 3)
        v93.AnchorPoint = Vector2.new(0, 1)
        v93.Position = UDim2.new(0, 0, 1, 0)
        v93.Size = UDim2.new(1, 0, 1, 0)

        local highlight = Instance.new("Highlight")
        highlight.FillColor = v10.Chams
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Enabled = false
        highlight.Parent = nil

        local v94 = {}

        for index20, value38 in ipairs({
          "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", "LeftUpperArm",
          "RightUpperArm", "LeftUpperLeg", "RightUpperLeg",
        }) do
          local boxHandleAdornment = Instance.new("BoxHandleAdornment")
          boxHandleAdornment.AlwaysOnTop = true
          boxHandleAdornment.ZIndex = 10
          boxHandleAdornment.Color3 = v10.Chams
          boxHandleAdornment.Transparency = 0.5
          boxHandleAdornment.Adornee = nil
          boxHandleAdornment.Parent = nil

          v94[value38] = boxHandleAdornment
        end

        v90[value36] = {
          Box = frame14,
          Sides = v91,
          Label = textLabel8,
          HealthBack = v92,
          HealthFill = v93,
          Highlight = highlight,
          Adornments = v94,
        }

        return
      end
    end

    local waitForChild7 = localPlayer:WaitForChild("PlayerGui", 5)

    if waitForChild7 then
      if spectrewarePlayerESP then
        spectrewarePlayerESP:Destroy()
      end

      v90 = {}

      spectrewarePlayerESP = Instance.new("ScreenGui")
      spectrewarePlayerESP.Name = "SPECTREWARE_PlayerESP"
      spectrewarePlayerESP.ResetOnSpawn = false
      spectrewarePlayerESP.IgnoreGuiInset = true
      spectrewarePlayerESP.DisplayOrder = 100
      spectrewarePlayerESP.Parent = waitForChild7

      for index21, value39 in ipairs(players:GetPlayers()) do
        makeTextLabel6(value39)
      end

      local connect7 = players.PlayerAdded:Connect(makeTextLabel6)

      while localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") do
        local currentCamera2 = workspaceService.CurrentCamera

        if currentCamera2 then
          local character3 = localPlayer.Character
          local humanoidRootPart5 = character3 and character3:FindFirstChild("HumanoidRootPart")
          local value40 = v9.ESPDistanceLimit and v9.ESPDistanceLimit.Value or 2000

          for key23, value41 in pairs(v90) do
            local v95 = false

            if v9.ESPWhitelist and type(v9.ESPWhitelist.Value) == "table" then
              if v9.ESPWhitelist.Value[key23.Name] then
                v95 = true
              end
            elseif v9.ESPWhitelist and v9.ESPWhitelist.Value == key23.Name then
              v95 = true
            end

            local character4 = key23.Character

            if v95 or not character4 or not character3 or not value41.Box
              or not value41.Box.Parent then
              value41.Box.Visible = false
              value41.Label.Visible = false
              value41.HealthBack.Visible = false
              value41.Highlight.Enabled = false

              for key24, value42 in pairs(value41.Adornments) do
                value42.Adornee = nil
              end
            else
              local humanoidRootPart6 = character4:FindFirstChild("HumanoidRootPart")
              local humanoid3 = character4:FindFirstChildOfClass("Humanoid")
              local v96 = not humanoidRootPart6
              local head = character4:FindFirstChild("Head")

              if v96 or not humanoid3 or not head or not humanoidRootPart5
                or humanoid3.Health <= 0 then
                value41.Box.Visible = false
                value41.Label.Visible = false
                value41.HealthBack.Visible = false
                value41.Highlight.Enabled = false

                for key25, value43 in pairs(value41.Adornments) do
                  value43.Adornee = nil
                end
              else
                local magnitude = (humanoidRootPart6.Position
                  - humanoidRootPart5.Position).Magnitude

                if magnitude > value40 then
                  value41.Box.Visible = false
                  value41.Label.Visible = false
                  value41.HealthBack.Visible = false
                  value41.Highlight.Enabled = false

                  for key26, value44 in pairs(value41.Adornments) do
                    value44.Adornee = nil
                  end
                else
                  if v8.Chams and v8.Chams.Value then
                    if (v9.ChamsMode and v9.ChamsMode.Value or "Highlight") == "Highlight" then
                      value41.Highlight.FillColor = v10.Chams
                      value41.Highlight.Parent = character4
                      value41.Highlight.Enabled = true

                      for key27, value45 in pairs(value41.Adornments) do
                        value45.Adornee = nil
                      end
                    else
                      value41.Highlight.Enabled = false

                      for key28, value46 in pairs(value41.Adornments) do
                        local findFirstChild2 = character4:FindFirstChild(key28)

                        if findFirstChild2 and findFirstChild2:IsA("BasePart") then
                          value46.Color3 = v10.Chams
                          value46.Adornee = findFirstChild2
                          value46.Size = findFirstChild2.Size + Vector3.new(0.1, 0.1, 0.1)
                          value46.Parent = currentCamera2
                        else
                          value46.Adornee = nil
                        end
                      end
                    end
                  else
                    value41.Highlight.Enabled = false

                    for key29, value47 in pairs(value41.Adornments) do
                      value47.Adornee = nil
                    end
                  end

                  local vector = Vector3.new(0, head.Size.Y * 0.5 - 0.25, 0)

                  local vector2 = Vector3.new(0, humanoid3.HipHeight
                      + humanoidRootPart6.Size.Y * 0.5
                    - 0.15, 0)

                  local v97, v98 = currentCamera2:WorldToViewportPoint(head.Position + vector)

                  local v99, v100 = currentCamera2:WorldToViewportPoint(humanoidRootPart6.Position
                    - vector2)

                  if v97.Z <= 0 and v99.Z <= 0 then
                    value41.Box.Visible = false
                    value41.Label.Visible = false
                    value41.HealthBack.Visible = false
                  else
                    local v101 = math.abs(v99.Y - v97.Y)

                    if v101 < 2 then
                      value41.Box.Visible = false
                      value41.Label.Visible = false
                      value41.HealthBack.Visible = false
                    else
                      local v102 = v101 * 0.48
                      local v103 = v97.X - v102 * 0.5
                      local y = v97.Y

                      if v8.PlayerESP and v8.PlayerESP.Value then
                        value41.Box.Position = UDim2.fromOffset(v103, y)
                        value41.Box.Size = UDim2.fromOffset(v102, v101)

                        local count3 = 0

                        while true do
                          count3 = 1 + count3

                          if not (count3 <= 4) then
                            break
                          end

                          value41.Sides[count3].BackgroundColor3 = v10.Box
                        end

                        value41.Sides[1].Position = UDim2.fromOffset(0, 0)
                        value41.Sides[1].Size = UDim2.new(1, 0, 0, 1.5)
                        value41.Sides[2].Position = UDim2.fromOffset(0, v101 - 1.5, 1, 0)
                        value41.Sides[2].Size = UDim2.new(1, 0, 0, 1.5)
                        value41.Sides[3].Position = UDim2.fromOffset(0, 0)
                        value41.Sides[3].Size = UDim2.new(0, 1.5, 1, 0)
                        value41.Sides[4].Position = UDim2.fromOffset(v102 - 1.5, 0, 0, 0)
                        value41.Sides[4].Size = UDim2.new(0, 1.5, 1, 0)
                        value41.Box.Visible = true
                      else
                        value41.Box.Visible = false
                      end

                      local v104 = {}

                      if v8.ESPName and v8.ESPName.Value then
                        table.insert(v104, key23.DisplayName)
                      end

                      if v8.ESPHP and v8.ESPHP.Value then
                        table.insert(
                          v104, string.format("[%d HP]", math.floor(humanoid3.Health))
                        )
                      end

                      if v8.ESPTools and v8.ESPTools.Value then
                        table.insert(v104, "Item: " .. f9(key23))
                      end

                      if v8.ESPDistance and v8.ESPDistance.Value then
                        table.insert(
                          v104, string.format("%d studs", math.floor(magnitude + 0.5))
                        )
                      end

                      if #v104 > 0 then
                        value41.Label.Position = UDim2.fromOffset(
                          v103 - 50, y - (#v104 * 14 + 4)
                        )

                        value41.Label.Size = UDim2.fromOffset(v102 + 100, #v104 * 14 + 4)
                        value41.Label.Text = table.concat(v104, "\n")
                        value41.Label.TextColor3 = v10.Name
                        value41.Label.Visible = true
                      else
                        value41.Label.Visible = false
                      end

                      if v8.ESPHPBar and v8.ESPHPBar.Value then
                        local v105 = math.clamp(humanoid3.Health
                          / math.max(humanoid3.MaxHealth, 1), 0, 1)

                        value41.HealthBack.Position = UDim2.fromOffset(v103 - 4 - 3, y)
                        value41.HealthBack.Size = UDim2.fromOffset(4, v101)
                        value41.HealthFill.Size = UDim2.new(1, 0, v105, 0)
                        value41.HealthFill.BackgroundColor3 = Color3.new(1 - v105, v105, 0)
                        value41.HealthBack.Visible = true
                      else
                        value41.HealthBack.Visible = false
                      end
                    end
                  end
                end
              end
            end
          end
        end

        task.wait(0.03)
      end

      connect7:Disconnect()
    end

    task.wait(1)
  end
end)

task.spawn(function()
  local vector3

  while true do
    local waitForChild8 = localPlayer:WaitForChild("PlayerGui", 5)

    if waitForChild8 then
      local v106 = {}
      local v107 = {}

      local spectrewareTracers = Instance.new("ScreenGui")
      spectrewareTracers.Name = "SPECTREWARE_Tracers"
      spectrewareTracers.ResetOnSpawn = false
      spectrewareTracers.IgnoreGuiInset = true
      spectrewareTracers.Parent = waitForChild8

      local spectrewareArrows = Instance.new("ScreenGui")
      spectrewareArrows.Name = "SPECTREWARE_Arrows"
      spectrewareArrows.ResetOnSpawn = false
      spectrewareArrows.IgnoreGuiInset = true
      spectrewareArrows.Parent = waitForChild8

      for index22, value48 in ipairs(players:GetPlayers()) do
        if value48 ~= localPlayer then
          local frame15 = Instance.new("Frame")
          frame15.AnchorPoint = Vector2.new(0.5, 0.5)
          frame15.BorderSizePixel = 0
          frame15.BackgroundColor3 = v10.Tracers
          frame15.Visible = false
          frame15.Parent = spectrewareTracers

          v106[value48] = frame15

          local textLabel9 = Instance.new("TextLabel")
          textLabel9.Size = UDim2.fromOffset(22, 22)
          textLabel9.AnchorPoint = Vector2.new(0.5, 0.5)
          textLabel9.BackgroundTransparency = 1
          textLabel9.Text = "▲"
          textLabel9.Font = Enum.Font.GothamBold
          textLabel9.TextSize = 22
          textLabel9.TextColor3 = v10.Arrows
          textLabel9.TextStrokeTransparency = 0.1
          textLabel9.Visible = false
          textLabel9.Parent = spectrewareArrows

          v107[value48] = { label = textLabel9, angle = nil }
        end
      end

      while localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") do
        local v108 = runService.RenderStepped:Wait()
        local value49 = v8.Tracers and v8.Tracers.Value
        local value50 = v8.Arrows and v8.Arrows.Value

        for key30, value51 in pairs(v106) do
          if not value49 or not value51.Parent then
            value51.Visible = false
          end
        end

        for key31, value52 in pairs(v107) do
          if not value50 or not value52.label.Parent then
            value52.label.Visible = false
          end
        end

        if value49 or value50 then
          local currentCamera3 = workspaceService.CurrentCamera

          if currentCamera3 then
            local viewportSize = currentCamera3.ViewportSize
            local v109 = viewportSize / 2

            for key32, value53 in pairs(v106) do
              if value49 then
                local character5 = key32.Character

                local humanoidRootPart7 = character5
                humanoidRootPart7 = character5 and character5:FindFirstChild("HumanoidRootPart")

                local humanoid4 = character5
                humanoid4 = character5 and character5:FindFirstChildOfClass("Humanoid")

                if not character5 or not humanoidRootPart7 or not humanoid4
                  or humanoid4.Health <= 0 then
                  value53.Visible = false
                else
                  local v110, v111 = currentCamera3:WorldToViewportPoint(humanoidRootPart7.Position)

                  if v110.Z <= 0 then
                    value53.Visible = false
                  else
                    local vector4 = Vector2.new(v109.X, viewportSize.Y - 4)
                    local vector5 = Vector2.new(v110.X, v110.Y)
                    local v112 = vector5 - vector4

                    value53.BackgroundColor3 = v10.Tracers

                    value53.Position = UDim2.fromOffset(
                      (vector4.X + vector5.X) / 2, (vector4.Y + vector5.Y) / 2
                    )

                    value53.Size = UDim2.fromOffset(v112.Magnitude, 1)
                    value53.Rotation = math.deg(math.atan2(v112.Y, v112.X))
                    value53.Visible = true
                  end
                end
              end
            end

            for key33, value54 in pairs(v107) do
              local label = value54.label

              if not value50 then
                label.Visible = false
              else
                local character6 = key33.Character

                local humanoidRootPart8 = character6
                humanoidRootPart8 = character6 and character6:FindFirstChild("HumanoidRootPart")

                local humanoid5 = character6
                humanoid5 = character6 and character6:FindFirstChildOfClass("Humanoid")

                if not humanoidRootPart8 or not humanoid5 or humanoid5.Health <= 0 then
                  label.Visible = false
                else
                  local vectorToObjectSpace = currentCamera3.CFrame:VectorToObjectSpace((humanoidRootPart8.Position
                    - currentCamera3.CFrame.Position).Unit)

                  local vector6 = Vector2.new(vectorToObjectSpace.X, -vectorToObjectSpace.Y)

                  if vectorToObjectSpace.Z > 0 then
                    vector6 = -vector6
                  end

                  if vector6.Magnitude < 0.001 then
                    vector3 = Vector2.new(0, -1)
                  else
                    vector3 = vector6.Unit
                  end

                  local v113 = math.atan2(vector3.Y, vector3.X)

                  if not value54.angle then
                    value54.angle = v113
                  else
                    local v114 = math.sin(v113 - value54.angle)
                    local v115 = math.atan2(v114, math.cos(v113 - value54.angle))
                    value54.angle = value54.angle + v115 * (1 - math.exp(-14 * v108))
                  end

                  label.TextColor3 = v10.Arrows

                  label.Position = UDim2.fromOffset(
                    v109.X + math.cos(value54.angle) * 65, v109.Y + math.sin(value54.angle) * 65
                  )

                  label.Rotation = math.deg(value54.angle) + 90
                  label.Visible = true
                end
              end
            end
          end
        end
      end
    end

    task.wait(1)
  end
end)

task.spawn(function()
  local spectrewareAimAssistGui, fovCircle

  local function makeScreenGui()
    if spectrewareAimAssistGui then
      spectrewareAimAssistGui:Destroy()
    end

    spectrewareAimAssistGui = Instance.new("ScreenGui")
    spectrewareAimAssistGui.Name = "SPECTREWARE_AimAssistGui"
    spectrewareAimAssistGui.ResetOnSpawn = false
    spectrewareAimAssistGui.IgnoreGuiInset = true
    spectrewareAimAssistGui.Parent = localPlayer:WaitForChild("PlayerGui")

    fovCircle = Instance.new("Frame")
    fovCircle.Name = "FOVCircle"
    fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    fovCircle.Position = UDim2.fromScale(0.5, 0.5)
    fovCircle.BackgroundTransparency = 1
    fovCircle.BorderSizePixel = 0
    fovCircle.Parent = spectrewareAimAssistGui

    local uiStroke7 = Instance.new("UIStroke")
    uiStroke7.Color = v10.FOV
    uiStroke7.Thickness = 1.5
    uiStroke7.Parent = fovCircle

    local uiCorner24 = Instance.new("UICorner")
    uiCorner24.CornerRadius = UDim.new(1, 0)
    uiCorner24.Parent = fovCircle
  end

  makeScreenGui()

  local renderStepped5 = runService.RenderStepped

  table.insert(v7, renderStepped5:Connect(function()
    if not fovCircle or not fovCircle.Parent then
      return
    else
      local value55 = v9.AimFOV and v9.AimFOV.Value or 180
      fovCircle.Size = UDim2.fromOffset(value55 * 2, value55 * 2)

      local v116 = fovCircle
      v116.Visible = v8.DrawFOV and v8.DrawFOV.Value

      if fovCircle:FindFirstChildOfClass("UIStroke") then
        local v117 = fovCircle
        v117:FindFirstChildOfClass("UIStroke").Color = v10.FOV
      end

      if v8.AimAssist and v8.AimAssist.Value
        and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local currentCamera4 = workspaceService.CurrentCamera

        if currentCamera4 then
          local character7 = localPlayer.Character
          local humanoidRootPart9 = character7 and character7:FindFirstChild("HumanoidRootPart")
          local humanoid6 = character7 and character7:FindFirstChildOfClass("Humanoid")

          if character7 and humanoidRootPart9 and humanoid6 and humanoid6.Health > 0 then
            local v118 = currentCamera4.ViewportSize / 2
            local v119 = value55
            local v120 = nil
            local value56 = v9.AimPart and v9.AimPart.Value or "Head"
            local value57 = v9.AimDist and v9.AimDist.Value or 500

            for index23, value58 in ipairs(players:GetPlayers()) do
              if value58 ~= localPlayer and value58.Character then
                local v121 = false

                if v9.AimWhitelist and type(v9.AimWhitelist.Value) == "table" then
                  if v9.AimWhitelist.Value[value58.Name] then
                    v121 = true
                  end
                elseif v9.AimWhitelist and v9.AimWhitelist.Value == value58.Name then
                  v121 = true
                end

                if not v121 then
                  local character8 = value58.Character
                  local humanoid7 = character8:FindFirstChildOfClass("Humanoid")
                  local findFirstChild3 = character8:FindFirstChild(value56)

                  local head2 = findFirstChild3
                  head2 = findFirstChild3 or character8:FindFirstChild("Head")

                  local humanoidRootPart10 = character8:FindFirstChild("HumanoidRootPart")

                  if humanoid7 and humanoid7.Health > 0 and head2 and humanoidRootPart10 then
                    if (humanoidRootPart10.Position - humanoidRootPart9.Position).Magnitude
                      <= value57 then
                      local v122, v123 = currentCamera4:WorldToViewportPoint(head2.Position)

                      if v123 and v122.Z > 0 then
                        local magnitude2 = (Vector2.new(v122.X, v122.Y) - v118).Magnitude

                        if magnitude2 <= v119 then
                          v119 = magnitude2
                          v120 = value58
                        end
                      end
                    end
                  end
                end
              end
            end

            if v120 and v120.Character then
              local findFirstChild4 = v120.Character:FindFirstChild(value56)

              local head3 = findFirstChild4
              head3 = findFirstChild4 or v120.Character:FindFirstChild("Head")

              if head3 then
                local cframe = CFrame.lookAt(currentCamera4.CFrame.Position, head3.Position)
                currentCamera4.CFrame = currentCamera4.CFrame:Lerp(cframe, 0.18)
              end
            end
          end
        end
      end

      return
    end
  end))
end)

task.spawn(function()
  local v124 = {}
  local spectrewareCrosshair, frame16

  local function makeScreenGui2()
    if spectrewareCrosshair then
      spectrewareCrosshair:Destroy()
    end

    spectrewareCrosshair = Instance.new("ScreenGui")
    spectrewareCrosshair.Name = "SPECTREWARE_Crosshair"
    spectrewareCrosshair.ResetOnSpawn = false
    spectrewareCrosshair.IgnoreGuiInset = true
    spectrewareCrosshair.Parent = localPlayer:WaitForChild("PlayerGui")

    frame16 = Instance.new("Frame")
    frame16.BackgroundTransparency = 1
    frame16.AnchorPoint = Vector2.new(0.5, 0.5)
    frame16.Position = UDim2.fromScale(0.5, 0.5)
    frame16.Size = UDim2.fromOffset(0, 0)
    frame16.Parent = spectrewareCrosshair

    v124 = {}
    local count4 = 0

    while true do
      count4 = 1 + count4

      if not (4 >= count4) then
        break
      end

      local frame17 = Instance.new("Frame")
      frame17.BorderSizePixel = 0
      frame17.AnchorPoint = Vector2.new(0.5, 0.5)
      frame17.Parent = frame16

      v124[count4] = frame17
    end
  end

  makeScreenGui2()

  local renderStepped6 = runService.RenderStepped

  table.insert(v7, renderStepped6:Connect(function()
    local value59 = v8.CustomCrosshair and v8.CustomCrosshair.Value

    if spectrewareCrosshair then
      spectrewareCrosshair.Enabled = value59
    end

    if not value59 or #v124 < 4 then
      return
    else
      local value60 = v9.CHColor and v9.CHColor.Value or Color3.fromRGB(0, 255, 120)
      local value61 = v9.CHLength and v9.CHLength.Value or 8
      local value62 = v9.CHWidth and v9.CHWidth.Value or 1
      local value63 = v9.CHGap and v9.CHGap.Value or 4

      v124[1].BackgroundColor3 = value60
      v124[1].Size = UDim2.fromOffset(value62, value61)
      v124[1].Position = UDim2.fromOffset(0, -(value63 + value61 / 2))
      v124[2].BackgroundColor3 = value60
      v124[2].Size = UDim2.fromOffset(value62, value61)
      v124[2].Position = UDim2.fromOffset(0, value63 + value61 / 2)
      v124[3].BackgroundColor3 = value60
      v124[3].Size = UDim2.fromOffset(value61, value62)
      v124[3].Position = UDim2.fromOffset(-(value63 + value61 / 2), 0)
      v124[4].BackgroundColor3 = value60
      v124[4].Size = UDim2.fromOffset(value61, value62)
      v124[4].Position = UDim2.fromOffset(value63 + value61 / 2, 0)

      return
    end
  end))
end)

task.spawn(function()
  local vector7 = Vector3.new()
  local vector8 = Vector2.new(0, 0)
  local v125 = false
  local stepped = runService.Stepped

  table.insert(v7, stepped:Connect(function(p34)
    local character9 = localPlayer.Character

    if not character9 then
      return
    else
      local humanoid8 = character9:FindFirstChildOfClass("Humanoid")

      if humanoid8 then
        if v8.Sprint and v8.Sprint.Value then
          humanoid8.WalkSpeed = (userInputService:IsKeyDown(Enum.KeyCode.LeftShift)
                or userInputService:IsKeyDown(Enum.KeyCode.RightShift))
              and (v9.SpeedValue and v9.SpeedValue.Value or 36)
            or 16
        else
          humanoid8.WalkSpeed = 16
        end
      end

      if v8.Noclip and v8.Noclip.Value then
        for index24, value64 in ipairs(character9:GetDescendants()) do
          if value64:IsA("BasePart") then
            value64.CanCollide = false
          end
        end
      end

      return
    end
  end))

  local jumpRequest = userInputService.JumpRequest

  table.insert(v7, jumpRequest:Connect(function()
    if v8.InfJump and v8.InfJump.Value and localPlayer.Character then
      local humanoid9 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid9 then
        humanoid9:ChangeState(Enum.HumanoidStateType.Jumping)
      end
    end
  end))

  local renderStepped7 = runService.RenderStepped

  table.insert(v7, renderStepped7:Connect(function(index25)
    if not (v8.Freecam and v8.Freecam.Value) then
      if v125 then
        workspaceService.CurrentCamera.CameraType = Enum.CameraType.Custom
        v125 = false
      end

      return
    else
      if not v125 then
        local currentCamera5 = workspaceService.CurrentCamera

        if currentCamera5 then
          vector7 = currentCamera5.CFrame.Position
        end
      end

      v125 = true
      local currentCamera6 = workspaceService.CurrentCamera

      if not currentCamera6 then
        return
      else
        currentCamera6.CameraType = Enum.CameraType.Scriptable
        local value65 = v9.FreecamSpeed and v9.FreecamSpeed.Value or 50

        if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
          value65 = value65 * 2.5
        end

        local vector9 = Vector3.new()

        if userInputService:IsKeyDown(Enum.KeyCode.W) then
          vector9 = vector9 + Vector3.new(0, 0, -1)
        end

        if userInputService:IsKeyDown(Enum.KeyCode.S) then
          vector9 = vector9 + Vector3.new(0, 0, 1)
        end

        if userInputService:IsKeyDown(Enum.KeyCode.A) then
          vector9 = vector9 + Vector3.new(-1, 0, 0)
        end

        if userInputService:IsKeyDown(Enum.KeyCode.D) then
          vector9 = vector9 + Vector3.new(1, 0, 0)
        end

        if userInputService:IsKeyDown(Enum.KeyCode.E) then
          vector9 = vector9 + Vector3.new(0, 1, 0)
        end

        if userInputService:IsKeyDown(Enum.KeyCode.Q) then
          vector9 = vector9 + Vector3.new(0, -1, 0)
        end

        if userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
          local getMouseDelta = userInputService:GetMouseDelta()
          vector8 = vector8 - Vector2.new(getMouseDelta.X * 0.003, getMouseDelta.Y * 0.003)
          vector8 = Vector2.new(vector8.X, math.clamp(vector8.Y, -1.57, 1.57))
        end

        local v126 = CFrame.Angles(0, vector8.X, 0) * CFrame.Angles(vector8.Y, 0, 0)
        vector7 = vector7 + v126 * vector9 * (value65 * index25)
        currentCamera6.CFrame = CFrame.new(vector7) * v126
        return
      end
    end
  end))
end)

local v127 = false
local v128 = false

local function f21()
  if v128 then
    return
  end

  v128 = true
  v127 = not v127

  tweenService:Create(
    blurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    { Size = v127 and 16 or 0 }
  ):Play()

  for index26, value66 in ipairs(v4) do
    local group = value66.Group

    if v127 then
      group.Visible = true
      group.GroupTransparency = 1
      group.Position = group.Position + UDim2.new(0, 0, 0, 15)

      tweenService:Create(group, TweenInfo.new(
        0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
      ), {
        GroupTransparency = 0,
        Position = group.Position - UDim2.new(0, 0, 0, 15),
      }):Play()
    else
      tweenService:Create(group, TweenInfo.new(
        0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In
      ), {
        GroupTransparency = 1,
        Position = group.Position + UDim2.new(0, 0, 0, 15),
      }):Play()
    end
  end

  task.delay(0.3, function()
    if not v127 then
      for index27, value67 in ipairs(v4) do
        value67.Group.Visible = false
        value67.Group.Position = value67.Group.Position - UDim2.new(0, 0, 0, 15)
      end
    end

    v128 = false
  end)
end

local inputBegan5 = userInputService.InputBegan

table.insert(v7, inputBegan5:Connect(function(p35, p36)
  if not p36 and p35.KeyCode == rightShift then
    f21()
  end
end))

local function makeTextLabel7(p37)
  tweenService:Create(blurEffect, TweenInfo.new(0.5), { Size = 24 }):Play()

  local frame18 = Instance.new("Frame")
  frame18.Size = UDim2.new(1, 0, 1, 0)
  frame18.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  frame18.BackgroundTransparency = 0.35
  frame18.ZIndex = 100
  frame18.Parent = spectreWareImpactUI

  local frame19 = Instance.new("Frame")
  frame19.Size = UDim2.new(0, 700, 0, 420)
  frame19.Position = UDim2.new(0.5, -350, 0.5, -210)
  frame19.BackgroundTransparency = 1
  frame19.ZIndex = 101
  frame19.Parent = frame18

  local imageLabel = Instance.new("ImageLabel")
  imageLabel.Size = UDim2.new(0, v1.SizeX, 0, v1.SizeY)
  imageLabel.Position = UDim2.new(0.5, -v1.SizeX / 2 + v1.OffsetX, 0, v1.OffsetY)
  imageLabel.BackgroundTransparency = 1
  imageLabel.Image = "rbxassetid://134757833073289"
  imageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
  imageLabel.ScaleType = Enum.ScaleType.Fit
  imageLabel.ZIndex = 102
  imageLabel.Parent = frame19

  pcall(function() contentProvider:PreloadAsync({ imageLabel }) end)

  local textLabel10 = Instance.new("TextLabel")
  textLabel10.Size = UDim2.new(1, 0, 0, 45)
  textLabel10.Position = UDim2.new(0, 0, 0, 210)
  textLabel10.BackgroundTransparency = 1
  textLabel10.Text = "SPECTREWARE"
  textLabel10.TextColor3 = Color3.fromRGB(255, 255, 255)
  textLabel10.TextSize = 38
  textLabel10.Font = Enum.Font.GothamBold
  textLabel10.ZIndex = 102
  textLabel10.Parent = frame19

  local textLabel11 = Instance.new("TextLabel")
  textLabel11.Size = UDim2.new(1, 0, 0, 24)
  textLabel11.Position = UDim2.new(0, 0, 0, 265)
  textLabel11.BackgroundTransparency = 1
  textLabel11.Text = "Initializing..."
  textLabel11.TextColor3 = Color3.fromRGB(210, 210, 220)
  textLabel11.TextSize = 13
  textLabel11.Font = Enum.Font.Code
  textLabel11.ZIndex = 102
  textLabel11.Parent = frame19

  local frame20 = Instance.new("Frame")
  frame20.Size = UDim2.new(1, -100, 0, 6)
  frame20.Position = UDim2.new(0, 50, 0, 305)
  frame20.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
  frame20.BorderSizePixel = 0
  frame20.ZIndex = 102
  frame20.Parent = frame19

  local uiCorner25 = Instance.new("UICorner")
  uiCorner25.CornerRadius = UDim.new(0, 3)
  uiCorner25.Parent = frame20

  local frame21 = Instance.new("Frame")
  frame21.Size = UDim2.new(0, 0, 1, 0)
  frame21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  frame21.BorderSizePixel = 0
  frame21.ZIndex = 103
  frame21.Parent = frame20

  local uiCorner26 = Instance.new("UICorner")
  uiCorner26.CornerRadius = UDim.new(0, 3)
  uiCorner26.Parent = frame21

  task.wait(1.2)
  textLabel11.Text = "Checking License & Assets..."

  tweenService:Create(frame21, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
    Size = UDim2.new(0.4, 0, 1, 0),
  }):Play()

  task.wait(0.6)
  textLabel11.Text = "Bypassing Anti-Cheat..."

  tweenService:Create(frame21, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
    Size = UDim2.new(0.75, 0, 1, 0),
  }):Play()

  task.wait(0.7)
  textLabel11.Text = "SpectreWare Ready!"

  tweenService:Create(frame21, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
    Size = UDim2.new(1, 0, 1, 0),
  }):Play()

  task.wait(0.5)
  local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

  tweenService:Create(frame18, tweenInfo, { BackgroundTransparency = 1 }):Play()
  tweenService:Create(imageLabel, tweenInfo, { ImageTransparency = 1 }):Play()
  tweenService:Create(textLabel10, tweenInfo, { TextTransparency = 1 }):Play()
  tweenService:Create(textLabel11, tweenInfo, { TextTransparency = 1 }):Play()
  tweenService:Create(frame20, tweenInfo, { BackgroundTransparency = 1 }):Play()
  tweenService:Create(frame21, tweenInfo, { BackgroundTransparency = 1 }):Play()

  task.delay(0.5, function()
    frame18:Destroy()

    if p37 then
      p37()
    end
  end)
end

makeTextLabel7(function() f21() end)

