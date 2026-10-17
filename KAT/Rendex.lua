
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local repo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local MainESP, CullingSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotWhyLclc/Main/refs/heads/main/Utils/esp.luau"))()
local Options = Library.Options
local Toggles = Library.Toggles

local time = tick()
Library:Notify("Loading")

MainESP.Options = {
  Enabled = false,
  Box = false,
  Health = false,
  Tracer = false,
  TracerOrigin = "Bottom",
  Name = false,
  Distance = false,
  Direction = false,
  Skeleton = false,
  TextOutline = false,
  Color = Color3.new(1, 1, 1),
  UseTeamColor = true,
  Rainbow = false,
  Font = 3,
  FontSize = 15,
  TeamCheck = false,
  BoxThickness = 0,
  TracerThickness = 0,
  DirectionThickness = 0,
  SkeletonThickness = 0,
  Bounties = false,
  KATBounty = false,
}

CullingSystem.maxRenderDistance = 20000
CullingSystem.nearDistance = 10000
CullingSystem.farDistance = 15000

local userinputservice = game:GetService("UserInputService")
local runservice = game:GetService("RunService")
local players = game:GetService("Players")
local httpservice = game:GetService("HttpService")
local teleportservice = game:GetService("TeleportService")
local localplayer = players.LocalPlayer

local client = {
    internal = false
}

local configs = {
    player = {
        noclip = false,
        walkspeedenabled = false,
        walkspeed = 16,
        infjump = false,
        flight = false,
        flightSpeed = 50
    },
    combat = {
        enabled = false,
        showFOV = false,
        fovRadius = 150,
        targetPart = "Head",
        wallcheck = false
    },
    settings = {
        serverhop = false,
        fpsBoost = false
    }
}

client.fovCircle = Drawing.new("Circle")
client.fovCircle.Thickness = 1.5
client.fovCircle.NumSides = 100
client.fovCircle.Radius = configs.combat.fovRadius
client.fovCircle.Filled = false
client.fovCircle.Visible = false
client.fovCircle.ZIndex = 999
client.fovCircle.Transparency = 1
client.fovCircle.Color = Color3.fromRGB(255, 255, 255)

client.ispc = (function()
  if userinputservice.TouchEnabled and not userinputservice.KeyboardEnabled and not userinputservice.MouseEnabled then
    return false
  elseif not userinputservice.TouchEnabled and userinputservice.KeyboardEnabled and userinputservice.MouseEnabled then
    return true
  end
  return false
end)

client.isvisible = function(targetPart, targetCharacter)
    local camera = workspace.CurrentCamera
    local localCharacter = localplayer.Character

    if not camera or not localCharacter or not targetPart then
        return false
    end

    local ignoreList = { localCharacter, camera }
    if workspace:FindFirstChild("WorldIgnore") then
        table.insert(ignoreList, workspace.WorldIgnore)
    end

    client.internal = true
    local ray = Ray.new(camera.CFrame.Position, (targetPart.Position - camera.CFrame.Position).Unit * 1000)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList, true, false)
    client.internal = false

    return hit == targetPart or (hit and hit:IsDescendantOf(targetCharacter))
end

