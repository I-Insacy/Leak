local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetMouseLocation = UserInputService.GetMouseLocation
local Vector2_new = Vector2.new
local Vector3_new = Vector3.new
local Color3_new = Color3.new
local Color3_fromRGB = Color3.fromRGB
local math_clamp = math.clamp
local math_floor = math.floor
local table_insert = table.insert

local Unloaded = false
local RuntimeConnections = {}
local ItemDrawings = {}

local function ConnectEvent(signal, callback)
    local conn = signal:Connect(callback)
    table_insert(RuntimeConnections, conn)
    return conn
end

local crouchRemote = nil
task.spawn(function()
    pcall(function()
        local playersFolder = ReplicatedStorage:WaitForChild("Players", 5)
        if playersFolder then crouchRemote = playersFolder:WaitForChild("Crouch", 5) end
    end)
end)

local ItemData
task.spawn(function()
    pcall(function() ItemData = require(ReplicatedStorage:WaitForChild("ItemData", 5)) end)
end)

local Ballistics
task.spawn(function()
    pcall(function()
        Ballistics = require(ReplicatedStorage:WaitForChild("GunSystem", 5):WaitForChild("Ballistics", 5))
    end)
end)

local function GetSafeParent()
    local success, hui = pcall(function() return gethui() end)
    if success and hui then return hui end
    if CoreGui then return CoreGui end
    return PlayerGui
end

local TargetGuiParent = GetSafeParent()
local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

local function cleanupOldGui(name)
    local g1 = CoreGui:FindFirstChild(name) if g1 then g1:Destroy() end
    local g2 = PlayerGui:FindFirstChild(name) if g2 then g2:Destroy() end
    local g3 = TargetGuiParent:FindFirstChild(name) if g3 then g3:Destroy() end
end

cleanupOldGui("StealthMenu")
cleanupOldGui("StealthWatermark")
cleanupOldGui("StealthSAInfo")
cleanupOldGui("TargetInventoryViewer")

local ScreenGui 
local RefreshHitboxes 
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd
local OriginalFogStart = Lighting.FogStart
local OriginalGlobalShadows = Lighting.GlobalShadows
local CurrentBulletSpeed = 1500

local OriginalAtmosphereDensity = 0.3
local OriginalAtmosphereOffset = 0
pcall(function()
    local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmo then
        OriginalAtmosphereDensity = atmo.Density
        OriginalAtmosphereOffset = atmo.Offset
    end
end)

local OriginalPartSizes = {}
setmetatable(OriginalPartSizes, { __mode = "k" })

local function saveOriginalData(part)
    if part and part:IsA("BasePart") and not OriginalPartSizes[part] then
        local currentSize = part.Size
        if currentSize.X > 5 or currentSize.Y > 5 or currentSize.Z > 5 then
            currentSize = Vector3_new(1.2, 1.2, 1.2)
        end
        OriginalPartSizes[part] = {
            Size = currentSize,
            CanCollide = part.CanCollide,
            Massless = part.Massless,
            Transparency = part.Transparency,
            CollisionGroup = part.CollisionGroup
        }
    end
end

local Skyboxes = {
    ["default"] = {Bk="rbxassetid://6444884337",Dn="rbxassetid://6444884785",Ft="rbxassetid://6444884337",Lf="rbxassetid://6444884337",Rt="rbxassetid://6444884337",Up="rbxassetid://6412503613"},
    ["setting sun"] = {Bk="rbxassetid://626460377",Dn="rbxassetid://626460216",Ft="rbxassetid://626460513",Lf="rbxassetid://626473032",Rt="rbxassetid://626458639",Up="rbxassetid://626460625"},
    ["fade blue"] = {Bk="rbxassetid://153695414",Dn="rbxassetid://153695352",Ft="rbxassetid://153695452",Lf="rbxassetid://153695320",Rt="rbxassetid://153695383",Up="rbxassetid://153695471"},
    ["purple sky"] = {Bk="rbxassetid://570557514",Dn="rbxassetid://570557775",Ft="rbxassetid://570557559",Lf="rbxassetid://570557620",Rt="rbxassetid://570557672",Up="rbxassetid://570557727"},
    ["pinky sky"] = {Bk="rbxassetid://11427769401",Dn="rbxassetid://11427770685",Ft="rbxassetid://11427769401",Lf="rbxassetid://11427769401",Rt="rbxassetid://11427769401",Up="rbxassetid://11427771954"},
    ["blue sky"] = {Bk="rbxassetid://591058823",Dn="rbxassetid://591059876",Ft="rbxassetid://591058104",Lf="rbxassetid://591057861",Rt="rbxassetid://591057625",Up="rbxassetid://591059642"},
    ["neptune"] = {Bk="rbxassetid://218955819",Dn="rbxassetid://218953419",Ft="rbxassetid://218954524",Lf="rbxassetid://218958493",Rt="rbxassetid://218957134",Up="rbxassetid://218950090"},
    ["redshift"] = {Bk="rbxassetid://401664839",Dn="rbxassetid://401664862",Ft="rbxassetid://401664960",Lf="rbxassetid://401664881",Rt="rbxassetid://401664901",Up="rbxassetid://401664936"},
    ["elegant morning"] = {Bk="rbxassetid://153767241",Dn="rbxassetid://153767216",Ft="rbxassetid://153767266",Lf="rbxassetid://153767200",Rt="rbxassetid://153767231",Up="rbxassetid://153767288"}
}
local SkyboxNames = {"default", "setting sun", "fade blue", "purple sky", "pinky sky", "blue sky", "neptune", "redshift", "elegant morning"}

local hitSoundList = {
    ["Neverlose"] = "rbxassetid://139452805868562",
    ["GameSense"] = "rbxassetid://83717596220569",
    ["Fatality"]  = "rbxassetid://115982072912004",
    ["TF2"]       = "rbxassetid://138901307926331",
    ["MineCraft"] = "rbxassetid://73571339886360",
    ["VeryUP"]    = "rbxassetid://7380502345",
    ["Windows"]   = "rbxassetid://112503411915717"
}

local hitSoundNames = {}
for name in pairs(hitSoundList) do table_insert(hitSoundNames, name) end
table.sort(hitSoundNames)

local TargetInvGui

local Settings = {
    SA_General = false,
    SA_Predict = false,
    SA_TargetPart = "Head",
    SA_ShowFov = false,
    SA_FovColor = Color3_new(1, 1, 1),
    SA_FovRadius = 150,
    SA_TargetLine = false,
    SA_TargetLineColor = Color3_new(1, 1, 1),
    SA_AutoShot = false,
    SA_ShowText = false,
    SA_ShowNickname = false,
    HB_ExpandHead = false,
    AutoHeal = false,
    Misc_TargetInventory = false,
    ESP_Enabled = false,
    ESP_Box = false,
    ESP_BoxColor = Color3_fromRGB(255, 255, 255),
    ESP_Name = false,
    ESP_NameColor = Color3_fromRGB(255, 255, 255),
    ESP_Distance = false,
    ESP_DistanceColor = Color3_fromRGB(255, 255, 255),
    ESP_Health = false,
    ESP_MaxDistance = 2000, 
    Visuals_WeaponChams = false,
    Visuals_WeaponChamsColor = Color3_new(1, 1, 1),
    Visuals_Tracers = false,
    Visuals_TracersColor = Color3_new(1, 1, 1),
    Visuals_HitSound = false,
    Visuals_HitSoundVal = "Neverlose",
    VM_Enabled = false,
    VM_X = 0,
    VM_Y = -0.15,
    VM_Z = -0.6,
    Gun_NoRecoil = false,
    Gun_NoSpread = false,
    Gun_NoDrop = false,
    Gun_NoBob = false,
    Gun_NoShotSfx = false,
    Gun_NoShotVFX = false,
    Gun_InstantBow = false,
    World_Skybox = false,
    World_SkyboxVal = "default",
    World_TimeChanger = false,
    World_TimeValue = 12,
    World_NoClouds = false,
    World_NoGrass = false,
    World_NoFog = false,
    World_NoShadows = false,
    World_Distance = 250,
    World_ESP_Hemp = false,
    World_ESP_HempColor = Color3_new(1, 1, 1),
    World_ESP_Stone = false,
    World_ESP_StoneColor = Color3_new(1, 1, 1),
    World_ESP_MetalOre = false,
    World_ESP_MetalOreColor = Color3_new(1, 1, 1),
    World_ESP_SulfurOre = false,
    World_ESP_SulfurOreColor = Color3_new(1, 1, 1),
    World_ESP_JunkPile = false,
    World_ESP_JunkPileColor = Color3_new(1, 1, 1),
    World_ESP_MushRoom = false,
    World_ESP_MushRoomColor = Color3_new(1, 1, 1),
    Camera_Zoom = false,
    Misc_OmniSprint = false,
    Misc_Speedhack = false,
    Misc_SilentWalk = false,
    Misc_FastTools = false
}

local VFXCache = {}
local SFXCache = {}
local SFXConnections = {}
local originalSpringHooks = {}

local function applySkybox(name)
    local data = Skyboxes[name]
    if not data then return end
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Parent = Lighting
    end
    sky.SkyboxBk = data.Bk
    sky.SkyboxDn = data.Dn
    sky.SkyboxFt = data.Ft
    sky.SkyboxLf = data.Lf
    sky.SkyboxRt = data.Rt
    sky.SkyboxUp = data.Up
end

local function HandleVFX(instance)
    if not instance then return end
    if instance:IsA("ParticleEmitter") then
        if not VFXCache[instance] then VFXCache[instance] = {Enabled = instance.Enabled, Rate = instance.Rate, Size = instance.Size, Transparency = instance.Transparency} end
        if Settings.Gun_NoShotVFX then
            instance.Enabled = false
            instance.Rate = 0
            instance.Size = NumberSequence.new(0)
            instance.Transparency = NumberSequence.new(1)
        end
    elseif instance:IsA("Light") or instance:IsA("PointLight") or instance:IsA("SpotLight") then
        if not VFXCache[instance] then VFXCache[instance] = {Enabled = instance.Enabled, Brightness = instance.Brightness, Range = instance.Range} end
        if Settings.Gun_NoShotVFX then
            instance.Enabled = false
            instance.Brightness = 0
            instance.Range = 0
        end
    elseif instance:IsA("Beam") or instance:IsA("Trail") then
        if not VFXCache[instance] then VFXCache[instance] = {Enabled = instance.Enabled, Transparency = instance.Transparency} end
        if Settings.Gun_NoShotVFX then
            instance.Enabled = false
            instance.Transparency = NumberSequence.new(1)
        end
    elseif instance:IsA("BasePart") and (instance.Name == "TracerCore" or instance.Name == "ClientBulletTracer" or instance.Name == "BulletHole") then
        if not VFXCache[instance] then VFXCache[instance] = {Transparency = instance.Transparency, Size = instance.Size} end
        if Settings.Gun_NoShotVFX then
            instance.Transparency = 1
            instance.Size = Vector3_new()
        end
    end
end

local function RestoreVFX()
    for instance, cache in pairs(VFXCache) do
        if instance and instance.Parent then
            for prop, val in pairs(cache) do pcall(function() instance[prop] = val end) end
        end
    end
end

ConnectEvent(Camera.DescendantAdded, HandleVFX)
ConnectEvent(workspace.Terrain.DescendantAdded, HandleVFX)
ConnectEvent(ReplicatedStorage.DescendantAdded, HandleVFX)

local dummySound = Instance.new("Sound")
local oldPlay
oldPlay = hookfunction(dummySound.Play, function(self, ...)
    if Unloaded then return oldPlay(self, ...) end
    if Settings.Gun_NoShotSfx and typeof(self) == "Instance" and self:IsA("Sound") then
        local name = self.Name:lower()
        if name == "fire" or name:find("shoot") or name:find("shot") or self:IsDescendantOf(ReplicatedStorage:FindFirstChild("GunSystem")) then
            self.Volume = 0
            return nil
        end
    end
    return oldPlay(self, ...)
end)

pcall(function()
    local MakeSoundClient = ReplicatedStorage:WaitForChild("SoundService", 5)
    if MakeSoundClient then
        MakeSoundClient = MakeSoundClient:WaitForChild("RemoteEvents", 5)
        if MakeSoundClient then
            MakeSoundClient = MakeSoundClient:WaitForChild("MakeSoundClient", 5)
            if MakeSoundClient then
                local oldFSC = MakeSoundClient.FireServer
                hookfunction(MakeSoundClient.FireServer, function(self, ...)
                    if Unloaded then return oldFSC(self, ...) end
                    if Settings.Gun_NoShotSfx then return nil end
                    return oldFSC(self, ...)
                end)
            end
        end
    end
end)

