
local players = game:GetService("Players")
local workspaceService = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local lighting = game:GetService("Lighting")
local httpService = game:GetService("HttpService")
local starterGui = game:GetService("StarterGui")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local teleportService = game:GetService("TeleportService")

starterGui:SetCore("SendNotification", {
  Title = "1337",
  Text = "Working for Mobile and PC Executor",
  Duration = 8,
})

starterGui:SetCore("SendNotification", { Title = "Made By:", Text = "L", Duration = 8 })

local v1 = { fly = false, flyspeed = 50 }
local localPlayer = players.LocalPlayer

local v2 = {
  W = false,
  S = false,
  A = false,
  D = false,
  Moving = false,
}

local character, humanoid, bodyVelocity, bodyAngularVelocity, camera, v3

local function makeBodyVelocity()
  if not localPlayer.Character or not localPlayer.Character.Head or v3 then
    return
  else
    character = localPlayer.Character

    humanoid = character.Humanoid
    humanoid.PlatformStand = true

    camera = workspace:WaitForChild("Camera")
    bodyVelocity = Instance.new("BodyVelocity")
    bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    local vector = Vector3.new(0, 0, 0)
    local vector2 = Vector3.new(10000, 10000, 10000)

    bodyVelocity.Velocity = vector
    bodyVelocity.MaxForce = vector2
    bodyVelocity.P = 1000

    local vector3 = Vector3.new(0, 0, 0)
    local vector4 = Vector3.new(10000, 10000, 10000)

    bodyAngularVelocity.AngularVelocity = vector3
    bodyAngularVelocity.MaxTorque = vector4
    bodyAngularVelocity.P = 1000

    bodyVelocity.Parent = character.Head
    bodyAngularVelocity.Parent = character.Head
    v3 = true
    humanoid.Died:Connect(function() v3 = false end)
    return
  end
end

local function f1()
  if not localPlayer.Character or not v3 then
    return
  end

  humanoid.PlatformStand = false
  bodyVelocity:Destroy()
  bodyAngularVelocity:Destroy()
  v3 = false
end

userInputService.InputBegan:Connect(function(input, p1)
  if p1 then
    return
  end

  for key, value in pairs(v2) do
    if key ~= "Moving" and input.KeyCode == Enum.KeyCode[key] then
      v2[key] = true
      v2.Moving = true
    end
  end
end)

userInputService.InputEnded:Connect(function(input2, p2)
  if p2 then
    return
  else
    local moving = false

    for key2, value2 in pairs(v2) do
      if key2 ~= "Moving" then
        if input2.KeyCode == Enum.KeyCode[key2] then
          v2[key2] = false
        end

        if v2[key2] then
          moving = true
        end
      end
    end

    v2.Moving = moving
    return
  end
end)

local function f2(index)
  return index * (v1.flyspeed / index.Magnitude)
end

