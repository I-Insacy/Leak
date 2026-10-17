
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Mouse = LocalPlayer:GetMouse()
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

if CoreGui:FindFirstChild("StealthMenu") then CoreGui.StealthMenu:Destroy() end
if PlayerGui:FindFirstChild("StealthMenu") then PlayerGui.StealthMenu:Destroy() end
if CoreGui:FindFirstChild("StealthWatermark") then CoreGui.StealthWatermark:Destroy() end
if PlayerGui:FindFirstChild("StealthWatermark") then PlayerGui.StealthWatermark:Destroy() end
if CoreGui:FindFirstChild("Stealth_HitLogs") then CoreGui.Stealth_HitLogs:Destroy() end
if PlayerGui:FindFirstChild("Stealth_HitLogs") then PlayerGui.Stealth_HitLogs:Destroy() end
if CoreGui:FindFirstChild("StealthSAInfo") then CoreGui.StealthSAInfo:Destroy() end
if PlayerGui:FindFirstChild("StealthSAInfo") then PlayerGui.StealthSAInfo:Destroy() end

local ScreenGui 
local RefreshHitboxes 
local OriginalClockTime = Lighting.ClockTime

local OriginalPartSizes = {}
setmetatable(OriginalPartSizes, { __mode = "k" })

local function saveOriginalData(part)
    if part and part:IsA("BasePart") and not OriginalPartSizes[part] then
        local currentSize = part.Size
        if currentSize.X > 5 or currentSize.Y > 5 or currentSize.Z > 5 then
            currentSize = Vector3.new(1.2, 1.2, 1.2)
        end
        OriginalPartSizes[part] = {
            Size = currentSize,
            CanCollide = part.CanCollide,
            Massless = part.Massless,
            Transparency = part.Transparency
        }
    end
end

local Skyboxes = {
    ["default"] = {Bk="http://www.roblox.com/asset/?id=91458024",Dn="http://www.roblox.com/asset/?id=91457980",Ft="http://www.roblox.com/asset/?id=91458024",Lf="http://www.roblox.com/asset/?id=91458024",Rt="http://www.roblox.com/asset/?id=91458024",Up="http://www.roblox.com/asset/?id=91458002"},
    ["setting sun"] = {Bk="rbxassetid://626460377",Dn="rbxassetid://626460216",Ft="rbxassetid://626460513",Lf="rbxassetid://626473032",Rt="rbxassetid://626458639",Up="rbxassetid://626460625"},
    ["fade blue"] = {Bk="rbxassetid://153695414",Dn="rbxassetid://153695352",Ft="rbxassetid://153695452",Lf="rbxassetid://153695320",Rt="rbxassetid://153695383",Up="rbxassetid://153695471"},
    ["purple sky"] = {Bk="rbxassetid://570557514",Dn="rbxassetid://570557775",Ft="rbxassetid://570557559",Lf="rbxassetid://570557620",Rt="rbxassetid://570557672",Up="rbxassetid://570557727"},
    ["pinky sky"] = {Bk="rbxassetid://11427769401",Dn="rbxassetid://11427770685",Ft="rbxassetid://11427769401",Lf="rbxassetid://11427769401",Rt="rbxassetid://11427769401",Up="rbxassetid://11427771954"},
    ["blue sky"] = {Bk="rbxassetid://591058823",Dn="rbxassetid://591059876",Ft="rbxassetid://591058104",Lf="rbxassetid://591057861",Rt="rbxassetid://591057625",Up="rbxassetid://591059642"},
    ["neptune"] = {Bk="rbxassetid://218955819",Dn="rbxassetid://218953419",Ft="rbxassetid://218954524",Lf="rbxassetid://218958493",Rt="rbxassetid://218957134",Up="rbxassetid://218950090"},
    ["redshift"] = {Bk="rbxassetid://401664839",Dn="rbxassetid://401664862",Ft="rbxassetid://401664960",Lf="rbxassetid://401664881",Rt="rbxassetid://401664901",Up="rbxassetid://401664936"},
    ["elegant morning"] = {Bk="rbxassetid://153767241",Dn="rbxassetid://153767216",Ft="rbxassetid://153767266",Lf="rbxassetid://153767200",Rt="rbxassetid://153767231",Up="rbxassetid://153767288"}
}

local SkyboxNames = {
    "default", "setting sun", "fade blue", "purple sky", "pinky sky", "blue sky", "neptune", "redshift", "elegant morning"
}

local function applySkybox(boxName)
    local target = Skyboxes[boxName]
    if not target then return end
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Parent = Lighting
    end
    sky.SkyboxBk = target.Bk
    sky.SkyboxDn = target.Dn
    sky.SkyboxFt = target.Ft
    sky.SkyboxLf = target.Lf
    sky.SkyboxRt = target.Rt
    sky.SkyboxUp = target.Up
end

local HookedRayCastFunction = nil
local OriginalRayCastHandler = nil

task.spawn(function()
    pcall(function()
        for _, f in pairs(getgc()) do
            if type(f) == "function" and string.find(debug.info(f, "s"), "RayCastHandler") then
                HookedRayCastFunction = f
                OriginalRayCastHandler = hookfunction(f, function()
                    return task.wait(9e9)
                end)
            end
        end
    end)
end)

local Settings = {
    SA_General = false,
    SA_TargetPart = "Head",
    SA_ShowFov = false,
    SA_FovColor = Color3.new(1, 1, 1),
    SA_FovRadius = 150,
    SA_TargetLine = false,
    SA_TargetLineColor = Color3.new(1, 1, 1),
    SA_AutoShot = false,
    SA_ShowText = false,
    SA_ShowNickname = false,
    SA_ShowStatus = false,
    GM_FullAuto = false,
    GM_RapidFire = false,
    GM_NoSpread = false,
    GM_NoRecoil = false,
    GM_NoSway = false,
    GM_CanShoot = false,
    GM_InstantBullet = false,
    GM_NoBobble = false,
    GM_NoShotVFX = false,
    GM_NoShotSFX = false,
    GM_BulletTracer = false,
    GM_BulletTracerColor = Color3.new(1, 1, 1),
    HB_Enabled = false,
    HB_TeamCheck = false,
    HB_ShowHitbox = false,
    HB_Color = Color3.fromRGB(255, 255, 255),
    HB_X = 2,
    HB_Y = 2,
    HB_Z = 2,
    ESP_Enabled = false,
    ESP_Box = false,
    ESP_BoxColor = Color3.fromRGB(255, 255, 255),
    ESP_Name = false,
    ESP_NameColor = Color3.fromRGB(255, 255, 255),
    ESP_Distance = false,
    ESP_DistanceColor = Color3.fromRGB(255, 255, 255),
    ESP_Health = false,
    ESP_MaxDistance = 2000, 
    ESP_Chams = false,
    ESP_ChamsColor = Color3.new(1, 1, 1),
    World_Skybox = false,
    World_SkyboxVal = "default",
    World_TimeChanger = false,
    World_TimeValue = 12,
    World_NoClouds = false,
    World_NoGrass = false,
    Movement_Speed = false,
    Movement_SpeedVal = 16,
    Movement_InfJump = false,
    Movement_Fly = false,
    Movement_Minicopter = false,
    Camera_Zoom = false,
    Events_HitLogs = false
}

local Colors = {
    Background = Color3.fromRGB(13, 13, 13),
    Panel = Color3.fromRGB(14, 14, 14),
    PanelInner = Color3.fromRGB(18, 18, 18),
    OuterBorder = Color3.fromRGB(26, 26, 26),
    InnerBorder = Color3.fromRGB(55, 55, 55),
    DividerLine = Color3.fromRGB(31, 31, 31),
    Accent = Color3.fromRGB(199, 36, 177),
    AccentDark = Color3.fromRGB(120, 20, 105),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(150, 150, 150),
    TextGroup = Color3.fromRGB(140, 140, 140),
    Black = Color3.new(0, 0, 0),
}