local function SilenceSound(s)
    if s:IsA("Sound") then
        local name = s.Name:lower()
        if name == "fire" or name:find("shoot") or name:find("shot") then
            if not SFXCache[s] then SFXCache[s] = s.Volume end
            if Settings.Gun_NoShotSfx then s.Volume = 0 end
            if not SFXConnections[s] then
                SFXConnections[s] = ConnectEvent(s:GetPropertyChangedSignal("Volume"), function()
                    if Settings.Gun_NoShotSfx and s.Volume > 0 then
                        SFXCache[s] = s.Volume
                        s.Volume = 0
                    end
                end)
            end
        end
    end
end

local function RestoreSFX()
    for s, vol in pairs(SFXCache) do
        if s and s.Parent then pcall(function() s.Volume = vol end) end
    end
end

for _, s in ipairs(game:GetDescendants()) do SilenceSound(s) end
ConnectEvent(game.DescendantAdded, SilenceSound)

pcall(function()
    for _, v in pairs(getloadedmodules()) do
        if v.Name == "GunClient" then
            local GC = require(v)
            if GC.CreateTracer then
                local oldCT = GC.CreateTracer
                GC.CreateTracer = function(...)
                    if Unloaded then return oldCT(...) end
                    if Settings.Gun_NoShotVFX then return end
                    return oldCT(...)
                end
            end
            if GC.DisplayPredictedShot then
                local oldDPS = GC.DisplayPredictedShot
                GC.DisplayPredictedShot = function(...)
                    if Unloaded then return oldDPS(...) end
                    if Settings.Gun_NoShotVFX then return end
                    return oldDPS(...)
                end
            end
        elseif v.Name == "ImpactEffects" then
            local IE = require(v)
            if IE.Spawn then
                local oldSpawn = IE.Spawn
                IE.Spawn = function(...)
                    if Unloaded then return oldSpawn(...) end
                    if Settings.Gun_NoShotVFX then return end
                    return oldSpawn(...)
                end
            end
            if IE.Surface and IE.Surface.PlayOwn then
                local oldPO = IE.Surface.PlayOwn
                IE.Surface.PlayOwn = function(...)
                    if Unloaded then return oldPO(...) end
                    if Settings.Gun_NoShotVFX then return end
                    return oldPO(...)
                end
            end
        end
    end
end)

local function HookSprings()
    for _, obj in pairs(getgc(true)) do
        if type(obj) == "table" and ((rawget(obj, "p") and rawget(obj, "v")) or (rawget(obj, "Position") and rawget(obj, "Velocity"))) then
            if type(rawget(obj, "shove")) == "function" and not originalSpringHooks[obj] then
                local oldShove = rawget(obj, "shove")
                local oldUpdate = rawget(obj, "update")
                originalSpringHooks[obj] = true
                
                rawset(obj, "shove", function(self, ...)
                    if Unloaded then return oldShove(self, ...) end
                    if Settings.Gun_NoBob then
                        if type(self) == "table" then
                            self.p = Vector3_new()
                            self.v = Vector3_new()
                            self.target = Vector3_new()
                        end
                        return
                    end
                    return oldShove(self, ...)
                end)
                
                if oldUpdate then
                    rawset(obj, "update", function(self, ...)
                        if Unloaded then return oldUpdate(self, ...) end
                        if Settings.Gun_NoBob then
                            if type(self) == "table" then
                                self.p = Vector3_new()
                                self.v = Vector3_new()
                                self.target = Vector3_new()
                            end
                            return Vector3_new()
                        end
                        return oldUpdate(self, ...)
                    end)
                end
            end
        end
    end
end
task.spawn(HookSprings)

local Colors = {
    Background = Color3_fromRGB(13, 13, 13),
    Panel = Color3_fromRGB(14, 14, 14),
    PanelInner = Color3_fromRGB(18, 18, 18),
    OuterBorder = Color3_fromRGB(26, 26, 26),
    InnerBorder = Color3_fromRGB(55, 55, 55),
    DividerLine = Color3_fromRGB(31, 31, 31),
    Accent = Color3_fromRGB(199, 36, 177),
    AccentDark = Color3_fromRGB(120, 20, 105),
    Text = Color3_fromRGB(255, 255, 255),
    TextDim = Color3_fromRGB(150, 150, 150),
    TextGroup = Color3_fromRGB(140, 140, 140),
    Black = Color3_new(0, 0, 0),
}

local WINDOW_SIZE = UDim2.fromOffset(580, 580)
local PADDING = 15
local SUBTAB_BAR_HEIGHT = 26
local ROW_HEIGHT = 22
local GROUP_HEADER_H = 28

local TABS = {
    { name = "Combat", subtabs = {
        { name = "Main", left = "Silent Aimbot", right = "Other" },
        { name = "Guns", left = "Guns mode", right = "Empty" },
    }},
    { name = "Visuals", subtabs = {
        { name = "ESP", left = "ESP", right = "Visuals" },
        { name = "World", left = "World", right = "World Settings" },
    }},
    { name = "Misc", subtabs = {
        { name = "Misc 1", left = "Movement", right = "Camera" },
        { name = "Misc 2", left = "Events", right = "Other" },
    }},
    { name = "Settings", subtabs = {
        { name = "Config", left = "Menu", right = "System" },
    }},
}

local function create(className, props)
    local inst = Instance.new(className)
    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then inst.AutoLocalize = false end
    for k, v in pairs(props) do inst[k] = v end
    return inst
end

local function addStroke(parent, color, thickness)
    return create("UIStroke", { Color = color, Thickness = thickness or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = parent })
end

local Library = { Font = Enum.Font.Code, FontColor = Colors.Text, MainColor = Colors.PanelInner, OpenedFrames = {} }

function Library:Create(Class, Properties)
    local inst = type(Class) == "string" and Instance.new(Class) or Class
    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then inst.AutoLocalize = false end
    for Property, Value in pairs(Properties) do inst[Property] = Value end
    return inst
end

function Library:CreateLabel(Properties)
    local inst = Library:Create("TextLabel", { BackgroundTransparency = 1, Font = Library.Font, TextColor3 = Library.FontColor, TextSize = 14 })
    return Library:Create(inst, Properties)
end

function Library:SafeCallback(f, ...) if f then pcall(f, ...) end end
function Library:MapValue(V, MinA, MaxA, MinB, MaxB) return (1 - ((V - MinA) / (MaxA - MinA))) * MinB + ((V - MinA) / (MaxA - MinA)) * MaxB end
function Library:MouseIsOverOpenedFrame()
    for Frame in pairs(Library.OpenedFrames) do
        if Frame.Visible then
            local P, S = Frame.AbsolutePosition, Frame.AbsoluteSize
            if Mouse.X >= P.X and Mouse.X <= P.X + S.X and Mouse.Y >= P.Y and Mouse.Y <= P.Y + S.Y then return true end
        end
    end
    return false
end

local Controls = {}

function Controls.Row(parent, height)
    local row = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, height or ROW_HEIGHT), Parent = parent })
    Library:Create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6), Parent = row })
    return row
end

function Controls.Toggle(parent, Info)
    local Toggle = { Value = Info.Default or false, Callback = Info.Callback }
    local Holder = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(Info.Width or 160, ROW_HEIGHT), Parent = parent })
    
    local BoxOuter = Library:Create("Frame", { BackgroundColor3 = Colors.Black, BorderSizePixel = 0, Size = UDim2.fromOffset(13, 13), Position = UDim2.new(0, 0, 0.5, -7), Parent = Holder })
    local BoxInner = Library:Create("Frame", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Parent = BoxOuter })
    addStroke(BoxInner, Colors.InnerBorder, 1)

    Library:CreateLabel({ Size = UDim2.new(1, -22, 1, 0), Position = UDim2.new(0, 22, 0, 0), TextSize = 13, Text = Info.Text or "Toggle", TextXAlignment = Enum.TextXAlignment.Left, Parent = Holder })
    local Region = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = Holder })

    function Toggle:Display() BoxInner.BackgroundColor3 = Toggle.Value and Colors.Accent or Library.MainColor end
    function Toggle:SetValue(v) Toggle.Value = v; Toggle:Display(); Library:SafeCallback(Toggle.Callback, Toggle.Value) end

    ConnectEvent(Region.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then Toggle:SetValue(not Toggle.Value) end
    end)
    Toggle:Display(); return Toggle
end

function Controls.Slider(parent, Info)
    local Slider = { Value = Info.Default or Info.Min, Min = Info.Min, Max = Info.Max, Rounding = Info.Rounding or 0, Callback = Info.Callback }
    local Holder = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(Info.Width or 220, ROW_HEIGHT + 14), Parent = parent })

    Library:CreateLabel({ Size = UDim2.new(1, 0, 0, 14), TextSize = 13, Text = Info.Text or "Slider", TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Colors.TextDim, Parent = Holder })
    local BarOuter = Library:Create("Frame", { BackgroundColor3 = Colors.Black, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 13), Position = UDim2.new(0, 0, 0, 16), Parent = Holder })
    local BarInner = Library:Create("Frame", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Parent = BarOuter })
    addStroke(BarInner, Colors.InnerBorder, 1)

    local Handle = Library:Create("Frame", { BackgroundColor3 = Colors.Accent, BorderSizePixel = 0, Size = UDim2.new(0, 6, 1, 0), AnchorPoint = Vector2_new(0.5, 0), Parent = BarInner })
    local ValueLabel = Library:CreateLabel({ Size = UDim2.new(1, 0, 1, 0), TextSize = 12, Text = "", Parent = BarInner })

    function Slider:Display()
        local scale = math_clamp((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1)
        Handle.Position = UDim2.new(scale, 0, 0, 0)
        ValueLabel.Text = tostring(Slider.Value) .. (Info.Suffix or "")
    end
    
    function Slider:SetValue(v)
        Slider.Value = tonumber(string.format("%."..Slider.Rounding.."f", math_clamp(tonumber(v) or Slider.Min, Slider.Min, Slider.Max)))
        Slider:Display(); Library:SafeCallback(Slider.Callback, Slider.Value)
    end

    ConnectEvent(BarInner.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                local relX = math_clamp(Mouse.X - BarInner.AbsolutePosition.X, 0, BarInner.AbsoluteSize.X)
                Slider:SetValue(Library:MapValue(relX, 0, BarInner.AbsoluteSize.X, Slider.Min, Slider.Max))
                RunService.RenderStepped:Wait()
            end
        end
    end)
    Slider:Display(); return Slider
end

function Controls.Dropdown(parent, Info)
    local Dropdown = { Value = Info.Default, Values = Info.Values, Opened = false, Callback = Info.Callback }
    local Width = Info.Width or 200
    local ListHeight = math_clamp(#Dropdown.Values, 1, 6) * 20

    local Holder = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(0, Width, 0, ROW_HEIGHT), ClipsDescendants = true, Parent = parent })
    local MainBtn = Library:Create("Frame", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 0, 1), Parent = Holder })
    local Label = Library:CreateLabel({ Position = UDim2.new(0, 5, 0, 0), Size = UDim2.new(1, -25, 1, 0), TextSize = 13, Text = Dropdown.Value or "--", TextXAlignment = Enum.TextXAlignment.Left, Parent = MainBtn })
    local Arrow = Library:CreateLabel({ Position = UDim2.new(1, -20, 0, 0), Size = UDim2.new(0, 20, 1, 0), TextSize = 12, Text = "▼", TextColor3 = Colors.TextDim, Parent = MainBtn })
    
    local ListBg = Library:Create("Frame", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, ListHeight), Position = UDim2.new(0, 0, 0, 22), Parent = Holder })
    local Scrolling = Library:Create("ScrollingFrame", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), CanvasSize = UDim2.new(0, 0, 0, #Dropdown.Values * 20), ScrollBarThickness = 2, ScrollBarImageColor3 = Colors.Accent, Parent = ListBg })
    Library:Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = Scrolling })

    local function UpdateState()
        Arrow.Text = Dropdown.Opened and "▲" or "▼"
        Holder.Size = Dropdown.Opened and UDim2.new(0, Width, 0, ROW_HEIGHT + ListHeight + 2) or UDim2.new(0, Width, 0, ROW_HEIGHT)
    end

    ConnectEvent(MainBtn.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
            Dropdown.Opened = not Dropdown.Opened; UpdateState()
        end
    end)

    for _, val in ipairs(Dropdown.Values) do
        local Btn = Library:Create("TextLabel", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 20), Font = Library.Font, Text = "  " .. val, TextSize = 13, TextColor3 = (Dropdown.Value == val) and Colors.Accent or Colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = Scrolling })
        ConnectEvent(Btn.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dropdown.Value = val; Label.Text = val; Dropdown.Opened = false; UpdateState()
                for _, c in ipairs(Scrolling:GetChildren()) do if c:IsA("TextLabel") then c.TextColor3 = (c.Text == "  " .. val) and Colors.Accent or Colors.Text end end
                Library:SafeCallback(Dropdown.Callback, val)
            end
        end)
    end
    return Dropdown