client.gettarget = function()
    if not configs.combat.enabled then return nil end
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    
    local mousePos = userinputservice:GetMouseLocation()
    local bestPart = nil
    local bestDistance = configs.combat.fovRadius
    
    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localplayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local part = nil
                if configs.combat.targetPart == "Random" then
                    local possibleParts = player.Character:GetChildren()
                    local validParts = {}
                    for _, child in ipairs(possibleParts) do
                        if child:IsA("BasePart") then
                            table.insert(validParts, child)
                        end
                    end
                    if #validParts > 0 then
                        part = validParts[math.random(1, #validParts)]
                    end
                else
                    part = player.Character:FindFirstChild(configs.combat.targetPart) or player.Character:FindFirstChild("HumanoidRootPart")
                end
                
                if part then
                    local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                    if onScreen and screenPos.Z > 0 then
                        local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if distance <= bestDistance then
                            if not configs.combat.wallcheck or client.isvisible(part, player.Character) then
                                bestDistance = distance
                                bestPart = part
                            end
                        end
                    end
                end
            end
        end
    end
    return bestPart
end

runservice.RenderStepped:Connect(function()
    if configs.combat.showFOV and configs.combat.enabled then
        local mousePos = userinputservice:GetMouseLocation()
        client.fovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        client.fovCircle.Radius = configs.combat.fovRadius
        client.fovCircle.Visible = true
    else
        client.fovCircle.Visible = false
    end
end)

task.spawn(function()
    while true do
        task.wait()
        if localplayer.Character then
            local humanoid = localplayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = configs.player.walkspeedenabled and configs.player.walkspeed or 16
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait()
        if configs.player.noclip and localplayer.Character then
            for _, part in ipairs(localplayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

userinputservice.JumpRequest:Connect(function()
    if configs.player.infjump and localplayer.Character then
        local humanoid = localplayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

client.flight = function(enabled)
    if enabled then
        client.flightThread = task.spawn(function()
            local Character = localplayer.Character or localplayer.CharacterAdded:Wait()
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
            local Humanoid = Character:WaitForChild("Humanoid")
            
            Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            
            while configs.player.flight do
                task.wait()
                                
                local moveDir = Vector3.zero
                local cam = workspace.CurrentCamera
                
                local direction = Vector3.zero
                if userinputservice:IsKeyDown(Enum.KeyCode.W) then direction += Vector3.new(0, 0, -1) end
                if userinputservice:IsKeyDown(Enum.KeyCode.S) then direction += Vector3.new(0, 0, 1) end
                if userinputservice:IsKeyDown(Enum.KeyCode.A) then direction += Vector3.new(-1, 0, 0) end
                if userinputservice:IsKeyDown(Enum.KeyCode.D) then direction += Vector3.new(1, 0, 0) end
                
                if cam then
                    moveDir += cam.CFrame.RightVector * direction.X
                    moveDir -= cam.CFrame.LookVector * direction.Z
                    local up = userinputservice:IsKeyDown(Enum.KeyCode.Space) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonA) or userinputservice:IsKeyDown(Enum.KeyCode.DPadUp)
                    local down = userinputservice:IsKeyDown(Enum.KeyCode.LeftControl) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonB) or userinputservice:IsKeyDown(Enum.KeyCode.DPadDown)
                    moveDir += Vector3.yAxis * (up and 1 or 0)
                    moveDir -= Vector3.yAxis * (down and 1 or 0)
                end

                local speed = configs.player.flightSpeed or 50
                HumanoidRootPart.AssemblyLinearVelocity = moveDir.Magnitude > 0 and moveDir.Unit * speed or Vector3.zero
            end
            
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        end)
    else
        if client.flightThread then
            task.cancel(client.flightThread)
            client.flightThread = nil
            local Character = localplayer.Character
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                if Character:FindFirstChild("HumanoidRootPart") then
                    Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                end
            end
        end
    end
end

local ws_mt = getrawmetatable(workspace)
local old_ws_index = ws_mt.__index
setreadonly(ws_mt, false)
ws_mt.__index = newcclosure(function(self, key)
    if self == workspace and (key == "WorldToViewportPoint" or key == "WorldToScreenPoint") then
        local cam = workspace.CurrentCamera
        if cam then
            return function(_, ...)
                return cam[key](cam, ...)
            end
        end
    end
    return old_ws_index(self, key)
end)
setreadonly(ws_mt, true)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    if client.internal then
        return oldNamecall(self, ...)
    end

    local method = getnamecallmethod()

    if self == workspace and (method == "WorldToViewportPoint" or method == "WorldToScreenPoint") then
        local cam = workspace.CurrentCamera
        if cam then
            local args = {...}
            for _, v in ipairs(args) do
                if typeof(v) == "Vector3" then
                    return cam[method](cam, v)
                end
            end
            return cam[method](cam, unpack(args))
        end
    end

    if method == "FindPartOnRayWithIgnoreList" and self == workspace then
        local ray = ...
        local cam = workspace.CurrentCamera

        if typeof(ray) == "Ray" and cam and ray.Direction.Magnitude > 500 and (ray.Origin - cam.CFrame.Position).Magnitude < 5 then
            local target = client.gettarget()
            if target then
                return target, target.Position, Vector3.new(0, 1, 0), target.Material
            end
        end
    end

    return oldNamecall(self, ...)
end))

client.fpsBoosted = false
client.togglefpsboost = function(a)
    configs.settings.fpsBoost = a
    if a and not client.fpsBoosted then
        client.fpsBoosted = true
        local Terrain = workspace:FindFirstChildOfClass('Terrain')
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 0
        end
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 9e9
        pcall(function() settings().Rendering.QualityLevel = 1 end)
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("Decal") then v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then v.BlastPressure = 1; v.BlastRadius = 1 end
        end
        for _, v in pairs(game.Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
        Library:Notify("FPS Boost Enabled!")
    end
end

local function ServerHop(placeId)
    placeId = placeId or game.PlaceId

    local servers = {}
    local success, result = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
    end)

    if not success or not result then
        Library:Notify("Server Hop", "Failed to fetch servers.")
        return
    end

    local body = httpservice:JSONDecode(result)

    if body and body.data then
        for _, v in next, body.data do
            if type(v) == "table" and v.playing and v.maxPlayers and v.id ~= game.JobId then
                if v.playing < v.maxPlayers then
                    table.insert(servers, v.id)
                end
            end
        end
    end

    if #servers > 0 then
        teleportservice:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)], localplayer)
    else
        Library:Notify("Server Hop", "No available servers found.")
    end