local WINDOW_SIZE = UDim2.fromOffset(580, 580)
local PADDING = 15
local SUBTAB_BAR_HEIGHT = 26
local ROW_HEIGHT = 22
local GROUP_HEADER_H = 28

local TABS = {
    { name = "Combat", subtabs = {
        { name = "Main", left = "Silent Aimbot", right = "Other" },
        { name = "Guns", left = "GunMods", right = "HitboxExpander" },
    }},
    { name = "Visuals", subtabs = {
        { name = "ESP", left = "ESP", right = "Chams" },
        { name = "World", left = "World", right = "World Settings" },
    }},
    { name = "Misc", subtabs = {
        { name = "Misc 1", left = "Movement", right = "Camera" },
        { name = "Misc 2", left = "Events", right = "Other" },
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
    for Frame, _ in pairs(Library.OpenedFrames) do
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

    Region.InputBegan:Connect(function(input)
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

    local Handle = Library:Create("Frame", { BackgroundColor3 = Colors.Accent, BorderSizePixel = 0, Size = UDim2.new(0, 6, 1, 0), AnchorPoint = Vector2.new(0.5, 0), Parent = BarInner })
    local ValueLabel = Library:CreateLabel({ Size = UDim2.new(1, 0, 1, 0), TextSize = 12, Text = "", Parent = BarInner })

    function Slider:Display()
        local scale = math.clamp((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1)
        Handle.Position = UDim2.new(scale, 0, 0, 0)
        ValueLabel.Text = tostring(Slider.Value) .. (Info.Suffix or "")
    end
    
    function Slider:SetValue(v)
        Slider.Value = tonumber(string.format("%."..Slider.Rounding.."f", math.clamp(tonumber(v) or Slider.Min, Slider.Min, Slider.Max)))
        Slider:Display(); Library:SafeCallback(Slider.Callback, Slider.Value)
    end

    BarInner.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                local relX = math.clamp(Mouse.X - BarInner.AbsolutePosition.X, 0, BarInner.AbsoluteSize.X)
                Slider:SetValue(Library:MapValue(relX, 0, BarInner.AbsoluteSize.X, Slider.Min, Slider.Max))
                RenderStepped:Wait()
            end
        end
    end)
    Slider:Display(); return Slider
end

function Controls.Dropdown(parent, Info)
    local Dropdown = { Value = Info.Default, Values = Info.Values, Opened = false, Callback = Info.Callback }
    local Width = Info.Width or 200
    local ListHeight = math.clamp(#Dropdown.Values, 1, 6) * 20

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

    MainBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
            Dropdown.Opened = not Dropdown.Opened; UpdateState()
        end
    end)

    for _, val in ipairs(Dropdown.Values) do
        local Btn = Library:Create("TextLabel", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 20), Font = Library.Font, Text = "  " .. val, TextSize = 13, TextColor3 = (Dropdown.Value == val) and Colors.Accent or Colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = Scrolling })
        Btn.InputBegan:Connect(function(input)
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
    local ColorPicker = { Value = Info.Default or Color3.fromRGB(255, 255, 255), Callback = Info.Callback }
    local Holder = Library:Create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(Info.Width or 26, ROW_HEIGHT), Parent = parent })
    
    local Display = Library:Create("Frame", { BackgroundColor3 = ColorPicker.Value, BorderSizePixel = 0, Size = UDim2.fromOffset(22, 14), Position = UDim2.new(0.5, -11, 0.5, -7), Parent = Holder })
    addStroke(Display, Colors.InnerBorder, 1)

    local Popup = Library:Create("Frame", { BackgroundColor3 = Colors.Black, BorderSizePixel = 0, Size = UDim2.fromOffset(160, 160), Visible = false, ZIndex = 60, Parent = ScreenGui })
    local PopupInner = Library:Create("Frame", { BackgroundColor3 = Library.MainColor, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), ZIndex = 61, Parent = Popup })
    addStroke(PopupInner, Colors.InnerBorder, 1)

    local h, s, v = Color3.toHSV(ColorPicker.Value)

    local SatVibOuter = Library:Create("Frame", { BackgroundColor3 = Colors.Black, Size = UDim2.fromOffset(130, 130), Position = UDim2.fromOffset(6, 6), BorderSizePixel = 0, ZIndex = 62, Parent = PopupInner })
    local SatVib = Library:Create("ImageLabel", { BackgroundColor3 = Color3.fromHSV(h, 1, 1), Image = "rbxassetid://4155801252", Size = UDim2.new(1, 0, 1, 0), BorderSizePixel = 0, ZIndex = 62, Parent = SatVibOuter })
    local SVMarker = Library:Create("Frame", { BackgroundColor3 = Color3.new(1,1,1), Size = UDim2.fromOffset(4, 4), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(s, 0, 1-v, 0), ZIndex = 63, Parent = SatVib })
    addStroke(SVMarker, Colors.Black, 1)

    local HueOuter = Library:Create("Frame", { BackgroundColor3 = Colors.Black, Size = UDim2.fromOffset(12, 130), Position = UDim2.fromOffset(142, 6), BorderSizePixel = 0, ZIndex = 62, Parent = PopupInner })
    local HueInner = Library:Create("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.new(1, 0, 1, 0), BorderSizePixel = 0, ZIndex = 62, Parent = HueOuter })
    local seq = {} for i = 0, 1, 0.1 do table.insert(seq, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1))) end
    Library:Create("UIGradient", { Color = ColorSequence.new(seq), Rotation = 90, Parent = HueInner })
    local HueMarker = Library:Create("Frame", { BackgroundColor3 = Color3.new(1,1,1), Size = UDim2.new(1, 2, 0, 2), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -1, h, 0), ZIndex = 63, Parent = HueInner })
    addStroke(HueMarker, Colors.Black, 1)

    local function UpdateColor()
        local col = Color3.fromHSV(h, s, v)
        ColorPicker.Value = col; Display.BackgroundColor3 = col
        SatVib.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        SVMarker.Position = UDim2.new(s, 0, 1 - v, 0); HueMarker.Position = UDim2.new(0, -1, h, 0)
        Library:SafeCallback(ColorPicker.Callback, col)
    end

    SatVib.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                s = math.clamp(Mouse.X - SatVib.AbsolutePosition.X, 0, SatVib.AbsoluteSize.X) / SatVib.AbsoluteSize.X
                v = 1 - (math.clamp(Mouse.Y - SatVib.AbsolutePosition.Y, 0, SatVib.AbsoluteSize.Y) / SatVib.AbsoluteSize.Y)
                UpdateColor(); RenderStepped:Wait()
            end
        end
    end)
    HueInner.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                h = math.clamp(Mouse.Y - HueInner.AbsolutePosition.Y, 0, HueInner.AbsoluteSize.Y) / HueInner.AbsoluteSize.Y
                UpdateColor(); RenderStepped:Wait()
            end
        end
    end)

    Display:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
        if Popup.Visible then Popup.Position = UDim2.fromOffset(Display.AbsolutePosition.X + 35, Display.AbsolutePosition.Y - 5) end
    end)

    Display.InputBegan:Connect(function(input)
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

    PickOuter.InputBegan:Connect(function(input)
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
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe or KeyPicker.Picking or KeyPicker.Value == "None" then return end
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == KeyPicker.Value) or (input.UserInputType == Enum.UserInputType.MouseButton2 and KeyPicker.Value == "MB2") then
            if KeyPicker.LinkedToggle then KeyPicker.LinkedToggle:SetValue(not KeyPicker.LinkedToggle.Value) else Library:SafeCallback(KeyPicker.Callback, true) end
        end
    end)
    return KeyPicker