end

function Controls.ColorPicker(parent, Info)
    local ColorPicker = { Value = Info.Default or Color3_fromRGB(255, 255, 255), Callback = Info.Callback }
    local Holder = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(Info.Width or 26, ROW_HEIGHT), Parent = parent })
    
    local Display = Library:Create("Frame", { BackgroundColor3 = ColorPicker.Value, BorderSizePixel = 0, Size = UDim2.fromOffset(22, 14), Position = UDim2.new(0.5, -11, 0.5, -7), Parent = Holder })
    addStroke(Display, Colors.InnerBorder, 1)

    local Popup = Library:Create("Frame", { BackgroundColor3 = Colors.Black, BorderSizePixel = 0, Size = UDim2.fromOffset(160, 160), Visible = false, ZIndex = 60, Parent = ScreenGui })
    local PopupInner = Library:Create("Frame", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), ZIndex = 61, Parent = Popup })
    addStroke(PopupInner, Colors.InnerBorder, 1)

    local h, s, v = Color3.toHSV(ColorPicker.Value)

    local SatVibOuter = Library:Create("Frame", { BackgroundColor3 = Colors.Black, Size = UDim2.fromOffset(130, 130), Position = UDim2.fromOffset(6, 6), BorderSizePixel = 0, ZIndex = 62, Parent = PopupInner })
    local SatVib = Library:Create("ImageLabel", { BackgroundColor3 = Color3.fromHSV(h, 1, 1), Image = "rbxassetid://4155801252", Size = UDim2.new(1, 0, 1, 0), BorderSizePixel = 0, ZIndex = 62, Parent = SatVibOuter })
    local SVMarker = Library:Create("Frame", { BackgroundColor3 = Color3_new(1,1,1), Size = UDim2.fromOffset(4, 4), AnchorPoint = Vector2_new(0.5, 0.5), Position = UDim2.new(s, 0, 1-v, 0), ZIndex = 63, Parent = SatVib })
    addStroke(SVMarker, Colors.Black, 1)

    local HueOuter = Library:Create("Frame", { BackgroundColor3 = Colors.Black, Size = UDim2.fromOffset(12, 130), Position = UDim2.fromOffset(142, 6), BorderSizePixel = 0, ZIndex = 62, Parent = PopupInner })
    local HueInner = Library:Create("Frame", { BackgroundColor3 = Color3_new(1, 1, 1), Size = UDim2.new(1, 0, 1, 0), BorderSizePixel = 0, ZIndex = 62, Parent = HueOuter })
    local seq = {} for i = 0, 1, 0.1 do table_insert(seq, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1))) end
    Library:Create("UIGradient", { Color = ColorSequence.new(seq), Rotation = 90, Parent = HueInner })
    local HueMarker = Library:Create("Frame", { BackgroundColor3 = Color3_new(1,1,1), Size = UDim2.new(1, 2, 0, 2), AnchorPoint = Vector2_new(0, -1, h, 0), ZIndex = 63, Parent = HueInner })
    addStroke(HueMarker, Colors.Black, 1)

    local function UpdateColor()
        local col = Color3.fromHSV(h, s, v)
        ColorPicker.Value = col; Display.BackgroundColor3 = col
        SatVib.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        SVMarker.Position = UDim2.new(s, 0, 1 - v, 0); HueMarker.Position = UDim2.new(0, -1, h, 0)
        Library:SafeCallback(ColorPicker.Callback, col)
    end

    ConnectEvent(SatVib.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                s = math_clamp(Mouse.X - SatVib.AbsolutePosition.X, 0, SatVib.AbsoluteSize.X) / SatVib.AbsoluteSize.X
                v = 1 - (math_clamp(Mouse.Y - SatVib.AbsolutePosition.Y, 0, SatVib.AbsoluteSize.Y) / SatVib.AbsoluteSize.Y)
                UpdateColor(); RunService.RenderStepped:Wait()
            end
        end
    end)
    ConnectEvent(HueInner.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                h = math_clamp(Mouse.Y - HueInner.AbsolutePosition.Y, 0, HueInner.AbsoluteSize.Y) / HueInner.AbsoluteSize.Y
                UpdateColor(); RunService.RenderStepped:Wait()
            end
        end
    end)

    ConnectEvent(Display:GetPropertyChangedSignal("AbsolutePosition"), function()
        if Popup.Visible then Popup.Position = UDim2.fromOffset(Display.AbsolutePosition.X + 35, Display.AbsolutePosition.Y - 5) end
    end)

    ConnectEvent(Display.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Popup.Position = UDim2.fromOffset(Display.AbsolutePosition.X + 35, Display.AbsolutePosition.Y - 5)
            Popup.Visible = not Popup.Visible
            Library.OpenedFrames[Popup] = Popup.Visible and true or nil
        end
    end)
    return ColorPicker
end

function Controls.KeyPicker(parent, Info)
    local KeyPicker = { Value = Info.Default or "None", LinkedToggle = Info.LinkedToggle, Callback = Info.Callback, Picking = false }
    local Holder = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(Info.Width or 60, ROW_HEIGHT), Parent = parent })
    
    local PickOuter = Library:Create("Frame", { BackgroundColor3 = Colors.Black, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 18), Position = UDim2.new(0, 0, 0.5, -9), Parent = Holder })
    local PickInner = Library:Create("Frame", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Parent = PickOuter })
    addStroke(PickInner, Colors.InnerBorder, 1)

    local Display = Library:CreateLabel({ Size = UDim2.new(1, 0, 1, 0), TextSize = 13, Text = KeyPicker.Value, Parent = PickInner })

    function KeyPicker:Refresh()
        Display.Text = KeyPicker.Picking and "..." or KeyPicker.Value
        Display.TextColor3 = KeyPicker.Picking and Colors.Accent or Colors.Text
    end

    ConnectEvent(PickOuter.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
            KeyPicker.Picking = true; KeyPicker:Refresh()
            if KeyPicker.BindEvent then KeyPicker.BindEvent:Disconnect() end
            KeyPicker.BindEvent = UserInputService.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.Keyboard or inp.UserInputType == Enum.UserInputType.MouseButton2 then
                    KeyPicker.Value = (inp.UserInputType == Enum.UserInputType.Keyboard) and inp.KeyCode.Name or "MB2"
                    KeyPicker.Picking = false; KeyPicker:Refresh()
                    if KeyPicker.BindEvent then KeyPicker.BindEvent:Disconnect(); KeyPicker.BindEvent = nil end
                end
            end)
        end
    end)
    ConnectEvent(UserInputService.InputBegan, function(input, gpe)
        if gpe or Unloaded or KeyPicker.Picking or KeyPicker.Value == "None" then return end
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == KeyPicker.Value) or (input.UserInputType == Enum.UserInputType.MouseButton2 and KeyPicker.Value == "MB2") then
            if KeyPicker.LinkedToggle then KeyPicker.LinkedToggle:SetValue(not KeyPicker.LinkedToggle.Value) else Library:SafeCallback(KeyPicker.Callback, true) end
        end
    end)
    return KeyPicker
end

function Controls.Button(parent, Info)
    local Holder = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(Info.Width or 200, ROW_HEIGHT), Parent = parent })
    local BtnOuter = Library:Create("Frame", { BackgroundColor3 = Colors.Black, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, -4), Position = UDim2.new(0, 0, 0, 2), Parent = Holder })
    local BtnInner = Library:Create("TextButton", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Font = Library.Font, TextSize = 13, TextColor3 = Colors.Text, Text = Info.Text or "Button", Parent = BtnOuter })
    addStroke(BtnInner, Colors.InnerBorder, 1)
    ConnectEvent(BtnInner.MouseButton1Click, function() Library:SafeCallback(Info.Callback) end)
    return BtnInner
end

ScreenGui = create("ScreenGui", { Name = "StealthMenu", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Global, IgnoreGuiInset = true, Parent = TargetGuiParent })
ProtectGui(ScreenGui)

local Outer = create("Frame", { Size = WINDOW_SIZE, AnchorPoint = Vector2_new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), BackgroundColor3 = Colors.Background, BorderSizePixel = 0, Active = true, Parent = ScreenGui })
addStroke(Outer, Colors.OuterBorder, 1)

local Inner = create("Frame", { Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), BackgroundColor3 = Colors.Background, BorderSizePixel = 0, Parent = Outer })
addStroke(Inner, Colors.InnerBorder, 1)

local Header = create("Frame", { Size = UDim2.new(1, 0, 0, 56), BackgroundTransparency = 1, Parent = Inner })
create("TextLabel", { Position = UDim2.fromOffset(0, 8), Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = "Stealth.xyz", TextColor3 = Colors.Text, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Center, Parent = Header })
create("TextLabel", { Position = UDim2.fromOffset(0, 28), Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = "build : beta", TextColor3 = Colors.TextDim, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Center, Parent = Header })

local TabBar = create("Frame", { Position = UDim2.fromOffset(PADDING, 58), Size = UDim2.new(1, -PADDING * 2, 0, 22), BackgroundTransparency = 1, Parent = Inner })
create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 25), Parent = TabBar })
create("Frame", { Position = UDim2.fromOffset(0, 84), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Colors.DividerLine, BorderSizePixel = 0, Parent = Inner })

local Panel = create("Frame", { Position = UDim2.fromOffset(PADDING, 92), Size = UDim2.new(1, -PADDING * 2, 1, -92 - PADDING), BackgroundColor3 = Colors.Panel, BorderSizePixel = 0, ClipsDescendants = true, Parent = Inner })
addStroke(Panel, Colors.InnerBorder, 1)

local SubTabBar = create("Frame", { Size = UDim2.new(1, 0, 0, SUBTAB_BAR_HEIGHT), BackgroundTransparency = 1, Parent = Panel })
create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 40), Parent = SubTabBar })
create("Frame", { Position = UDim2.fromOffset(0, SUBTAB_BAR_HEIGHT), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Colors.DividerLine, BorderSizePixel = 0, Parent = Panel })

local GroupArea = create("Frame", { Position = UDim2.fromOffset(0, SUBTAB_BAR_HEIGHT + 1), Size = UDim2.new(1, 0, 1, -(SUBTAB_BAR_HEIGHT + 1)), BackgroundTransparency = 1, Parent = Panel })
create("Frame", { Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.new(0, 1, 1, 0), BackgroundColor3 = Colors.DividerLine, BorderSizePixel = 0, Parent = GroupArea })

local function makeGroup(side, title)
    local group = create("Frame", { Size = UDim2.new(0.5, 0, 1, 0), Position = (side == "left") and UDim2.fromOffset(0, 0) or UDim2.new(0.5, 0, 0, 0), BackgroundTransparency = 1, Visible = false, Parent = GroupArea })
    create("TextLabel", { Position = UDim2.fromOffset(0, 10), Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = title, TextColor3 = Colors.TextGroup, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Center, Parent = group })
    create("Frame", { Position = UDim2.fromOffset(0, GROUP_HEADER_H), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Colors.DividerLine, BorderSizePixel = 0, Parent = group })
    local Content = create("ScrollingFrame", { Position = UDim2.fromOffset(0, GROUP_HEADER_H + 1), Size = UDim2.new(1, 0, 1, -(GROUP_HEADER_H + 1)), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 3, ScrollBarImageColor3 = Colors.Accent, Parent = group })
    local Layout = create("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Left, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6), Parent = Content })
    create("UIPadding", { PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = Content })
    ConnectEvent(Layout:GetPropertyChangedSignal("AbsoluteContentSize"), function() Content.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 16) end)
    return group, Content
end

