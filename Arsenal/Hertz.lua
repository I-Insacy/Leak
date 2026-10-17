-- very bad

local coreGui = game:GetService("CoreGui")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local workspaceService = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local httpService = game:GetService("HttpService")
local guiService = game:GetService("GuiService")
local tweenService = game:GetService("TweenService")
local localPlayer = players.LocalPlayer
local currentCamera = workspaceService.CurrentCamera

if coreGui:FindFirstChild("CustomHertzHub") then
  coreGui.CustomHertzHub:Destroy()
end

local v1 = getgenv()

v1.HertzConfig = getgenv().HertzConfig or {
  Aimbot = false,
  FOVEnabled = false,
  FOVSize = 80,
  NoRecoil = false,
  SpeedEnabled = false,
  WalkSpeed = 16,
  InfiniteJump = false,
  NoClip = false,
  Fly = false,
  FlySpeed = 50,
  AutoSprint = false,
  BigJump = false,
  BigJumpHeight = 50,
  BigHeadEnabled = false,
  BigHeadSize = 3,
  CirclePlayers = false,
  CirclePlayersRadius = 50,
  VisualEnabled = false,
  VisualSelections = {
    Box = false,
    Nametag = false,
    Health = false,
    Armor = false,
    Skeleton = false,
    Snapline = false,
    Aura = false,
    Outline = false,
  },
}

local customHertzHub = Instance.new("ScreenGui")
customHertzHub.Name = "CustomHertzHub"
customHertzHub.Parent = coreGui
customHertzHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
customHertzHub.IgnoreGuiInset = true

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = customHertzHub
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -340, 0.5, -205)
mainFrame.Size = UDim2.new(0, 680, 0, 410)
mainFrame.ClipsDescendants = false

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Parent = mainFrame
uiStroke.Color = Color3.fromRGB(30, 30, 30)
uiStroke.Thickness = 1.2
uiStroke.Transparency = 0.1

local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Name = "BackgroundImage"
backgroundImage.Parent = mainFrame
backgroundImage.AnchorPoint = Vector2.new(0.5, 0.5)
backgroundImage.Position = UDim2.new(0.5, 0, 0.5, 0)
backgroundImage.Size = UDim2.new(1, 0, 1, 0)
backgroundImage.BackgroundTransparency = 1
backgroundImage.Image = "rbxassetid://6071575925"
backgroundImage.ImageTransparency = 0.65
backgroundImage.ZIndex = 0
backgroundImage.ScaleType = Enum.ScaleType.Tile
backgroundImage.TileSize = UDim2.new(0, 100, 0, 100)

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Parent = mainFrame
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topBar.BorderSizePixel = 0
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.ZIndex = 50

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 8)
uiCorner2.Parent = topBar

local textLabel = Instance.new("TextLabel")
textLabel.Parent = topBar
textLabel.BackgroundTransparency = 1
textLabel.Position = UDim2.new(0, 14, 0, 0)
textLabel.Size = UDim2.new(0, 350, 1, 0)
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = "HERTZ HUB #ARSENAL"
textLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
textLabel.TextSize = 13
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.ZIndex = 50

local textButton = Instance.new("TextButton")
textButton.Parent = topBar
textButton.BackgroundTransparency = 1
textButton.Position = UDim2.new(1, -95, 0, 0)
textButton.Size = UDim2.new(0, 30, 1, 0)
textButton.Font = Enum.Font.GothamBold
textButton.Text = "-"
textButton.TextColor3 = Color3.fromRGB(160, 160, 160)
textButton.TextSize = 16
textButton.ZIndex = 50

local textButton2 = Instance.new("TextButton")
textButton2.Parent = topBar
textButton2.BackgroundTransparency = 1
textButton2.Position = UDim2.new(1, -65, 0, 0)
textButton2.Size = UDim2.new(0, 30, 1, 0)
textButton2.Font = Enum.Font.GothamBold
textButton2.Text = "↗"
textButton2.TextColor3 = Color3.fromRGB(160, 160, 160)
textButton2.TextSize = 12
textButton2.ZIndex = 50

local textButton3 = Instance.new("TextButton")
textButton3.Parent = topBar
textButton3.BackgroundTransparency = 1
textButton3.Position = UDim2.new(1, -30, 0, 0)
textButton3.Size = UDim2.new(0, 30, 1, 0)
textButton3.Font = Enum.Font.GothamBold
textButton3.Text = "X"
textButton3.TextColor3 = Color3.fromRGB(160, 160, 160)
textButton3.TextSize = 14
textButton3.ZIndex = 50

local circle = Drawing.new("Circle")
circle.Thickness = 1.2
circle.Color = Color3.fromRGB(225, 225, 225)
circle.Transparency = 0.7
circle.Filled = false
circle.NumSides = 64
circle.Visible = false

local v2 = {}

local function f1(key)
  if v2[key] then
    for key2, value in pairs(v2[key]) do
      local v3 = value

      if typeof(v3) == "table" then
        for key3, value2 in pairs(v3) do
          local v4 = value2
          pcall(function() v4:Remove() end)
        end
      else
        pcall(function() v3:Remove() end)
      end
    end

    v2[key] = nil
  end
end

local v5 = {}

local function f2(key4)
  if v2[key4] then
    pcall(function() v2[key4].Box.Visible = false end)
    pcall(function() v2[key4].Name.Visible = false end)
    pcall(function() v2[key4].HealthBar.Visible = false end)
    pcall(function() v2[key4].ArmorBar.Visible = false end)
    pcall(function() v2[key4].Snapline.Visible = false end)

    if v2[key4].SkeletonLines then
      for key5, value3 in pairs(v2[key4].SkeletonLines) do
        local v6 = value3
        pcall(function() v6.Visible = false end)
      end
    end
  end
end

local function f3(p1)
  f2(p1)

  if p1.Character then
    local hertzOutline = p1.Character:FindFirstChild("HertzOutline")

    if hertzOutline then
      hertzOutline:Destroy()
    end

    local humanoidRootPart = p1.Character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and humanoidRootPart:FindFirstChild("HertzAura") then
      humanoidRootPart.HertzAura:Destroy()
    end
  end
end

textButton3.MouseButton1Click:Connect(function()
  circle.Visible = false
  circle:Remove()

  for key6, value4 in pairs(v2) do
    f1(key6)
  end

  for key7, value5 in pairs(v5) do
    local v7 = key7
    local cframe = value5

    if v7.Character and v7.Character:FindFirstChild("HumanoidRootPart") then
      pcall(function() v7.Character.HumanoidRootPart.CFrame = cframe end)
    end
  end

  customHertzHub:Destroy()
end)

local v8 = false

textButton.MouseButton1Click:Connect(function()
  v8 = not v8

  for key8, value6 in pairs(mainFrame:GetChildren()) do
    if value6 ~= topBar and value6 ~= uiCorner and value6 ~= uiStroke
      and value6 ~= backgroundImage then
      value6.Visible = not v8
    end
  end

  mainFrame.Size = v8 and UDim2.new(0, mainFrame.AbsoluteSize.X, 0, 36)
    or UDim2.new(0, mainFrame.AbsoluteSize.X, 0, 410)
end)

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Parent = mainFrame
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
sidebar.BorderSizePixel = 0
sidebar.Position = UDim2.new(0, 0, 0, 36)
sidebar.Size = UDim2.new(0, 150, 1, -36)
sidebar.ZIndex = 2

local containerHolder = Instance.new("Frame")
containerHolder.Name = "ContainerHolder"
containerHolder.Parent = mainFrame
containerHolder.BackgroundTransparency = 1
containerHolder.Position = UDim2.new(0, 150, 0, 36)
containerHolder.Size = UDim2.new(1, -150, 1, -36)
containerHolder.ZIndex = 2
containerHolder.ClipsDescendants = true