end

ScreenGui = create("ScreenGui", { Name = "StealthMenu", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Global, IgnoreGuiInset = true, Parent = PlayerGui })
ProtectGui(ScreenGui)

local Outer = create("Frame", { Size = WINDOW_SIZE, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), BackgroundColor3 = Colors.Background, BorderSizePixel = 0, Active = true, Parent = ScreenGui })
addStroke(Outer, Colors.OuterBorder, 1)

local Inner = create("Frame", { Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), BackgroundColor3 = Colors.Background, BorderSizePixel = 0, Parent = Outer })
addStroke(Inner, Colors.InnerBorder, 1)

local Header = create("Frame", { Size = UDim2.new(1, 0, 0, 56), BackgroundTransparency = 1, Parent = Inner })
create("TextLabel", { Position = UDim2.fromOffset(0, 8), Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = "Stealth.xyz", TextColor3 = Colors.Text, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Center, Parent = Header })
create("TextLabel", { Position = UDim2.fromOffset(0, 28), Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = "build : beta", TextColor3 = Colors.TextDim, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Center, Parent = Header })

local TabBar = create("Frame", { Position = UDim2.fromOffset(PADDING, 58), Size = UDim2.new(1, -PADDING * 2, 0, 22), BackgroundTransparency = 1, Parent = Inner })
create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 40), Parent = TabBar })
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
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() Content.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 16) end)
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
    tabLabel.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then showTab(tab.name) end end)
    subTabButtons[tab.name] = {}; subTabGroups[tab.name] = {}
    for j, sub in ipairs(tab.subtabs) do
        local btn = create("TextLabel", { Size = UDim2.fromOffset(80, 20), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = sub.name, TextColor3 = Colors.TextDim, TextSize = 14, Visible = false, LayoutOrder = j, Parent = SubTabBar })
        subTabButtons[tab.name][sub.name] = btn
        btn.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then showSubTab(tab.name, sub.name) end end)
        local lGrp, lContent = makeGroup("left", sub.left)
        local rGrp, rContent = makeGroup("right", sub.right)
        subTabGroups[tab.name][sub.name] = { left = lGrp, right = rGrp, leftContent = lContent, rightContent = rContent }
    end
end

do
    local L = subTabGroups["Combat"]["Main"].leftContent
    Controls.Toggle(L, { Text = "General", Callback = function(v) Settings.SA_General = v end })
    
    local rFov = Controls.Row(L)
    Controls.Toggle(rFov, { Text = "Show fov", Width = 140, Callback = function(v) Settings.SA_ShowFov = v end })
    Controls.ColorPicker(rFov, { Default = Color3.new(1,1,1), Callback = function(c) Settings.SA_FovColor = c end })
    
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
    Controls.Toggle(R, { Text = "Show Status", Callback = function(v) Settings.SA_ShowStatus = v end })
end

do
    local L = subTabGroups["Combat"]["Guns"].leftContent
    Controls.Toggle(L, { Text = "Full Auto", Callback = function(v) Settings.GM_FullAuto = v end })
    Controls.Toggle(L, { Text = "Rapid Fire", Callback = function(v) Settings.GM_RapidFire = v end })
    Controls.Toggle(L, { Text = "No Spread", Callback = function(v) Settings.GM_NoSpread = v end })
    Controls.Toggle(L, { Text = "No Recoil", Callback = function(v) Settings.GM_NoRecoil = v end })
    Controls.Toggle(L, { Text = "No Sway", Callback = function(v) Settings.GM_NoSway = v end })
    Controls.Toggle(L, { Text = "Shoot Anywhere", Callback = function(v) Settings.GM_CanShoot = v end })
    Controls.Toggle(L, { Text = "Instant Bullet", Callback = function(v) Settings.GM_InstantBullet = v end })
    Controls.Toggle(L, { Text = "No Bobble", Callback = function(v) Settings.GM_NoBobble = v end })
    Controls.Toggle(L, { Text = "No VFX (Flash)", Callback = function(v) Settings.GM_NoShotVFX = v end })
    Controls.Toggle(L, { Text = "No SFX (Silent)", Callback = function(v) Settings.GM_NoShotSFX = v end })
    
    local rTracer = Controls.Row(L)
    Controls.Toggle(rTracer, { Text = "Bullet Tracers", Width = 140, Callback = function(v) Settings.GM_BulletTracer = v end })
    Controls.ColorPicker(rTracer, { Default = Color3.new(1, 1, 1), Callback = function(c) Settings.GM_BulletTracerColor = c end })

    local R = subTabGroups["Combat"]["Guns"].rightContent
    Controls.Toggle(R, { Text = "Hitbox Expander", Callback = function(v) Settings.HB_Enabled = v; if RefreshHitboxes then RefreshHitboxes() end end })
    Controls.Toggle(R, { Text = "Team Check", Callback = function(v) Settings.HB_TeamCheck = v; if RefreshHitboxes then RefreshHitboxes() end end })
    
    local rHB = Controls.Row(R)
    Controls.Toggle(rHB, { Text = "Show Hitbox", Width = 140, Callback = function(v) Settings.HB_ShowHitbox = v; if RefreshHitboxes then RefreshHitboxes() end end })
    Controls.ColorPicker(rHB, { Default = Settings.HB_Color, Callback = function(c) Settings.HB_Color = c; if RefreshHitboxes then RefreshHitboxes() end end })
    
    Controls.Slider(R, { Text = "Size X", Min = 0, Max = 15, Default = 2, Rounding = 1, Callback = function(v) Settings.HB_X = v; if RefreshHitboxes then RefreshHitboxes() end end })
    Controls.Slider(R, { Text = "Size Y", Min = 0, Max = 15, Default = 2, Rounding = 1, Callback = function(v) Settings.HB_Y = v; if RefreshHitboxes then RefreshHitboxes() end end })
    Controls.Slider(R, { Text = "Size Z", Min = 0, Max = 15, Default = 2, Rounding = 1, Callback = function(v) Settings.HB_Z = v; if RefreshHitboxes then RefreshHitboxes() end end })
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
    local rChams = Controls.Row(R_ESP)
    Controls.Toggle(rChams, { Text = "General", Width = 140, Callback = function(v) Settings.ESP_Chams = v end })
    Controls.ColorPicker(rChams, { Default = Color3.new(1, 1, 1), Callback = function(c) Settings.ESP_ChamsColor = c end })
end