local subTabGroups, subTabButtons = {}, {}
local function showSubTab(tabName, subName)
    for _, tabDict in pairs(subTabGroups) do for _, grps in pairs(tabDict) do grps.left.Visible = false; grps.right.Visible = false end end
    if subTabGroups[tabName] and subTabGroups[tabName][subName] then subTabGroups[tabName][subName].left.Visible = true; subTabGroups[tabName][subName].right.Visible = true end
    for tName, btnDict in pairs(subTabButtons) do for sName, btn in pairs(btnDict) do btn.TextColor3 = (tName == tabName and sName == subName) and Colors.Accent or Colors.TextDim end end
end

local function showTab(tabName)
    for _, c in ipairs(TabBar:GetChildren()) do if c:IsA("TextLabel") then c.TextColor3 = (c.Name == "Tab_" .. tabName) and Colors.Accent or Colors.TextDim end end
    for tName, s in pairs(subTabButtons) do for _, btn in pairs(s) do btn.Visible = (tName == tabName) end end
    local firstSubTab
    for _, tab in ipairs(TABS) do if tab.name == tabName then firstSubTab = tab.subtabs[1].name; break end end
    if firstSubTab then showSubTab(tabName, firstSubTab) end
end

for i, tab in ipairs(TABS) do
    local tabLabel = create("TextLabel", { Name = "Tab_" .. tab.name, Size = UDim2.fromOffset(80, 20), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = tab.name, TextColor3 = Colors.TextDim, TextSize = 14, Parent = TabBar, LayoutOrder = i })
    ConnectEvent(tabLabel.InputBegan, function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then showTab(tab.name) end end)
    subTabButtons[tab.name] = {}; subTabGroups[tab.name] = {}
    for j, sub in ipairs(tab.subtabs) do
        local btn = create("TextLabel", { Size = UDim2.fromOffset(80, 20), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = sub.name, TextColor3 = Colors.TextDim, TextSize = 14, Visible = false, LayoutOrder = j, Parent = SubTabBar })
        subTabButtons[tab.name][sub.name] = btn
        ConnectEvent(btn.InputBegan, function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then showSubTab(tab.name, sub.name) end end)
        local lGrp, lContent = makeGroup("left", sub.left)
        local rGrp, rContent = makeGroup("right", sub.right)
        subTabGroups[tab.name][sub.name] = { left = lGrp, right = rGrp, leftContent = lContent, rightContent = rContent }
    end
end

local targetSoundNames = { ["Hit"] = true, ["HeadshotHit"] = true, ["Headshot"] = true }
local originalSoundIds = {}

local function applyHitSoundToObj(snd)
    if not snd:IsA("Sound") or not targetSoundNames[snd.Name] then return end
    if not originalSoundIds[snd] then originalSoundIds[snd] = snd.SoundId end
    if Settings.Visuals_HitSound and Settings.Visuals_HitSoundVal ~= "" then
        snd.SoundId = hitSoundList[Settings.Visuals_HitSoundVal] or originalSoundIds[snd]
    else
        snd.SoundId = originalSoundIds[snd]
    end
end

local function updateHitSounds()
    pcall(function()
        for _, obj in ipairs(SoundService:GetDescendants()) do applyHitSoundToObj(obj) end
    end)
end
ConnectEvent(SoundService.DescendantAdded, function(child) pcall(function() applyHitSoundToObj(child) end) end)

local function applyPassiveHealConfig()
    pcall(function()
        local toolSystem = ReplicatedStorage:WaitForChild("ToolSystem", 2)
        if not toolSystem then return end
        for _, desc in ipairs(toolSystem:GetDescendants()) do
            if desc:IsA("ModuleScript") then
                local success, cfg = pcall(require, desc)
                if success and type(cfg) == "table" and Settings.AutoHeal then
                    if cfg.UseTime ~= nil then cfg.UseTime = 0 end
                    if cfg.HealTime ~= nil then cfg.HealTime = 0 end
                    if cfg.Duration ~= nil then cfg.Duration = 0 end
                    if cfg.Cooldown ~= nil then cfg.Cooldown = 0 end
                end
            end
        end
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        if Unloaded then break end
        if Settings.AutoHeal then
            pcall(function()
                local character = LocalPlayer.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                
                if not humanoid or humanoid.Health <= 0 or humanoid.Health >= humanoid.MaxHealth then
                    return
                end

                local toolSystem = ReplicatedStorage:FindFirstChild("ToolSystem")
                local remote = toolSystem and toolSystem:FindFirstChild("RemoteEvents") and toolSystem.RemoteEvents:FindFirstChild("Use")
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                local hotbar = playerGui and playerGui:FindFirstChild("Inventory") and playerGui.Inventory:FindFirstChild("Hotbar")

                if remote and hotbar then
                    local selectedSlot = hotbar:FindFirstChild("SelectedSlot") and hotbar.SelectedSlot.Value
                    if selectedSlot then
                        local itemName = selectedSlot:FindFirstChild("ItemName")
                        if itemName and (itemName.Value == "Bandage" or itemName.Value == "Medical Syringe") then
                            remote:FireServer(selectedSlot)
                            return
                        end
                    end
                    for _, slot in ipairs(hotbar:GetChildren()) do
                        local itemName = slot:FindFirstChild("ItemName")
                        if itemName and (itemName.Value == "Bandage" or itemName.Value == "Medical Syringe") then
                            remote:FireServer(slot)
                            break
                        end
                    end
                end
            end)
        end
    end
end)

local ToolBaseTimes = {
    ["Rock"] = {0.34, 0.5, 0.6},
    ["Stone Hatchet"] = {0.28, 0.5, 0.25},
    ["Metal Hatchet"] = {0.28, 0.5, 0.25},
    ["Stone Pickaxe"] = {0.29, 0.47, 0.25},
    ["Metal Pickaxe"] = {0.29, 0.47, 0.25},
    ["Wooden Spear"] = {0.2, 0.57, 0.25},
}

local function updateFastTools(enabled)
    if not ItemData or not ItemData.Items then return end
    local MULT = 20
    for n, base in pairs(ToolBaseTimes) do
        local it = ItemData.Items[n]
        if it and it.ToolInfo then
            if enabled then
                it.ToolInfo.HitTime = math.max(0.01, base[1] / MULT)
                it.ToolInfo.PlayTime = math.max(0.05, base[2] / MULT)
                it.ToolInfo.WaitTime = math.max(0.01, base[3] / MULT)
            else
                it.ToolInfo.HitTime = base[1]
                it.ToolInfo.PlayTime = base[2]
                it.ToolInfo.WaitTime = base[3]
            end
        end
    end
end

local safeWeaponWords = {"handguard", "handle", "firearm", "armature", "bolt", "mag", "stock", "barrel", "body", "gun", "receiver", "slide", "trigger", "iron"}
local bodyWords = {"arm", "hand", "glove", "sleeve", "wrist", "finger", "thumb", "humanoidrootpart", "torso", "leg", "foot", "head"}

local function IsBodyPart(name)
    name = name:lower()
    for _, safeWord in ipairs(safeWeaponWords) do if name:find(safeWord) then return false end end
    for _, bodyWord in ipairs(bodyWords) do if name:find(bodyWord) then return true end end
    return false
end

local function NukeTextures(part)
    if not part:IsA("BasePart") or IsBodyPart(part.Name) then return end
    part.Material = Enum.Material.Neon
    part.Color = Settings.Visuals_WeaponChamsColor
    
    if part:IsA("UnionOperation") and not part.UsePartColor then
        part.UsePartColor = true
    elseif part:IsA("MeshPart") and part.TextureID ~= "" then
        part.TextureID = ""
    end
    
    for _, child in ipairs(part:GetChildren()) do
        if child:IsA("SurfaceAppearance") or child:IsA("Decal") or child:IsA("Texture") then
            child:Destroy()
        elseif child:IsA("SpecialMesh") then
            if child.TextureId ~= "" then child.TextureId = "" end
            child.VertexColor = Vector3_new(1, 1, 1)
        end
    end
end

local function ApplyWeaponChamsToModel(model)
    if not model then return end
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then NukeTextures(part) end
    end
end

local function SweepAllChams()
    if not Settings.Visuals_WeaponChams then return end
    if LocalPlayer.Character then
        for _, child in ipairs(LocalPlayer.Character:GetChildren()) do
            if child:IsA("Tool") or (child:IsA("Model") and child:FindFirstChild("GunComponents")) then
                ApplyWeaponChamsToModel(child)
            end
        end
    end
    if Camera then
        for _, child in ipairs(Camera:GetChildren()) do
            if child:IsA("Model") then ApplyWeaponChamsToModel(child) end
        end
    end
end

local function hookBowValue(valObj)
    if valObj.Name == "ReadyToShoot" and valObj:IsA("BoolValue") then
        if Settings.Gun_InstantBow then valObj.Value = true end
        ConnectEvent(valObj:GetPropertyChangedSignal("Value"), function()
            if Settings.Gun_InstantBow and not valObj.Value then
                valObj.Value = true
            end
        end)
    end
end

local function hookBowInContainer(container)
    if not container then return end
    for _, desc in ipairs(container:GetDescendants()) do hookBowValue(desc) end
    ConnectEvent(container.DescendantAdded, function(desc)
        hookBowValue(desc)
        if Settings.Visuals_WeaponChams and desc:IsA("BasePart") then
            task.defer(function() NukeTextures(desc) end)
        end
    end)
end

if LocalPlayer.Character then hookBowInContainer(LocalPlayer.Character) end
hookBowInContainer(Camera)

ConnectEvent(LocalPlayer.CharacterAdded, function(char)
    hookBowInContainer(char)
    task.wait(0.5)
    if Settings.Misc_SilentWalk and crouchRemote then
        crouchRemote:FireServer(true)
    end
end)

do
    local L = subTabGroups["Combat"]["Main"].leftContent
    Controls.Toggle(L, { Text = "General", Callback = function(v) Settings.SA_General = v end })
    Controls.Toggle(L, { Text = "Predict [beta]", Callback = function(v) Settings.SA_Predict = v end })
    
    local rFov = Controls.Row(L)
    Controls.Toggle(rFov, { Text = "Show fov", Width = 140, Callback = function(v) Settings.SA_ShowFov = v end })
    Controls.ColorPicker(rFov, { Default = Color3_new(1,1,1), Callback = function(c) Settings.SA_FovColor = c end })
    
    local r1 = Controls.Row(L)
    Controls.Toggle(r1, { Text = "TargetLine", Width = 140, Callback = function(v) Settings.SA_TargetLine = v end })
    Controls.ColorPicker(r1, { Callback = function(c) Settings.SA_TargetLineColor = c end })
    
    Controls.Dropdown(L, { Values = {"Head", "HumanoidRootPart"}, Default = "Head", Width = 200, Callback = function(v) Settings.SA_TargetPart = v end })
    Controls.Slider(L, { Text = "Fov radius", Min = 100, Max = 800, Default = 150, Callback = function(v) Settings.SA_FovRadius = v end })

    local R = subTabGroups["Combat"]["Main"].rightContent
    local r2 = Controls.Row(R)
    local tgAuto = Controls.Toggle(r2, { Text = "AutoShot", Width = 110, Callback = function(v) Settings.SA_AutoShot = v end })
    Controls.KeyPicker(r2, { Default = "None", LinkedToggle = tgAuto })
    
    Controls.Toggle(R, { Text = "ShowText", Callback = function(v) Settings.SA_ShowText = v end })
    Controls.Toggle(R, { Text = "Show Target nickname", Callback = function(v) Settings.SA_ShowNickname = v end })
    Controls.Toggle(R, { Text = "Expand HeadHitbox", Callback = function(v) Settings.HB_ExpandHead = v; if RefreshHitboxes then RefreshHitboxes() end end })
    Controls.Toggle(R, { Text = "AutoHeal", Callback = function(v) Settings.AutoHeal = v; applyPassiveHealConfig() end })
    
    Controls.Toggle(R, { Text = "Target Inventory", Callback = function(v) 
        Settings.Misc_TargetInventory = v 
        if TargetInvGui then TargetInvGui.Enabled = v end
    end })
end