local pages = Instance.new("Folder")
pages.Name = "Pages"
pages.Parent = containerHolder

local function makeScrollingFrame(p2)
  local scrollingFrame = Instance.new("ScrollingFrame")
  scrollingFrame.Name = p2 .. "Page"
  scrollingFrame.Parent = pages
  scrollingFrame.Active = true
  scrollingFrame.BackgroundTransparency = 1
  scrollingFrame.BorderSizePixel = 0
  scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
  scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
  scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
  scrollingFrame.ScrollBarThickness = 4
  scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
  scrollingFrame.Visible = false
  scrollingFrame.ZIndex = 3
  scrollingFrame.ClipsDescendants = true
  scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

  local uiPadding = Instance.new("UIPadding")
  uiPadding.Parent = scrollingFrame
  uiPadding.PaddingTop = UDim.new(0, 15)
  uiPadding.PaddingBottom = UDim.new(0, 20)
  uiPadding.PaddingLeft = UDim.new(0, 15)
  uiPadding.PaddingRight = UDim.new(0, 20)

  local uiListLayout = Instance.new("UIListLayout")
  uiListLayout.Parent = scrollingFrame
  uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout.Padding = UDim.new(0, 10)

  return scrollingFrame
end

local main = makeScrollingFrame("Main")
main.Visible = true

local visual = makeScrollingFrame("Visual")
local teleport = makeScrollingFrame("Teleport")
local info = makeScrollingFrame("Info")

local function makeTextButton(parent, text, key9, p3)
  local textButton4 = Instance.new("TextButton")
  textButton4.Parent = parent
  textButton4.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
  textButton4.Size = UDim2.new(0.5, -5, 0, 32)
  textButton4.AutoButtonColor = false
  textButton4.Text = ""
  textButton4.ZIndex = 4

  local uiCorner3 = Instance.new("UICorner")
  uiCorner3.CornerRadius = UDim.new(0, 5)
  uiCorner3.Parent = textButton4

  local textLabel2 = Instance.new("TextLabel")
  textLabel2.Parent = textButton4
  textLabel2.BackgroundTransparency = 1
  textLabel2.Position = UDim2.new(0, 10, 0, 0)
  textLabel2.Size = UDim2.new(1, -50, 1, 0)
  textLabel2.Font = Enum.Font.GothamMedium
  textLabel2.Text = text
  textLabel2.TextColor3 = Color3.fromRGB(195, 195, 195)
  textLabel2.TextSize = 11
  textLabel2.TextXAlignment = Enum.TextXAlignment.Left
  textLabel2.ZIndex = 4

  local frame = Instance.new("Frame")
  frame.Parent = textButton4
  frame.AnchorPoint = Vector2.new(1, 0.5)
  frame.Position = UDim2.new(1, -10, 0.5, 0)
  frame.Size = UDim2.new(0, 26, 0, 14)

  frame.BackgroundColor3 = getgenv().HertzConfig[key9] and Color3.fromRGB(225, 225, 225)
    or Color3.fromRGB(30, 30, 30)

  frame.ZIndex = 5

  local uiCorner4 = Instance.new("UICorner")
  uiCorner4.CornerRadius = UDim.new(1, 0)
  uiCorner4.Parent = frame

  local frame2 = Instance.new("Frame")
  frame2.Parent = frame
  frame2.AnchorPoint = Vector2.new(0, 0.5)

  frame2.Position = getgenv().HertzConfig[key9] and UDim2.new(1, -12, 0.5, 0)
    or UDim2.new(0, 2, 0.5, 0)

  frame2.Size = UDim2.new(0, 10, 0, 10)
  frame2.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
  frame2.ZIndex = 6

  local uiCorner5 = Instance.new("UICorner")
  uiCorner5.CornerRadius = UDim.new(1, 0)
  uiCorner5.Parent = frame2

  textButton4.MouseButton1Click:Connect(function()
    getgenv().HertzConfig[key9] = not getgenv().HertzConfig[key9]
    local v9 = getgenv().HertzConfig[key9]
    frame.BackgroundColor3 = v9 and Color3.fromRGB(225, 225, 225) or Color3.fromRGB(30, 30, 30)

    frame2:TweenPosition(
      v9 and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad, 0.15, true
    )

    if p3 then
      p3(v9)
    end
  end)

  return textButton4, frame, frame2
end

local function makeTextLabel(parent2, text2, layoutOrder)
  local textLabel3 = Instance.new("TextLabel")
  textLabel3.Parent = parent2
  textLabel3.BackgroundTransparency = 1
  textLabel3.Size = UDim2.new(1, 0, 0, 22)
  textLabel3.Font = Enum.Font.GothamBold
  textLabel3.Text = text2
  textLabel3.TextColor3 = Color3.fromRGB(180, 180, 180)
  textLabel3.TextSize = 11.5
  textLabel3.TextXAlignment = Enum.TextXAlignment.Left
  textLabel3.ZIndex = 1
  textLabel3.LayoutOrder = layoutOrder

  return textLabel3
end

local function makeFrame(parent3, layoutOrder2)
  local frame3 = Instance.new("Frame")
  frame3.Parent = parent3
  frame3.BackgroundTransparency = 1
  frame3.Size = UDim2.new(1, 0, 0, 32)
  frame3.ZIndex = 3
  frame3.ClipsDescendants = false
  frame3.LayoutOrder = layoutOrder2

  local uiListLayout2 = Instance.new("UIListLayout")
  uiListLayout2.Parent = frame3
  uiListLayout2.FillDirection = Enum.FillDirection.Horizontal
  uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout2.Padding = UDim.new(0, 10)

  return frame3
end