do
    local L = subTabGroups["Visuals"]["World"].leftContent
    
    local function updateSkybox()
        if Settings.World_Skybox then
            applySkybox(Settings.World_SkyboxVal)
        else
            applySkybox("default")
        end
    end

    Controls.Toggle(L, { Text = "Skybox", Callback = function(v) 
        Settings.World_Skybox = v 
        updateSkybox()
    end })
    
    Controls.Toggle(L, { Text = "Time Changer", Callback = function(v) 
        Settings.World_TimeChanger = v 
        if not v then
            Lighting.ClockTime = OriginalClockTime
        end
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
    
    local R = subTabGroups["Visuals"]["World"].rightContent
    
    Controls.Dropdown(R, { Values = SkyboxNames, Default = "default", Width = 200, Callback = function(v)
        Settings.World_SkyboxVal = v
        if Settings.World_Skybox then
            updateSkybox()
        end
    end })
    
    Controls.Slider(R, { Text = "Time Value", Min = 0, Max = 24, Default = 12, Rounding = 1, Callback = function(v) Settings.World_TimeValue = v end })
end

do
    local L = subTabGroups["Misc"]["Misc 1"].leftContent
    local rSpd = Controls.Row(L)
    local tSpd = Controls.Toggle(rSpd, { Text = "SpeedHack", Width = 140, Callback = function(v) Settings.Movement_Speed = v end })
    Controls.KeyPicker(rSpd, { Default = "None", LinkedToggle = tSpd })
    Controls.Slider(L, { Text = "Speed Value", Min = 16, Max = 35, Default = 16, Callback = function(v) Settings.Movement_SpeedVal = v end })

    local rJmp = Controls.Row(L)
    local tJmp = Controls.Toggle(rJmp, { Text = "Infinity Jump", Width = 140, Callback = function(v) Settings.Movement_InfJump = v end })
    Controls.KeyPicker(rJmp, { Default = "None", LinkedToggle = tJmp })

    local rFly = Controls.Row(L)
    local tFly = Controls.Toggle(rFly, { Text = "FlyHack", Width = 140, Callback = function(v) Settings.Movement_Fly = v end })
    Controls.KeyPicker(rFly, { Default = "None", LinkedToggle = tFly })

    Controls.Toggle(L, { Text = "Minicopter Fly", Callback = function(v) Settings.Movement_Minicopter = v end })

    local R = subTabGroups["Misc"]["Misc 1"].rightContent
    local rCam = Controls.Row(R)
    local tCam = Controls.Toggle(rCam, { Text = "Zoom", Width = 140, Callback = function(v) Settings.Camera_Zoom = v end })
    Controls.KeyPicker(rCam, { Default = "None", LinkedToggle = tCam })
    
    local LEvents = subTabGroups["Misc"]["Misc 2"].leftContent
    Controls.Toggle(LEvents, { Text = "Hit Logs", Callback = function(v) Settings.Events_HitLogs = v end })
end

showTab("Combat")

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

local FOVCircle = Drawing.new("Circle"); FOVCircle.Thickness = 1; FOVCircle.Filled = false
local TracerLine = Drawing.new("Line"); TracerLine.Thickness = 1

local SAInfoGui = create("ScreenGui", { Name = "StealthSAInfo", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Global, IgnoreGuiInset = true, Parent = PlayerGui })
ProtectGui(SAInfoGui)

local function makeSALabel(size)
    return create("TextLabel", {
        Parent = SAInfoGui,
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(400, size),
        AnchorPoint = Vector2.new(0.5, 0),
        Font = Enum.Font.Code,
        TextSize = size,
        TextStrokeTransparency = 0.35,
        TextStrokeColor3 = Color3.new(0, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Center,
        Visible = false
    })
end

local SATitle = makeSALabel(20)
SATitle.RichText = true
SATitle.Text = '<font color="#ffffff">Stealth</font><font color="#c724b1">.xyz</font>'

local SATarget = makeSALabel(18)
SATarget.TextColor3 = Color3.new(1, 1, 1)

local SAStatus = makeSALabel(16)

local currentTarget = nil
local currentTargetPart = nil
local currentWeaponRange = 0
local isWeaponEquipped = false

RunService.RenderStepped:Connect(function()
    if Settings.World_TimeChanger then Lighting.ClockTime = Settings.World_TimeValue end
    if Settings.Camera_Zoom then Camera.FieldOfView = 30 else Camera.FieldOfView = 70 end

    local closestDist = Settings.SA_ShowFov and Settings.SA_FovRadius or math.huge
    currentTarget, currentTargetPart = nil, nil
    local mouseLoc = UserInputService:GetMouseLocation()
    
    if Settings.SA_General then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Settings.SA_TargetPart) then
                local hum = player.Character:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 and not IsTeammate(player) then
                    local part = player.Character[Settings.SA_TargetPart]
                    local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - mouseLoc).Magnitude
                        if dist < closestDist then
                            closestDist = dist; currentTargetPart = part; currentTarget = player
                        end
                    end
                end
            end
        end
    end

    FOVCircle.Visible = Settings.SA_ShowFov
    if FOVCircle.Visible then FOVCircle.Position = mouseLoc; FOVCircle.Radius = Settings.SA_FovRadius; FOVCircle.Color = Settings.SA_FovColor end

    TracerLine.Visible = Settings.SA_TargetLine and currentTargetPart ~= nil
    if TracerLine.Visible then
        local pos, onScreen = Camera:WorldToViewportPoint(currentTargetPart.Position)
        if onScreen then
            TracerLine.From = mouseLoc; TracerLine.To = Vector2.new(pos.X, pos.Y)
            TracerLine.Color = Settings.SA_TargetLineColor
        else TracerLine.Visible = false end
    end

    local screenSize = Camera.ViewportSize
    local yPos = (screenSize.Y / 2) + 40

    SATitle.Visible = Settings.SA_ShowText
    if Settings.SA_ShowText then
        SATitle.Position = UDim2.fromOffset(screenSize.X / 2, yPos)
        yPos = yPos + 25
    end

    SATarget.Visible = Settings.SA_ShowNickname and currentTarget ~= nil
    if SATarget.Visible then
        SATarget.Position = UDim2.fromOffset(screenSize.X / 2, yPos)
        SATarget.Text = currentTarget.Name
        yPos = yPos + 20
    end

    SAStatus.Visible = Settings.SA_ShowStatus and currentTarget ~= nil
    if SAStatus.Visible then
        SAStatus.Position = UDim2.fromOffset(screenSize.X / 2, yPos)
        if isWeaponEquipped and currentTarget.Character and currentTarget.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local dist3D = (currentTarget.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if dist3D > currentWeaponRange then
                SAStatus.Text = "dont shoot!! (unreg)"
                SAStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
            else
                SAStatus.Text = "Shoot!!"
                SAStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
            end
        else
            SAStatus.Text = "No weapon equipped"
            SAStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
end)

task.spawn(function()
    pcall(function()
        local GunClient = require(ReplicatedStorage.Gun.Scripts.GunClient)
        local GunTypes = require(ReplicatedStorage.Gun.Types)
        local SoundMixer = require(ReplicatedStorage.Modules.SoundMixer)

        local activeGun = nil
        local oldEquip = GunClient.equipped
        GunClient.equipped = function(self)
            activeGun = self
            if self.Range then currentWeaponRange = self.Range; isWeaponEquipped = true end
            return oldEquip(self)
        end

        local oldUnequip = GunClient.unequipped
        GunClient.unequipped = function(self)
            if activeGun == self then activeGun = nil end; isWeaponEquipped = false
            return oldUnequip(self)
        end

        RunService.RenderStepped:Connect(function()
            if activeGun then
                if Settings.GM_NoSway then
                    if activeGun.ViewModel and activeGun.ViewModel.components and activeGun.ViewModel.components.sway then activeGun.ViewModel.components.sway.swayMult.Value = 0 end
                    if activeGun.TremblingHandler then activeGun.TremblingHandler.tremblingMult = 0 end
                    if activeGun.SightGuiSwayHandler then activeGun.SightGuiSwayHandler:stop() end
                end
                if Settings.GM_NoBobble then
                    if activeGun.ViewModel and activeGun.ViewModel.components and activeGun.ViewModel.components.bobble then activeGun.ViewModel.components.bobble:disable() end
                end
                if Settings.GM_NoRecoil then
                    if activeGun.RecoilHandler then activeGun.RecoilHandler.RecoilMultiplier = 0 end
                end
                
                if Settings.SA_AutoShot then
                    if activeGun.CurrentAmmo > 0 and not activeGun.Reloading and not activeGun.Equipping then
                        if currentTargetPart then
                            if not activeGun.HoldingMouseButton1 then activeGun:startFiring() end
                        else
                            if activeGun.HoldingMouseButton1 and not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then 
                                activeGun.HoldingMouseButton1 = false 
                            end
                        end
                    end
                else
                    if activeGun.HoldingMouseButton1 and not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then 
                        activeGun.HoldingMouseButton1 = false 
                    end
                end
            end
        end)

        local oldGetSpread = GunClient.getBulletSpread
        GunClient.getBulletSpread = function(self) if Settings.GM_NoSpread then return 0 end; return oldGetSpread(self) end

        local oldStartFiring = GunClient.startFiring
        GunClient.startFiring = function(self)
            if Settings.GM_FullAuto then self.FiringType = GunTypes.FiringType.Auto end
            if Settings.GM_RapidFire then self.FireDelay = 0.03 end
            return oldStartFiring(self)
        end

        local oldOnSwim = GunClient.onSwim
        GunClient.onSwim = function(self) if Settings.GM_CanShoot then self.IsSwimming = false; return end; return oldOnSwim(self) end

        local oldCanFire = GunClient.canFire
        GunClient.canFire = function(self)
            if Settings.GM_CanShoot then if self.CurrentAmmo > 0 and not self.Reloading and not self.Equipping then return true end end
            if oldCanFire then return oldCanFire(self) end; return false
        end

        local oldFire = GunClient.fire
        GunClient.fire = function(self, b2)
            if Settings.GM_InstantBullet and self.FireVisuals then self.FireVisuals.Velocity = 999999 end

            local oldAnimTrack, oldFireOffset, oldPlayTempSound, oldPlaySound

            if Settings.GM_NoShotVFX then
                oldAnimTrack = self.AnimationHandler.playTrack; self.AnimationHandler.playTrack = function() end
                if self.ViewModel and self.ViewModel.components and self.ViewModel.components.fire then
                    oldFireOffset = self.ViewModel.components.fire.createFireOffset; self.ViewModel.components.fire.createFireOffset = function() end
                end
                if self.FireVisuals then self.FireVisuals.TracerEnabled = false end
                if self.FireOriginPart then
                    for _, v in ipairs(self.FireOriginPart:GetChildren()) do if v:IsA("ParticleEmitter") or v:IsA("Light") then v.Enabled = false end end
                end
            else
                if self.FireVisuals and self.TotalAttachmentStats then self.FireVisuals.TracerEnabled = not self.TotalAttachmentStats.DisableTracer end
            end

            if Settings.GM_NoShotSFX then
                oldPlayTempSound = SoundMixer.playTempSound; SoundMixer.playTempSound = function() end
                oldPlaySound = SoundMixer.playSound; SoundMixer.playSound = function() end
            end

            if Settings.GM_BulletTracer and self.FireOriginPart then
                task.spawn(function()
                    local origin = self.FireOriginPart.Position
                    local aimRay = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * self.Range)
                    local dir = self:getfireDirection(origin, aimRay)
                    local params = RaycastParams.new(); params.FilterType = Enum.RaycastFilterType.Exclude; params.FilterDescendantsInstances = {LocalPlayer.Character, self.Tool, Camera}
                    local resHit = workspace:Raycast(origin, dir * 999, params)
                    local endPos = resHit and resHit.Position or (origin + dir * 999)
                    local dist = (endPos - origin).Magnitude

                    local tracer = Instance.new("Part")
                    tracer.Anchored = true; tracer.CanCollide = false; tracer.CanQuery = false; tracer.CanTouch = false; tracer.Massless = true
                    tracer.Material = Enum.Material.Neon; tracer.Color = Settings.GM_BulletTracerColor; tracer.Size = Vector3.new(0.05, 0.05, dist)
                    tracer.CFrame = CFrame.new(origin, endPos) * CFrame.new(0, 0, -dist / 2); tracer.Parent = workspace

                    local tween = TweenService:Create(tracer, TweenInfo.new(0.6), {Transparency = 1, Size = Vector3.new(0, 0, dist)})
                    tween:Play(); game.Debris:AddItem(tracer, 0.6)
                end)
            end

            local res = oldFire(self, b2)

            if Settings.GM_NoShotVFX then self.AnimationHandler.playTrack = oldAnimTrack; if oldFireOffset then self.ViewModel.components.fire.createFireOffset = oldFireOffset end end
            if Settings.GM_NoShotSFX then SoundMixer.playTempSound = oldPlayTempSound; SoundMixer.playSound = oldPlaySound end

            return res
        end

        local oldGetFireDir = GunClient.getfireDirection
        GunClient.getfireDirection = function(self, vec1, u8)
            if Settings.SA_General and currentTargetPart then return CFrame.new(vec1, currentTargetPart.Position).LookVector end
            return oldGetFireDir(self, vec1, u8)
        end
    end)
end)

local HitboxIndicators  = {}
setmetatable(HitboxIndicators, { __mode = "k" })

local function getHitboxSize()
    return Vector3.new(Settings.HB_X, Settings.HB_Y, Settings.HB_Z)
end

local function removeHitboxIndicator(part)
    local indicator = part:FindFirstChild("HB_SizeIndicator")
    if indicator then indicator:Destroy() end
    HitboxIndicators[part] = nil
end

local function updateHitboxIndicator(part, size, color)
    local indicator = part:FindFirstChild("HB_SizeIndicator")
    if not indicator then
        indicator = Instance.new("Part")
        indicator.Name = "HB_SizeIndicator"
        indicator.Size = size
        indicator.CFrame = part.CFrame
        indicator.Transparency = 0.5
        indicator.Color = color
        indicator.Material = Enum.Material.ForceField
        indicator.CanCollide = false
        indicator.CanTouch = false
        indicator.CanQuery = false
        indicator.Massless = true
        indicator.Anchored = false

        local weld = Instance.new("WeldConstraint")
        weld.Part0 = part
        weld.Part1 = indicator
        weld.Parent = indicator
        indicator.Parent = part
        HitboxIndicators[part] = indicator
    else
        indicator.Size = size
        indicator.Color = color
    end
end

local function resetSinglePart(part)
    if not part or not part.Parent then return end
    local orig = OriginalPartSizes[part]
    if orig then
        pcall(function()
            part.Size = orig.Size
            part.CanCollide = orig.CanCollide
            part.Massless = orig.Massless
            part.Transparency = orig.Transparency
            
            if sethiddenproperty then
                pcall(function() sethiddenproperty(part, "CanQuery", true) end)
            end
        end)
    end
    removeHitboxIndicator(part)
end

local function resetAllPlayerParts(character)
    for _, part in ipairs(character:GetDescendants()) do
        if OriginalPartSizes[part] then resetSinglePart(part) end
    end
end

RefreshHitboxes = function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local character = player.Character
        if not character then continue end

        local isInvalid = not Settings.HB_Enabled or (Settings.HB_TeamCheck and IsTeammate(player))
        local targetPart = character:FindFirstChild("Head")

        if isInvalid then
            resetAllPlayerParts(character)
            continue
        end

        if not targetPart or not targetPart:IsA("BasePart") then continue end

        saveOriginalData(targetPart)

        local desiredSize = getHitboxSize()
        if targetPart.Size ~= desiredSize then
            targetPart.Size = desiredSize
            targetPart.CanCollide = false
            targetPart.Massless = true
            targetPart.Transparency = 1
            targetPart.CollisionGroup = "Default"
            if sethiddenproperty then
                pcall(function() sethiddenproperty(targetPart, "CanQuery", true) end)
            end
        end

        if Settings.HB_ShowHitbox then
            updateHitboxIndicator(targetPart, desiredSize, Settings.HB_Color)
        else
            removeHitboxIndicator(targetPart)
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        RefreshHitboxes()
    end
end)