do
    local L = subTabGroups["Combat"]["Guns"].leftContent
    Controls.Toggle(L, { Text = "No recoil", Callback = function(v) Settings.Gun_NoRecoil = v end })
    Controls.Toggle(L, { Text = "No spread", Callback = function(v) Settings.Gun_NoSpread = v end })
    Controls.Toggle(L, { Text = "No bullet drops", Callback = function(v) Settings.Gun_NoDrop = v end })
    Controls.Toggle(L, { Text = "No Bob", Callback = function(v)
        Settings.Gun_NoBob = v
        if v then
            HookSprings()
            for _, obj in pairs(getgc(true)) do
                if type(obj) == "table" and ((rawget(obj, "p") and rawget(obj, "v")) or (rawget(obj, "Position") and rawget(obj, "Velocity"))) then
                    if rawget(obj, "p") then rawset(obj, "p", Vector3_new()) end
                    if rawget(obj, "v") then rawset(obj, "v", Vector3_new()) end
                    if rawget(obj, "target") then rawset(obj, "target", Vector3_new()) end
                end
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.CameraOffset = Vector3_new()
            end
        end
    end })
    Controls.Toggle(L, { Text = "No Shot SFX", Callback = function(v)
        Settings.Gun_NoShotSfx = v
        if v then
            for _, s in ipairs(game:GetDescendants()) do SilenceSound(s) end
        else
            RestoreSFX()
        end
    end })
    Controls.Toggle(L, { Text = "No Shot VFX", Callback = function(v)
        Settings.Gun_NoShotVFX = v
        if v then
            for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do HandleVFX(obj) end
            for _, obj in ipairs(Camera:GetDescendants()) do HandleVFX(obj) end
            for _, obj in ipairs(workspace.Terrain:GetDescendants()) do HandleVFX(obj) end
        else
            RestoreVFX()
        end
    end })
    Controls.Toggle(L, { Text = "Instant Bow", Callback = function(v) 
        Settings.Gun_InstantBow = v 
        if v then
            if LocalPlayer.Character then
                for _, obj in pairs(LocalPlayer.Character:GetDescendants()) do hookBowValue(obj) end
            end
            if Camera then
                for _, obj in pairs(Camera:GetDescendants()) do hookBowValue(obj) end
            end
        end
    end })
end

do
    local L = subTabGroups["Visuals"]["ESP"].leftContent
    Controls.Toggle(L, { Text = "General", Callback = function(v) Settings.ESP_Enabled = v end })
    
    local r1 = Controls.Row(L)
    Controls.Toggle(r1, { Text = "Box", Width = 140, Callback = function(v) Settings.ESP_Box = v end })
    Controls.ColorPicker(r1, { Callback = function(c) Settings.ESP_BoxColor = c end }) 
    
    local r2 = Controls.Row(L)
    Controls.Toggle(r2, { Text = "Nickname", Width = 140, Callback = function(v) Settings.ESP_Name = v end })
    Controls.ColorPicker(r2, { Callback = function(c) Settings.ESP_NameColor = c end }) 
    
    local r3 = Controls.Row(L)
    Controls.Toggle(r3, { Text = "Distance", Width = 140, Callback = function(v) Settings.ESP_Distance = v end })
    Controls.ColorPicker(r3, { Callback = function(c) Settings.ESP_DistanceColor = c end }) 
    
    Controls.Toggle(L, { Text = "Health bar", Callback = function(v) Settings.ESP_Health = v end })
    Controls.Slider(L, { Text = "MaxDistance", Min = 0, Max = 2000, Default = 2000, Callback = function(v) Settings.ESP_MaxDistance = v end })

    local R_ESP = subTabGroups["Visuals"]["ESP"].rightContent
    local rWChams = Controls.Row(R_ESP)
    Controls.Toggle(rWChams, { Text = "Weapon chams", Width = 140, Callback = function(v) 
        Settings.Visuals_WeaponChams = v 
        if v then SweepAllChams() end
    end })
    Controls.ColorPicker(rWChams, { Default = Color3_new(1, 1, 1), Callback = function(c) 
        Settings.Visuals_WeaponChamsColor = c 
        if Settings.Visuals_WeaponChams then SweepAllChams() end
    end })

    local rTracers = Controls.Row(R_ESP)
    Controls.Toggle(rTracers, { Text = "Bullet tracer", Width = 140, Callback = function(v) Settings.Visuals_Tracers = v end })
    Controls.ColorPicker(rTracers, { Default = Color3_new(1, 1, 1), Callback = function(c) Settings.Visuals_TracersColor = c end })

    Controls.Toggle(R_ESP, { Text = "Hit Sound", Callback = function(v) Settings.Visuals_HitSound = v; updateHitSounds() end })
    Controls.Dropdown(R_ESP, { Values = hitSoundNames, Default = "Neverlose", Width = 200, Callback = function(v) Settings.Visuals_HitSoundVal = v; updateHitSounds() end })

    Controls.Toggle(R_ESP, { Text = "ViewModel", Callback = function(v) Settings.VM_Enabled = v end })
    Controls.Slider(R_ESP, { Text = "Offset X", Min = -2, Max = 2, Default = 0, Rounding = 2, Callback = function(v) Settings.VM_X = v end })
    Controls.Slider(R_ESP, { Text = "Offset Y", Min = -2, Max = 2, Default = -0.15, Rounding = 2, Callback = function(v) Settings.VM_Y = v end })
    Controls.Slider(R_ESP, { Text = "Offset Z", Min = -4, Max = 2, Default = -0.6, Rounding = 2, Callback = function(v) Settings.VM_Z = v end })
end

do
    local L = subTabGroups["Visuals"]["World"].leftContent
    
    local function updateSkybox()
        if Settings.World_Skybox then applySkybox(Settings.World_SkyboxVal) else applySkybox("default") end
    end

    local function updateFog()
        if Settings.World_NoFog then
            Lighting.FogEnd = 9e9
            Lighting.FogStart = 9e9
            local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
            if atmosphere then atmosphere.Density = 0; atmosphere.Offset = 0 end
        else
            Lighting.FogEnd = OriginalFogEnd
            Lighting.FogStart = OriginalFogStart
            local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
            if atmosphere then atmosphere.Density = OriginalAtmosphereDensity; atmosphere.Offset = OriginalAtmosphereOffset end
        end
    end

    local function updateShadows()
        Lighting.GlobalShadows = not Settings.World_NoShadows
    end

    Controls.Toggle(L, { Text = "Skybox", Callback = function(v) 
        Settings.World_Skybox = v 
        updateSkybox()
    end })
    
    Controls.Toggle(L, { Text = "Time Changer", Callback = function(v) 
        Settings.World_TimeChanger = v 
        if not v then Lighting.ClockTime = OriginalClockTime end
    end })
    
    local function updateClouds()
        local clouds = workspace:FindFirstChildOfClass("Clouds") or (workspace:FindFirstChildOfClass("Terrain") and workspace.Terrain:FindFirstChildOfClass("Clouds"))
        if clouds then clouds.Enabled = not Settings.World_NoClouds end
    end
    Controls.Toggle(L, { Text = "No Clouds", Callback = function(v) 
        Settings.World_NoClouds = v 
        updateClouds()
    end })
    
    Controls.Toggle(L, { Text = "No Grass", Callback = function(v) 
        Settings.World_NoGrass = v 
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain and sethiddenproperty then
            pcall(function() sethiddenproperty(terrain, "Decoration", not v) end)
        end
    end })

    Controls.Toggle(L, { Text = "No Fog", Callback = function(v) 
        Settings.World_NoFog = v 
        updateFog()
    end })

    Controls.Toggle(L, { Text = "No Shadows", Callback = function(v) 
        Settings.World_NoShadows = v 
        updateShadows()
    end })

    create("Frame", { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Colors.DividerLine, BorderSizePixel = 0, Parent = L })
    
    local function AddItemESPUI(name, labelText, settingKey, colorKey)
        local row = Controls.Row(L)
        Controls.Toggle(row, { Text = labelText, Width = 140, Callback = function(v) Settings[settingKey] = v end })
        Controls.ColorPicker(row, { Default = Color3_new(1, 1, 1), Callback = function(c) Settings[colorKey] = c end })
    end

    AddItemESPUI("Hemp", "Hemp ESP", "World_ESP_Hemp", "World_ESP_HempColor")
    AddItemESPUI("Stone", "Stone ESP", "World_ESP_Stone", "World_ESP_StoneColor")
    AddItemESPUI("MetalOre", "Metal Ore ESP", "World_ESP_MetalOre", "World_ESP_MetalOreColor")
    AddItemESPUI("SulfurOre", "Sulfur Ore ESP", "World_ESP_SulfurOre", "World_ESP_SulfurOreColor")
    AddItemESPUI("JunkPile", "JunkPile ESP", "World_ESP_JunkPile", "World_ESP_JunkPileColor")
    AddItemESPUI("MushRoom", "Mushroom ESP", "World_ESP_MushRoom", "World_ESP_MushRoomColor")
    
    local R = subTabGroups["Visuals"]["World"].rightContent
    
    Controls.Dropdown(R, { Values = SkyboxNames, Default = "default", Width = 200, Callback = function(v)
        Settings.World_SkyboxVal = v
        if Settings.World_Skybox then updateSkybox() end
    end })
    
    Controls.Slider(R, { Text = "Time Value", Min = 0, Max = 24, Default = 12, Rounding = 1, Callback = function(v) Settings.World_TimeValue = v end })
    
    Controls.Slider(R, { Text = "WorldDistance", Min = 0, Max = 250, Default = 250, Rounding = 0, Callback = function(v) Settings.World_Distance = v end })
end

do
    local L_Misc1 = subTabGroups["Misc"]["Misc 1"].leftContent
    Controls.Toggle(L_Misc1, { Text = "Omni sprint", Callback = function(v) Settings.Misc_OmniSprint = v end })
    Controls.Toggle(L_Misc1, { Text = "Speedhack", Callback = function(v) Settings.Misc_Speedhack = v end })
    
    local rSilentWalk = Controls.Row(L_Misc1)
    local tSilentWalk = Controls.Toggle(rSilentWalk, { Text = "Silent Walk", Width = 140, Callback = function(v) 
        Settings.Misc_SilentWalk = v
        if crouchRemote then pcall(function() crouchRemote:FireServer(v) end) end
    end })
    Controls.KeyPicker(rSilentWalk, { Default = "None", LinkedToggle = tSilentWalk })

    local R_Misc1 = subTabGroups["Misc"]["Misc 1"].rightContent
    local rCam = Controls.Row(R_Misc1)
    local tCam = Controls.Toggle(rCam, { Text = "Zoom", Width = 140, Callback = function(v) Settings.Camera_Zoom = v end })
    Controls.KeyPicker(rCam, { Default = "None", LinkedToggle = tCam })
end

do
    local L_Misc2 = subTabGroups["Misc"]["Misc 2"].leftContent

    local R_Misc2 = subTabGroups["Misc"]["Misc 2"].rightContent
    
    Controls.Toggle(R_Misc2, { Text = "Fast tools", Callback = function(v) 
        Settings.Misc_FastTools = v 
        updateFastTools(v)
    end })
    
    Controls.Button(R_Misc2, { Text = "Kill all scientists", Width = 200, Callback = function()
        for _, junkpile in ipairs(workspace:WaitForChild("Junkpiles"):GetChildren()) do
            local scientist = junkpile:FindFirstChild("JunkPile") and junkpile.JunkPile:FindFirstChild("Scientist")
            if scientist then
                local humanoid = scientist:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.Health = 0 end
            end
        end
    end })
end

local IsShooting = false
local ESPObjects = {}
local FOVCircle = Drawing.new("Circle")
local TargetLine = Drawing.new("Line")

local SAInfoGui = create("ScreenGui", { Name = "StealthSAInfo", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Global, IgnoreGuiInset = true, Parent = TargetGuiParent })
ProtectGui(SAInfoGui)

local WatermarkGui = create("ScreenGui", { Name = "StealthWatermark", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Global, IgnoreGuiInset = true, Parent = TargetGuiParent })
ProtectGui(WatermarkGui)