local function makeTextButton2(p4, text3, key10, p5, text4, index, index2, text5, p6)
  local frame4 = Instance.new("Frame")
  frame4.Parent = p4
  frame4.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
  frame4.Size = UDim2.new(0.5, -5, 0, 32)
  frame4.ClipsDescendants = false
  frame4.ZIndex = 15

  local uiCorner6 = Instance.new("UICorner")
  uiCorner6.CornerRadius = UDim.new(0, 5)
  uiCorner6.Parent = frame4

  local textLabel4 = Instance.new("TextLabel")
  textLabel4.Parent = frame4
  textLabel4.BackgroundTransparency = 1
  textLabel4.Position = UDim2.new(0, 10, 0, 0)
  textLabel4.Size = UDim2.new(1, -70, 0, 32)
  textLabel4.Font = Enum.Font.GothamBold
  textLabel4.Text = text3
  textLabel4.TextColor3 = Color3.fromRGB(215, 215, 215)
  textLabel4.TextSize = 11
  textLabel4.TextXAlignment = Enum.TextXAlignment.Left
  textLabel4.ZIndex = 16

  local textButton5 = Instance.new("TextButton")
  textButton5.Parent = frame4
  textButton5.AnchorPoint = Vector2.new(1, 0)
  textButton5.Position = UDim2.new(1, -10, 0, 9)
  textButton5.Size = UDim2.new(0, 26, 0, 14)

  textButton5.BackgroundColor3 = getgenv().HertzConfig[key10] and Color3.fromRGB(225, 225, 225)
    or Color3.fromRGB(30, 30, 30)

  textButton5.AutoButtonColor = false
  textButton5.Text = ""
  textButton5.ZIndex = 17

  local uiCorner7 = Instance.new("UICorner")
  uiCorner7.CornerRadius = UDim.new(1, 0)
  uiCorner7.Parent = textButton5

  local frame5 = Instance.new("Frame")
  frame5.Parent = textButton5
  frame5.AnchorPoint = Vector2.new(0, 0.5)

  frame5.Position = getgenv().HertzConfig[key10] and UDim2.new(1, -12, 0.5, 0)
    or UDim2.new(0, 2, 0.5, 0)

  frame5.Size = UDim2.new(0, 10, 0, 10)
  frame5.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
  frame5.ZIndex = 18

  local uiCorner8 = Instance.new("UICorner")
  uiCorner8.CornerRadius = UDim.new(1, 0)
  uiCorner8.Parent = frame5

  local textButton6 = Instance.new("TextButton")
  textButton6.Parent = frame4
  textButton6.AnchorPoint = Vector2.new(1, 0)
  textButton6.Position = UDim2.new(1, -40, 0, 9)
  textButton6.Size = UDim2.new(0, 14, 0, 14)
  textButton6.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  textButton6.AutoButtonColor = false
  textButton6.Font = Enum.Font.GothamBold
  textButton6.Text = "v"
  textButton6.TextColor3 = Color3.fromRGB(180, 180, 180)
  textButton6.TextSize = 8
  textButton6.ZIndex = 17

  local uiCorner9 = Instance.new("UICorner")
  uiCorner9.CornerRadius = UDim.new(0, 3)
  uiCorner9.Parent = textButton6

  local frame6 = Instance.new("Frame")
  frame6.Parent = frame4
  frame6.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
  frame6.Position = UDim2.new(0, 0, 1, 4)
  frame6.Size = UDim2.new(1, 0, 0, 36)
  frame6.Visible = false
  frame6.ZIndex = 120

  local uiCorner10 = Instance.new("UICorner")
  uiCorner10.CornerRadius = UDim.new(0, 5)
  uiCorner10.Parent = frame6

  local uiStroke2 = Instance.new("UIStroke")
  uiStroke2.Parent = frame6
  uiStroke2.Color = Color3.fromRGB(50, 50, 50)
  uiStroke2.Thickness = 1

  local textLabel5 = Instance.new("TextLabel")
  textLabel5.Parent = frame6
  textLabel5.BackgroundTransparency = 1
  textLabel5.Position = UDim2.new(0, 10, 0, 3)
  textLabel5.Size = UDim2.new(1, -55, 0, 14)
  textLabel5.Font = Enum.Font.GothamMedium
  textLabel5.Text = text4
  textLabel5.TextColor3 = Color3.fromRGB(195, 195, 195)
  textLabel5.TextSize = 10
  textLabel5.TextXAlignment = Enum.TextXAlignment.Left
  textLabel5.ZIndex = 121

  local textLabel6 = Instance.new("TextLabel")
  textLabel6.Parent = frame6
  textLabel6.BackgroundTransparency = 1
  textLabel6.Position = UDim2.new(1, -45, 0, 3)
  textLabel6.Size = UDim2.new(0, 35, 0, 14)
  textLabel6.Font = Enum.Font.GothamBold
  textLabel6.Text = tostring(text5)
  textLabel6.TextColor3 = Color3.fromRGB(195, 195, 195)
  textLabel6.TextSize = 10
  textLabel6.TextXAlignment = Enum.TextXAlignment.Right
  textLabel6.ZIndex = 121

  local frame7 = Instance.new("Frame")
  frame7.Parent = frame6
  frame7.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  frame7.Position = UDim2.new(0, 10, 0, 22)
  frame7.Size = UDim2.new(1, -20, 0, 4)
  frame7.ZIndex = 121

  local frame8 = Instance.new("Frame")
  frame8.Parent = frame7
  frame8.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
  frame8.Size = UDim2.new((text5 - index) / (index2 - index), 0, 1, 0)
  frame8.ZIndex = 122

  local v10 = false

  textButton6.MouseButton1Click:Connect(function()
    v10 = not v10
    textButton6.Text = v10 and "^" or "v"
    frame6.Visible = v10

    if v10 then
      p4.ZIndex = 100
      frame4.ZIndex = 100
    else
      p4.ZIndex = 3
      frame4.ZIndex = 15
    end
  end)

  textButton5.MouseButton1Click:Connect(function()
    getgenv().HertzConfig[key10] = not getgenv().HertzConfig[key10]
    local v11 = getgenv().HertzConfig[key10]

    textButton5.BackgroundColor3 = v11 and Color3.fromRGB(225, 225, 225)
      or Color3.fromRGB(30, 30, 30)

    frame5:TweenPosition(
      v11 and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad, 0.15, true
    )

    if p5 then
      p5(v11)
    end
  end)

  local v12 = false

  local function f4(input)
    local v13 = math.clamp(
      (input.Position.X - frame7.AbsolutePosition.X) / frame7.AbsoluteSize.X, 0, 1
    )

    local v14 = math.floor(index + (index2 - index) * v13)
    frame8.Size = UDim2.new(v13, 0, 1, 0)
    textLabel6.Text = tostring(v14)

    if p6 then
      p6(v14)
    end
  end

  frame7.InputBegan:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseButton1
      or input2.UserInputType == Enum.UserInputType.Touch then
      v12 = true
      f4(input2)
    end
  end)

  userInputService.InputEnded:Connect(function(input3)
    if input3.UserInputType == Enum.UserInputType.MouseButton1
      or input3.UserInputType == Enum.UserInputType.Touch then
      v12 = false
    end
  end)

  userInputService.InputChanged:Connect(function(input4)
    if v12
      and (input4.UserInputType == Enum.UserInputType.MouseMovement
        or input4.UserInputType == Enum.UserInputType.Touch) then
      f4(input4)
    end
  end)

  return frame4, textButton5, frame5
end

makeTextLabel(main, "Combat & Main Features", 1)
local v15 = makeFrame(main, 2)

makeTextButton(v15, "Universal No Recoil", "NoRecoil", function(noRecoil)
  getgenv().HertzConfig.NoRecoil = noRecoil
end)

makeTextButton(v15, "No Clip (Walk Through Walls)", "NoClip", function(noClip)
  getgenv().HertzConfig.NoClip = noClip
end)

local v16 = makeFrame(main, 3)

makeTextButton(v16, "Aimbot (Hold RMB)", "Aimbot", function(aimbot)
  getgenv().HertzConfig.Aimbot = aimbot
end)

makeTextButton2(
  v16, "Show FOV Circle", "FOVEnabled",
  function(fovEnabled) getgenv().HertzConfig.FOVEnabled = fovEnabled end, "FOV Radius Size", 20,
  300, getgenv().HertzConfig.FOVSize,
  function(fovSize) getgenv().HertzConfig.FOVSize = fovSize end
)

makeTextLabel(main, "Movement Features", 4)
local v17 = makeFrame(main, 5)
local v18, v19

v19, _, v18 = makeTextButton2(v17, "Custom WalkSpeed Hack", "SpeedEnabled", function(p7)
  getgenv().HertzConfig.SpeedEnabled = p7

  if not p7 and localPlayer.Character then
    local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid then
      humanoid.WalkSpeed = 16
    end
  end
end, "WalkSpeed Modifier", 16, 120, getgenv().HertzConfig.WalkSpeed, function(walkSpeed) getgenv().HertzConfig.WalkSpeed = walkSpeed end)

makeTextButton(v17, "Infinite Jump", "InfiniteJump", function(infiniteJump)
  getgenv().HertzConfig.InfiniteJump = infiniteJump
end)

local v20 = makeFrame(main, 6)

makeTextButton2(
  v20, "Big Jump Height", "BigJump",
  function(bigJump) getgenv().HertzConfig.BigJump = bigJump end, "Jump Height Power", 30, 200,
  getgenv().HertzConfig.BigJumpHeight,
  function(bigJumpHeight) getgenv().HertzConfig.BigJumpHeight = bigJumpHeight end
)

makeTextButton(v20, "Fly Mode (Space/Ctrl)", "Fly", function(fly)
  getgenv().HertzConfig.Fly = fly
end)

local v21 = makeFrame(main, 7)