end

local function RejoinServer()
    teleportservice:TeleportToPlaceInstance(game.PlaceId, game.JobId, localplayer)
end

client.antilag = function()
    local Terrain = workspace:FindFirstChildWhichIsA("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end
    
    game.Lighting.GlobalShadows = false
    game.Lighting.FogEnd = 9e9
    game.Lighting.FogStart = 9e9
    settings().Rendering.QualityLevel = 1
    
    for _, v in pairs(game:GetDescendants()) do
        pcall(function()
            if v:IsA("BasePart") then
                v.CastShadow = false
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
                v.TopSurface = Enum.SurfaceType.SmoothNoOutlines
                v.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
                v.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
                v.RightSurface = Enum.SurfaceType.SmoothNoOutlines
                v.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
                v.BackSurface = Enum.SurfaceType.SmoothNoOutlines
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            end
        end)
    end
    
    for _, v in pairs(game.Lighting:GetDescendants()) do
        pcall(function()
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end)
    end
    
    workspace.DescendantAdded:Connect(function(child)
        task.spawn(function()
            pcall(function()
                if child:IsA("ForceField") or child:IsA("Sparkles") or child:IsA("Smoke") or child:IsA("Fire") or child:IsA("Beam") then
                    runservice.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA("BasePart") then
                    child.CastShadow = false
                end
            end)
        end)
    end)
end

AddToggle = function(groupboxes, txt, clbck, default, tootip, customId)
    default = default or false
    local id = customId or txt:gsub("%s+", "")
    local tbl = {
        Text = txt,
        Default = default,
        Callback = clbck
    }
    if type(tootip) == "string" then
        tbl.Tooltip = tootip
    end
    return groupboxes:AddToggle(id, tbl)
end

AddSlider = (function(groupboxes, txt, clbck, default, min, max, round, tootip, customId)
    default = default or 0
    tootip = type(tootip) == "string" and tootip or nil
    round = round or 0
    
    local id = customId or string.gsub(txt, " ", "")
    
    local tbl = {
        Text     = txt,
        Default  = default,
        Max      = max,
        Min      = min,
        Rounding = round,
        Callback = clbck
    }
    
    if tootip then 
        tbl.Tooltip = tootip 
    end
    
    return groupboxes:AddSlider(id, tbl)
end)

Library.ForceCheckbox = true

local Window = Library:CreateWindow({
  Title = "Rendex",
  Footer = "Rendex | KAT | 1.0.1",
  Icon = 'rbxassetid://88268210823182',
  SidebarCompacted = true,
  Center = true,
  AutoShow = false,
  Resizable = true,
  ShowCustomCursor = true,
  NotifySide = "Right",
  TabPadding = 1,
  MenuFadeTime = 0.2,
  EnableSidebarResize = true,
  ShowToggleFrameInKeybinds = true,
  GlobalSearch = true,
  TabTransitionTime = 0.22,
  TabSwipeOffset = 26,
  TabSwipeFrom = "top",
  Animations = {
    ToggleWindow = true,
    TabSwitch = true,
    Groupbox = true,
    Dropdown = true,
    KeyPicker = true
  },
})

local tab = Window:AddTab("Player", "user", "Modifications for player")

local group = tab:AddLeftGroupbox("Movement")
AddToggle(group, "Walkspeed", function(a)
    configs.player.walkspeedenabled = a
end)
AddSlider(group, "Speed Value", function(a)
    configs.player.walkspeed = a
end, 16, 16, 25, 0)
AddToggle(group, "Infinite Jump", function(a) 
    configs.player.infjump = a
end)
local flighttoggle = AddToggle(group, "Flight", function(a) 
    configs.player.flight = a
    client.flight(a)
end)
AddSlider(group, "Flight Speed", function(a)
    configs.player.flightSpeed = a
end, 50, 10, 25, 0)
flighttoggle:AddKeyPicker("FlightKey", {
  Default = "X",
  Text = "Flight",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.flight = a
    if a then
      client.flight()
    end
  end
})
local nocliptoggle = AddToggle(group, "Noclip", function(a)
    configs.player.noclip = a
end)
nocliptoggle:AddKeyPicker("NoclipKey", {
  Default = "N",
  Text = "Noclip",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.noclip = a
  end
})

local tab = Window:AddTab("Combat", "hand-fist", "Modifications for combat")
local group = tab:AddLeftGroupbox("Silent Aim")

AddToggle(group, "Enabled", 
    function(a) 
    configs.combat.enabled = a
end)
AddToggle(group, "Wallcheck", 
    function(a) 
    configs.combat.wallcheck = a 
end)
AddToggle(group, "FOV Circle", 
    function(a) 
    configs.combat.showFOV = a
end)

AddSlider(group, "FOV Radius", function(a)
    configs.combat.fovRadius = a
end, 150, 0, 800, 0)

group:AddDropdown("TargetPart", {
    Text = "Target Part",
    Default = configs.combat.targetPart,
    Values = {"Head", "Torso", "Random"},
    Callback = function(a) 
        configs.combat.targetPart = a 
    end
})

local tab = Window:AddTab("Visual", "eye")

local group = tab:AddLeftGroupbox("ESP Options")
AddToggle(group, "Enabled", function(a)
  MainESP.Options.Enabled = a
end, false, nil, "EspEnabled")
AddToggle(group, "Bounty", function(a)
  MainESP.Options.KATBounty = a
end, false, nil, "KATBountyToggle")
AddToggle(group, "Box", function(a)
  MainESP.Options.Box = a
end)
AddToggle(group, "Tracer", function(a)
  MainESP.Options.Tracer = a
end)
AddToggle(group, "Name", function(a)
  MainESP.Options.Name = a
end)
AddToggle(group, "Distance", function(a)
  MainESP.Options.Distance = a
end)
AddToggle(group, "Health", function(a)
  MainESP.Options.Health = a
end)
AddToggle(group, "Skeleton", function(a)
  MainESP.Options.Skeleton = a
end)

local group = tab:AddRightGroupbox("ESP Settings")
AddToggle(group, "Team Check", function(a)
  MainESP.Options.TeamCheck = a
end)
AddToggle(group, "Use Team Color", function(a)
  MainESP.Options.UseTeamColor = a
end, true)
AddToggle(group, "Rainbow", function(a)
  MainESP.Options.Rainbow = a
end)
AddToggle(group, "Text Outline", function(a)
  MainESP.Options.TextOutline = a
end)
AddSlider(group, "Text Size", function(a)
  MainESP.Options.FontSize = a
end, 15, 1, 50, 0)
group:AddDropdown('TracerOrigins', {
  Values = { "Top", "Middle", "Bottom" },
  Default = 3,
  Multi = false,
  Text = "Tracer Origins",
  Searchable = false,
  Callback = function(Value)  
    MainESP.Options.TracerOrigin = Value
  end,
  Visible = true,
})

local tab = Window:AddTab("Misc", "earth")
local group = tab:AddLeftGroupbox("Servers")
group:AddButton("Server Hop", function()
    ServerHop()
end)
group:AddButton("Rejoin Server", function()
    RejoinServer()
end)

local group = tab:AddRightGroupbox("Others")
group:AddButton("Anti Lag", function()
    local AntiLagDialog = Window:AddDialog("AntiLagConfirm", {
        Title = "Warning",
        Description = "This action is irreversible and will drastically degrade graphics quality. You must rejoin the game to disable it. Are you sure you want to proceed?",
        AutoDismiss = true,
        OutsideClickDismiss = true,
        FooterButtons = {
            Cancel = {
                Title = "Cancel",
                Variant = "Ghost",
                Order = 1,
                Callback = function() end
            },
            Confirm = {
                Title = "Apply",
                Variant = "Destructive",
                WaitTime = 3,
                Order = 2,
                Callback = function()
                    client.antilag()
                end
            }
        }
    })
end)
local tab = Window:AddTab("Settings", "settings")
local MenuGroup = tab:AddLeftGroupbox("Menu Options")
MenuGroup:AddLabel("Menu bind")
    :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
MenuGroup:AddToggle("KeybindMenuOpen", {
  Default = Library.KeybindFrame.Visible,
  Text = "Open Keybind Menu",
  Callback = function(value)
    Library.KeybindFrame.Visible = value
  end,
})
AddToggle(MenuGroup, "Execute on serverhop", function(a)
    configs.settings.serverhop = a
    
    if a then
        queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotWhyLclc/Rendex/refs/heads/main/Loader.luau"))()')
    end
end)
MenuGroup:AddDivider()
MenuGroup:AddButton({
    Text = "Join Our Discord",
    Func = function()
        pcall(function()
            game:GetService("GuiService"):OpenUrl("https://discord.gg/X4GW8N5GdW")
        end)
    end
}):AddButton({
    Text = "Copy Invite Link",
    Func = function()
        if setclipboard then
            setclipboard("https://discord.gg/X4GW8N5GdW")
            Library:Notify("Copied Discord invite!", 2)
        else
            Library:Notify("Missing setclipboard function", 2)
        end
    end
})
MenuGroup:AddButton({
    Text = "Unload",
    DoubleClick = true,
    Func = function()
        if client.fovCircle then client.fovCircle:Remove() end
        Library:Unload()
    end
})
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder('Rendex')
SaveManager:SetFolder('Rendex/KAT')
ThemeManager:SetDefaultTheme({
    FontColor = Color3.fromRGB(255, 255, 255),
    MainColor = Color3.fromRGB(30, 30, 30),
    AccentColor = Color3.fromRGB(229, 96, 14),
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    OutlineColor = Color3.fromRGB(50, 50, 50),

    FontFace = Font.new("rbxasset://fonts/families/Jura.json")
})
SaveManager:BuildConfigSection(tab)
ThemeManager:ApplyToTab(tab)
SaveManager:LoadAutoloadConfig()

local loadTime = math.floor((tick() - time) * 100) / 100
Library:Notify("Loaded in " .. loadTime .. " seconds!", 3)
if client.ispc() then
  Library:Notify("Right shift to open", 3)
end