local MenuKeyPicker
do
    local L = subTabGroups["Settings"]["Config"].leftContent
    local rMenu = Controls.Row(L)
    Library:CreateLabel({ Size = UDim2.new(0, 140, 1, 0), Text = "Menu Toggle Key", TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = rMenu })
    MenuKeyPicker = Controls.KeyPicker(rMenu, { Default = "Delete", Callback = function(val) end })

    local R = subTabGroups["Settings"]["Config"].rightContent
    Controls.Button(R, { Text = "Unload Cheat", Width = 200, Callback = function()
        Unloaded = true
        
        pcall(function()
            if Camera then Camera.FieldOfView = 70 end
            
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = 16
                hum.CameraOffset = Vector3_new(0, 0, 0)
            end
            
            if crouchRemote then
                crouchRemote:FireServer(false)
            end
        end)
        
        if IsShooting then
            IsShooting = false
            if mouse1release then mouse1release() else VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0) end
        end
        
        Settings.Gun_NoShotSfx = false; RestoreSFX()
        Settings.Gun_NoShotVFX = false; RestoreVFX()
        Settings.World_TimeChanger = false; Lighting.ClockTime = OriginalClockTime
        Settings.World_Skybox = false; applySkybox("default")
        Settings.World_NoFog = false; Lighting.FogEnd = OriginalFogEnd; Lighting.FogStart = OriginalFogStart
        Settings.World_NoShadows = false; Lighting.GlobalShadows = OriginalGlobalShadows
        Settings.HB_ExpandHead = false; if RefreshHitboxes then RefreshHitboxes() end
        Settings.Misc_FastTools = false; updateFastTools(false)
        
        for _, conn in ipairs(RuntimeConnections) do
            if conn.Disconnect then pcall(function() conn:Disconnect() end) end
        end
        table.clear(RuntimeConnections)
        
        pcall(function() FOVCircle:Remove() end)
        pcall(function() TargetLine:Remove() end)
        
        for _, esp in pairs(ESPObjects) do
            pcall(function() esp:Destroy() end)
        end
        table.clear(ESPObjects)
        
        for _, data in ipairs(ItemDrawings) do
            pcall(function() data.drawing:Remove() end)
        end
        table.clear(ItemDrawings)
        
        if ScreenGui then ScreenGui:Destroy() end
        if WatermarkGui then WatermarkGui:Destroy() end
        if SAInfoGui then SAInfoGui:Destroy() end
        if TargetInvGui then TargetInvGui:Destroy() end
    end })
end

task.spawn(function()
    while true do
        task.wait(1)
        if Unloaded then break end
        if Settings.Misc_SilentWalk and crouchRemote then pcall(function() crouchRemote:FireServer(true) end) end
    end
end)

showTab("Combat")

local function getItemPos(obj)
    if obj:IsA("BasePart") then return obj.Position end
    if obj:IsA("Model") then
        local cf = obj:GetBoundingBox()
        return cf.Position
    end
    return nil
end

local function registerItemESP(obj, typeName, labelText)
    local success, d = pcall(function()
        local draw = Drawing.new("Text")
        draw.Text = labelText
        draw.Size = 14
        draw.Center = true
        draw.Outline = true
        draw.Visible = false
        return draw
    end)
    if success and d then
        table_insert(ItemDrawings, { drawing = d, obj = obj, type = typeName })
    end
end

local function checkAndRegisterItem(desc)
    local name = desc.Name:lower()
    if name == "cloth" then registerItemESP(desc, "Hemp", "[Hemp]")
    elseif name == "stone" then registerItemESP(desc, "Stone", "[Stone]")
    elseif name == "metal ore" then registerItemESP(desc, "MetalOre", "[Metal Ore]")
    elseif name == "sulfur ore" then registerItemESP(desc, "SulfurOre", "[Sulfur Ore]")
    elseif name == "junkpile" then registerItemESP(desc, "JunkPile", "[JunkPile]")
    elseif name == "mushrooms" then registerItemESP(desc, "MushRoom", "[Mushroom]")
    end
end

task.spawn(function()
    local function scanFolder(folder)
        if not folder then return end
        for _, desc in ipairs(folder:GetDescendants()) do checkAndRegisterItem(desc) end
        ConnectEvent(folder.DescendantAdded, checkAndRegisterItem)
    end

    pcall(function()
        local treeSpawns = workspace:WaitForChild("TreeSpawns", 10)
        if treeSpawns then scanFolder(treeSpawns:WaitForChild("Grass", 5)) end
    end)
    pcall(function()
        local oreSpawns = workspace:WaitForChild("OreSpawns", 10)
        if oreSpawns then scanFolder(oreSpawns:WaitForChild("Grass", 5)) end
    end)
    pcall(function()
        local junkpiles = workspace:WaitForChild("Junkpiles", 10)
        if junkpiles then scanFolder(junkpiles) end
    end)
end)

local function IsTeammate(player)
    if player == LocalPlayer then return true end
    if player.Team ~= nil and player.Team == LocalPlayer.Team then return true end
    local character = player.Character
    if character and character:FindFirstChild("Head") then
        local gui = character.Head:FindFirstChild("TeammateGui")
        if gui and gui:IsA("BillboardGui") then return true end
    end
    return false
end

local function makeSALabel(size)
    return create("TextLabel", {
        Parent = SAInfoGui,
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(400, size),
        AnchorPoint = Vector2_new(0.5, 0),
        Font = Enum.Font.Code,
        TextSize = size,
        TextStrokeTransparency = 0.35,
        TextStrokeColor3 = Color3_new(0, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Center,
        Visible = false
    })
end

local SATitle = makeSALabel(20)
SATitle.RichText = true
SATitle.Text = '<font color="#ffffff">Stealth</font><font color="#c724b1">.xyz</font>'

local SATarget = makeSALabel(18)
SATarget.TextColor3 = Color3_new(1, 1, 1)

FOVCircle.Visible = false
FOVCircle.Thickness = 1
FOVCircle.Filled = false
FOVCircle.Transparency = 1

TargetLine.Visible = false
TargetLine.Thickness = 1
TargetLine.Transparency = 1

local CurrentTarget = nil

local function GetClosestTarget()
    if not Settings.SA_General and not Settings.SA_AutoShot then return nil end

    local mousePos = GetMouseLocation(UserInputService)
    local mouseX, mouseY = mousePos.X, mousePos.Y
    local radius = Settings.SA_FovRadius
    local closestDistSq = radius * radius
    local target = nil

    local playersList = Players:GetPlayers()
    for i = 1, #playersList do
        local plr = playersList[i]
        if plr ~= LocalPlayer and not IsTeammate(plr) then
            local character = plr.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local part = character:FindFirstChild(Settings.SA_TargetPart)
                
                if humanoid and humanoid.Health > 0 and part then
                    local screenPos, onScreen = WorldToViewportPoint(Camera, part.Position)
                    if onScreen then
                        local dx = screenPos.X - mouseX
                        local dy = screenPos.Y - mouseY
                        local distSq = dx * dx + dy * dy
                        
                        if distSq < closestDistSq then
                            closestDistSq = distSq
                            target = character
                        end
                    end
                end
            end
        end
    end
    return target
end

local function createESPInstance(player)
    local esp = {
        Player = player,
        BoxOutline = Drawing.new("Square"),
        Box = Drawing.new("Square"),
        HealthBg = Drawing.new("Square"),
        HealthFill = Drawing.new("Square"),
        NameText = Drawing.new("Text"),
        DistText = Drawing.new("Text")
    }

    esp.BoxOutline.Thickness = 3
    esp.BoxOutline.Filled = false
    esp.BoxOutline.Color = Color3_new(0, 0, 0)
    esp.Box.Thickness = 1
    esp.Box.Filled = false
    esp.HealthBg.Thickness = 1
    esp.HealthBg.Filled = true
    esp.HealthBg.Color = Color3_new(0, 0, 0)
    esp.HealthFill.Thickness = 1
    esp.HealthFill.Filled = true
    esp.NameText.Size = 14
    esp.NameText.Center = true
    esp.NameText.Outline = true
    esp.NameText.OutlineColor = Color3_new(0, 0, 0)
    esp.DistText.Size = 12
    esp.DistText.Center = true
    esp.DistText.Outline = true
    esp.DistText.OutlineColor = Color3_new(0, 0, 0)

    function esp:SetVisible(state)
        self.BoxOutline.Visible = state
        self.Box.Visible = state
        self.HealthBg.Visible = state
        self.HealthFill.Visible = state
        self.NameText.Visible = state
        self.DistText.Visible = state
    end

    function esp:Destroy()
        self.BoxOutline:Remove()
        self.Box:Remove()
        self.HealthBg:Remove()
        self.HealthFill:Remove()
        self.NameText:Remove()
        self.DistText:Remove()
    end

    esp:SetVisible(false)
    ESPObjects[player] = esp
    return esp
end

local function removeESPInstance(player)
    if ESPObjects[player] then
        ESPObjects[player]:Destroy()
        ESPObjects[player] = nil
    end
end

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then createESPInstance(plr) end
end
ConnectEvent(Players.PlayerAdded, createESPInstance)
ConnectEvent(Players.PlayerRemoving, removeESPInstance)

ConnectEvent(RunService.RenderStepped, function()
    local camPos = Camera.CFrame.Position
    local screenSize = Camera.ViewportSize
    local mousePos = GetMouseLocation(UserInputService)

    for i = #ItemDrawings, 1, -1 do
        local data = ItemDrawings[i]
        local obj = data.obj
        local text = data.drawing
        local typ = data.type

        if obj and obj.Parent then
            if Settings["World_ESP_" .. typ] then
                local pos3d = getItemPos(obj)
                if pos3d then
                    local dist = (camPos - pos3d).Magnitude
                    if dist <= Settings.World_Distance then
                        local screenPos, onScreen = WorldToViewportPoint(Camera, pos3d)
                        if onScreen and screenPos.Z > 0 then
                            text.Position = Vector2_new(screenPos.X, screenPos.Y)
                            text.Color = Settings["World_ESP_" .. typ .. "Color"]
                            text.Visible = true
                        else
                            text.Visible = false
                        end
                    else
                        text.Visible = false
                    end
                else
                    text.Visible = false
                end
            else
                text.Visible = false
            end
        else
            pcall(function() text:Remove() end)
            table.remove(ItemDrawings, i)
        end
    end

    FOVCircle.Visible = Settings.SA_ShowFov
    FOVCircle.Position = mousePos
    FOVCircle.Radius = Settings.SA_FovRadius
    FOVCircle.Color = Settings.SA_FovColor

    CurrentTarget = GetClosestTarget()

    if Settings.SA_AutoShot then
        if CurrentTarget and not IsShooting then
            IsShooting = true
            if mouse1press then mouse1press() else VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0) end
        elseif not CurrentTarget and IsShooting then
            IsShooting = false
            if mouse1release then mouse1release() else VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0) end
        end
    elseif IsShooting then
        IsShooting = false
        if mouse1release then mouse1release() else VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0) end
    end

    if CurrentTarget and Settings.SA_TargetLine then
        local targetPart = CurrentTarget:FindFirstChild(Settings.SA_TargetPart)
        if targetPart then
            local aimPos = targetPart.Position
            if Settings.SA_Predict then
                local rootPart = CurrentTarget:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local velocity = rootPart.AssemblyLinearVelocity
                    local distance = (aimPos - camPos).Magnitude
                    local timeToHit = distance / CurrentBulletSpeed
                    aimPos = aimPos + (velocity * timeToHit)
                end
            end
            
            local screenPos, onScreen = WorldToViewportPoint(Camera, aimPos)
            if onScreen then
                TargetLine.From = mousePos
                TargetLine.To = Vector2_new(screenPos.X, screenPos.Y)
                TargetLine.Color = Settings.SA_TargetLineColor
                TargetLine.Visible = true
            else
                TargetLine.Visible = false
            end
        else
            TargetLine.Visible = false
        end
    else
        TargetLine.Visible = false
    end

    local yPos = (screenSize.Y / 2) + 40
    SATitle.Visible = Settings.SA_ShowText
    if Settings.SA_ShowText then
        SATitle.Position = UDim2.fromOffset(screenSize.X / 2, yPos)
        yPos = yPos + 25
    end

    SATarget.Visible = Settings.SA_ShowNickname and CurrentTarget ~= nil
    if SATarget.Visible then
        local plr = Players:GetPlayerFromCharacter(CurrentTarget)
        SATarget.Position = UDim2.fromOffset(screenSize.X / 2, yPos)
        SATarget.Text = plr and plr.DisplayName or CurrentTarget.Name
    end

    if Settings.World_TimeChanger then Lighting.ClockTime = Settings.World_TimeValue end
    Camera.FieldOfView = Settings.Camera_Zoom and 30 or 70

    if Settings.VM_Enabled then
        for _, child in ipairs(Camera:GetChildren()) do
            if child:IsA("Model") then
                local root = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart") or child:FindFirstChild("CameraBone")
                if root then root.CFrame = root.CFrame * CFrame.new(Settings.VM_X, Settings.VM_Y, Settings.VM_Z) end
            end
        end
    end

    local espEnabled = Settings.ESP_Enabled
    local maxDist = Settings.ESP_MaxDistance

    for player, esp in pairs(ESPObjects) do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")

        if espEnabled and character and hrp and humanoid and humanoid.Health > 0 and not IsTeammate(player) then
            local hrpPos = hrp.Position
            local dist = (camPos - hrpPos).Magnitude

            if dist <= maxDist then
                local rootPos, onScreen = WorldToViewportPoint(Camera, hrpPos)

                if onScreen then
                    local head = character:FindFirstChild("Head")
                    local headPos = head and head.Position or (hrpPos + Vector3_new(0, 1.5, 0))
                    local topPos = WorldToViewportPoint(Camera, headPos + Vector3_new(0, 1.2, 0))
                    local bottomPos = WorldToViewportPoint(Camera, hrpPos - Vector3_new(0, 3, 0))

                    local boxHeight = math.abs(bottomPos.Y - topPos.Y)
                    local boxWidth = boxHeight * 0.6
                    local boxPosX = rootPos.X - (boxWidth / 2)
                    local boxPosY = topPos.Y

                    if Settings.ESP_Box then
                        esp.BoxOutline.Size = Vector2_new(boxWidth, boxHeight)
                        esp.BoxOutline.Position = Vector2_new(boxPosX, boxPosY)
                        esp.BoxOutline.Visible = true

                        esp.Box.Size = Vector2_new(boxWidth, boxHeight)
                        esp.Box.Position = Vector2_new(boxPosX, boxPosY)
                        esp.Box.Color = Settings.ESP_BoxColor
                        esp.Box.Visible = true
                    else
                        esp.BoxOutline.Visible = false
                        esp.Box.Visible = false
                    end

                    if Settings.ESP_Name then
                        esp.NameText.Text = player.DisplayName
                        esp.NameText.Position = Vector2_new(rootPos.X, boxPosY - 16)
                        esp.NameText.Color = Settings.ESP_NameColor
                        esp.NameText.Visible = true
                    else
                        esp.NameText.Visible = false
                    end

                    if Settings.ESP_Distance then
                        esp.DistText.Text = math_floor(dist) .. "m"
                        esp.DistText.Position = Vector2_new(rootPos.X, boxPosY + boxHeight + 2)
                        esp.DistText.Color = Settings.ESP_DistanceColor
                        esp.DistText.Visible = true
                    else
                        esp.DistText.Visible = false
                    end
                    
                    if Settings.ESP_Health then
                        local hpPct = math_clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                        esp.HealthBg.Size = Vector2_new(4, boxHeight + 2)
                        esp.HealthBg.Position = Vector2_new(boxPosX - 6, boxPosY - 1)
                        esp.HealthBg.Visible = true

                        local fillHeight = boxHeight * hpPct
                        esp.HealthFill.Size = Vector2_new(2, fillHeight)
                        esp.HealthFill.Position = Vector2_new(boxPosX - 5, (boxPosY + boxHeight) - fillHeight)
                        esp.HealthFill.Color = Color3_fromRGB(255, 0, 0):Lerp(Color3_fromRGB(0, 255, 0), hpPct)
                        esp.HealthFill.Visible = true
                    else
                        esp.HealthBg.Visible = false
                        esp.HealthFill.Visible = false
                    end
                else
                    esp:SetVisible(false)
                end
            else
                esp:SetVisible(false)
            end
        else
            esp:SetVisible(false)
        end
    end

    if Settings.Gun_NoBob then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.CameraOffset ~= Vector3_new() then
                hum.CameraOffset = Vector3_new()
            end
        end
    end