makeTextButton2(
  v21, "Fly Speed Multiplier", "Fly", function(p8) end, "Fly Speed Power", 20, 200,
  getgenv().HertzConfig.FlySpeed,
  function(flySpeed) getgenv().HertzConfig.FlySpeed = flySpeed end
)

makeTextButton(v21, "Auto Sprint", "AutoSprint", function(autoSprint)
  getgenv().HertzConfig.AutoSprint = autoSprint
end)

makeTextLabel(main, "Trolling & Fun Features", 8)

makeTextButton2(makeFrame(main, 9), "Circle All Players", "CirclePlayers", function(p9)
  getgenv().HertzConfig.CirclePlayers = p9

  if not p9 then
    for key11, value7 in pairs(v5) do
      local v22 = key11
      local cframe2 = value7

      if v22.Character and v22.Character:FindFirstChild("HumanoidRootPart") then
        pcall(function() v22.Character.HumanoidRootPart.CFrame = cframe2 end)
      end
    end

    v5 = {}
  end
end, "Search Radius", 10, 300, getgenv().HertzConfig.CirclePlayersRadius, function(circlePlayersRadius)
  getgenv().HertzConfig.CirclePlayersRadius = circlePlayersRadius
end)

makeTextLabel(visual, "Wallhacks & Modifications", 1)

local function makeTextButton3(p10, text6, key12, index3, p11)
  local frame9 = Instance.new("Frame")
  frame9.Parent = p10
  frame9.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
  frame9.Size = UDim2.new(0.5, -5, 0, 32)
  frame9.ClipsDescendants = false
  frame9.ZIndex = 15

  local uiCorner11 = Instance.new("UICorner")
  uiCorner11.CornerRadius = UDim.new(0, 5)
  uiCorner11.Parent = frame9

  local textLabel7 = Instance.new("TextLabel")
  textLabel7.Parent = frame9
  textLabel7.BackgroundTransparency = 1
  textLabel7.Position = UDim2.new(0, 10, 0, 0)
  textLabel7.Size = UDim2.new(1, -70, 0, 32)
  textLabel7.Font = Enum.Font.GothamBold
  textLabel7.Text = text6
  textLabel7.TextColor3 = Color3.fromRGB(215, 215, 215)
  textLabel7.TextSize = 11
  textLabel7.TextXAlignment = Enum.TextXAlignment.Left
  textLabel7.ZIndex = 16

  local textButton7 = Instance.new("TextButton")
  textButton7.Parent = frame9
  textButton7.AnchorPoint = Vector2.new(1, 0)
  textButton7.Position = UDim2.new(1, -10, 0, 9)
  textButton7.Size = UDim2.new(0, 26, 0, 14)

  textButton7.BackgroundColor3 = getgenv().HertzConfig[key12] and Color3.fromRGB(225, 225, 225)
    or Color3.fromRGB(30, 30, 30)

  textButton7.AutoButtonColor = false
  textButton7.Text = ""
  textButton7.ZIndex = 17

  local uiCorner12 = Instance.new("UICorner")
  uiCorner12.CornerRadius = UDim.new(1, 0)
  uiCorner12.Parent = textButton7

  local frame10 = Instance.new("Frame")
  frame10.Parent = textButton7
  frame10.AnchorPoint = Vector2.new(0, 0.5)

  frame10.Position = getgenv().HertzConfig[key12] and UDim2.new(1, -12, 0.5, 0)
    or UDim2.new(0, 2, 0.5, 0)

  frame10.Size = UDim2.new(0, 10, 0, 10)
  frame10.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
  frame10.ZIndex = 18

  local uiCorner13 = Instance.new("UICorner")
  uiCorner13.CornerRadius = UDim.new(1, 0)
  uiCorner13.Parent = frame10

  local textButton8 = Instance.new("TextButton")
  textButton8.Parent = frame9
  textButton8.AnchorPoint = Vector2.new(1, 0)
  textButton8.Position = UDim2.new(1, -40, 0, 9)
  textButton8.Size = UDim2.new(0, 14, 0, 14)
  textButton8.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  textButton8.AutoButtonColor = false
  textButton8.Font = Enum.Font.GothamBold
  textButton8.Text = "v"
  textButton8.TextColor3 = Color3.fromRGB(180, 180, 180)
  textButton8.TextSize = 8
  textButton8.ZIndex = 17

  local uiCorner14 = Instance.new("UICorner")
  uiCorner14.CornerRadius = UDim.new(0, 3)
  uiCorner14.Parent = textButton8

  local frame11 = Instance.new("Frame")
  frame11.Parent = frame9
  frame11.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
  frame11.Position = UDim2.new(0, 0, 1, 4)
  frame11.Size = UDim2.new(1, 0, 0, #index3 * 24 + 8)
  frame11.Visible = false
  frame11.ZIndex = 120

  local uiCorner15 = Instance.new("UICorner")
  uiCorner15.CornerRadius = UDim.new(0, 5)
  uiCorner15.Parent = frame11

  local uiStroke3 = Instance.new("UIStroke")
  uiStroke3.Parent = frame11
  uiStroke3.Color = Color3.fromRGB(50, 50, 50)
  uiStroke3.Thickness = 1

  local v23 = false

  textButton8.MouseButton1Click:Connect(function()
    v23 = not v23
    textButton8.Text = v23 and "^" or "v"
    frame11.Visible = v23

    if v23 then
      p10.ZIndex = 100
      frame9.ZIndex = 100
      frame11.ZIndex = 120
    else
      p10.ZIndex = 3
      frame9.ZIndex = 15
      frame11.ZIndex = 40
    end
  end)

  textButton7.MouseButton1Click:Connect(function()
    getgenv().HertzConfig[key12] = not getgenv().HertzConfig[key12]
    local v24 = getgenv().HertzConfig[key12]

    textButton7.BackgroundColor3 = v24 and Color3.fromRGB(225, 225, 225)
      or Color3.fromRGB(30, 30, 30)

    frame10:TweenPosition(
      v24 and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), Enum.EasingDirection.Out,
      Enum.EasingStyle.Quad, 0.15, true
    )

    if p11 then
      p11(v24)
    end
  end)

  for index4, value8 in ipairs(index3) do
    local v25 = value8

    local textButton9 = Instance.new("TextButton")
    textButton9.Parent = frame11
    textButton9.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    textButton9.Position = UDim2.new(0, 6, 0, (index4 - 1) * 24 + 4)
    textButton9.Size = UDim2.new(1, -12, 0, 20)
    textButton9.AutoButtonColor = false
    textButton9.Text = ""
    textButton9.ZIndex = 121

    local uiCorner16 = Instance.new("UICorner")
    uiCorner16.CornerRadius = UDim.new(0, 3)
    uiCorner16.Parent = textButton9

    local textLabel8 = Instance.new("TextLabel")
    textLabel8.Parent = textButton9
    textLabel8.BackgroundTransparency = 1
    textLabel8.Position = UDim2.new(0, 6, 0, 0)
    textLabel8.Size = UDim2.new(1, -6, 1, 0)
    textLabel8.Font = Enum.Font.Gotham
    textLabel8.Text = v25.Name

    textLabel8.TextColor3 = v25.GetState() and Color3.fromRGB(225, 225, 225)
      or Color3.fromRGB(135, 135, 135)

    textLabel8.TextSize = 10.5
    textLabel8.TextXAlignment = Enum.TextXAlignment.Left
    textLabel8.ZIndex = 121

    textButton9.MouseButton1Click:Connect(function()
      textLabel8.TextColor3 = v25.Toggle() and Color3.fromRGB(225, 225, 225)
        or Color3.fromRGB(135, 135, 135)
    end)
  end

  return frame9, textButton7, frame10
end

local v26 = makeFrame(visual, 2)
local v27, v28