local OriginalWalkSpeed = 16
local MinicopterRootPart = nil

UserInputService.JumpRequest:Connect(function()
    if not Settings.Movement_InfJump then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

Heartbeat:Connect(function(delta)
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")

    if Settings.Movement_Speed then
        if hum then hum.WalkSpeed = Settings.Movement_SpeedVal end
    else
        if hum and hum.WalkSpeed == Settings.Movement_SpeedVal then hum.WalkSpeed = OriginalWalkSpeed end
    end

    if Settings.Movement_InfJump and hrp and hum and hum.Health > 0 then
        if hrp.AssemblyLinearVelocity.Y < -55 then
            local rp = RaycastParams.new()
            rp.FilterDescendantsInstances = { char }
            rp.FilterType = Enum.RaycastFilterType.Exclude
            if workspace:Raycast(hrp.Position, Vector3.new(0, -10, 0), rp) then
                hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, -2, hrp.AssemblyLinearVelocity.Z)
            end
        end
    end

    if Settings.Movement_Fly and hrp and hum then
        local spacePressed = UserInputService:IsKeyDown(Enum.KeyCode.Space)
        local oldVel = hrp.AssemblyLinearVelocity
        if spacePressed then
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 40 * delta, 0)
            if hum.FloorMaterial == Enum.Material.Air then
                hrp.AssemblyLinearVelocity = Vector3.new(0, -9e9, 0)
                RunService.RenderStepped:Wait()
                hrp.AssemblyLinearVelocity = Vector3.new(oldVel.X, 40, oldVel.Z)
            else
                hrp.AssemblyLinearVelocity = Vector3.new(oldVel.X, 50, oldVel.Z)
            end
        elseif hum:GetState() == Enum.HumanoidStateType.Freefall then
            if hum.FloorMaterial == Enum.Material.Air then
                local cv = hrp.AssemblyLinearVelocity
                hrp.AssemblyLinearVelocity = Vector3.new(0, -9e9, 0)
                RunService.RenderStepped:Wait()
                hrp.AssemblyLinearVelocity = Vector3.new(cv.X, math.clamp(cv.Y, -7.5, 0), cv.Z)
            end
        end
    end

    if Settings.Movement_Minicopter then
        if hum and hum.SeatPart then
            MinicopterRootPart = hum.SeatPart.AssemblyRootPart
            if not MinicopterRootPart:FindFirstChild("VanishBV") then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "VanishBV"
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Parent = MinicopterRootPart
                local bg = Instance.new("BodyGyro")
                bg.Name = "VanishBG"
                bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.Parent = MinicopterRootPart
            end
            local v = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then v = v + Camera.CFrame.LookVector  end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then v = v - Camera.CFrame.LookVector  end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then v = v - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then v = v + Camera.CFrame.RightVector end
            MinicopterRootPart.VanishBV.Velocity = v * 100
            MinicopterRootPart.VanishBG.CFrame = Camera.CFrame
        else
            if MinicopterRootPart then
                if MinicopterRootPart:FindFirstChild("VanishBV") then MinicopterRootPart.VanishBV:Destroy() end
                if MinicopterRootPart:FindFirstChild("VanishBG") then MinicopterRootPart.VanishBG:Destroy() end
                MinicopterRootPart = nil
            end
        end
    else
        if MinicopterRootPart then
            if MinicopterRootPart:FindFirstChild("VanishBV") then MinicopterRootPart.VanishBV:Destroy() end
            if MinicopterRootPart:FindFirstChild("VanishBG") then MinicopterRootPart.VanishBG:Destroy() end
            MinicopterRootPart = nil
        end
    end