end)

ConnectEvent(RunService.Heartbeat, function()
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if Settings.Misc_Speedhack then
            humanoid.WalkSpeed = 19
        elseif Settings.Misc_SilentWalk then
            humanoid.WalkSpeed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 16.5 or 12
        end
    end

    if Settings.World_NoFog then
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 9e9
        local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmosphere and atmosphere.Density > 0 then
            atmosphere.Density = 0
            atmosphere.Offset = 0
        end
    end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    if Unloaded then return oldNamecall(self, ...) end
    
    local method = getnamecallmethod()

    if method == "ViewportPointToRay" and self == Camera then
        if Settings.SA_General and CurrentTarget then
            local targetPart = CurrentTarget:FindFirstChild(Settings.SA_TargetPart)
            if targetPart then
                local origin = Camera.CFrame.Position
                local aimPosition = targetPart.Position
                
                if Settings.SA_Predict then
                    local rootPart = CurrentTarget:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        local velocity = rootPart.AssemblyLinearVelocity
                        local distance = (aimPosition - origin).Magnitude
                        local timeToHit = distance / CurrentBulletSpeed
                        aimPosition = aimPosition + (velocity * timeToHit)
                    end
                end
                
                return Ray.new(origin, (aimPosition - origin).Unit)
            end
        end
    end

    if method == "FireServer" and not checkcaller() then
        if Settings.Misc_SilentWalk then
            if (crouchRemote and self == crouchRemote) or (self.Name == "Crouch" and self:IsA("RemoteEvent")) then
                local args = {...}
                args[1] = true 
                return oldNamecall(self, unpack(args))
            end
        end
    end

    return oldNamecall(self, ...)
end)

mt.__index = newcclosure(function(t, k)
    if Unloaded then return oldIndex(t, k) end
    if k == "MoveDirection" and Settings.Misc_OmniSprint and not checkcaller() then
        if typeof(t) == "Instance" and t:IsA("Humanoid") then
            local realDir = oldIndex(t, k)
            if realDir.Magnitude > 0 then
                local hrp = t.Parent and t.Parent:FindFirstChild("HumanoidRootPart")
                if hrp then return hrp.CFrame.LookVector end
            end
        end
    end
    return oldIndex(t, k)
end)

setreadonly(mt, true)

local function resetSinglePart(part)
    if not part then return end
    local orig = OriginalPartSizes[part]
    if orig then
        pcall(function()
            part.Size = orig.Size
            part.CanCollide = orig.CanCollide
            part.Massless = orig.Massless
            part.Transparency = orig.Transparency
            if orig.CollisionGroup then part.CollisionGroup = orig.CollisionGroup end
            if sethiddenproperty then pcall(function() sethiddenproperty(part, "CanQuery", true) end) end
        end)
    else
        if part.Name == "Head" then
            pcall(function()
                part.Size = Vector3_new(1.2, 1.2, 1.2)
                part.CanCollide = true
                part.Transparency = 0
            end)
        end
    end
end

RefreshHitboxes = function()
    local expand = Settings.HB_ExpandHead
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetPart = player.Character:FindFirstChild("Head")
            if targetPart and targetPart:IsA("BasePart") then
                if not expand then
                    resetSinglePart(targetPart)
                else
                    saveOriginalData(targetPart)
                    local desiredSize = Vector3_new(2, 2, 2)
                    if targetPart.Size ~= desiredSize then
                        targetPart.Size = desiredSize
                        targetPart.CanCollide = false
                        targetPart.Massless = true
                        targetPart.Transparency = 1
                        targetPart.CollisionGroup = "Default"
                        if sethiddenproperty then pcall(function() sethiddenproperty(targetPart, "CanQuery", true) end) end
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while task.wait(1.5) do 
        if Unloaded then break end
        if Settings.HB_ExpandHead then RefreshHitboxes() end 
    end
end)

local WMOuter = create("Frame", { AnchorPoint = Vector2_new(1, 0), Position = UDim2.new(1, -10, 0, 10), Size = UDim2.fromOffset(10, 26), BackgroundColor3 = Colors.Background, BorderSizePixel = 0, Parent = WatermarkGui })
addStroke(WMOuter, Colors.OuterBorder, 1)

local WMInner = create("Frame", { Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), BackgroundColor3 = Colors.Background, BorderSizePixel = 0, Parent = WMOuter })
addStroke(WMInner, Colors.InnerBorder, 1)

create("Frame", { Position = UDim2.fromOffset(0, 4), Size = UDim2.new(0, 2, 1, -8), BackgroundColor3 = Colors.Accent, BorderSizePixel = 0, Parent = WMInner })
local WMLabel = create("TextLabel", { Position = UDim2.fromOffset(10, 0), Size = UDim2.new(0, 0, 1, 0), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = "", TextColor3 = Colors.Text, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = WMInner })

local fps, frameCount, lastTime = 0, 0, tick()
task.spawn(function()
    while task.wait(0.5) do
        if Unloaded then break end
        local now = tick()
        fps = math_floor(frameCount / (now - lastTime) + 0.5)
        frameCount = 0
        lastTime = now

        local ping = 0
        pcall(function() ping = math_floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) end)

        WMLabel.Text = "Stealth.xyz | " .. os.date("%H:%M:%S") .. " | " .. fps .. " FPS | " .. ping .. " ms"
        local w = WMLabel.TextBounds.X
        WMOuter.Size = UDim2.fromOffset(w + 26, 26)
        WMLabel.Size = UDim2.new(0, w, 1, 0)
    end
end)
ConnectEvent(RunService.RenderStepped, function() frameCount += 1 end)