_, v27, v28 = makeTextButton3(v26, "Wallhack (ESP Hub)", "VisualEnabled", {
  {
    Name = "Box ESP",
    GetState = function() return getgenv().HertzConfig.VisualSelections.Box end,
    Toggle = function()
      getgenv().HertzConfig.VisualSelections.Box = not getgenv().HertzConfig.VisualSelections.Box
      return getgenv().HertzConfig.VisualSelections.Box
    end,
  },
  {
    Name = "Nametags (Below Feet, Thin)",
    GetState = function() return getgenv().HertzConfig.VisualSelections.Nametag end,
    Toggle = function()
      getgenv().HertzConfig.VisualSelections.Nametag = not getgenv().HertzConfig.VisualSelections.Nametag
      return getgenv().HertzConfig.VisualSelections.Nametag
    end,
  },
  {
    Name = "Health Bars",
    GetState = function() return getgenv().HertzConfig.VisualSelections.Health end,
    Toggle = function()
      getgenv().HertzConfig.VisualSelections.Health = not getgenv().HertzConfig.VisualSelections.Health
      return getgenv().HertzConfig.VisualSelections.Health
    end,
  },
  {
    Name = "Armor Bars",
    GetState = function() return getgenv().HertzConfig.VisualSelections.Armor end,
    Toggle = function()
      getgenv().HertzConfig.VisualSelections.Armor = not getgenv().HertzConfig.VisualSelections.Armor
      return getgenv().HertzConfig.VisualSelections.Armor
    end,
  },
  {
    Name = "Skeleton ESP",
    GetState = function() return getgenv().HertzConfig.VisualSelections.Skeleton end,
    Toggle = function()
      getgenv().HertzConfig.VisualSelections.Skeleton = not getgenv().HertzConfig.VisualSelections.Skeleton
      return getgenv().HertzConfig.VisualSelections.Skeleton
    end,
  },
  {
    Name = "Snaplines",
    GetState = function() return getgenv().HertzConfig.VisualSelections.Snapline end,
    Toggle = function()
      getgenv().HertzConfig.VisualSelections.Snapline = not getgenv().HertzConfig.VisualSelections.Snapline
      return getgenv().HertzConfig.VisualSelections.Snapline
    end,
  },
  {
    Name = "Rainbow Aura",
    GetState = function() return getgenv().HertzConfig.VisualSelections.Aura end,
    Toggle = function()
      getgenv().HertzConfig.VisualSelections.Aura = not getgenv().HertzConfig.VisualSelections.Aura
      return getgenv().HertzConfig.VisualSelections.Aura
    end,
  },
  {
    Name = "Body Outline",
    GetState = function() return getgenv().HertzConfig.VisualSelections.Outline end,
    Toggle = function()
      getgenv().HertzConfig.VisualSelections.Outline = not getgenv().HertzConfig.VisualSelections.Outline
      return getgenv().HertzConfig.VisualSelections.Outline
    end,
  },
}, function(p12)
  getgenv().HertzConfig.VisualEnabled = p12

  if not p12 then
    for key13, value9 in pairs(v2) do
    end
  end
end)

makeTextButton2(v26, "BigHead Expansion", "BigHeadEnabled", function(bigHeadEnabled)
  getgenv().HertzConfig.BigHeadEnabled = bigHeadEnabled
end, "Scale Limit", 1, 8, getgenv().HertzConfig.BigHeadSize, function(bigHeadSize) getgenv().HertzConfig.BigHeadSize = bigHeadSize end)