end)

local function getPartCorners(part)
    if part.Name == "HB_SizeIndicator" then return {} end
    
    saveOriginalData(part)
    
    local cf = part.CFrame
    local size = part.Size
    
    if OriginalPartSizes[part] then
        size = OriginalPartSizes[part].Size
    end
    
    if size.X > 4 or size.Y > 4 or size.Z > 4 then
        size = Vector3.new(1.2, 1.2, 1.2)
    end
    
    local sx, sy, sz = size.X / 2, size.Y / 2, size.Z / 2
    return {
        cf * Vector3.new(sx, sy, sz), cf * Vector3.new(sx, sy, -sz),
        cf * Vector3.new(sx, -sy, sz), cf * Vector3.new(sx, -sy, -sz),
        cf * Vector3.new(-sx, sy, sz), cf * Vector3.new(-sx, sy, -sz),
        cf * Vector3.new(-sx, -sy, sz), cf * Vector3.new(-sx, -sy, -sz)
    }
end

local function createPlayerESP(player)
    local boxOutline = Drawing.new("Square"); boxOutline.Visible = false; boxOutline.Color = Color3.new(0, 0, 0); boxOutline.Thickness = 3; boxOutline.Filled = false
    local box = Drawing.new("Square"); box.Visible = false; box.Thickness = 1; box.Filled = false
    local healthBg = Drawing.new("Square"); healthBg.Visible = false; healthBg.Color = Color3.new(0, 0, 0); healthBg.Thickness = 1; healthBg.Filled = true
    local healthFill = Drawing.new("Square"); healthFill.Visible = false; healthFill.Thickness = 1; healthFill.Filled = true
    
    local nameText = Drawing.new("Text"); nameText.Visible = false; nameText.Size = 16; nameText.Center = true; nameText.Outline = true; nameText.OutlineColor = Color3.new(0, 0, 0)
    local distText = Drawing.new("Text"); distText.Visible = false; distText.Size = 14; distText.Center = true; distText.Outline = true; distText.OutlineColor = Color3.new(0, 0, 0)
    
    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 0
    highlight.OutlineTransparency = 1
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = false
    pcall(function() highlight.Parent = CoreGui end)
    if not highlight.Parent then pcall(function() highlight.Parent = LocalPlayer:WaitForChild("PlayerGui") end) end
    
    local function removeESP() 
        boxOutline:Remove()
        box:Remove()
        healthBg:Remove()
        healthFill:Remove()
        nameText:Remove()
        distText:Remove()
        if highlight then highlight:Destroy() end
    end
    
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not player.Parent then removeESP(); connection:Disconnect(); return end
        
        local character = player.Character
        local isValid = character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 and not IsTeammate(player)
        
        if isValid then
            local hrp = character.HumanoidRootPart
            local distance3D = (Camera.CFrame.Position - hrp.Position).Magnitude
            
            if Settings.ESP_Chams then
                highlight.Adornee = character
                highlight.FillColor = Settings.ESP_ChamsColor
                highlight.Enabled = true
            else
                highlight.Enabled = false
            end
            
            if Settings.ESP_Enabled and distance3D <= Settings.ESP_MaxDistance then
                local humanoid = character.Humanoid
                local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                if not onScreen then
                    boxOutline.Visible=false; box.Visible=false; healthBg.Visible=false; healthFill.Visible=false; nameText.Visible=false; distText.Visible=false
                    return
                end
                
                local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
                for _, obj in pairs(character:GetChildren()) do
                    if obj:IsA("BasePart") then
                        local corners = getPartCorners(obj)
                        for _, corner in ipairs(corners) do
                            local screenPos = Camera:WorldToViewportPoint(corner)
                            if screenPos.X < minX then minX = screenPos.X end
                            if screenPos.X > maxX then maxX = screenPos.X end
                            if screenPos.Y < minY then minY = screenPos.Y end
                            if screenPos.Y > maxY then maxY = screenPos.Y end
                        end
                    end
                end
                
                local pad = 2; local width = (maxX - minX) + (pad * 2); local height = (maxY - minY) + (pad * 2)
                local posX, posY = minX - pad, minY - pad; local centerX = posX + (width / 2)
                
                if Settings.ESP_Box then
                    boxOutline.Size, boxOutline.Position, boxOutline.Visible = Vector2.new(width, height), Vector2.new(posX, posY), true
                    box.Size, box.Position, box.Color, box.Visible = Vector2.new(width, height), Vector2.new(posX, posY), Settings.ESP_BoxColor, true
                else boxOutline.Visible, box.Visible = false, false end
                
                if Settings.ESP_Name then
                    nameText.Text, nameText.Position, nameText.Color, nameText.Visible = player.DisplayName, Vector2.new(centerX, posY - 20), Settings.ESP_NameColor, true
                else nameText.Visible = false end
                
                if Settings.ESP_Distance then
                    distText.Text, distText.Position, distText.Color, distText.Visible = math.floor(distance3D).."s", Vector2.new(centerX, posY + height + 4), Settings.ESP_DistanceColor, true
                else distText.Visible = false end
                
                if Settings.ESP_Health then
                    healthBg.Size, healthBg.Position, healthBg.Visible = Vector2.new(4, height + 2), Vector2.new(posX - 7, posY - 1), true
                    local hpPct = humanoid.Health / humanoid.MaxHealth; local fillHeight = height * hpPct
                    healthFill.Size, healthFill.Position = Vector2.new(2, fillHeight), Vector2.new(posX - 6, (posY + height) - fillHeight)
                    healthFill.Color, healthFill.Visible = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(0, 255, 0), hpPct), true
                else healthBg.Visible, healthFill.Visible = false, false end
            else
                boxOutline.Visible=false; box.Visible=false; healthBg.Visible=false; healthFill.Visible=false; nameText.Visible=false; distText.Visible=false
            end
        else
            highlight.Enabled = false
            boxOutline.Visible=false; box.Visible=false; healthBg.Visible=false; healthFill.Visible=false; nameText.Visible=false; distText.Visible=false
        end
    end)