local dragToggle, dragStart, startPos
ConnectEvent(Header.InputBegan, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true; dragStart = input.Position; startPos = Outer.Position
        local dragConn
        dragConn = ConnectEvent(input.Changed, function() 
            if input.UserInputState == Enum.UserInputState.End then 
                dragToggle = false
                if dragConn then dragConn:Disconnect() end
            end 
        end)
    end
end)
ConnectEvent(UserInputService.InputChanged, function(input)
    if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Outer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ConnectEvent(UserInputService.InputBegan, function(input, gpe)
    if gpe or Unloaded then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == MenuKeyPicker.Value then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

local latestVelocities = nil

local function DrawLaserTracer(startPos, endPos)
    local distance = (endPos - startPos).Magnitude
    local tracer = Instance.new("Part")
    tracer.Name = "CheatTracer"
    tracer.Anchored = true
    tracer.CanCollide = false
    tracer.CanQuery = false
    tracer.CastShadow = false
    tracer.Material = Enum.Material.Neon
    tracer.Color = Settings.Visuals_TracersColor
    tracer.Size = Vector3_new(0.06, 0.06, distance)
    tracer.CFrame = CFrame.lookAt(startPos, endPos) * CFrame.new(0, 0, -distance / 2)
    tracer.Parent = Camera

    local tween = TweenService:Create(tracer, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1, Size = Vector3_new(0, 0, distance)
    })
    tween:Play()
    Debris:AddItem(tracer, 1.25)
end

task.spawn(function()
    for _, fn in pairs(getgc(false)) do
        if type(fn) == "function" and not isexecutorclosure(fn) then
            local scriptOrigin = debug.info(fn, "s")
            if scriptOrigin and scriptOrigin:find("HotbarScript") then
                local constants = debug.getconstants(fn)
                if table.find(constants, "CameraOffset") and table.find(constants, "Lerp") then
                    local oldFn
                    oldFn = hookfunction(fn, function(...)
                        if Unloaded then return oldFn(...) end
                        if Settings.Gun_NoBob then return end
                        return oldFn(...)
                    end)
                end
            end
        end
    end

    local inv = PlayerGui:WaitForChild("Inventory", 10) if not inv then return end
    local hotbar = inv:WaitForChild("HotbarScript", 10) if not hotbar then return end

    local GunShootModule, GunClient, Ballistics_m, SpringModule
    pcall(function() GunShootModule = require(hotbar:WaitForChild("GunShootModule")) end)
    pcall(function() GunClient = require(hotbar:WaitForChild("GunClient")) end)
    pcall(function() Ballistics_m = require(ReplicatedStorage:WaitForChild("GunSystem"):WaitForChild("Ballistics")) end)
    pcall(function() SpringModule = require(ReplicatedStorage:WaitForChild("GunSystem"):WaitForChild("Modules"):WaitForChild("SpringModule")) end)

    if SpringModule and type(SpringModule) == "table" then
        if SpringModule.shove and type(SpringModule.shove) == "function" then
            local oldShove = SpringModule.shove
            hookfunction(SpringModule.shove, function(self, ...)
                if Unloaded then return oldShove(self, ...) end
                if Settings.Gun_NoBob then
                    if type(self) == "table" then
                        self.p = Vector3_new()
                        self.v = Vector3_new()
                        self.target = Vector3_new()
                    end
                    return
                end
                return oldShove(self, ...)
            end)
        end
        if SpringModule.update and type(SpringModule.update) == "function" then
            local oldUpdate = SpringModule.update
            hookfunction(SpringModule.update, function(self, ...)
                if Unloaded then return oldUpdate(self, ...) end
                if Settings.Gun_NoBob then
                    if type(self) == "table" then
                        self.p = Vector3_new()
                        self.v = Vector3_new()
                        self.target = Vector3_new()
                    end
                    return Vector3_new()
                end
                return oldUpdate(self, ...)
            end)
        end
    end

    if GunShootModule then
        local oldShoot = GunShootModule.Shoot
        GunShootModule.Shoot = function(arg18, arg19)
            if Unloaded then return oldShoot(arg18, arg19) end
            latestVelocities = nil 
            if Settings.Gun_NoRecoil and arg19 then
                local originalShove = arg19.RecoilSpring and arg19.RecoilSpring.shove
                local originalShake = arg19.ShakeCamera
                if arg19.RecoilSpring then arg19.RecoilSpring.shove = function() end end
                arg19.ShakeCamera = function() end
                
                local result = oldShoot(arg18, arg19)
                
                if arg19.RecoilSpring then arg19.RecoilSpring.shove = originalShove end
                arg19.ShakeCamera = originalShake

                if Settings.Visuals_Tracers and latestVelocities and arg19 then
                    task.spawn(function()
                        local barrelPos = Camera.CFrame.Position - Vector3_new(0, 0.5, 0)
                        if arg19.ToolModel then
                            local gunComps = arg19.ToolModel:FindFirstChild("GunComponents")
                            local barrel = gunComps and gunComps:FindFirstChild("Barrel")
                            if barrel then barrelPos = barrel.Position end
                        end
                        local params = RaycastParams.new()
                        params.FilterType = Enum.RaycastFilterType.Exclude
                        params.FilterDescendantsInstances = {LocalPlayer.Character, Camera, workspace:FindFirstChild("Bullets")}
                        for _, vel in ipairs(latestVelocities) do
                            local direction = vel.Unit
                            local hit = workspace:Raycast(barrelPos, direction * 2000, params)
                            DrawLaserTracer(barrelPos, hit and hit.Position or (barrelPos + direction * 2000))
                        end
                    end)
                end
                return result
            end
            
            local result = oldShoot(arg18, arg19)
            if Settings.Visuals_Tracers and latestVelocities and arg19 then
                task.spawn(function()
                    local barrelPos = Camera.CFrame.Position - Vector3_new(0, 0.5, 0)
                    if arg19.ToolModel then
                        local gunComps = arg19.ToolModel:FindFirstChild("GunComponents")
                        local barrel = gunComps and gunComps:FindFirstChild("Barrel")
                        if barrel then barrelPos = barrel.Position end
                    end
                    local params = RaycastParams.new()
                    params.FilterType = Enum.RaycastFilterType.Exclude
                    params.FilterDescendantsInstances = {LocalPlayer.Character, Camera, workspace:FindFirstChild("Bullets")}
                    for _, vel in ipairs(latestVelocities) do
                        local direction = vel.Unit
                        local hit = workspace:Raycast(barrelPos, direction * 2000, params)
                        DrawLaserTracer(barrelPos, hit and hit.Position or (barrelPos + direction * 2000))
                    end
                end)
            end
            return result
        end
    end

    if Ballistics_m then
        local oldGetVelocities = Ballistics_m.GetVelocities
        Ballistics_m.GetVelocities = function(a1, weaponData, a3, a4, aimDirection, config, isFirstShot)
            if Unloaded then return oldGetVelocities(a1, weaponData, a3, a4, aimDirection, config, isFirstShot) end
            if config and config.Speed then
                CurrentBulletSpeed = config.Speed
            elseif weaponData and weaponData.MuzzleVelocity then
                CurrentBulletSpeed = weaponData.MuzzleVelocity
            end

            local result
            if Settings.Gun_NoSpread then
                local straightVelocities = {}
                local pelletCount = weaponData and tonumber(weaponData.PelletCount) or 1
                pelletCount = math_clamp(math_floor(pelletCount), 1, 32)
                for i = 1, pelletCount do straightVelocities[i] = aimDirection.Unit * config.Speed end
                result = straightVelocities
            else
                result = oldGetVelocities(a1, weaponData, a3, a4, aimDirection, config, isFirstShot)
            end
            latestVelocities = result
            return result
        end

        local oldGetConfig = Ballistics_m.GetConfig
        Ballistics_m.GetConfig = function(weaponName, weaponData)
            local config = oldGetConfig(weaponName, weaponData)
            if Unloaded then return config end
            if Settings.Gun_NoDrop and type(config) == "table" then config.Gravity = 0 end
            return config
        end

        if Ballistics_m.GetBowConfig then
            local oldGetBowConfig = Ballistics_m.GetBowConfig
            Ballistics_m.GetBowConfig = function(bowData)
                local config = oldGetBowConfig(bowData)
                if Unloaded then return config end
                if Settings.Gun_NoDrop and type(config) == "table" then config.Gravity = 0 end
                return config
            end
        end
    end

    if GunClient then
        local oldCalcSpread = GunClient.CalculateSpreadDirection
        GunClient.CalculateSpreadDirection = function(baseDirection, rngObj, spreadAngle)
            if Unloaded then return oldCalcSpread(baseDirection, rngObj, spreadAngle) end
            if Settings.Gun_NoSpread and baseDirection then return baseDirection.Unit end
            return oldCalcSpread(baseDirection, rngObj, spreadAngle)
        end
    end
end)

do
    TargetInvGui = Instance.new("ScreenGui")
    TargetInvGui.Name = "TargetInventoryViewer"
    TargetInvGui.ResetOnSpawn = false
    TargetInvGui.Enabled = false
    TargetInvGui.Parent = TargetGuiParent
    ProtectGui(TargetInvGui)

    local Frame = Instance.new("Frame")
    Frame.Name = "MainFrame"
    Frame.Size = UDim2.new(0, 350, 0, 175)
    Frame.Position = UDim2.new(0.5, -175, 0.5, -87)
    Frame.BackgroundColor3 = Color3_fromRGB(8, 8, 8)
    Frame.BorderSizePixel = 0
    Frame.Active = true
    Frame.Parent = TargetInvGui

    local HeaderFrame = Instance.new("Frame")
    HeaderFrame.Name = "HeaderFrame"
    HeaderFrame.Size = UDim2.new(1, 0, 0, 46)
    HeaderFrame.BackgroundColor3 = Color3_fromRGB(16, 16, 16)
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.Parent = Frame

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "PlayerNameLabel"
    NameLabel.Size = UDim2.new(1, -20, 1, 0)
    NameLabel.Position = UDim2.new(0, 15, 0, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextColor3 = Color3_fromRGB(245, 245, 245)
    NameLabel.Font = Enum.Font.GothamMedium
    NameLabel.TextSize = 14
    NameLabel.Text = "No Target"
    NameLabel.Parent = HeaderFrame

    local Row1 = Instance.new("Frame")
    Row1.Name = "Row1"
    Row1.Size = UDim2.new(0, 318, 0, 48)
    Row1.Position = UDim2.new(0.5, 0, 0, 56)
    Row1.AnchorPoint = Vector2_new(0.5, 0)
    Row1.BackgroundTransparency = 1
    Row1.Parent = Frame
    local Row1Layout = Instance.new("UIListLayout")
    Row1Layout.FillDirection = Enum.FillDirection.Horizontal
    Row1Layout.Padding = UDim.new(0, 6)
    Row1Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Row1Layout.Parent = Row1

    local Row2 = Instance.new("Frame")
    Row2.Name = "Row2"
    Row2.Size = UDim2.new(0, 318, 0, 48)
    Row2.Position = UDim2.new(0.5, 0, 0, 110)
    Row2.AnchorPoint = Vector2_new(0.5, 0)
    Row2.BackgroundTransparency = 1
    Row2.Parent = Frame
    local Row2Layout = Instance.new("UIListLayout")
    Row2Layout.FillDirection = Enum.FillDirection.Horizontal
    Row2Layout.Padding = UDim.new(0, 6)
    Row2Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Row2Layout.Parent = Row2

    local InvSlots = {}
    local function createSlot(index, parentRow)
        local Box = Instance.new("Frame")
        Box.Name = "Slot" .. index
        Box.Size = UDim2.new(0, 48, 0, 48)
        Box.BackgroundColor3 = Color3_fromRGB(0, 0, 0)
        Box.BorderSizePixel = 0
        Box.LayoutOrder = index
        Box.Parent = parentRow

        local ItemIcon = Instance.new("ImageLabel")
        ItemIcon.Name = "ItemIcon"
        ItemIcon.Size = UDim2.new(1, -6, 1, -6)
        ItemIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        ItemIcon.AnchorPoint = Vector2_new(0.5, 0.5)
        ItemIcon.BackgroundTransparency = 1
        ItemIcon.Image = ""
        ItemIcon.ZIndex = 2
        ItemIcon.Parent = Box

        local FallbackText = Instance.new("TextLabel")
        FallbackText.Name = "FallbackText"
        FallbackText.Size = UDim2.new(1, -4, 1, -4)
        FallbackText.Position = UDim2.new(0.5, 0, 0.5, 0)
        FallbackText.AnchorPoint = Vector2_new(0.5, 0.5)
        FallbackText.BackgroundTransparency = 1
        FallbackText.TextColor3 = Color3_fromRGB(200, 200, 200)
        FallbackText.TextScaled = true
        FallbackText.Font = Enum.Font.GothamBold
        FallbackText.Text = ""
        FallbackText.ZIndex = 2
        FallbackText.Parent = Box

        local AmountText = Instance.new("TextLabel")
        AmountText.Name = "AmountText"
        AmountText.Size = UDim2.new(1, -3, 0, 12)
        AmountText.Position = UDim2.new(0, 0, 1, -12)
        AmountText.BackgroundTransparency = 1
        AmountText.TextColor3 = Color3_fromRGB(255, 255, 255)
        AmountText.TextSize = 10
        AmountText.Font = Enum.Font.GothamBold
        AmountText.TextXAlignment = Enum.TextXAlignment.Right
        AmountText.TextYAlignment = Enum.TextYAlignment.Bottom
        AmountText.TextStrokeTransparency = 1
        AmountText.ZIndex = 3
        AmountText.Parent = Box

        InvSlots[index] = Box
    end

    for i = 25, 30 do createSlot(i, Row1) end
    for i = 31, 35 do createSlot(i, Row2) end

    local Dragging = false
    local DragStart, StartPos

    ConnectEvent(HeaderFrame.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPos = Frame.Position
        end
    end)

    ConnectEvent(UserInputService.InputChanged, function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - DragStart
            Frame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
        end
    end)

    ConnectEvent(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)

    local function clearSlots()
        for i = 25, 35 do
            local slot = InvSlots[i]
            if slot then
                slot.ItemIcon.Image = ""
                slot.AmountText.Text = ""
                slot.FallbackText.Text = ""
            end
        end
    end

    task.spawn(function()
        while true do
            task.wait(0.3)
            if Unloaded or not TargetInvGui.Parent then break end
            if not TargetInvGui.Enabled or not Settings.Misc_TargetInventory then continue end
            
            local targetPlayer = CurrentTarget and Players:GetPlayerFromCharacter(CurrentTarget) or nil
            if not targetPlayer then
                NameLabel.Text = "No Target"
                clearSlots()
                continue
            end
            
            NameLabel.Text = targetPlayer.DisplayName .. " (@" .. targetPlayer.Name .. ")"
            
            local Data = targetPlayer:FindFirstChild("Data")
            if not Data then 
                clearSlots()
                continue 
            end

            for i = 25, 35 do
                local Box = InvSlots[i]
                local Slot = Data:FindFirstChild("Slot" .. i)

                Box.ItemIcon.Image = ""
                Box.AmountText.Text = ""
                Box.FallbackText.Text = ""

                if Slot then
                    local ItemName = Slot:FindFirstChild("ItemName")
                    local Amount = Slot:FindFirstChild("Amount")

                    if ItemName and ItemName:IsA("ValueBase") then
                        local Name = tostring(ItemName.Value)
                        if Name ~= "" and Name ~= "None" and Name ~= "nil" then
                            local Count = (Amount and Amount:IsA("ValueBase")) and Amount.Value or 1
                            if Count > 1 then Box.AmountText.Text = "x" .. tostring(Count) end

                            if ItemData and ItemData.Items and ItemData.Items[Name] and ItemData.Items[Name].Image then
                                Box.ItemIcon.Image = ItemData.Items[Name].Image
                            else
                                Box.FallbackText.Text = Name
                            end
                        end
                    end
                end
            end
        end
    end)
    end