local function makeTextButton4()
  for key14, value10 in pairs(teleport:GetChildren()) do
    if value10:IsA("Frame") or value10:IsA("TextLabel") then
      value10:Destroy()
    end
  end

  makeTextLabel(teleport, "Players In Game (" .. #players:GetPlayers() - 1 .. ")", 1)
  local v29 = 2

  for index5, value11 in ipairs(players:GetPlayers()) do
    local v30 = value11

    if v30 ~= localPlayer then
      local frame12 = Instance.new("Frame")
      frame12.Parent = teleport
      frame12.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
      frame12.Size = UDim2.new(1, 0, 0, 36)
      frame12.ZIndex = 4
      frame12.LayoutOrder = v29

      v29 = v29 + 1

      local uiCorner17 = Instance.new("UICorner")
      uiCorner17.CornerRadius = UDim.new(0, 5)
      uiCorner17.Parent = frame12

      local imageLabel = Instance.new("ImageLabel")
      imageLabel.Parent = frame12
      imageLabel.Position = UDim2.new(0, 8, 0.5, -13)
      imageLabel.Size = UDim2.new(0, 26, 0, 26)
      imageLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
      imageLabel.Image = "rbxthumb://type=AvatarHeadShot&id=" .. v30.UserId .. "&w=150&h=150"
      imageLabel.ZIndex = 5

      local uiCorner18 = Instance.new("UICorner")
      uiCorner18.CornerRadius = UDim.new(1, 0)
      uiCorner18.Parent = imageLabel

      local uiStroke4 = Instance.new("UIStroke")
      uiStroke4.Parent = imageLabel
      uiStroke4.Color = Color3.fromRGB(50, 50, 50)
      uiStroke4.Thickness = 1

      local textLabel9 = Instance.new("TextLabel")
      textLabel9.Parent = frame12
      textLabel9.BackgroundTransparency = 1
      textLabel9.Position = UDim2.new(0, 42, 0, 0)
      textLabel9.Size = UDim2.new(1, -125, 1, 0)
      textLabel9.Font = Enum.Font.GothamMedium
      textLabel9.Text = v30.DisplayName .. " (@" .. v30.Name .. ")"
      textLabel9.TextColor3 = Color3.fromRGB(205, 205, 205)
      textLabel9.TextSize = 11
      textLabel9.TextXAlignment = Enum.TextXAlignment.Left
      textLabel9.TextTruncate = Enum.TextTruncate.AtEnd
      textLabel9.ZIndex = 5

      local textButton10 = Instance.new("TextButton")
      textButton10.Parent = frame12
      textButton10.AnchorPoint = Vector2.new(1, 0.5)
      textButton10.Position = UDim2.new(1, -8, 0.5, 0)
      textButton10.Size = UDim2.new(0, 65, 0, 22)
      textButton10.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
      textButton10.Font = Enum.Font.GothamBold
      textButton10.Text = "Teleport"
      textButton10.TextColor3 = Color3.fromRGB(225, 225, 225)
      textButton10.TextSize = 10
      textButton10.ZIndex = 5
      textButton10.AutoButtonColor = true

      local uiCorner19 = Instance.new("UICorner")
      uiCorner19.CornerRadius = UDim.new(0, 4)
      uiCorner19.Parent = textButton10

      textButton10.MouseButton1Click:Connect(function()
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
          if v30.Character and v30.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = v30.Character.HumanoidRootPart.CFrame
              * CFrame.new(0, 0, 3)
          end
        end
      end)
    end
  end
end

players.PlayerAdded:Connect(makeTextButton4)
players.PlayerRemoving:Connect(makeTextButton4)

makeTextButton4()
makeTextLabel(info, "Hub Information & Links", 1)

local textButton11 = Instance.new("TextButton")
textButton11.Parent = info
textButton11.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
textButton11.Size = UDim2.new(1, 0, 0, 36)
textButton11.AutoButtonColor = false
textButton11.Font = Enum.Font.GothamMedium
textButton11.Text = "  @prayfornueve ( author )"
textButton11.TextColor3 = Color3.fromRGB(225, 225, 225)
textButton11.TextSize = 12
textButton11.TextXAlignment = Enum.TextXAlignment.Left
textButton11.ZIndex = 3
textButton11.LayoutOrder = 2

local uiCorner20 = Instance.new("UICorner")
uiCorner20.CornerRadius = UDim.new(0, 5)
uiCorner20.Parent = textButton11

local textButton12 = Instance.new("TextButton")
textButton12.Parent = info
textButton12.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
textButton12.Size = UDim2.new(1, 0, 0, 36)
textButton12.AutoButtonColor = false
textButton12.Font = Enum.Font.GothamMedium
textButton12.Text = "  HERTZ #PODCAST"
textButton12.TextColor3 = Color3.fromRGB(100, 160, 255)
textButton12.TextSize = 12
textButton12.TextXAlignment = Enum.TextXAlignment.Left
textButton12.ZIndex = 3
textButton12.LayoutOrder = 3

local uiCorner21 = Instance.new("UICorner")
uiCorner21.CornerRadius = UDim.new(0, 5)
uiCorner21.Parent = textButton12

textButton12.MouseButton1Click:Connect(function()

  textButton12.Text = "  [ Opened in Chrome / Discord App! ]"
  task.wait(1.5)
  textButton12.Text = "  HERTZ #PODCAST"
end)

local v31

local function makeTextButton5(text7, index6, p13)
  local textButton13 = Instance.new("TextButton")
  textButton13.Parent = sidebar
  textButton13.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
  textButton13.BorderSizePixel = 0
  textButton13.Position = UDim2.new(0, 10, 0, 12 + (index6 - 1) * 38)
  textButton13.Size = UDim2.new(0, 130, 0, 32)
  textButton13.AutoButtonColor = false
  textButton13.ZIndex = 3
  textButton13.Visible = true

  local uiCorner22 = Instance.new("UICorner")
  uiCorner22.CornerRadius = UDim.new(0, 5)
  uiCorner22.Parent = textButton13

  textButton13.Font = Enum.Font.GothamMedium
  textButton13.Text = text7
  textButton13.TextColor3 = Color3.fromRGB(130, 130, 130)
  textButton13.TextSize = 11.5

  textButton13.MouseButton1Click:Connect(function()
    for key15, value12 in pairs(pages:GetChildren()) do
      value12.Visible = false
    end

    p13.Visible = true

    if v31 then
      v31.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
      v31.TextColor3 = Color3.fromRGB(130, 130, 130)
    end

    textButton13.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    textButton13.TextColor3 = Color3.fromRGB(225, 225, 225)

    v31 = textButton13
  end)

  return textButton13
end

local v32 = makeTextButton5("Main", 1, main)
v32.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
v32.TextColor3 = Color3.fromRGB(225, 225, 225)

v31 = v32

makeTextButton5("Visual", 2, visual)
makeTextButton5("Teleport", 3, teleport)
makeTextButton5("Information", 4, info)

local textLabel10 = Instance.new("TextLabel")
textLabel10.Parent = sidebar
textLabel10.BackgroundTransparency = 1
textLabel10.Position = UDim2.new(0, 12, 0, 326)
textLabel10.Size = UDim2.new(0, 126, 0, 36)
textLabel10.Font = Enum.Font.GothamBold

textLabel10.Text = [[
Made By
@prayfornueve]]

textLabel10.TextColor3 = Color3.fromRGB(90, 90, 90)
textLabel10.TextSize = 10
textLabel10.TextXAlignment = Enum.TextXAlignment.Left
textLabel10.ZIndex = 3

local v33, position, position2

topBar.InputBegan:Connect(function(input5)
  if input5.UserInputType == Enum.UserInputType.MouseButton1
    or input5.UserInputType == Enum.UserInputType.Touch then
    v33 = true
    position = input5.Position
    position2 = mainFrame.Position

    input5.Changed:Connect(function()
      if input5.UserInputState == Enum.UserInputState.End then
        v33 = false
      end
    end)
  end
end)

local v34

userInputService.InputChanged:Connect(function(input6)
  if input6.UserInputType == Enum.UserInputType.MouseMovement
    or input6.UserInputType == Enum.UserInputType.Touch then
    v34 = input6
  end
end)

local v35 = false
local position3, absoluteSize

textButton2.InputBegan:Connect(function(input7)
  if input7.UserInputType == Enum.UserInputType.MouseButton1
    or input7.UserInputType == Enum.UserInputType.Touch then
    v35 = true
    position3 = input7.Position
    absoluteSize = mainFrame.AbsoluteSize

    input7.Changed:Connect(function()
      if input7.UserInputState == Enum.UserInputState.End then
        v35 = false
      end
    end)
  end
end)

runService.RenderStepped:Connect(function()
  if v33 and v34 then
    local v36 = v34.Position - position

    mainFrame.Position = UDim2.new(
      position2.X.Scale, position2.X.Offset + v36.X, position2.Y.Scale,
      position2.Y.Offset + v36.Y
    )
  end

  if v35 and v34 then
    local v37 = v34.Position - position3
    local v38 = math.clamp(absoluteSize.X + v37.X, 450, 1200)
    local v39 = math.clamp(absoluteSize.Y + v37.Y, 300, 800)
    mainFrame.Size = UDim2.new(0, v38, 0, v39)
  end
end)

local v40 = 0
local v41 = 0
local v42 = 0

userInputService.InputBegan:Connect(function(input8, p14)
  if p14 then
    return
  else
    local v43 = tick()

    if input8.KeyCode == Enum.KeyCode.H then
      if v43 - v40 > 0.3 then
        v40 = v43
        mainFrame.Visible = not mainFrame.Visible
      end
    elseif input8.KeyCode == Enum.KeyCode.KeypadEight then
      if v43 - v41 > 0.3 then
        v41 = v43
        getgenv().HertzConfig.SpeedEnabled = not getgenv().HertzConfig.SpeedEnabled
        local speedEnabled = getgenv().HertzConfig.SpeedEnabled

        if not speedEnabled and localPlayer.Character then
          local humanoid2 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

          if humanoid2 then
            humanoid2.WalkSpeed = 16
          end
        end

        if v19 then
          v19.BackgroundColor3 = speedEnabled and Color3.fromRGB(225, 225, 225)
            or Color3.fromRGB(30, 30, 30)
        end

        if v18 then
          v18:TweenPosition(
            speedEnabled and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
            Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true
          )
        end
      end
    elseif input8.KeyCode == Enum.KeyCode.KeypadNine then
      if v43 - v42 > 0.3 then
        v42 = v43
        getgenv().HertzConfig.VisualEnabled = not getgenv().HertzConfig.VisualEnabled
        local visualEnabled = getgenv().HertzConfig.VisualEnabled

        if not visualEnabled then
          for key16, value13 in pairs(v2) do
          end
        end

        if v27 then
          v27.BackgroundColor3 = visualEnabled and Color3.fromRGB(225, 225, 225)
            or Color3.fromRGB(30, 30, 30)
        end

        if v28 then
          v28:TweenPosition(visualEnabled and UDim2.new(1, -12, 0.5, 0)
            or UDim2.new(0, 2, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
      end
    end

    return
  end
end)

userInputService.JumpRequest:Connect(function()
  if getgenv().HertzConfig.InfiniteJump and localPlayer.Character
    and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
    localPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
  end
end)

local function f5(key17)
  key17.CharacterRemoving:Connect(function()
    f3(key17)
    f1(key17)

    if v5[key17] then
      v5[key17] = nil
    end
  end)
end

for index7, value14 in ipairs(players:GetPlayers()) do
  if value14 ~= localPlayer then
    f5(value14)
  end
end

players.PlayerAdded:Connect(function(player)
  if player ~= localPlayer then
    f5(player)
  end
end)

players.PlayerRemoving:Connect(function(player2)
  f3(player2)
  f1(player2)

  if v5[player2] then
    v5[player2] = nil
  end
end)

runService.RenderStepped:Connect(function()
  if not customHertzHub.Parent then
    return
  else
    for key18, value15 in pairs(v2) do
    end

    if getgenv().HertzConfig.Aimbot and getgenv().HertzConfig.FOVEnabled then
      circle.Visible = true
      circle.Radius = getgenv().HertzConfig.FOVSize
      circle.Position = userInputService:GetMouseLocation()
    else
      circle.Visible = false
    end

    if getgenv().HertzConfig.Aimbot
      and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
      local head = nil
      local fovSize2 = getgenv().HertzConfig.FOVSize
      local getMouseLocation = userInputService:GetMouseLocation()

      for key19, value16 in pairs(players:GetPlayers()) do
        if value16 ~= localPlayer and value16.Character
          and value16.Character:FindFirstChild("Head")
          and value16.Character:FindFirstChildOfClass("Humanoid") then
          if value16.Character.Humanoid.Health > 0 then
            local v44, v45 = currentCamera:WorldToViewportPoint(value16.Character.Head.Position)

            if v45 then
              local magnitude = (Vector2.new(v44.X, v44.Y) - getMouseLocation).Magnitude

              if magnitude < fovSize2 then
                fovSize2 = magnitude
                head = value16.Character.Head
              end
            end
          end
        end
      end

      if head then
        currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, head.Position)
      end
    end

    if getgenv().HertzConfig.SpeedEnabled and localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
      local character = localPlayer.Character
      character:FindFirstChildOfClass("Humanoid").WalkSpeed = getgenv().HertzConfig.WalkSpeed
    end

    if getgenv().HertzConfig.AutoSprint and localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
      local humanoid3 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid3.MoveDirection.Magnitude > 0 then
        humanoid3.WalkSpeed = math.max(humanoid3.WalkSpeed, 24)
      end
    end

    if getgenv().HertzConfig.BigJump and localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
      if localPlayer.Character:FindFirstChildOfClass("Humanoid").FloorMaterial
          ~= Enum.Material.Air
        and userInputService:IsKeyDown(Enum.KeyCode.Space) then
        local humanoidRootPart2 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart2 then
          humanoidRootPart2.Velocity = Vector3.new(
            humanoidRootPart2.Velocity.X, getgenv().HertzConfig.BigJumpHeight,
            humanoidRootPart2.Velocity.Z
          )
        end
      end
    end

    if getgenv().HertzConfig.NoClip and localPlayer.Character then
      for key20, value17 in pairs(localPlayer.Character:GetDescendants()) do
        if value17:IsA("BasePart") then
          value17.CanCollide = false
        end
      end
    end

    if getgenv().HertzConfig.Fly and localPlayer.Character
      and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
      local humanoidRootPart3 = localPlayer.Character.HumanoidRootPart
      local cframe3 = currentCamera.CFrame
      local vector = Vector3.new()

      if userInputService:IsKeyDown(Enum.KeyCode.W) then
        vector = vector + cframe3.LookVector
      end

      if userInputService:IsKeyDown(Enum.KeyCode.S) then
        vector = vector - cframe3.LookVector
      end

      if userInputService:IsKeyDown(Enum.KeyCode.D) then
        vector = vector + cframe3.RightVector
      end

      if userInputService:IsKeyDown(Enum.KeyCode.A) then
        vector = vector - cframe3.RightVector
      end

      if vector.Magnitude > 0 then
        humanoidRootPart3.Velocity = vector.Unit * getgenv().HertzConfig.FlySpeed
      else
        humanoidRootPart3.Velocity = Vector3.new(0, 1, 0)
      end
    end

    if getgenv().HertzConfig.CirclePlayers and localPlayer.Character
      and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
      local humanoidRootPart4 = localPlayer.Character.HumanoidRootPart
      local circlePlayersRadius2 = getgenv().HertzConfig.CirclePlayersRadius
      local v46 = {}

      for key21, value18 in pairs(players:GetPlayers()) do
        if value18 ~= localPlayer and value18.Character
          and value18.Character:FindFirstChild("HumanoidRootPart")
          and value18.Character:FindFirstChildOfClass("Humanoid") then
          if value18.Character.Humanoid.Health > 0 then
            local humanoidRootPart5 = value18.Character.HumanoidRootPart

            if (humanoidRootPart5.Position - humanoidRootPart4.Position).Magnitude
              <= circlePlayersRadius2 then
              if not v5[value18] then
                v5[value18] = humanoidRootPart5.CFrame
              end

              table.insert(v46, humanoidRootPart5)
            end
          end
        end
      end

      local v47 = #v46

      if v47 > 0 then
        for index8, value19 in ipairs(v46) do
          local v48 = index8 / v47 * (2 * math.pi)
          local v49 = math.cos(v48)
          local v50 = math.sin(v48)
          local cframe4 = CFrame.new(v49 * 15, 0, v50 * 15)

          value19.CFrame = humanoidRootPart4.CFrame * cframe4
          value19.Velocity = Vector3.new(0, 0, 0)
        end
      end
    elseif next(v5) then
      for key22, value20 in pairs(v5) do
        local v51 = key22
        local cframe5 = value20

        if v51.Character and v51.Character:FindFirstChild("HumanoidRootPart") then
          pcall(function() v51.Character.HumanoidRootPart.CFrame = cframe5 end)
        end
      end

      v5 = {}
    end

    local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    local v52 = {}

    for key23, value21 in pairs(players:GetPlayers()) do
      if value21 ~= localPlayer then
        v52[value21] = true

        if value21.Character and value21.Character:FindFirstChild("HumanoidRootPart")
          and value21.Character:FindFirstChildOfClass("Humanoid")
          and value21.Character.Humanoid.Health > 0 then
          local head2 = value21.Character:FindFirstChild("Head")

          if head2 then
            if getgenv().HertzConfig.BigHeadEnabled then
              if not head2:FindFirstChild("OriginalSize") then
                local originalSize = Instance.new("Vector3Value")
                originalSize.Name = "OriginalSize"
                originalSize.Value = head2.Size
                originalSize.Parent = head2
              end

              head2.Size = head2.OriginalSize.Value * getgenv().HertzConfig.BigHeadSize
              head2.Massless = true
            elseif head2:FindFirstChild("OriginalSize") then
              head2.Size = head2.OriginalSize.Value
            end
          end

          if getgenv().HertzConfig.VisualEnabled
            and getgenv().HertzConfig.VisualSelections.Outline then
            if not value21.Character:FindFirstChild("HertzOutline") then
              local hertzOutline2 = Instance.new("Highlight")
              hertzOutline2.Name = "HertzOutline"
              hertzOutline2.Adornee = value21.Character
              hertzOutline2.FillTransparency = 0.5
              hertzOutline2.OutlineTransparency = 0
              hertzOutline2.Parent = value21.Character
            end

            value21.Character.HertzOutline.FillColor = color
            value21.Character.HertzOutline.OutlineColor = Color3.fromRGB(255, 255, 255)
          elseif value21.Character:FindFirstChild("HertzOutline") then
            value21.Character.HertzOutline:Destroy()
          end

          if getgenv().HertzConfig.VisualEnabled and getgenv().HertzConfig.VisualSelections.Aura then
            if not value21.Character.HumanoidRootPart:FindFirstChild("HertzAura") then
              local hertzAura = Instance.new("ParticleEmitter")
              hertzAura.Name = "HertzAura"
              hertzAura.Texture = "rbxassetid://258129463"
              hertzAura.Size = NumberSequence.new(1.5, 0)
              hertzAura.Rate = 20
              hertzAura.Parent = value21.Character.HumanoidRootPart
            end

            value21.Character.HumanoidRootPart.HertzAura.Color = ColorSequence.new(color)
          elseif value21.Character.HumanoidRootPart:FindFirstChild("HertzAura") then
            value21.Character.HumanoidRootPart.HertzAura:Destroy()
          end

          if getgenv().HertzConfig.VisualEnabled then
            if not v2[value21] then
              v2[value21] = {
                Box = Drawing.new("Square"),
                Name = Drawing.new("Text"),
                HealthBar = Drawing.new("Line"),
                ArmorBar = Drawing.new("Line"),
                Snapline = Drawing.new("Line"),
                SkeletonLines = {
                  Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"),
                  Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"),
                  Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"),
                },
              }

              v2[value21].Box.Filled = false
              v2[value21].Box.Thickness = 1
              v2[value21].Name.Size = 10
              v2[value21].Name.Center = true
              v2[value21].Name.Color = Color3.fromRGB(225, 225, 225)
              v2[value21].Name.Outline = true
              v2[value21].Name.OutlineColor = Color3.fromRGB(0, 0, 0)
              v2[value21].HealthBar.Thickness = 2
              v2[value21].HealthBar.Color = Color3.fromRGB(40, 220, 90)
              v2[value21].ArmorBar.Thickness = 2
              v2[value21].ArmorBar.Color = Color3.fromRGB(40, 140, 255)
              v2[value21].Snapline.Thickness = 1
              v2[value21].Snapline.Color = Color3.fromRGB(255, 255, 255)
              v2[value21].Snapline.Transparency = 0.7

              for key24, value22 in pairs(v2[value21].SkeletonLines) do
                value22.Thickness = 1
              end
            end

            local humanoid4 = value21.Character.Humanoid
            local v53, v54 = currentCamera:WorldToViewportPoint(value21.Character.HumanoidRootPart.Position)
            local v55 = v2[value21]
            local aura = getgenv().HertzConfig.VisualSelections.Aura and color

            local color2 = aura
            color2 = aura or Color3.fromRGB(225, 225, 225)

            v55.Box.Color = color2

            for key25, value23 in pairs(v55.SkeletonLines) do
              value23.Color = color2
            end

            if v54 and v53.Z > 0 then
              if getgenv().HertzConfig.VisualSelections.Box then
                local vector2 = Vector2.new(2000 / v53.Z, 3000 / v53.Z)

                v55.Box.Size = vector2
                v55.Box.Position = Vector2.new(v53.X - vector2.X / 2, v53.Y - vector2.Y / 2)
                v55.Box.Visible = true
              end

              if getgenv().HertzConfig.VisualSelections.Nametag then
                local z = v53.Z

                v55.Name.Text = value21.Name
                v55.Name.Position = Vector2.new(v53.X, v53.Y + 3000 / z / 2 + 6)
                v55.Name.Visible = true
              end

              if getgenv().HertzConfig.VisualSelections.Health then
                local v56 = 3000 / v53.Z
                local v57 = math.clamp(humanoid4.Health / humanoid4.MaxHealth, 0, 1)

                v55.HealthBar.From = Vector2.new(v53.X - 2000 / v53.Z / 2 - 6, v53.Y + v56 / 2)

                v55.HealthBar.To = Vector2.new(
                  v53.X - 2000 / v53.Z / 2 - 6, v53.Y + v56 / 2 - v56 * v57
                )

                v55.HealthBar.Visible = true
              end

              if getgenv().HertzConfig.VisualSelections.Armor then
                local v58 = 3000 / v53.Z

                v55.ArmorBar.From = Vector2.new(v53.X - 2000 / v53.Z / 2 - 10, v53.Y + v58 / 2)

                v55.ArmorBar.To = Vector2.new(
                  v53.X - 2000 / v53.Z / 2 - 10, v53.Y + v58 / 2 - v58 * 0.75
                )

                v55.ArmorBar.Visible = true
              end

              if getgenv().HertzConfig.VisualSelections.Snapline then
                local viewportSize = currentCamera.ViewportSize

                v55.Snapline.From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                v55.Snapline.To = Vector2.new(v53.X, v53.Y)
                v55.Snapline.Visible = true
              end

              if getgenv().HertzConfig.VisualSelections.Skeleton then
                local character2 = value21.Character
                local head3 = character2:FindFirstChild("Head")
                local upperTorso = character2:FindFirstChild("UpperTorso")

                local torso = upperTorso
                torso = upperTorso or character2:FindFirstChild("Torso")

                local leftUpperArm = character2:FindFirstChild("LeftUpperArm")

                local leftArm = leftUpperArm
                leftArm = leftUpperArm or character2:FindFirstChild("Left Arm")

                local leftLowerArm = character2:FindFirstChild("LeftLowerArm")

                local leftHand = leftLowerArm
                leftHand = leftLowerArm or character2:FindFirstChild("LeftHand")

                local rightUpperArm = character2:FindFirstChild("RightUpperArm")

                local rightArm = rightUpperArm
                rightArm = rightUpperArm or character2:FindFirstChild("Right Arm")

                local rightLowerArm = character2:FindFirstChild("RightLowerArm")

                local rightHand = rightLowerArm
                rightHand = rightLowerArm or character2:FindFirstChild("RightHand")

                local leftUpperLeg = character2:FindFirstChild("LeftUpperLeg")

                local leftLeg = leftUpperLeg
                leftLeg = leftUpperLeg or character2:FindFirstChild("Left Leg")

                local leftLowerLeg = character2:FindFirstChild("LeftLowerLeg")

                local leftFoot = leftLowerLeg
                leftFoot = leftLowerLeg or character2:FindFirstChild("LeftFoot")

                local rightUpperLeg = character2:FindFirstChild("RightUpperLeg")

                local rightLeg = rightUpperLeg
                rightLeg = rightUpperLeg or character2:FindFirstChild("Right Leg")

                local rightLowerLeg = character2:FindFirstChild("RightLowerLeg")

                local rightFoot = rightLowerLeg
                rightFoot = rightLowerLeg or character2:FindFirstChild("RightFoot")

                local function f6(p15)
                  if not p15 then
                    return nil
                  else
                    local v59, v60 = currentCamera:WorldToViewportPoint(p15.Position)

                    if v60 and v59.Z > 0 then
                      return Vector2.new(v59.X, v59.Y)
                    end

                    return nil
                  end
                end

                for index9, value24 in ipairs({
                  { f6(head3), f6(torso) }, { f6(torso), f6(leftArm) },
                  { f6(leftArm), f6(leftHand) }, { f6(torso), f6(rightArm) },
                  { f6(rightArm), f6(rightHand) }, { f6(torso), f6(leftLeg) },
                  { f6(leftLeg), f6(leftFoot) }, { f6(torso), f6(rightLeg) },
                  { f6(rightLeg), f6(rightFoot) },
                }) do
                  if value24[1] and value24[2] then
                    v55.SkeletonLines[index9].From = value24[1]
                    v55.SkeletonLines[index9].To = value24[2]
                    v55.SkeletonLines[index9].Visible = true
                  end
                end
              end
            end
          else
            f3(value21)
          end
        else
          f3(value21)
        end
      end
    end

    for key26, value25 in pairs(v2) do
      if not v52[key26] or not key26.Parent or not key26.Character
        or not key26.Character:FindFirstChild("HumanoidRootPart") then
        f1(key26)
      end
    end

    return
  end
end)

local v61 = getrawmetatable(game)
local namecall = v61.__namecall
setreadonly(v61, false)

v61.__namecall = newcclosure(function(p16, ...)
  local v62 = getnamecallmethod()

  if getgenv().HertzConfig.NoRecoil and p16 == currentCamera
    and (v62 == "CFrame" or v62 == "SetPrimaryPartCFrame") then
    local v63 = { ... }

    if typeof(v63[1]) == "CFrame" then
      v63[1] = CFrame.new(currentCamera.CFrame.Position) * (v63[1] - v63[1].Position)
    end

    return namecall(p16, unpack(v63))
  end

  return namecall(p16, ...)
end)

setreadonly(v61, true)