end

for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer then createPlayerESP(player) end end
Players.PlayerAdded:Connect(function(player) createPlayerESP(player) end)

do
    local fl, fc, fa = math.floor, math.clamp, math.abs
    local clock, delay, spawn, fmt = os.clock, task.delay, task.spawn, string.format
    local function safe(f, ...) local ok, r = pcall(f, ...); return ok and r end

    local HM_dur = 2.5
    local HM_color = Color3.new(1,1,1)
    local HM_kill = Color3.fromRGB(220,80,80)
    local HM_size = 12
    local HM_thick = 2

    local conns = {}
    local function keep(c) conns[#conns+1] = c; return c end

    local function upd(c)
        if c then spawn(function() c:WaitForChild("Humanoid", 15) end) end
    end
    keep(LocalPlayer.CharacterAdded:Connect(upd))

    local shots = {}
    local function isOurs(pos)
        local now = clock()
        for i = #shots, 1, -1 do
            local s = shots[i]
            if now - s.t > 6 then table.remove(shots, i)
            else
                local v = pos - s.o
                local a = v:Dot(s.d)
                if a > 0 and (v - s.d * a).Magnitude <= fc(2.25 + a * 0.002, 2.25, 8) then return true end
            end
        end
    end

    if hookmetamethod and getnamecallmethod and newcclosure and checkcaller then
        local old
        old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            if getnamecallmethod() == "Raycast" and self == workspace and not checkcaller() then
                local o, d = ...
                if typeof(o) == "Vector3" and typeof(d) == "Vector3" and d.Magnitude > 50 then
                    local cam = workspace.CurrentCamera
                    if cam and (o - cam.CFrame.Position).Magnitude <= 5 then
                        shots[#shots+1] = { t = clock(), o = o, d = d.Unit }
                        if #shots > 25 then table.remove(shots, 1) end
                    end
                end
            end
            return old(self, ...)
        end))
    end

    local DrawingOK = safe(function() local t = Drawing.new("Line"); t:Remove() end)
    local hmQ = {}
    local DIRS = {{1,1},{-1,1},{1,-1},{-1,-1}}
    local function spawnHM(pos, kill)
        if not DrawingOK then return end
        local ls = {}
        for i = 1, 4 do
            local l = Drawing.new("Line")
            l.Visible, l.Thickness, l.ZIndex = false, HM_thick, 5
            ls[i] = l
        end
        hmQ[#hmQ+1] = { p = pos, b = clock(), k = kill, l = ls }
    end
    
    local function processHM()
        if not DrawingOK or #hmQ == 0 then return end
        local cam, now = workspace.CurrentCamera, clock()
        for i = #hmQ, 1, -1 do
            local m = hmQ[i]
            local age = now - m.b
            if age > HM_dur then
                for _, l in ipairs(m.l) do safe(function() l:Remove() end) end
                table.remove(hmQ, i)
            elseif not Settings.Events_HitLogs then
                for _, l in ipairs(m.l) do l.Visible = false end
            elseif cam and m.p then
                local sp, vis = cam:WorldToViewportPoint(m.p)
                local a = 1 - age / HM_dur
                local c = m.k and HM_kill or HM_color
                for j = 1, 4 do
                    local l, d = m.l[j], DIRS[j]
                    l.Visible, l.Transparency, l.Color, l.Thickness = vis, a, c, HM_thick
                    l.From = Vector2.new(sp.X + d[1]*HM_size*0.3, sp.Y + d[2]*HM_size*0.3)
                    l.To = Vector2.new(sp.X + d[1]*HM_size, sp.Y + d[2]*HM_size)
                end
            end
        end
    end

    local gui = Instance.new("ScreenGui")
    gui.Name, gui.ResetOnSpawn, gui.IgnoreGuiInset, gui.DisplayOrder = "Stealth_HitLogs", false, true, 9998
    ProtectGui(gui)
    safe(function() gui.Parent = CoreGui end)
    if not gui.Parent then safe(function() gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end) end

    local holder = Instance.new("Frame")
    holder.BackgroundTransparency, holder.BorderSizePixel = 1, 0
    holder.AutomaticSize, holder.Size = Enum.AutomaticSize.XY, UDim2.fromOffset(0,0)
    holder.AnchorPoint, holder.Position = Vector2.new(0.5, 0), UDim2.new(0.5, 0, 0.62, 0)
    holder.Parent = gui
    Instance.new("UIListLayout", holder).SortOrder = Enum.SortOrder.LayoutOrder

    local order = 0
    local lastLog = {}
    local function showLog(name, part, dmg, hp, killed)
        local now, hpV = clock(), tonumber(hp) or 0
        local prev = lastLog[name]
        if prev and ((hpV <= 0 and prev.h <= 0 and now - prev.t <= 2)
            or (now - prev.t <= 0.35 and fa(prev.h - hpV) <= 0.001)) then return end
        lastLog[name] = { t = now, h = hpV }
        
        local label = Instance.new("TextLabel")
        order = order + 1
        label.LayoutOrder, label.Parent = -order, holder
        label.BackgroundTransparency, label.BorderSizePixel, label.AutomaticSize = 1, 0, Enum.AutomaticSize.X
        label.Size, label.Font, label.TextSize = UDim2.fromOffset(0,18), Enum.Font.Code, 13
        
        local msgColor = killed and "#ff3737" or "#b0b0d1"
        label.TextColor3 = Color3.new(1,1,1)
        label.TextStrokeColor3, label.TextStrokeTransparency, label.TextTransparency = Color3.new(0,0,0), 1, 1
        label.RichText, label.TextXAlignment, label.ZIndex = 10
        label.Text = fmt('[ <font color="#ffffff">Stealth</font><font color="#c724b1">.xyz</font> ] <font color="%s">Hit %s in the %s for %s damage (%s health remaining)</font>', msgColor, name, part, dmg, hp)
        
        TweenService:Create(label, TweenInfo.new(0.18), { TextTransparency = 0, TextStrokeTransparency = 0.35 }):Play()
        delay(5, function()
            if not label.Parent then return end
            local tw = TweenService:Create(label, TweenInfo.new(0.35), { TextTransparency = 1, TextStrokeTransparency = 1 })
            tw:Play(); tw.Completed:Wait(); safe(function() label:Destroy() end)
        end)
    end

    local lastHit, deathSeen = {}, setmetatable({}, {__mode="k"})
    local dmgConns, deathConns, remoteConns, humHp = {}, {}, {}, {}
    local recentDmg = setmetatable({}, {__mode="k"})

    local function onDamaged(plr, char, dmg, hp)
        if dmg <= 0.01 or plr == LocalPlayer then return end
        local now = clock()
        local rp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
        if not (rp and isOurs(rp.Position)) then return end
        local prev = recentDmg[plr]
        if prev and now - prev.t <= 0.2 and fa(prev.h - hp) <= 0.001 and fa(prev.d - dmg) <= 0.001 then return end
        recentDmg[plr] = { t = now, h = hp, d = dmg }
        local part = char:FindFirstChild("HeadHitbox") or char:FindFirstChild("Head") or rp
        lastHit[plr] = now
        if Settings.Events_HitLogs then 
            spawnHM(part.Position, false)
            showLog(plr.DisplayName, part.Name, fmt("%.0f", dmg), fmt("%.0f", hp), hp <= 0)
        end
    end

    local function onDied(plr, char)
        local now = clock()
        if deathSeen[plr] and now - deathSeen[plr] <= 1.5 then return end
        deathSeen[plr] = now
        if lastHit[plr] and now - lastHit[plr] <= 6 and Settings.Events_HitLogs then
            local rp = char and char:FindFirstChild("HumanoidRootPart")
            if rp then spawnHM(rp.Position, true) end
        end
        lastHit[plr] = nil
    end

    spawn(function()
        local function hook(remote, fn)
            if remote and remote:IsA("RemoteEvent") then
                local c = safe(function() return remote.OnClientEvent:Connect(fn) end)
                if c then remoteConns[#remoteConns+1] = c end
            end
        end
        local g = ReplicatedStorage:FindFirstChild("Gun")
        local gr = g and g:FindFirstChild("Remotes")
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        hook(gr and gr:FindFirstChild("Hit"), function(...)
            local args = table.pack(...)
            local vChar
            for i = 1, args.n do
                local v = args[i]
                if typeof(v) == "Instance" then
                    if v:IsA("BasePart") then vChar = vChar or v:FindFirstAncestorOfClass("Model")
                    elseif v:IsA("Model") then vChar = vChar or v end
                end
            end
            local plr = vChar and Players:GetPlayerFromCharacter(vChar)
            if plr and plr ~= LocalPlayer then
                local rp = vChar:FindFirstChild("HumanoidRootPart")
                if rp and isOurs(rp.Position) then lastHit[plr] = clock() end
            end
        end)
        hook(r and r:FindFirstChild("DealDamage"), function(victim)
            local vChar = typeof(victim) == "Instance"
                and (victim:IsA("Model") and victim or (victim:IsA("BasePart") and victim:FindFirstAncestorOfClass("Model")))
            local plr = vChar and Players:GetPlayerFromCharacter(vChar)
            if plr and plr ~= LocalPlayer then
                local rp = vChar:FindFirstChild("HumanoidRootPart")
                if rp and isOurs(rp.Position) then lastHit[plr] = clock() end
            end
        end)
    end)

    local function trackPlayer(plr)
        if plr == LocalPlayer then return end
        local function onChar(char)
            spawn(function()
                local hum = char:WaitForChild("Humanoid", 10)
                if not hum then return end
                if deathConns[hum] then safe(function() deathConns[hum]:Disconnect() end) end
                deathConns[hum] = hum.Died:Connect(function() onDied(plr, char) end)
                if dmgConns[hum] then safe(function() dmgConns[hum]:Disconnect() end) end
                humHp[hum] = hum.Health
                dmgConns[hum] = hum.HealthChanged:Connect(function(n)
                    local p = humHp[hum] or n
                    humHp[hum] = n
                    if n < p - 0.05 then onDamaged(plr, char, p - n, n) end
                end)
            end)
        end
        if plr.Character then onChar(plr.Character) end
        keep(plr.CharacterAdded:Connect(onChar))
    end

    for _, p in ipairs(Players:GetPlayers()) do trackPlayer(p) end
    keep(Players.PlayerAdded:Connect(trackPlayer))

    local renderConn = RunService.RenderStepped:Connect(processHM)

    getgenv().STEALTH_HITLOGS_UNLOAD = function()
        safe(function() gui:Destroy() end)
        for _, c in ipairs(remoteConns) do safe(function() c:Disconnect() end) end
        for h, c in pairs(dmgConns) do safe(function() c:Disconnect() end); dmgConns[h] = nil end
        for h, c in pairs(deathConns) do safe(function() c:Disconnect() end); deathConns[h] = nil end
        for _, m in ipairs(hmQ) do for _, l in ipairs(m.l) do safe(function() l:Remove() end) end end
        for _, c in pairs(conns) do safe(function() c:Disconnect() end) end
        safe(function() renderConn:Disconnect() end)
    end
end

local WatermarkGui = create("ScreenGui", { Name = "StealthWatermark", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Global, IgnoreGuiInset = true, Parent = PlayerGui })
ProtectGui(WatermarkGui)

local WMOuter = create("Frame", { AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 10), Size = UDim2.fromOffset(10, 26), BackgroundColor3 = Colors.Background, BorderSizePixel = 0, Parent = WatermarkGui })
addStroke(WMOuter, Colors.OuterBorder, 1)

local WMInner = create("Frame", { Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), BackgroundColor3 = Colors.Background, BorderSizePixel = 0, Parent = WMOuter })
addStroke(WMInner, Colors.InnerBorder, 1)