runService.Heartbeat:Connect(function(delta)
  if v3 and character and character.PrimaryPart then
    local position = character.PrimaryPart.Position
    local cframe = camera.CFrame
    local v4, v5, v6 = cframe:toEulerAnglesXYZ()

    character:SetPrimaryPartCFrame(CFrame.new(position.x, position.y, position.z)
      * CFrame.Angles(v4, v5, v6))

    if v2.Moving then
      local vector5 = Vector3.new()

      if v2.W then
        vector5 = vector5 + f2(cframe.lookVector)
      end

      if v2.S then
        vector5 = vector5 - f2(cframe.lookVector)
      end

      if v2.A then
        vector5 = vector5 - f2(cframe.rightVector)
      end

      if v2.D then
        vector5 = vector5 + f2(cframe.rightVector)
      end

      character:TranslateBy(vector5 * delta)
    end
  end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
local options = library.Options
local toggles = library.Toggles

task.spawn(function()
  task.wait(1)
  pcall(function() library:SetFont(Enum.Font.Gotham) end)
end)

local titanicHUBWindow = library:CreateWindow({
  Title = "1337",
  Footer = "Arsenal | Freemium",
  Center = true,
  AutoShow = true,
  Resizable = true,
  ShowCustomCursor = true,
})

local v7 = {
  Info = titanicHUBWindow:AddTab("Info", "info"),
  Main = titanicHUBWindow:AddTab("Main", "house"),
  Gun = titanicHUBWindow:AddTab("Gun Modded", "bolt"),
  Player = titanicHUBWindow:AddTab("Player", "user"),
  Skins = titanicHUBWindow:AddTab("Color Skins", "star"),
  Extra = titanicHUBWindow:AddTab("Extra", "sparkles"),
  Visuals = titanicHUBWindow:AddTab("Visuals", "eye"),
  Setting = titanicHUBWindow:AddTab("Setting", "settings"),
  Credits = titanicHUBWindow:AddTab("Credits", "info"),
}

local addLeftGroupbox = v7.Info:AddLeftGroupbox("Account Info", "user")
local addRightGroupbox = v7.Info:AddRightGroupbox("Links", "link")
local v8 = "Unknown"

pcall(function()
  if identifyexecutor then
    v8 = identifyexecutor()
  elseif getexecutorname then
    v8 = getexecutorname()
  end
end)

local localPlayer2 = players.LocalPlayer

addLeftGroupbox:AddLabel("Username: " .. localPlayer2.Name)
addLeftGroupbox:AddLabel("Display Name: " .. localPlayer2.DisplayName)
addLeftGroupbox:AddLabel("User ID: " .. tostring(localPlayer2.UserId))
addLeftGroupbox:AddLabel("Executor: " .. tostring(v8))
addLeftGroupbox:AddLabel('Script: <font color="#FF0000">Arsenal v2</font>', false)
addLeftGroupbox:AddLabel('Team: <font color="#00FF00">Deepseek Ai Team</font>', false)

addRightGroupbox:AddLabel("discord.gg/AGzuCsXtnp")

local addLeftGroupbox2 = v7.Main:AddLeftGroupbox("Hitbox Settings", "square")
local addLeftGroupbox3 = v7.Main:AddLeftGroupbox("AutoFarm", "compass")
local addRightGroupbox2 = v7.Main:AddRightGroupbox("Triggerbot", "bolt")
local value3 = false
local value4 = false
local v9 = {}
local value5 = 21
local value6 = 6
local value7 = "FFA"
local v10 = { "UpperTorso", "Head", "HumanoidRootPart" }

local function f3(key3, findFirstChild)
  if not v9[key3] then
    v9[key3] = {}
  end

  if not v9[key3][findFirstChild.Name] then
    v9[key3][findFirstChild.Name] = {
      CanCollide = findFirstChild.CanCollide,
      Transparency = findFirstChild.Transparency,
      Size = findFirstChild.Size,
    }
  end
end

local localPlayer3 = players.LocalPlayer

local function f4(key4)
  if v9[key4] then
    for key5, value8 in pairs(v9[key4]) do
      local character2 = key4.Character

      local findFirstChild2 = character2
      findFirstChild2 = character2 and key4.Character:FindFirstChild(key5)

      if findFirstChild2 and findFirstChild2:IsA("BasePart") then
        findFirstChild2.CanCollide = value8.CanCollide
        findFirstChild2.Transparency = value8.Transparency
        findFirstChild2.Size = value8.Size
      end
    end
  end
end

local function f5(value9)
  if value7 == "FFA" or value7 == "Everyone" then
    return true
  end

  return value9.Team ~= localPlayer3.Team
end

local f6

local function f7(value10)
  for index2, value11 in ipairs(v10) do
    local findFirstChild3 = value10.Character
      and (value10.Character:FindFirstChild(value11) or f6(value10, value11))

    if findFirstChild3 and findFirstChild3:IsA("BasePart") then
      f3(value10, findFirstChild3)

      findFirstChild3.CanCollide = not value4
      findFirstChild3.Transparency = value6 / 10
      findFirstChild3.Size = Vector3.new(value5, value5, value5)
    end
  end
end

function f6(p3, p4)
  if not p3.Character then
    return nil
  end

  for index3, value12 in ipairs(p3.Character:GetChildren()) do
    if value12:IsA("BasePart") and value12.Name:lower():match(p4:lower()) then
      return value12
    end
  end

  return nil
end

local function f8()
  for key6, value13 in pairs(v9) do
    if not key6.Parent or not key6.Character or not key6.Character:IsDescendantOf(game) then
      f4(key6)
      v9[key6] = nil
    end
  end
end

local function f9()
  for index4, value14 in ipairs(players:GetPlayers()) do
    if value14 ~= localPlayer3 and value14.Character
      and value14.Character:FindFirstChild("HumanoidRootPart") then
      if f5(value14) then
        f7(value14)
      else
        f4(value14)
      end
    end
  end
end

local function f10(p5)
  task.wait(0.1)

  if value3 then
    f9()
  end
end

local function f11(value15)
  value15.CharacterAdded:Connect(f10)

  value15.CharacterRemoving:Connect(function()
    f4(value15)
    v9[value15] = nil
  end)
end

players.PlayerAdded:Connect(f11)

for index5, value16 in ipairs(players:GetPlayers()) do
  f11(value16)
end

addLeftGroupbox2:AddButton({
  Text = "[CLICK THIS FIRST] Enable Hitbox",
  Func = function()
    coroutine.wrap(function()
      while true do
        if value3 then
          f9()
          f8()
        end

        task.wait(0.1)
      end
    end)()
  end,
})

addLeftGroupbox2:AddToggle("HitboxEnabled", { Text = "Enable Hitbox", Default = false })

toggles.HitboxEnabled:OnChanged(function()
  value3 = toggles.HitboxEnabled.Value

  if not value3 then
    for index6, value17 in ipairs(players:GetPlayers()) do
      f4(value17)
    end

    v9 = {}
  else
    f9()
  end
end)

addLeftGroupbox2:AddSlider("HitboxSize", {
  Text = "Hitbox Size",
  Min = 1,
  Max = 25,
  Default = 21,
  Rounding = 0,
})

options.HitboxSize:OnChanged(function()
  value5 = options.HitboxSize.Value

  if value3 then
    f9()
  end
end)

addLeftGroupbox2:AddSlider("HitboxTransparency", {
  Text = "Hitbox Transparency",
  Min = 1,
  Max = 10,
  Default = 6,
  Rounding = 0,
})

options.HitboxTransparency:OnChanged(function()
  value6 = options.HitboxTransparency.Value

  if value3 then
    f9()
  end
end)

addLeftGroupbox2:AddDropdown("HitboxTeamCheck", {
  Text = "Team Check",
  Values = { "FFA", "Team-Based", "Everyone" },
  Default = "FFA",
  Multi = false,
})

options.HitboxTeamCheck:OnChanged(function()
  value7 = options.HitboxTeamCheck.Value

  if value3 then
    f9()
  end
end)

addLeftGroupbox2:AddToggle("NoCollision", { Text = "No Collision", Default = false })

toggles.NoCollision:OnChanged(function()
  value4 = toggles.NoCollision.Value

  coroutine.wrap(function()
    while value4 do
      if value3 then
        f9()
      end

      task.wait(0.01)
    end

    if value3 then
      f9()
    end
  end)()
end)

addLeftGroupbox3:AddToggle("AutoFarm", { Text = "AutoFarm", Default = false })

toggles.AutoFarm:OnChanged(function()
  local value18 = toggles.AutoFarm.Value
  getgenv().AutoFarm = value18
  local v11 = false
  local localPlayer4 = players.LocalPlayer
  local currentCamera = workspaceService.CurrentCamera

  local currentCurse = replicatedStorage.wkspc.CurrentCurse
  currentCurse.Value = value18 and "Infinite Ammo" or ""

  local function f12()
    local huge = math.huge
    local v12

    for key7, value19 in pairs(players:GetPlayers()) do
      if value19 ~= localPlayer4 and value19.TeamColor ~= localPlayer4.TeamColor
        and value19.Character then
        local character3 = value19.Character
        local humanoidRootPart = character3:FindFirstChild("HumanoidRootPart")
        local humanoid2 = character3:FindFirstChild("Humanoid")

        if humanoidRootPart and humanoid2 and humanoid2.Health > 0 then
          local magnitude = (localPlayer4.Character.HumanoidRootPart.Position
            - humanoidRootPart.Position).Magnitude

          if magnitude < huge then
            huge = magnitude
            v12 = value19
          end
        end
      end
    end

    return v12
  end

  local connect

  local function f13()
    local v13 = game
    v13:GetService("ReplicatedStorage").wkspc.TimeScale.Value = 12

    connect = runService.Stepped:Connect(function()
      if getgenv().AutoFarm then
        local v14 = f12()

        if v14 and localPlayer4.Character
          and localPlayer4.Character:FindFirstChild("HumanoidRootPart") then
          local humanoidRootPart2 = v14.Character.HumanoidRootPart
          local vector6 = Vector3.new(0, 2, 0)

          localPlayer4.Character.HumanoidRootPart.CFrame = CFrame.new(humanoidRootPart2.Position
              - humanoidRootPart2.CFrame.LookVector * 2
            + vector6)

          if v14.Character:FindFirstChild("Head") then
            currentCamera.CFrame = CFrame.new(
              currentCamera.CFrame.Position, v14.Character.Head.Position
            )
          end

          if not v11 then
            mouse1press()
            v11 = true
          end
        elseif v11 then
          mouse1release()
          v11 = false
        end
      else
        if connect then
          connect:Disconnect()
          connect = nil
        end

        if v11 then
          mouse1release()
          v11 = false
        end
      end
    end)
  end

  localPlayer4.CharacterAdded:Connect(function(character4)
    wait(0.5)
    f13()
  end)

  if value18 then
    wait(0.5)
    f13()
  else
    local v15 = game
    v15:GetService("ReplicatedStorage").wkspc.CurrentCurse.Value = ""

    getgenv().AutoFarm = false

    local v16 = game
    v16:GetService("ReplicatedStorage").wkspc.TimeScale.Value = 1

    if connect then
      connect:Disconnect()
      connect = nil
    end

    if v11 then
      mouse1release()
      v11 = false
    end
  end
end)

getgenv().triggerb = false
local value20 = "Team-Based"
local v17 = 0.2
local v18 = true
addRightGroupbox2:AddToggle("TriggerbotEnabled", { Text = "Enable Triggerbot", Default = false })

toggles.TriggerbotEnabled:OnChanged(function()
  getgenv().triggerb = toggles.TriggerbotEnabled.Value
end)

addRightGroupbox2:AddDropdown("TriggerbotTeamCheck", {
  Text = "Team Check Mode",
  Values = { "FFA", "Team-Based", "Everyone" },
  Default = "Team-Based",
  Multi = false,
})

options.TriggerbotTeamCheck:OnChanged(function() value20 = options.TriggerbotTeamCheck.Value end)

addRightGroupbox2:AddSlider("TriggerbotDelay", {
  Text = "Shot Delay (1-10)",
  Min = 1,
  Max = 10,
  Default = 10,
  Rounding = 0,
})

options.TriggerbotDelay:OnChanged(function() v17 = options.TriggerbotDelay.Value / 10 end)

local function f14(findFirstChild4)
  if value20 == "FFA" then
    return true
  elseif value20 == "Everyone" then
    return findFirstChild4 ~= players.LocalPlayer
  else
    if value20 == "Team-Based" then
      return findFirstChild4.Team ~= players.LocalPlayer.Team
    end

    return false
  end
end

local function f15()
  local localPlayer5 = players.LocalPlayer

  local humanoid3 = (localPlayer5.Character
    or localPlayer5.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")

  if humanoid3 then
    humanoid3.HealthChanged:Connect(function(p6) v18 = p6 > 0 end)
  end
end

players.LocalPlayer.CharacterAdded:Connect(f15)
f15()

runService.RenderStepped:Connect(function()
  if getgenv().triggerb and v18 then
    local localPlayer6 = players.LocalPlayer
    local target = localPlayer6:GetMouse().Target

    if target and target.Parent:FindFirstChild("Humanoid")
      and target.Parent.Name ~= localPlayer6.Name then
      local findFirstChild5 = players:FindFirstChild(target.Parent.Name)

      if findFirstChild5 and f14(findFirstChild5) then
        mouse1press()
        wait(v17)
        mouse1release()
      end
    end
  end
end)

local addLeftGroupbox4 = v7.Gun:AddLeftGroupbox("Overpower Gun", "bolt")
addLeftGroupbox4:AddToggle("InfiniteAmmoV1", { Text = "Infinite Ammo v1", Default = false })

toggles.InfiniteAmmoV1:OnChanged(function()
  local currentCurse2 = replicatedStorage.wkspc.CurrentCurse
  currentCurse2.Value = toggles.InfiniteAmmoV1.Value and "Infinite Ammo" or ""
end)

local value21 = false
addLeftGroupbox4:AddToggle("InfiniteAmmoV2", { Text = "Infinite Ammo v2", Default = false })

toggles.InfiniteAmmoV2:OnChanged(function()
  value21 = toggles.InfiniteAmmoV2.Value

  if value21 then
    runService.Stepped:Connect(function()
      pcall(function()
        if value21 then
          local playerGui = players.LocalPlayer.PlayerGui
          playerGui.GUI.Client.Variables.ammocount.Value = 99
          playerGui.GUI.Client.Variables.ammocount2.Value = 99
        end
      end)
    end)
  end
end)

local v19 = {
  FireRate = {},
  ReloadTime = {},
  EReloadTime = {},
  Auto = {},
  Spread = {},
  Recoil = {},
}

addLeftGroupbox4:AddToggle("FastReload", { Text = "Fast Reload", Default = false })

toggles.FastReload:OnChanged(function()
  local value22 = toggles.FastReload.Value

  for key8, value23 in pairs(replicatedStorage.Weapons:GetChildren()) do
    if value23:FindFirstChild("ReloadTime") then
      if value22 then
        if not v19.ReloadTime[value23] then
          v19.ReloadTime[value23] = value23.ReloadTime.Value
        end

        value23.ReloadTime.Value = 0.01
      else
        value23.ReloadTime.Value = v19.ReloadTime[value23] or 0.8
      end
    end

    if value23:FindFirstChild("EReloadTime") then
      if value22 then
        if not v19.EReloadTime[value23] then
          v19.EReloadTime[value23] = value23.EReloadTime.Value
        end

        value23.EReloadTime.Value = 0.01
      else
        value23.EReloadTime.Value = v19.EReloadTime[value23] or 0.8
      end
    end
  end
end)

addLeftGroupbox4:AddToggle("FastFireRate", { Text = "Fast Fire Rate", Default = false })

toggles.FastFireRate:OnChanged(function()
  local value24 = toggles.FastFireRate.Value

  for key9, value25 in pairs(replicatedStorage.Weapons:GetDescendants()) do
    if value25.Name == "FireRate" or value25.Name == "BFireRate" then
      if value24 then
        if not v19.FireRate[value25] then
          v19.FireRate[value25] = value25.Value
        end

        value25.Value = 0.02
      else
        value25.Value = v19.FireRate[value25] or 0.8
      end
    end
  end
end)

addLeftGroupbox4:AddToggle("AlwaysAuto", { Text = "Always Auto", Default = false })

toggles.AlwaysAuto:OnChanged(function()
  local value26 = toggles.AlwaysAuto.Value

  for key10, value27 in pairs(replicatedStorage.Weapons:GetDescendants()) do
    if value27.Name == "Auto" or value27.Name == "AutoFire" or value27.Name == "Automatic"
      or value27.Name == "AutoShoot" or value27.Name == "AutoGun" then
      if value26 then
        if not v19.Auto[value27] then
          v19.Auto[value27] = value27.Value
        end

        value27.Value = true
      else
        value27.Value = v19.Auto[value27] or false
      end
    end
  end
end)

addLeftGroupbox4:AddToggle("NoSpread", { Text = "No Spread", Default = false })

toggles.NoSpread:OnChanged(function()
  local value28 = toggles.NoSpread.Value

  for key11, value29 in pairs(replicatedStorage.Weapons:GetDescendants()) do
    if value29.Name == "MaxSpread" or value29.Name == "Spread"
      or value29.Name == "SpreadControl" then
      if value28 then
        if not v19.Spread[value29] then
          v19.Spread[value29] = value29.Value
        end

        value29.Value = 0
      else
        value29.Value = v19.Spread[value29] or 1
      end
    end
  end
end)

addLeftGroupbox4:AddToggle("NoRecoil", { Text = "No Recoil", Default = false })

toggles.NoRecoil:OnChanged(function()
  local value30 = toggles.NoRecoil.Value

  for key12, value31 in pairs(replicatedStorage.Weapons:GetDescendants()) do
    if value31.Name == "RecoilControl" or value31.Name == "Recoil" then
      if value30 then
        if not v19.Recoil[value31] then
          v19.Recoil[value31] = value31.Value
        end

        value31.Value = 0
      else
        value31.Value = v19.Recoil[value31] or 1
      end
    end
  end
end)

local addLeftGroupbox5 = v7.Player:AddLeftGroupbox("Fly Hacks", "move")
local addLeftGroupbox6 = v7.Player:AddLeftGroupbox("Speed Power", "bolt")
local addLeftGroupbox7 = v7.Player:AddLeftGroupbox("Jump Power", "chevronR")
local addLeftGroupbox8 = v7.Player:AddLeftGroupbox("Anti Aim", "circle")
local addRightGroupbox3 = v7.Player:AddRightGroupbox("Object Teleport", "package")
local addRightGroupbox4 = v7.Player:AddRightGroupbox("Useful Cheat", "star")
local addRightGroupbox5 = v7.Player:AddRightGroupbox("Misc", "settings")
addLeftGroupbox5:AddToggle("Fly", { Text = "Fly", Default = false })

toggles.Fly:OnChanged(function()
  if toggles.Fly.Value then
    makeBodyVelocity()
  else
    f1()
  end
end)

addLeftGroupbox5:AddSlider("FlySpeed", {
  Text = "Fly Speed",
  Min = 1,
  Max = 500,
  Default = 50,
  Rounding = 0,
})

options.FlySpeed:OnChanged(function() v1.flyspeed = options.FlySpeed.Value end)
local v20 = { WalkSpeed = 16 }
local value32 = false
local values = { "Velocity", "Vector", "CFrame" }
local value33 = "Velocity"
addLeftGroupbox6:AddToggle("WalkSpeedEnabled", { Text = "Custom WalkSpeed", Default = false })
toggles.WalkSpeedEnabled:OnChanged(function() value32 = toggles.WalkSpeedEnabled.Value end)

addLeftGroupbox6:AddDropdown("WalkMethod", {
  Text = "Walk Method",
  Values = values,
  Default = "Velocity",
  Multi = false,
})

options.WalkMethod:OnChanged(function() value33 = options.WalkMethod.Value end)

addLeftGroupbox6:AddSlider("WalkSpeedValue", {
  Text = "Walkspeed Power",
  Min = 16,
  Max = 500,
  Default = 16,
  Rounding = 0,
})

options.WalkSpeedValue:OnChanged(function() v20.WalkSpeed = options.WalkSpeedValue.Value end)

local function f16(localPlayer7, delta2)
  local character5 = localPlayer7.Character
  local humanoid4 = character5 and character5:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart3 = character5 and character5:FindFirstChild("HumanoidRootPart")

  if humanoid4 and humanoidRootPart3 then
    local v21 = humanoid4.MoveDirection * v20.WalkSpeed

    if value33 == "Velocity" then
      humanoidRootPart3.Velocity = Vector3.new(v21.X, humanoidRootPart3.Velocity.Y, v21.Z)
    elseif value33 == "Vector" then
      humanoidRootPart3.CFrame = humanoidRootPart3.CFrame + v21 * delta2 * 0.0001
    elseif value33 == "CFrame" then
      humanoidRootPart3.CFrame = humanoidRootPart3.CFrame
        + humanoid4.MoveDirection * v20.WalkSpeed * delta2 * 0.0001
    else
      humanoid4.WalkSpeed = v20.WalkSpeed
    end
  end
end

runService.Stepped:Connect(function(delta3)
  if value32 then
    local localPlayer8 = players.LocalPlayer

    if localPlayer8 and localPlayer8.Character
      and localPlayer8.Character:FindFirstChild("HumanoidRootPart") then
      f16(localPlayer8, delta3)
    end
  end
end)

local value34 = false
addLeftGroupbox7:AddToggle("InfiniteJump", { Text = "Infinite Jump", Default = false })

toggles.InfiniteJump:OnChanged(function()
  value34 = toggles.InfiniteJump.Value

  userInputService.JumpRequest:Connect(function()
    if value34 then
      players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
  end)
end)

local value35 = false
local values2 = { "Velocity", "Vector", "CFrame" }
local value36 = "Velocity"
addLeftGroupbox7:AddToggle("JumpPowerEnabled", { Text = "Custom JumpPower", Default = false })
toggles.JumpPowerEnabled:OnChanged(function() value35 = toggles.JumpPowerEnabled.Value end)

addLeftGroupbox7:AddDropdown("JumpMethod", {
  Text = "Jump Method",
  Values = values2,
  Default = "Velocity",
  Multi = false,
})

options.JumpMethod:OnChanged(function() value36 = options.JumpMethod.Value end)

addLeftGroupbox7:AddSlider("JumpPowerValue", {
  Text = "Change JumpPower",
  Min = 30,
  Max = 500,
  Default = 50,
  Rounding = 0,
})

options.JumpPowerValue:OnChanged(function()
  local value37 = options.JumpPowerValue.Value
  local localPlayer9 = players.LocalPlayer

  if localPlayer9.Character then
    local humanoid5 = localPlayer9.Character:WaitForChild("Humanoid")
    humanoid5.UseJumpPower = true

    humanoid5.Jumping:Connect(function(p7)
      if value35 and p7 then
        local humanoidRootPart4 = localPlayer9.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart4 then
          if value36 == "Velocity" then
            humanoidRootPart4.Velocity = humanoidRootPart4.Velocity * Vector3.new(1, 0, 1)
              + Vector3.new(0, value37, 0)
          elseif value36 == "Vector" then
            humanoidRootPart4.Velocity = Vector3.new(0, value37, 0)
          elseif value36 == "CFrame" then
            localPlayer9.Character:SetPrimaryPartCFrame(localPlayer9.Character:GetPrimaryPartCFrame()
              + Vector3.new(0, value37, 0))
          end
        end
      end
    end)
  end
end)

local value38 = 10
addLeftGroupbox8:AddToggle("AntiAimEnabled", { Text = "Anti-Aim v1", Default = false })
local antiAimGyro

toggles.AntiAimEnabled:OnChanged(function()
  local value39 = toggles.AntiAimEnabled.Value
  local character6 = players.LocalPlayer.Character
  local humanoidRootPart5 = character6 and character6:FindFirstChild("HumanoidRootPart")

  if value39 then
    if humanoidRootPart5 then
      local antiAimSpin = Instance.new("BodyAngularVelocity")
      antiAimSpin.Name = "AntiAimSpin"
      antiAimSpin.AngularVelocity = Vector3.new(0, value38, 0)
      antiAimSpin.MaxTorque = Vector3.new(0, math.huge, 0)
      antiAimSpin.P = 500000
      antiAimSpin.Parent = humanoidRootPart5

      antiAimGyro = Instance.new("BodyGyro")
      antiAimGyro.Name = "AntiAimGyro"
      antiAimGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
      antiAimGyro.CFrame = humanoidRootPart5.CFrame
      antiAimGyro.P = 3000
      antiAimGyro.Parent = humanoidRootPart5
    end
  elseif humanoidRootPart5 then
    local antiAimSpin2 = humanoidRootPart5:FindFirstChild("AntiAimSpin")

    if antiAimSpin2 then
      antiAimSpin2:Destroy()
    end

    if antiAimGyro then
      antiAimGyro:Destroy()
      antiAimGyro = nil
    end
  end
end)

addLeftGroupbox8:AddSlider("SpinSpeed", {
  Text = "Spin Speed",
  Min = 10,
  Max = 100,
  Default = 10,
  Rounding = 0,
})

options.SpinSpeed:OnChanged(function()
  value38 = options.SpinSpeed.Value
  local character7 = players.LocalPlayer.Character
  local humanoidRootPart6 = character7 and character7:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart6 then
    local antiAimSpin3 = humanoidRootPart6:FindFirstChild("AntiAimSpin")

    if antiAimSpin3 then
      antiAimSpin3.AngularVelocity = Vector3.new(0, value38, 0)
    end
  end
end)

local value40 = "Both"
local value41 = false
addRightGroupbox3:AddToggle("CollectDebris", { Text = "Enable Collect Debris", Default = false })

toggles.CollectDebris:OnChanged(function()
  value41 = toggles.CollectDebris.Value

  if value41 then
    spawn(function()
      while value41 do
        wait(0.1)

        pcall(function()
          local character8 = players.LocalPlayer.Character
          if character8 then
            local humanoidRootPart7 = character8:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart7 then
              for key13, value42 in pairs(workspaceService.Debris:GetChildren()) do
                if value40 == "DeadHP" and value42.Name == "DeadHP"
                  or value40 == "DeadAmmo" and value42.Name == "DeadAmmo"
                  or value40 == "Both"
                    and (value42.Name == "DeadHP" or value42.Name == "DeadAmmo") then
                  value42.CFrame = humanoidRootPart7.CFrame * CFrame.new(0, 0.2, 0)
                end
              end
            end
          end
        end)
      end
    end)
  end
end)

addRightGroupbox3:AddDropdown("DebrisSelect", {
  Text = "Select Object",
  Values = { "DeadHP", "DeadAmmo", "Both" },
  Default = "Both",
  Multi = false,
})

options.DebrisSelect:OnChanged(function() value40 = options.DebrisSelect.Value end)

addRightGroupbox4:AddInput("TimeScale", {
  Text = "TimeScale",
  Default = "1",
  Placeholder = "Enter TimeScale value",
  Finished = true,
})

options.TimeScale:OnChanged(function() end)

addRightGroupbox4:AddButton({
  Text = "Apply TimeScale",
  Func = function()
    local value43 = options.TimeScale.Value

    if value43 and value43 ~= "" then
      local timeScale = replicatedStorage.wkspc.TimeScale
      timeScale.Value = tonumber(value43) or value43

      library:Notify({
        Title = "TimeScale",
        Description = "Set to " .. tostring(value43),
        Time = 3,
      })
    end
  end,
})

addRightGroupbox5:AddSlider("FOVArsenal", {
  Text = "FOV Arsenal",
  Min = 0,
  Max = 120,
  Default = 70,
  Rounding = 0,
})

options.FOVArsenal:OnChanged(function()
  local v22 = game
  v22:GetService("Players").LocalPlayer.Settings.FOV.Value = options.FOVArsenal.Value
end)

local value44 = false
addRightGroupbox5:AddToggle("NoClip", { Text = "Toggle NoClip", Default = false })

toggles.NoClip:OnChanged(function()
  value44 = toggles.NoClip.Value
  local localPlayer10 = players.LocalPlayer

  local function f17()
    while value44 do
      local character9 = localPlayer10.Character

      if character9 then
        for key14, value45 in pairs(character9:GetDescendants()) do
          if value45:IsA("BasePart") then
            value45.CanCollide = false
          end
        end
      end

      runService.Stepped:Wait()
    end

    local character10 = localPlayer10.Character

    if character10 then
      for key15, value46 in pairs(character10:GetDescendants()) do
        if value46:IsA("BasePart") then
          value46.CanCollide = true
        end
      end
    end
  end

  if value44 then
    spawn(f17)
  end
end)

addRightGroupbox5:AddToggle("Xray", { Text = "Toggle Xray", Default = false })

toggles.Xray:OnChanged(function()
  if toggles.Xray.Value then
    for key16, value47 in pairs(workspace:GetDescendants()) do
      if value47:IsA("BasePart") then
        if not value47:FindFirstChild("OriginalTransparency") then
          local originalTransparency = Instance.new("NumberValue")
          originalTransparency.Name = "OriginalTransparency"
          originalTransparency.Value = value47.Transparency
          originalTransparency.Parent = value47
        end

        value47.Transparency = 0.5
      end
    end
  else
    for key17, value48 in pairs(workspace:GetDescendants()) do
      if value48:IsA("BasePart") then
        if value48:FindFirstChild("OriginalTransparency") then
          value48.Transparency = value48.OriginalTransparency.Value
          value48.OriginalTransparency:Destroy()
        end
      end
    end
  end
end)

local addLeftGroupbox9 = v7.Skins:AddLeftGroupbox("Arm Skins", "user")
local addLeftGroupbox10 = v7.Skins:AddLeftGroupbox("Gun Skin", "bolt")
local addRightGroupbox6 = v7.Skins:AddRightGroupbox("Rainbow Gun", "star")

local function f18(color)
  return Vector3.new(color.R, color.G, color.B)
end

local value49 = "Plastic"

addLeftGroupbox9:AddDropdown("ArmMaterial", {
  Text = "Arm Material",
  Values = { "Plastic", "ForceField", "Wood", "Grass" },
  Default = "Plastic",
  Multi = false,
})

options.ArmMaterial:OnChanged(function() value49 = options.ArmMaterial.Value end)
local color2 = Color3.fromRGB(50, 50, 50)

addLeftGroupbox9:AddSlider("ArmColorR", {
  Text = "Arm Color R",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

addLeftGroupbox9:AddSlider("ArmColorG", {
  Text = "Arm Color G",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

addLeftGroupbox9:AddSlider("ArmColorB", {
  Text = "Arm Color B",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

options.ArmColorR:OnChanged(function()
  color2 = Color3.fromRGB(
    options.ArmColorR.Value, options.ArmColorG.Value, options.ArmColorB.Value
  )
end)

options.ArmColorG:OnChanged(function()
  color2 = Color3.fromRGB(
    options.ArmColorR.Value, options.ArmColorG.Value, options.ArmColorB.Value
  )
end)

options.ArmColorB:OnChanged(function()
  color2 = Color3.fromRGB(
    options.ArmColorR.Value, options.ArmColorG.Value, options.ArmColorB.Value
  )
end)

local value50 = false
addLeftGroupbox9:AddToggle("ArmCharms", { Text = "Arm Charms", Default = false })

toggles.ArmCharms:OnChanged(function()
  value50 = toggles.ArmCharms.Value

  if value50 then
    spawn(function()
      while true do
        wait(0.01)

        if not value50 then
          break
        else
          local arms = workspace.Camera:FindFirstChild("Arms")

          if arms then
            for key18, value51 in pairs(arms:GetDescendants()) do
              if value51.Name == "Right Arm" or value51.Name == "Left Arm" then
                if value51:IsA("BasePart") then
                  value51.Material = Enum.Material[value49]
                  value51.Color = color2
                end
              elseif value51:IsA("SpecialMesh") then
                if value51.TextureId == "" then
                  value51.TextureId = "rbxassetid://0"
                  value51.VertexColor = f18(color2)
                end
              elseif value51.Name == "L" or value51.Name == "R" then
                value51:Destroy()
              end
            end
          end
        end
      end
    end)
  end
end)

local value52 = "Plastic"

addLeftGroupbox10:AddDropdown("GunMaterial", {
  Text = "Gun Material",
  Values = { "Plastic", "ForceField", "Wood", "Grass" },
  Default = "Plastic",
  Multi = false,
})

options.GunMaterial:OnChanged(function() value52 = options.GunMaterial.Value end)
local color3 = Color3.fromRGB(50, 50, 50)

addLeftGroupbox10:AddSlider("GunColorR", {
  Text = "Gun Color R",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

addLeftGroupbox10:AddSlider("GunColorG", {
  Text = "Gun Color G",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

addLeftGroupbox10:AddSlider("GunColorB", {
  Text = "Gun Color B",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

options.GunColorR:OnChanged(function()
  color3 = Color3.fromRGB(
    options.GunColorR.Value, options.GunColorG.Value, options.GunColorB.Value
  )
end)

options.GunColorG:OnChanged(function()
  color3 = Color3.fromRGB(
    options.GunColorR.Value, options.GunColorG.Value, options.GunColorB.Value
  )
end)

options.GunColorB:OnChanged(function()
  color3 = Color3.fromRGB(
    options.GunColorR.Value, options.GunColorG.Value, options.GunColorB.Value
  )
end)

local value53 = false
addLeftGroupbox10:AddToggle("GunCharms", { Text = "Gun Charms", Default = false })
local gunCharms = toggles.GunCharms

local function f19(index7)
  return math.acos(math.cos(index7 * math.pi)) / math.pi
end

gunCharms:OnChanged(function()
  value53 = toggles.GunCharms.Value

  if value53 then
    spawn(function()
      while true do
        wait(0.01)

        if not value53 then
          break
        end

        if not workspace.Camera:FindFirstChild("Arms") then
          wait()
        else
          for key19, value54 in pairs(workspace.Camera.Arms:GetDescendants()) do
            if value54:IsA("MeshPart") then
              value54.Material = Enum.Material[value52]
              value54.Color = color3
            end
          end
        end
      end
    end)
  end
end)

local value55 = false
local v23 = 1
addRightGroupbox6:AddToggle("RainbowV1", { Text = "Rainbow Gun v1", Default = false })
toggles.RainbowV1:OnChanged(function() value55 = toggles.RainbowV1.Value end)

runService.RenderStepped:Connect(function()
  if workspaceService.Camera:FindFirstChild("Arms") and value55 then
    for key20, value56 in pairs(workspaceService.Camera.Arms:GetDescendants()) do
      if value56.ClassName == "MeshPart" then
        value56.Color = Color3.fromHSV(f19(v23), 1, 1)
        v23 = v23 + 0.0001
      end
    end
  end
end)

local value57 = false
local v24 = 0

addRightGroupbox6:AddToggle("RainbowV2", {
  Text = "Rainbow Gun v2 [Crazy Fast]",
  Default = false,
})

toggles.RainbowV2:OnChanged(function() value57 = toggles.RainbowV2.Value end)

runService.RenderStepped:Connect(function()
  if workspaceService.Camera:FindFirstChild("Arms") and value57 then
    v24 = v24 + 0.1

    if v24 >= 1 then
      v24 = v24 % 1
    end

    for key21, value58 in pairs(workspaceService.Camera.Arms:GetDescendants()) do
      if value58.ClassName == "MeshPart" then
        value58.Color = Color3.fromHSV(v24, 1, 1)
      end
    end
  end
end)

local addLeftGroupbox11 = v7.Extra:AddLeftGroupbox("Random", "star")
local addRightGroupbox7 = v7.Extra:AddRightGroupbox("Chat", "info")

local function f20()
  for key22, value59 in pairs(game:GetDescendants()) do
    if value59:IsA("ParticleEmitter") then
      value59.Parent = workspace
    end
  end
end

local function f21()
  for key23, value60 in pairs(game:GetDescendants()) do
    if value60:IsA("ParticleEmitter") then
      value60.Parent = players.LocalPlayer.Character["Particle Area"]
    end
  end
end

addLeftGroupbox11:AddToggle("MessUpScreen", {
  Text = "Mess up your screen lol",
  Default = false,
})

toggles.MessUpScreen:OnChanged(function()
  if toggles.MessUpScreen.Value then
    f21()
  else
    f20()
  end
end)

local v25 = { Score = nil, Kills = nil }
addLeftGroupbox11:AddToggle("MaxLevel", { Text = "Max Level???", Default = false })

toggles.MaxLevel:OnChanged(function()
  local careerStatsCache = localPlayer3.CareerStatsCache

  if toggles.MaxLevel.Value then
    if not v25.Score then
      v25.Score = careerStatsCache.Score.Value
    end

    if not v25.Kills then
      v25.Kills = careerStatsCache.Kills.Value
    end

    careerStatsCache.Score.Value = 1000000000000000000
    careerStatsCache.Kills.Value = 100000000000000
  elseif v25.Score and v25.Kills then
    careerStatsCache.Score.Value = v25.Score
    careerStatsCache.Kills.Value = v25.Kills
  end
end)

local v26 = {
  GUIName = nil,
  GUIName2 = nil,
  KillFeed = {},
  WinnerName = nil,
  ScorecardName = nil,
}

local value61 = false

local function f22()
  local playerGui2 = localPlayer3.PlayerGui

  if v26.GUIName then
    playerGui2.Menew_Main.Container.PlrName.Text = v26.GUIName
  end

  if v26.GUIName2 then
    playerGui2.Menew_Main.Container.PlrName2.Text = v26.GUIName2
  end

  for key24, value62 in pairs(v26.KillFeed) do
    Workspace.KillFeed[tostring(key24)].Killer.Value = value62
  end

  if v26.WinnerName ~= nil then
    playerGui2.GUI.Winner.Visible = v26.WinnerName
  end

  if v26.ScorecardName then
    playerGui2.GUI_Scorecard.Scorecard.PlayerCard.Username.Text = v26.ScorecardName
  end
end

local v27 = false
addLeftGroupbox11:AddToggle("ChangeName", { Text = "Change Name", Default = false })

toggles.ChangeName:OnChanged(function()
  value61 = toggles.ChangeName.Value
  v27 = value61

  if value61 then
    local playerGui3 = localPlayer3.PlayerGui

    v26.GUIName = playerGui3.Menew_Main.Container.PlrName.Text
    v26.GUIName2 = playerGui3.Menew_Main.Container.PlrName2.Text
    v26.WinnerName = playerGui3.GUI.Winner.Visible
    v26.ScorecardName = playerGui3.GUI_Scorecard.Scorecard.PlayerCard.Username.Text

    local count = 0

    while true do
      count = 1 + count

      if not (6 >= count) then
        break
      end

      local v28 = count
      v26.KillFeed[v28] = Workspace.KillFeed[tostring(v28)].Killer.Value
    end

    spawn(function()
      while v27 do
        wait(0.2)
      end
    end)
  else
    v27 = false
    f22()
  end
end)

addRightGroupbox7:AddToggle("IsChad", { Text = "IsChad", Default = false })

toggles.IsChad:OnChanged(function()
  local localPlayer11 = players.LocalPlayer

  if localPlayer11:FindFirstChild("IsChad") then
    localPlayer11.IsChad:Destroy()
    return
  end

  if toggles.IsChad.Value then
    Instance.new("IntValue", localPlayer11).Name = "IsChad"
  end
end)

addRightGroupbox7:AddToggle("VIP", { Text = "VIP", Default = false })

toggles.VIP:OnChanged(function()
  local localPlayer12 = players.LocalPlayer

  if localPlayer12:FindFirstChild("VIP") then
    localPlayer12.VIP:Destroy()
    return
  end

  if toggles.VIP.Value then
    Instance.new("IntValue", localPlayer12).Name = "VIP"
  end
end)

addRightGroupbox7:AddToggle("OldVIP", { Text = "OldVIP", Default = false })

toggles.OldVIP:OnChanged(function()
  local localPlayer13 = players.LocalPlayer

  if localPlayer13:FindFirstChild("OldVIP") then
    localPlayer13.OldVIP:Destroy()
    return
  end

  if toggles.OldVIP.Value then
    Instance.new("IntValue", localPlayer13).Name = "OldVIP"
  end
end)

addRightGroupbox7:AddToggle("Romin", { Text = "Romin", Default = false })

toggles.Romin:OnChanged(function()
  local localPlayer14 = players.LocalPlayer

  if localPlayer14:FindFirstChild("Romin") then
    localPlayer14.Romin:Destroy()
    return
  end

  if toggles.Romin.Value then
    Instance.new("IntValue", localPlayer14).Name = "Romin"
  end
end)

addRightGroupbox7:AddToggle("IsAdmin", { Text = "IsAdmin", Default = false })

toggles.IsAdmin:OnChanged(function()
  local localPlayer15 = players.LocalPlayer

  if localPlayer15:FindFirstChild("IsAdmin") then
    localPlayer15.IsAdmin:Destroy()
    return
  end

  if toggles.IsAdmin.Value then
    Instance.new("IntValue", localPlayer15).Name = "IsAdmin"
  end
end)

local addLeftGroupbox12 = v7.Visuals:AddLeftGroupbox("ESP V1", "eye")
local addRightGroupbox8 = v7.Visuals:AddRightGroupbox("ESP Options", "settings")
local esp1 = loadstring(game:HttpGet("https://rawscript.vercel.app/api/raw/esp_1"))()
addLeftGroupbox12:AddToggle("ESPEnabled", { Text = "Enable ESP", Default = false })

toggles.ESPEnabled:OnChanged(function()
  local value63 = toggles.ESPEnabled.Value
  esp1:Toggle(value63)
  esp1.Players = value63
end)

addLeftGroupbox12:AddToggle("ESPTracers", { Text = "Tracers ESP", Default = false })
toggles.ESPTracers:OnChanged(function() esp1.Tracers = toggles.ESPTracers.Value end)
addLeftGroupbox12:AddToggle("ESPNames", { Text = "Name ESP", Default = false })
toggles.ESPNames:OnChanged(function() esp1.Names = toggles.ESPNames.Value end)
addLeftGroupbox12:AddToggle("ESPBoxes", { Text = "Boxes ESP", Default = false })
toggles.ESPBoxes:OnChanged(function() esp1.Boxes = toggles.ESPBoxes.Value end)
addLeftGroupbox12:AddToggle("ESPTeamColor", { Text = "Team Coordinate", Default = false })
toggles.ESPTeamColor:OnChanged(function() esp1.TeamColor = toggles.ESPTeamColor.Value end)
addLeftGroupbox12:AddToggle("ESPTeamMates", { Text = "Teammates", Default = false })
toggles.ESPTeamMates:OnChanged(function() esp1.TeamMates = toggles.ESPTeamMates.Value end)

addLeftGroupbox12:AddSlider("ESPColorR", {
  Text = "ESP Color R",
  Min = 0,
  Max = 255,
  Default = 255,
  Rounding = 0,
})

addLeftGroupbox12:AddSlider("ESPColorG", {
  Text = "ESP Color G",
  Min = 0,
  Max = 255,
  Default = 255,
  Rounding = 0,
})

addLeftGroupbox12:AddSlider("ESPColorB", {
  Text = "ESP Color B",
  Min = 0,
  Max = 255,
  Default = 255,
  Rounding = 0,
})

options.ESPColorR:OnChanged(function()
  esp1.Color = Color3.fromRGB(
    options.ESPColorR.Value, options.ESPColorG.Value, options.ESPColorB.Value
  )
end)

options.ESPColorG:OnChanged(function()
  esp1.Color = Color3.fromRGB(
    options.ESPColorR.Value, options.ESPColorG.Value, options.ESPColorB.Value
  )
end)

options.ESPColorB:OnChanged(function()
  esp1.Color = Color3.fromRGB(
    options.ESPColorR.Value, options.ESPColorG.Value, options.ESPColorB.Value
  )
end)

local v29 = {}
local v30 = "advtech_esp"

local function makeTextLabel(parent, text)
  local billboardGui = Instance.new("BillboardGui")
  local textLabel = Instance.new("TextLabel")

  billboardGui.Name = v30
  billboardGui.Parent = parent
  billboardGui.AlwaysOnTop = true
  billboardGui.Size = UDim2.new(0, 50, 0, 50)
  billboardGui.StudsOffset = Vector3.new(0, 2, 0)

  textLabel.Parent = billboardGui
  textLabel.BackgroundTransparency = 1
  textLabel.Size = UDim2.new(1, 0, 1, 0)
  textLabel.Text = text
  textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)

  return billboardGui
end

local f23

local function f24(value64, p8, p9)
  if value64 then
    for index8, value65 in ipairs(workspaceService:GetDescendants()) do
      if value65:IsA("TouchTransmitter") and value65.Parent.Name == p8 then
        f23(value65, p9)
      end
    end

    workspaceService.DescendantAdded:Connect(function(descendant)
      if descendant:IsA("TouchTransmitter") and descendant.Parent.Name == p8 then
        f23(descendant, p9)
      end
    end)
  else
    for key25, value66 in pairs(v29) do
      if key25 and value66 then
        value66:Destroy()
        v29[key25] = nil
      end
    end
  end
end

function f23(p10, p11)
  if p10:IsA("TouchTransmitter") then
    local parent2 = p10.Parent

    if not parent2:FindFirstChild(v30) then
      v29[parent2] = makeTextLabel(parent2, p11)
    end
  end
end

addRightGroupbox8:AddToggle("AmmoBoxESP", { Text = "Ammo Box ESP", Default = false })
toggles.AmmoBoxESP:OnChanged(function() f24(toggles.AmmoBoxESP.Value, "DeadAmmo", "Ammo Box") end)
addRightGroupbox8:AddToggle("HPJugESP", { Text = "HP Jug ESP", Default = false })
toggles.HPJugESP:OnChanged(function() f24(toggles.HPJugESP.Value, "DeadHP", "HP Jar") end)
local addLeftGroupbox13 = v7.Setting:AddLeftGroupbox("Performance", "bolt")
local addRightGroupbox9 = v7.Setting:AddRightGroupbox("Server", "globe")
local addRightGroupbox10 = v7.Setting:AddRightGroupbox("Keybind", "settings")
local v31 = {}
local v32 = {}

local v33 = {
  GlobalShadows = lighting.GlobalShadows,
  FogEnd = lighting.FogEnd,
  Brightness = lighting.Brightness,
}

local v34 = {
  WaterWaveSize = workspaceService.Terrain.WaterWaveSize,
  WaterWaveSpeed = workspaceService.Terrain.WaterWaveSpeed,
  WaterReflectance = workspaceService.Terrain.WaterReflectance,
  WaterTransparency = workspaceService.Terrain.WaterTransparency,
}

local v35 = {}
addLeftGroupbox13:AddToggle("AntiLag", { Text = "Anti Lag", Default = false })

toggles.AntiLag:OnChanged(function()
  if toggles.AntiLag.Value then
    for key26, value67 in pairs(workspaceService:GetDescendants()) do
      if value67:IsA("BasePart") and not value67.Parent:FindFirstChild("Humanoid") then
        v31[value67] = value67.Material
        value67.Material = Enum.Material.SmoothPlastic

        if value67:IsA("Texture") then
          table.insert(v32, value67)
          value67:Destroy()
        end
      end
    end
  else
    for key27, value68 in pairs(v31) do
      if key27 and key27:IsA("BasePart") then
        key27.Material = value68
      end
    end

    v31 = {}
  end
end)

addLeftGroupbox13:AddToggle("FPSBoost", { Text = "FPS Boost", Default = false })

toggles.FPSBoost:OnChanged(function()
  if toggles.FPSBoost.Value then
    local v36 = game
    local lighting2 = v36.Lighting

    local terrain = v36.Workspace.Terrain
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
    terrain.WaterTransparency = 0

    lighting2.GlobalShadows = false
    lighting2.FogEnd = 9000000000
    lighting2.Brightness = 0

    v20().Rendering.QualityLevel = "Level01"

    for key28, value69 in pairs(v36:GetDescendants()) do
      if value69:IsA("Part") or value69:IsA("Union") or value69:IsA("CornerWedgePart")
        or value69:IsA("TrussPart") then
        v31[value69] = value69.Material
        value69.Material = "Plastic"
        value69.Reflectance = 0
      elseif value69:IsA("Decal") or value69:IsA("Texture") then
        table.insert(v32, value69)
        value69.Transparency = 1
      elseif value69:IsA("ParticleEmitter") or value69:IsA("Trail") then
        value69.Lifetime = NumberRange.new(0)
      elseif value69:IsA("Explosion") then
        value69.BlastPressure = 1
        value69.BlastRadius = 1
      elseif value69:IsA("Fire") or value69:IsA("SpotLight") or value69:IsA("Smoke") then
        value69.Enabled = false
      elseif value69:IsA("MeshPart") then
        v31[value69] = value69.Material
        value69.Material = "Plastic"
        value69.Reflectance = 0
      end
    end

    for key29, value70 in pairs(lighting2:GetChildren()) do
      if value70:IsA("BlurEffect") or value70:IsA("SunRaysEffect")
        or value70:IsA("ColorCorrectionEffect") or value70:IsA("BloomEffect")
        or value70:IsA("DepthOfFieldEffect") then
        v35[value70] = value70.Enabled
        value70.Enabled = false
      end
    end
  else
    local terrain2 = workspaceService.Terrain
    terrain2.WaterWaveSize = v34.WaterWaveSize
    terrain2.WaterWaveSpeed = v34.WaterWaveSpeed
    terrain2.WaterReflectance = v34.WaterReflectance
    terrain2.WaterTransparency = v34.WaterTransparency

    lighting.GlobalShadows = v33.GlobalShadows
    lighting.FogEnd = v33.FogEnd
    lighting.Brightness = v33.Brightness

    v20().Rendering.QualityLevel = "Automatic"

    for key30, value71 in pairs(v31) do
      if key30 and key30:IsA("BasePart") then
        key30.Material = value71
        key30.Reflectance = 0
      end
    end

    v31 = {}

    for key31, value72 in pairs(v35) do
      if key31 then
        key31.Enabled = value72
      end
    end

    v35 = {}

    for key32, value73 in pairs(v32) do
      if value73 and value73.Parent then
        value73.Transparency = 0
      end
    end

    v32 = {}
  end
end)

local value74 = false
addLeftGroupbox13:AddToggle("FullBright", { Text = "Full Bright", Default = false })

toggles.FullBright:OnChanged(function()
  value74 = toggles.FullBright.Value

  local function f25()
    if value74 then
      lighting.Ambient = Color3.new(1, 1, 1)
      lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
      lighting.ColorShift_Top = Color3.new(1, 1, 1)
    else
      lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
      lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
      lighting.ColorShift_Top = Color3.new(0, 0, 0)
    end
  end

  f25()

  lighting.LightingChanged:Connect(f25)
end)

addRightGroupbox9:AddButton({
  Text = "Server Hop",
  Func = function()
    local placeId = game.PlaceId
    local jsonDecode = {}
    local nextPageCursor = ""
    local hour = os.date("!*t").hour

    if not pcall(function() jsonDecode = httpService:JSONDecode(readfile("NotSameServers.json")) end) then
      table.insert(jsonDecode, hour)
      writefile("NotSameServers.json", httpService:JSONEncode(jsonDecode))
    end

    local function f26()
      local jsonDecode2

      if nextPageCursor == "" then
        jsonDecode2 = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"
          .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
      else
        jsonDecode2 = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"
          .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. nextPageCursor))
      end

      local v37 = ""

      if jsonDecode2.nextPageCursor and jsonDecode2.nextPageCursor ~= "null"
        and jsonDecode2.nextPageCursor ~= nil then
        nextPageCursor = jsonDecode2.nextPageCursor
      end

      local count2 = 0

      for key33, value75 in pairs(jsonDecode2.data) do
        local v38 = true
        v37 = tostring(value75.id)

        if tonumber(value75.maxPlayers) > tonumber(value75.playing) then
          for key34, value76 in pairs(jsonDecode) do
            if count2 ~= 0 then
              if v37 == tostring(value76) then
                v38 = false
              end
            elseif tonumber(hour) ~= tonumber(value76) then
              pcall(function()
                delfile("NotSameServers.json")
                jsonDecode = {}
                table.insert(jsonDecode, hour)
              end)
            end

            count2 = count2 + 1
          end

          if v38 == true then
            table.insert(jsonDecode, v37)
            wait()

            pcall(function()
              writefile("NotSameServers.json", httpService:JSONEncode(jsonDecode))
              wait()
              teleportService:TeleportToPlaceInstance(placeId, v37, players.LocalPlayer)
            end)

            wait(4)
          end
        end
      end
    end

    while wait() do
      pcall(function()
        f26()

        if nextPageCursor ~= "" then
          f26()
        end
      end)
    end
  end,
})

addRightGroupbox9:AddButton({
  Text = "Rejoin Server",
  Func = function() teleportService:Teleport(game.PlaceId, players.LocalPlayer) end,
})

addRightGroupbox10:AddButton({
  Text = "Close UI (Press to Toggle)",
  Func = function() library:Toggle() end,
})

local addLeftGroupbox14 = v7.Credits:AddLeftGroupbox("Credits", "info")
local addRightGroupbox11 = v7.Credits:AddRightGroupbox("Developers", "user")

addLeftGroupbox14:AddLabel("Script Developed by:  Пидарасы Team")
addLeftGroupbox14:AddLabel("UI Framework: Obsidian")

addRightGroupbox11:AddDropdown("Developer", {
  Text = "Developer",
  Values = { "L", "BinContent" },
  Default = "L",
  Multi = false,
})

options.Developer:OnChanged(function()
  local value77 = options.Developer.Value
  print(value77 .. " created " .. ({ BinContent = "Owner", L = "Head Developer" })[value77])
end)

themeManager:SetLibrary(library)
saveManager:SetLibrary(library)
themeManager:SetFolder("THUB-Arsenal")
saveManager:SetFolder("THUB-Arsenal")

themeManager:SetDefaultTheme({
  FontColor = Color3.fromRGB(225, 225, 225),
  MainColor = Color3.fromRGB(28, 28, 28),
  AccentColor = Color3.fromRGB(100, 100, 255),
  BackgroundColor = Color3.fromRGB(20, 20, 20),
  OutlineColor = Color3.fromRGB(50, 50, 50),
  FontFace = Font.fromName("Gotham", Enum.FontWeight.Medium),
})

saveManager:BuildConfigSection(v7.Setting)

themeManager:ApplyToTab(v7.Setting)
themeManager:LoadDefault()

saveManager:LoadAutoloadConfig()

library:Notify({
  Title = "1337",
  Description = "Arsenal script loaded successfully!",
  Time = 4,
})