create("Frame", { Position = UDim2.fromOffset(0, 4), Size = UDim2.new(0, 2, 1, -8), BackgroundColor3 = Colors.Accent, BorderSizePixel = 0, Parent = WMInner })
local WMLabel = create("TextLabel", { Position = UDim2.fromOffset(10, 0), Size = UDim2.new(0, 0, 1, 0), BackgroundTransparency = 1, Font = Enum.Font.Code, Text = "", TextColor3 = Colors.Text, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = WMInner })

local fps, frameCount, lastTime = 0, 0, tick()
RunService.RenderStepped:Connect(function()
    frameCount += 1; local now = tick()
    if now - lastTime >= 0.5 then fps = math.floor(frameCount / (now - lastTime) + 0.5); frameCount = 0; lastTime = now end
end)

local function getPing() local ok, value = pcall(function() return Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end); return (ok and value) and math.floor(value + 0.5) or 0 end

task.spawn(function()
    while task.wait(0.25) do 
        WMLabel.Text = "Stealth.xyz | " .. os.date("%H:%M:%S") .. " | " .. fps .. " FPS | " .. getPing() .. " ms"
        local w = WMLabel.TextBounds.X
        WMOuter.Size = UDim2.fromOffset(w + 20 + 6, 26)
        WMLabel.Size = UDim2.new(0, w, 1, 0)
    end
end)

local dragToggle, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true; dragStart = input.Position; startPos = Outer.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragToggle = false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Outer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Insert then ScreenGui.Enabled = not ScreenGui.Enabled end
end)
    
