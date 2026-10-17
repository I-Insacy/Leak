if getgenv().OverflowUnload then
    pcall(getgenv().OverflowUnload)
end
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NIcoGabrielRealYtr/Aether.lua-Library/refs/heads/main/Source"))() -- https://pastebin.com/raw/w9gpgvjj
Library.Directory = "Overflow.gg"
if makefolder and isfolder then
    for _, folder in ipairs({"", "/Configs", "/Themes", "/Fonts"}) do
        if not isfolder("Overflow.gg" .. folder) then
            pcall(function() makefolder("Overflow.gg" .. folder) end)
        end
    end
    if not isfolder("Overflow.gg") then
        pcall(function() makefolder("Overflow.gg") end)
    end
end
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local env = (type(getfenv) == "function" and getfenv()) or {}
local genv = (type(getgenv) == "function" and getgenv()) or {}
local function fetchGlobal(name)
    return rawget(genv, name) or rawget(env, name) or _G[name]
end
local getclipboard = fetchGlobal("getclipboard") or fetchGlobal("get_clipboard") or fetchGlobal("readclipboard") or fetchGlobal("clipboardget")
local setclipboard = fetchGlobal("setclipboard") or fetchGlobal("set_clipboard") or fetchGlobal("writeclipboard") or fetchGlobal("toclipboard") or fetchGlobal("clipboardset")
local clipObj = fetchGlobal("clipboard")
if type(clipObj) == "table" and not setclipboard then
    if type(clipObj.set) == "function" then setclipboard = function(t) return clipObj.set(t) end end
end
if type(clipObj) == "table" and not getclipboard then
    if type(clipObj.get) == "function" then getclipboard = function() return clipObj.get() end end
    if type(clipObj.read) == "function" then getclipboard = function() return clipObj.read() end end
end
local isKeyFunc = fetchGlobal("iskeypressed") or fetchGlobal("iskeydown") or fetchGlobal("is_key_down") or fetchGlobal("is_key_pressed") or fetchGlobal("getkeystate") or fetchGlobal("isbuttonpressed") or fetchGlobal("getkeypressed") or fetchGlobal("keypressed") or fetchGlobal("getkeypress") or fetchGlobal("syn_input_is_key_down") or fetchGlobal("input_is_key_down") or fetchGlobal("IsKeyPressed") or fetchGlobal("IsKeyDown") or fetchGlobal("isKeyHeld") or fetchGlobal("keyheld") or fetchGlobal("is_button_pressed") or fetchGlobal("input_key_down")
if not isKeyFunc then
    local synObj = fetchGlobal("syn")
    if type(synObj) == "table" and type(synObj.is_key_down) == "function" then
        isKeyFunc = synObj.is_key_down
    end
end
local KeyDisplayMap = {
    [Enum.UserInputType.MouseButton1] = "MB1",
    [Enum.UserInputType.MouseButton2] = "MB2",
    [Enum.UserInputType.MouseButton3] = "MB3",
    [Enum.KeyCode.LeftShift] = "LS",
    [Enum.KeyCode.RightShift] = "RS",
    [Enum.KeyCode.LeftControl] = "LC",
    [Enum.KeyCode.RightControl] = "RC",
    [Enum.KeyCode.LeftAlt] = "LA",
    [Enum.KeyCode.RightAlt] = "RA",
    [Enum.KeyCode.Insert] = "INS",
    [Enum.KeyCode.Delete] = "DEL",
    [Enum.KeyCode.Home] = "HOME",
    [Enum.KeyCode.End] = "END",
    [Enum.KeyCode.PageUp] = "PGUP",
    [Enum.KeyCode.PageDown] = "PGDN",
    [Enum.KeyCode.Backspace] = "BS",
    [Enum.KeyCode.Return] = "Ent",
    [Enum.KeyCode.Tab] = "TAB",
    [Enum.KeyCode.CapsLock] = "CAPS",
    [Enum.KeyCode.Space] = "SPC",
    [Enum.KeyCode.Escape] = "ESC",
    [Enum.KeyCode.Tilde] = "~",
    [Enum.KeyCode.Backquote] = "`",
    [Enum.KeyCode.Minus] = "-",
    [Enum.KeyCode.Equals] = "=",
    [Enum.KeyCode.LeftBracket] = "[",
    [Enum.KeyCode.RightBracket] = "]",
    [Enum.KeyCode.BackSlash] = "\\",
    [Enum.KeyCode.Semicolon] = ";",
    [Enum.KeyCode.Quote] = "'",
    [Enum.KeyCode.Comma] = ",",
    [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Slash] = "/",
    [Enum.KeyCode.KeypadZero] = "Num0",
    [Enum.KeyCode.KeypadOne] = "Num1",
    [Enum.KeyCode.KeypadTwo] = "Num2",
    [Enum.KeyCode.KeypadThree] = "Num3",
    [Enum.KeyCode.KeypadFour] = "Num4",
    [Enum.KeyCode.KeypadFive] = "Num5",
    [Enum.KeyCode.KeypadSix] = "Num6",
    [Enum.KeyCode.KeypadSeven] = "Num7",
    [Enum.KeyCode.KeypadEight] = "Num8",
    [Enum.KeyCode.KeypadNine] = "Num9",
    [Enum.KeyCode.KeypadPlus] = "Num+",
    [Enum.KeyCode.KeypadMinus] = "Num-",
    [Enum.KeyCode.KeypadMultiply] = "Num*",
    [Enum.KeyCode.KeypadDivide] = "Num/",
    [Enum.KeyCode.KeypadEnter] = "NumEnt",
    [Enum.KeyCode.KeypadPeriod] = "Num.",
}
local function formatKeyName(key)
    if key == nil or key == "NONE" or key == "" then return "NONE" end
    if type(key) == "table" and key.Key then key = key.Key end
    if KeyDisplayMap[key] then return KeyDisplayMap[key] end
    local str = tostring(key)
    if str:find("MouseButton1") or str == "MB1" or str == "M1" then return "MB1" end
    if str:find("MouseButton2") or str == "MB2" or str == "M2" then return "MB2" end
    if str:find("MouseButton3") or str == "MB3" or str == "M3" then return "MB3" end
    if str:find("MouseButton4") or str == "MB4" or str == "M4" or str == "0x05" or str == "XBUTTON1" then return "MB4" end
    if str:find("MouseButton5") or str == "MB5" or str == "M5" or str == "0x06" or str == "XBUTTON2" then return "MB5" end
    str = str:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("KeyCode%.", ""):gsub("UserInputType%.", "")
    return str
end
local inputState = {
    keys = {},
    mouseButtons = {},
    custom = { MB4 = false, MB5 = false },
}
local mouseBackEnum = nil
pcall(function() mouseBackEnum = Enum.KeyCode.MouseBackButton end)
local function checkInputMatch(input, targetKey)
    if not targetKey or targetKey == "NONE" or targetKey == "" then return false end
    if type(targetKey) == "table" and targetKey.Key then
        targetKey = targetKey.Key
    end
    if typeof(targetKey) == "EnumItem" then
        if input.KeyCode == targetKey and targetKey ~= Enum.KeyCode.Unknown then
            return true
        end
        if input.UserInputType == targetKey then
            return true
        end
    end
    local targetStr = tostring(targetKey):gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):upper()
    if targetStr == "ALT" or targetStr == "LEFTALT" or targetStr == "RIGHTALT" or targetStr == "LA" or targetStr == "RA" then
        if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
            return true
        end
    end
    if targetStr == "CTRL" or targetStr == "CONTROL" or targetStr == "LEFTCONTROL" or targetStr == "RIGHTCONTROL" or targetStr == "LC" or targetStr == "RC" then
        if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
            return true
        end
    end
    if targetStr == "SHIFT" or targetStr == "LEFTSHIFT" or targetStr == "RIGHTSHIFT" or targetStr == "LS" or targetStr == "RS" then
        if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
            return true
        end
    end
    if targetStr == "MB1" or targetStr == "M1" or targetStr == "MOUSEBUTTON1" then
        return input.UserInputType == Enum.UserInputType.MouseButton1
    elseif targetStr == "MB2" or targetStr == "M2" or targetStr == "MOUSEBUTTON2" then
        return input.UserInputType == Enum.UserInputType.MouseButton2
    elseif targetStr == "MB3" or targetStr == "M3" or targetStr == "MOUSEBUTTON3" then
        return input.UserInputType == Enum.UserInputType.MouseButton3
    elseif targetStr == "MB4" or targetStr == "M4" or targetStr == "MOUSEBUTTON4" or targetStr == "XBUTTON1" then
        if input.UserInputType.Name:upper():find("MOUSEBUTTON4") or (input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name:upper():find("MOUSE4")) or (input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name:upper():find("XBUTTON1")) then
            return true
        end
    elseif targetStr == "MB5" or targetStr == "M5" or targetStr == "MOUSEBUTTON5" or targetStr == "XBUTTON2" then
        if input.UserInputType.Name:upper():find("MOUSEBUTTON5") or (input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name:upper():find("MOUSE5")) or (input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name:upper():find("XBUTTON2")) then
            return true
        end
    end
    if input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name:upper() == targetStr then
        return true
    end
    if input.UserInputType.Name:upper() == targetStr then
        return true
    end
    return false
end
local function isInputHeld(targetKey)
    if not targetKey or targetKey == "NONE" or targetKey == "" then return false end
    if type(targetKey) == "table" and targetKey.Key then
        targetKey = targetKey.Key
    end
    local keyStr = tostring(targetKey):gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):upper()
    if keyStr == "ALT" or keyStr == "LEFTALT" or keyStr == "RIGHTALT" or keyStr == "LA" or keyStr == "RA" then
        local ok1, p1 = pcall(function() return UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) end)
        if ok1 and p1 then return true end
        local ok2, p2 = pcall(function() return UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) end)
        if ok2 and p2 then return true end
        if inputState.keys[Enum.KeyCode.LeftAlt] or inputState.keys[Enum.KeyCode.RightAlt] then return true end
    end
    if keyStr == "CTRL" or keyStr == "CONTROL" or keyStr == "LEFTCONTROL" or keyStr == "RIGHTCONTROL" or keyStr == "LC" or keyStr == "RC" then
        local ok1, p1 = pcall(function() return UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) end)
        if ok1 and p1 then return true end
        local ok2, p2 = pcall(function() return UserInputService:IsKeyDown(Enum.KeyCode.RightControl) end)
        if ok2 and p2 then return true end
        if inputState.keys[Enum.KeyCode.LeftControl] or inputState.keys[Enum.KeyCode.RightControl] then return true end
    end
    if keyStr == "SHIFT" or keyStr == "LEFTSHIFT" or keyStr == "RIGHTSHIFT" or keyStr == "LS" or keyStr == "RS" then
        local ok1, p1 = pcall(function() return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) end)
        if ok1 and p1 then return true end
        local ok2, p2 = pcall(function() return UserInputService:IsKeyDown(Enum.KeyCode.RightShift) end)
        if ok2 and p2 then return true end
        if inputState.keys[Enum.KeyCode.LeftShift] or inputState.keys[Enum.KeyCode.RightShift] then return true end
    end
    if targetKey == Enum.UserInputType.MouseButton1 or keyStr == "MB1" or keyStr == "M1" or keyStr == "MOUSEBUTTON1" then
        local ok, pressed = pcall(function() return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) end)
        if ok and pressed then return true end
        if isKeyFunc and pcall(function() return isKeyFunc(0x01) end) and isKeyFunc(0x01) then return true end
        return inputState.mouseButtons[Enum.UserInputType.MouseButton1] == true
    end
    if targetKey == Enum.UserInputType.MouseButton2 or keyStr == "MB2" or keyStr == "M2" or keyStr == "MOUSEBUTTON2" then
        local ok, pressed = pcall(function() return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) end)
        if ok and pressed then return true end
        if isKeyFunc and pcall(function() return isKeyFunc(0x02) end) and isKeyFunc(0x02) then return true end
        return inputState.mouseButtons[Enum.UserInputType.MouseButton2] == true
    end
    if targetKey == Enum.UserInputType.MouseButton3 or keyStr == "MB3" or keyStr == "M3" or keyStr == "MOUSEBUTTON3" then
        local ok, pressed = pcall(function() return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3) end)
        if ok and pressed then return true end
        if isKeyFunc and pcall(function() return isKeyFunc(0x04) end) and isKeyFunc(0x04) then return true end
        return inputState.mouseButtons[Enum.UserInputType.MouseButton3] == true
    end
    if keyStr == "MB4" or keyStr == "M4" or keyStr == "MOUSEBUTTON4" or keyStr == "XBUTTON1" then
        if isKeyFunc and pcall(function() return isKeyFunc(0x05) end) and isKeyFunc(0x05) then return true end
        return inputState.custom["MB4"] == true
    end
    if keyStr == "MB5" or keyStr == "M5" or keyStr == "MOUSEBUTTON5" or keyStr == "XBUTTON2" then
        if isKeyFunc and pcall(function() return isKeyFunc(0x06) end) and isKeyFunc(0x06) then return true end
        return inputState.custom["MB5"] == true
    end
    if typeof(targetKey) == "EnumItem" and targetKey.EnumType == Enum.KeyCode and targetKey ~= Enum.KeyCode.Unknown then
        local ok, pressed = pcall(function() return UserInputService:IsKeyDown(targetKey) end)
        if ok and pressed then return true end
        return inputState.keys[targetKey] == true
    end
    for code, pressed in pairs(inputState.keys) do
        if pressed and code.Name:upper() == keyStr then
            return true
        end
    end
    return false
end
Library.AddKeyPicker = function(self, Data)
    Data = Data or {}
    local Cfg = {
        Text = Data.Text or Data.Name or Data.Title or "Keybind",
        Flag = Data.Flag or Data.Text or Data.Name or Data.Title or "Flag",
        Callback = Data.Callback or function() end,
        ShowInList = (Data.ShowInList ~= nil and Data.ShowInList) or true,
        Key = Data.Key or Data.Default or nil,
        Mode = Data.Mode or "Toggle",
        Active = Data.Active or false,
        Open = false,
        Tweening = false,
        BindingActive = false,
        Items = {},
        Debounce = false,
        Set = function(...) end,
        SetMode = function(...) end,
        NewKey = function(...) end,
        SetVisible = function(...) end,
    }
    Library.Flags[Cfg.Flag] = {
        Mode = Cfg.Mode,
        Key = Cfg.Key,
        Active = Cfg.Active,
        active = Cfg.Active,
    }
    local Items = Cfg.Items
    do
        Items.Object = Library:Create("Frame", {
            Parent = self.Items.Elements.Instance,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 16),
            BorderSizePixel = 0,
        })
        Items.Title = Library:Create("TextLabel", {
            FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
            TextColor3 = Color3.fromRGB(252, 252, 252),
            Text = Cfg.Text,
            Parent = Items.Object.Instance,
            AnchorPoint = Vector2.new(0, 0.5),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, -1, 0.5, 0),
            BorderSizePixel = 0,
            ZIndex = 2,
        })
        Items.Holder = Library:Create("Frame", {
            Parent = Items.Object.Instance,
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(0, 0, 1, 0),
            BorderSizePixel = 0,
        })
        Library:Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Parent = Items.Holder.Instance,
            Padding = UDim.new(0, 13),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })
        Items.Holder2 = Library:Create("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            Parent = Items.Holder.Instance,
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(0, 34, 0, 16),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = Color3.fromRGB(24, 24, 24),
        }):Themify("Other", "BackgroundColor3")
        Library:Create("UIStroke", {
            Color = Color3.fromRGB(23, 24, 27),
            Parent = Items.Holder2.Instance,
        }):Themify("Inline", "Color")
        Library:Create("UIPadding", {
            Parent = Items.Holder2.Instance,
            PaddingRight = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8),
        })
        Library:Create("UICorner", {
            Parent = Items.Holder2.Instance,
            CornerRadius = UDim.new(0, 5),
        })
        Items.Value = Library:Create("TextLabel", {
            FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
            TextColor3 = Color3.fromRGB(252, 252, 252),
            Text = "Key: " .. formatKeyName(Cfg.Key),
            Parent = Items.Holder2.Instance,
            AnchorPoint = Vector2.new(0, 0.5),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, -1, 0.5, 0),
            BorderSizePixel = 0,
            ZIndex = 2,
        })
        do
            local Section = Library:AddSection({ Text = "Settings" })
            Items.Dropdown = Section:AddDropdown({
                Text = "Mode",
                Flag = Cfg.Flag .. "_MODE",
                Options = { "Toggle", "Hold", "Always" },
                Callback = function(Option)
                    if Cfg.Debounce then return end
                    if Cfg.Set then Cfg.Set(Option) end
                end,
            })
            Items.Mouse = Section:AddDropdown({
                Text = "Mouse",
                Flag = Cfg.Flag .. "_MOUSE",
                Options = { "None", "MB4", "MB5" },
                Callback = function(Option)
                    if Cfg.Debounce then return end
                    if Option ~= "None" and Cfg.Set then Cfg.Set(Option) end
                end,
            })
            Items.Section = Section.Items.Section
            Items.Section.Instance.Parent = Library.Items.Instance
            Items.Section.Instance.Visible = false
            Items.Section:Reparent(Library.Elements.Instance)
        end
    end
    local KeybindListElement = Library:AddHotKey({ Key = formatKeyName(Cfg.Key), Name = Cfg.Text })
    Cfg.SetMode = function(Mode)
        Cfg.Mode = Mode
        if Mode == "Always" then
            Cfg.Set(true)
        elseif Mode == "Hold" then
            Cfg.Set(false)
        end
        Library.Flags[Cfg.Flag].Mode = Mode
    end
    Cfg.Set = function(input)
        if type(input) == "boolean" then
            Cfg.Active = input
            if Cfg.Mode == "Always" then Cfg.Active = true end
        elseif typeof(input) == "EnumItem" then
            if input == Enum.KeyCode.Escape then
                Cfg.Key = "NONE"
            else
                Cfg.Key = input
            end
        elseif type(input) == "string" then
            if table.find({ "Toggle", "Hold", "Always" }, input) then
                if input == "Always" then Cfg.Active = true end
                Cfg.Mode = input
                Cfg.SetMode(Cfg.Mode)
            elseif input == "Escape" or input == "ESC" then
                Cfg.Key = "NONE"
            else
                Cfg.Key = input
            end
        elseif type(input) == "table" then
            local k = input.Key
            if k == Enum.KeyCode.Escape or k == "Escape" or k == "ESC" then
                Cfg.Key = "NONE"
            elseif k ~= nil then
                Cfg.Key = k
            end
            if input.Active ~= nil then Cfg.Active = input.Active end
            if input.Mode then Cfg.SetMode(input.Mode) end
        end
        local displayKey = formatKeyName(Cfg.Key)
        Items.Value.Instance.Text = string.format("Key: %s", displayKey)
        Cfg.Debounce = true
        if Items.Dropdown and Items.Dropdown.Set then
            Items.Dropdown.Set(Cfg.Mode)
        end
        if Items.Mouse and Items.Mouse.Set then
            if displayKey == "MB4" or displayKey == "MB5" then
                Items.Mouse.Set(displayKey)
            else
                Items.Mouse.Set("None")
            end
        end
        Cfg.Debounce = false
        KeybindListElement:ChangeKey(displayKey)
        KeybindListElement:SetEnabled(Cfg.Active)
        Library.Flags[Cfg.Flag] = {
            Mode = Cfg.Mode,
            Key = Cfg.Key,
            Active = Cfg.Active,
            active = Cfg.Active,
        }
        pcall(Cfg.Callback, Cfg.Active, Cfg.Key)
    end
    Cfg.NewKey = function()
        if Cfg.BindingActive then return end
        Cfg.BindingActive = true
        Items.Value.Instance.Text = "Key: ..."
        local connection = nil
        local polling = true
        local function finalizeKey(selectedKey)
            if not Cfg.BindingActive then return end
            Cfg.BindingActive = false
            polling = false
            if connection and connection.Disconnect then
                pcall(function() connection:Disconnect() end)
            end
            Cfg.Set(selectedKey)
        end
        connection = UserInputService.InputBegan:Connect(function(input)
            if not Cfg.BindingActive then return end
            if input.KeyCode == Enum.KeyCode.Escape then
                finalizeKey("NONE")
            elseif input.KeyCode ~= Enum.KeyCode.Unknown then
                finalizeKey(input.KeyCode)
            elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                finalizeKey(Enum.UserInputType.MouseButton2)
            elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
                finalizeKey(Enum.UserInputType.MouseButton3)
            end
        end)
        task.spawn(function()
            while Cfg.BindingActive and polling do
                task.wait(0.01)
                if not Cfg.BindingActive then break end
                if isKeyFunc then
                    if pcall(function() return isKeyFunc(0x05) end) and isKeyFunc(0x05) then
                        finalizeKey("MB4")
                        break
                    elseif pcall(function() return isKeyFunc(0x06) end) and isKeyFunc(0x06) then
                        finalizeKey("MB5")
                        break
                    elseif pcall(function() return isKeyFunc(0x04) end) and isKeyFunc(0x04) then
                        finalizeKey(Enum.UserInputType.MouseButton3)
                        break
                    elseif pcall(function() return isKeyFunc(0x02) end) and isKeyFunc(0x02) then
                        finalizeKey(Enum.UserInputType.MouseButton2)
                        break
                    end
                end
            end
        end)
    end
    Cfg.SetVisible = function(bool)
        if Cfg.Tweening then return end
        task.wait()
        local Position = Items.Holder2.Instance.AbsolutePosition
        Items.Section:TweenDescendants(bool, Cfg)
        Items.Section:Tween({ Position = UDim2.fromOffset(Position.X + 1, Position.Y + 80) })
    end
    Items.Holder2:OnClick(function()
        Cfg.NewKey()
    end)
    Items.Dropdown.Items.DropdownHolder:OnClick(function()
        task.spawn(function()
            Cfg.Tweening = true
            task.wait()
            Cfg.Tweening = false
        end)
    end)
    Items.Section:OutsideClick(Cfg)
    Library:Connect(Items.Holder2.Instance.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            if Cfg.BindingActive then
                Cfg.Set(Enum.UserInputType.MouseButton2)
                Cfg.BindingActive = false
            else
                Cfg.Open = not Cfg.Open
                Cfg.SetVisible(Cfg.Open)
            end
        end
    end)
    Library:Connect(UserInputService.InputBegan, function(input)
        if checkInputMatch(input, Cfg.Key) then
            if Cfg.Mode == "Toggle" then
                Cfg.Active = not Cfg.Active
                Cfg.Set(Cfg.Active)
            elseif Cfg.Mode == "Hold" then
                Cfg.Set(true)
            end
        end
    end)
    Library:Connect(UserInputService.InputEnded, function(input)
        if checkInputMatch(input, Cfg.Key) then
            if Cfg.Mode == "Hold" then
                Cfg.Set(false)
            end
        end
    end)
    local prevMB4 = false
    local prevMB5 = false
    Library:Connect(RunService.Heartbeat, function()
        local m4 = inputState.custom["MB4"] == true
        local m5 = inputState.custom["MB5"] == true
        local keyName = formatKeyName(Cfg.Key)
        if keyName == "MB4" then
            if m4 and not prevMB4 then
                if Cfg.Mode == "Toggle" then
                    Cfg.Active = not Cfg.Active
                    Cfg.Set(Cfg.Active)
                elseif Cfg.Mode == "Hold" then
                    Cfg.Set(true)
                end
            elseif not m4 and prevMB4 and Cfg.Mode == "Hold" then
                Cfg.Set(false)
            end
        elseif keyName == "MB5" then
            if m5 and not prevMB5 then
                if Cfg.Mode == "Toggle" then
                    Cfg.Active = not Cfg.Active
                    Cfg.Set(Cfg.Active)
                elseif Cfg.Mode == "Hold" then
                    Cfg.Set(true)
                end
            elseif not m5 and prevMB5 and Cfg.Mode == "Hold" then
                Cfg.Set(false)
            end
        end
        prevMB4 = m4
        prevMB5 = m5
    end)
    Cfg.Set({ Mode = Cfg.Mode, Active = Cfg.Active, Key = Cfg.Key })
    Library.ConfigFlags[Cfg.Flag] = Cfg.Set
    self.UpdateSection(Items.Object.Instance)
    return setmetatable(Cfg, Library)
end
local originalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Ambient = Lighting.Ambient,
}
local scriptConnections = {}
local globalDrawingPool = {}
local PlayerESP, PlayerESPObjects = {}, {}
local Chams, ChamsObjects = {}, {}
local RemovePlayerESP, RemoveChams
local disableOreESP, disableLootESP, disableBoatESP
local disableFogDelete, disableFullbright, disableTimeChanger, disableSkybox
local disableNoRecoil, stopFly
local flyState = nil
local disableFOVChanger, enableFOVChanger
local fovChangerActive, targetFOV = false, 70
local disableOrbs, refreshOrbs, clearOrbs, updateOrbs, orbsSettings
local viewmodelChamsSettings, enableViewmodelChams, disableViewmodelChams
local viewmodelPosSettings, enableViewmodelPos, disableViewmodelPos
local speedHackSettings, enableSpeedHack, disableSpeedHack
local Window
local morphSettings, applyMorph, removeMorph, disableMorph
local freecamSettings, toggleFreecam, disableFreecam
local thirdPersonSettings, enableThirdPerson, disableThirdPerson, toggleThirdPerson
local aimbotSettings, disableAimbot
local silentAimSettings, enableSilentAim, disableSilentAim
local aimbotFOVCircle, aimbotFOVFill, aimbotTracerLine
local silentAimFOVCircle
local hitboxExpanderSettings, updateHitboxExpander, disableHitboxExpander
local anticheat = ReplicatedStorage:FindFirstChild("AntiCheat")
if anticheat then
    anticheat:Destroy()
end
table.insert(scriptConnections, ReplicatedStorage.ChildAdded:Connect(function(child)
    if child.Name == "AntiCheat" then
        task.wait(0.1)
        child:Destroy()
    end
end))
local function unloadScript()
    PlayerESP.Enabled = false
    for player in pairs(PlayerESPObjects) do
        RemovePlayerESP(player)
    end
    PlayerESPObjects = {}
    Chams.Enabled = false
    for player in pairs(ChamsObjects) do
        RemoveChams(player)
    end
    ChamsObjects = {}
    disableOreESP()
    disableLootESP()
    disableBoatESP()
    disableFogDelete()
    disableFullbright()
    disableTimeChanger()
    disableSkybox()
    disableNoRecoil()
    if disableFOVChanger then disableFOVChanger() end
    if disableFreecam then disableFreecam() end
    if disableThirdPerson then disableThirdPerson() end
    if disableAimbot then disableAimbot() end
    if disableSilentAim then disableSilentAim() end
    if disableHitboxExpander then disableHitboxExpander() end
    if disableOrbs then disableOrbs() end
    if disableViewmodelChams then disableViewmodelChams() end
    if disableSpeedHack then disableSpeedHack() end
    if disableViewmodelPos then disableViewmodelPos() end
    if disableMorph then disableMorph() end
    if flyState and flyState.flying then
        stopFly()
    end
    for _, conn in ipairs(scriptConnections) do
        if conn and conn.Disconnect then
            pcall(function() conn:Disconnect() end)
        end
    end
    scriptConnections = {}
    if Library and Library.Unload then
        pcall(function() Library:Unload() end)
    end
    for _, drawObj in ipairs(globalDrawingPool) do
        if drawObj and drawObj.Remove then
            pcall(function() drawObj.Visible = false; drawObj:Remove() end)
        end
    end
    globalDrawingPool = {}
    getgenv().OverflowUnload = nil
    getgenv().OverflowLibrary = nil
    getgenv().OverflowWindow = nil
end
local layoutFile = "Overflow.gg/layout.json"
local function saveLayout()
    if not writefile then return end
    if not (Library and Library.Window and Library.Window.Items) then return end
    local layout = {}
    if Library.Window.Items.Watermark and Library.Window.Items.Watermark.Instance then
        local wm = Library.Window.Items.Watermark.Instance
        layout.Watermark = { X = wm.Position.X.Offset, Y = wm.Position.Y.Offset }
    end
    if Library.Window.Items.KeybindList and Library.Window.Items.KeybindList.Instance then
        local kl = Library.Window.Items.KeybindList.Instance
        layout.KeybindList = { X = kl.Position.X.Offset, Y = kl.Position.Y.Offset }
    end
    writefile(layoutFile, HttpService:JSONEncode(layout))
end
local function loadLayout()
    if not isfile or not readfile then return end
    if not (Library and Library.Window and Library.Window.Items) then return end
    if not isfile(layoutFile) then return end
    local okRead, content = pcall(readfile, layoutFile)
    if not okRead or type(content) ~= "string" then return end
    local okDecode, data = pcall(function()
        return HttpService:JSONDecode(content)
    end)
    if not okDecode or type(data) ~= "table" then return end
    if data.Watermark and Library.Window.Items.Watermark and Library.Window.Items.Watermark.Instance then
        Library.Window.Items.Watermark.Instance.Position = UDim2.new(0, data.Watermark.X, 0, data.Watermark.Y)
    end
    if data.KeybindList and Library.Window.Items.KeybindList and Library.Window.Items.KeybindList.Instance then
        Library.Window.Items.KeybindList.Instance.Position = UDim2.new(0, data.KeybindList.X, 0, data.KeybindList.Y)
    end
end
local LogoUrl = "https://w0.peakpx.com/wallpaper/714/440/HD-wallpaper-yuno-gaisai-girl-anime-youno-thumbnail.jpg"
local logoPath = "Overflow.gg/logo.png"
local LogoAsset = "rbxassetid://95259225424429"
task.spawn(function()
    if writefile and getcustomasset then
        pcall(function()
            if not isfolder("Overflow.gg") then
                makefolder("Overflow.gg")
            end
            writefile(logoPath, game:HttpGet(LogoUrl))
        end)
        if isfile(logoPath) then
            pcall(function()
                local custom = getcustomasset(logoPath)
                if custom and Library.Window and Library.Window.Items then
                    if Library.Window.Items.Logo and Library.Window.Items.Logo.Instance then
                        Library.Window.Items.Logo.Instance.Image = custom
                    end
                    if Library.Window.Items.WatermarkLogo and Library.Window.Items.WatermarkLogo.Instance then
                        Library.Window.Items.WatermarkLogo.Instance.Image = custom
                    end
                end
            end)
        end
    end
end)
local fogConnections = {}
local function clearFog()
    Lighting.FogStart = 9e9
    Lighting.FogEnd = 9e9
    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmosphere then
        atmosphere.Density = 0
        atmosphere.Haze = 0
    end
end
local function enableFogDelete()
    clearFog()
    table.insert(fogConnections, Lighting.Changed:Connect(clearFog))
    table.insert(fogConnections, Lighting.ChildAdded:Connect(function(child)
        if child:IsA("Atmosphere") then
            task.wait(0.1)
            child.Density = 0
            child.Haze = 0
        end
    end))
end
disableFogDelete = function()
    for _, conn in ipairs(fogConnections) do
        conn:Disconnect()
    end
    fogConnections = {}
    Lighting.FogStart = 0
    Lighting.FogEnd = 100000
end
local timeChangerConn = nil
local timeChangerActive = false
local originalClockTime = Lighting.ClockTime
local function enableTimeChanger(time)
    timeChangerActive = true
    if Library.Flags["skybox_enabled"] then
        time = math.clamp(time or 14, 8, 18)
    end
    Lighting.ClockTime = time
    if timeChangerConn then timeChangerConn:Disconnect() end
    timeChangerConn = Lighting.Changed:Connect(function(prop)
        if prop == "ClockTime" and timeChangerActive then
            local t = Library.Flags["time_changer"] or time
            if Library.Flags["skybox_enabled"] then
                t = math.clamp(t, 8, 18)
            end
            Lighting.ClockTime = t
        end
    end)
end
disableTimeChanger = function()
    timeChangerActive = false
    if timeChangerConn then
        timeChangerConn:Disconnect()
        timeChangerConn = nil
    end
    Lighting.ClockTime = originalClockTime
end
local skyboxConn = nil
local originalColorShift = Lighting.ColorShift_Top
local currentCustomSky = nil
local originalSkies = {}
local skyboxPresets = {
    ["Purple Nebula"] = {
        Color = Color3.fromRGB(130, 40, 220),
        Ambient = Color3.fromRGB(75, 0, 130),
        Bk = "rbxassetid://159454299",
        Dn = "rbxassetid://159454296",
        Ft = "rbxassetid://159454293",
        Lf = "rbxassetid://159454286",
        Rt = "rbxassetid://159454300",
        Up = "rbxassetid://159454288",
    },
    ["Blood Sky"] = {
        Color = Color3.fromRGB(220, 30, 30),
        Ambient = Color3.fromRGB(120, 0, 0),
        Bk = "rbxassetid://600830446",
        Dn = "rbxassetid://600831635",
        Ft = "rbxassetid://600832720",
        Lf = "rbxassetid://600886090",
        Rt = "rbxassetid://600833862",
        Up = "rbxassetid://600835177",
    },
    ["Vaporwave"] = {
        Color = Color3.fromRGB(255, 105, 180),
        Ambient = Color3.fromRGB(180, 40, 140),
        Bk = "rbxassetid://1417494030",
        Dn = "rbxassetid://1417494146",
        Ft = "rbxassetid://1417494253",
        Lf = "rbxassetid://1417494402",
        Rt = "rbxassetid://1417494499",
        Up = "rbxassetid://1417494643",
    },
    ["Red Space"] = {
        Color = Color3.fromRGB(255, 60, 60),
        Ambient = Color3.fromRGB(140, 20, 20),
        Bk = "rbxassetid://401664839",
        Dn = "rbxassetid://401664862",
        Ft = "rbxassetid://401664960",
        Lf = "rbxassetid://401664881",
        Rt = "rbxassetid://401664901",
        Up = "rbxassetid://401664936",
    },
}
local function applySkybox(name)
    local preset = skyboxPresets[name]
    if not preset then return end
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("Sky") and child.Name ~= "OverflowSky" then
            if not originalSkies[child] then
                originalSkies[child] = child.Parent
            end
            child.Parent = nil
        end
    end
    if not currentCustomSky or not currentCustomSky.Parent then
        currentCustomSky = Instance.new("Sky")
        currentCustomSky.Name = "OverflowSky"
        currentCustomSky.Parent = Lighting
    end
    currentCustomSky.SkyboxBk = preset.Bk
    currentCustomSky.SkyboxDn = preset.Dn
    currentCustomSky.SkyboxFt = preset.Ft
    currentCustomSky.SkyboxLf = preset.Lf
    currentCustomSky.SkyboxRt = preset.Rt
    currentCustomSky.SkyboxUp = preset.Up
    currentCustomSky.SunTextureId = ""
    currentCustomSky.MoonTextureId = ""
    currentCustomSky.StarCount = 0
    Lighting.ColorShift_Top = preset.Color
    Lighting.ColorShift_Bottom = preset.Color
    Lighting.OutdoorAmbient = preset.Ambient or preset.Color
    Lighting.Ambient = preset.Ambient or preset.Color
end
local function enableSkybox(name)
    applySkybox(name)
    if timeChangerActive then
        Lighting.ClockTime = math.clamp(Library.Flags["time_changer"] or 14, 8, 18)
    end
    if skyboxConn then skyboxConn:Disconnect() end
    skyboxConn = Lighting.ChildAdded:Connect(function(child)
        if child:IsA("Sky") and child.Name ~= "OverflowSky" then
            task.wait()
            child.Parent = nil
        end
    end)
end
disableSkybox = function()
    if skyboxConn then
        skyboxConn:Disconnect()
        skyboxConn = nil
    end
    if currentCustomSky then
        currentCustomSky:Destroy()
        currentCustomSky = nil
    end
    for sky, parent in pairs(originalSkies) do
        if sky then
            pcall(function() sky.Parent = Lighting end)
        end
    end
    originalSkies = {}
    Lighting.ColorShift_Top = originalColorShift
    Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
    Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
    Lighting.Ambient = originalLighting.Ambient
end
local oreESPActive = false
local oreESPConn = nil
local oreSpawnsWatchConn = nil
local oreESPObjects = {}
local oreESPSettings = {
    ShowName = true,
    ShowDistance = true,
    MaxDistance = 5000,
    Color = Color3.fromRGB(255, 255, 255),
}
local function getOreDisplayInfo(ore)
    if not ore or not ore.Parent then return nil, nil end
    local realName = ore.Name
    local targetPart = nil
    if ore:IsA("Model") then
        for _, c in ipairs(ore:GetDescendants()) do
            if c:IsA("BasePart") and c.Name ~= "HumanoidRootPart" then
                targetPart = c
                if c.Name ~= "OreSpawn" and c.Name ~= "Part" and c.Name ~= "Spawner" and c.Name ~= "Rock" then
                    realName = c.Name
                end
                break
            end
        end
        if not targetPart then
            local p = ore:FindFirstChildWhichIsA("BasePart")
            if p then
                targetPart = p
            end
        end
    elseif ore:IsA("BasePart") then
        targetPart = ore
    end
    if not targetPart then return nil, nil end
    if realName == "OreSpawn" or realName == "Spawner" or realName == "Part" then
        realName = "Ore"
    end
    return targetPart, realName
end
local function createOreBillboard(part, displayName)
    if oreESPObjects[part] then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "OreESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = oreESPSettings.MaxDistance
    billboard.Enabled = true
    billboard.Parent = part
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboard
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 16)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = oreESPSettings.Color
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Text = displayName or part.Name
    nameLabel.Parent = frame
    local distLabel = Instance.new("TextLabel")
    distLabel.Position = UDim2.new(0, 0, 0, 15)
    distLabel.Size = UDim2.new(1, 0, 0, 15)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = oreESPSettings.Color
    distLabel.TextSize = 12
    distLabel.Font = Enum.Font.SourceSansBold
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLabel.Text = ""
    distLabel.Parent = frame
    oreESPObjects[part] = { Billboard = billboard, NameLabel = nameLabel, DistLabel = distLabel }
end
local function removeOreBillboard(part)
    if oreESPObjects[part] then
        if oreESPObjects[part].Billboard then
            oreESPObjects[part].Billboard:Destroy()
        end
        oreESPObjects[part] = nil
    end
end
local function clearAllOreESP()
    for part, _ in pairs(oreESPObjects) do
        removeOreBillboard(part)
    end
    oreESPObjects = {}
end
local function enableOreESP()
    oreESPActive = true
    local function scanOres()
        local oreSpawns = workspace:FindFirstChild("OreSpawns")
        if not oreSpawns then return end
        for _, ore in ipairs(oreSpawns:GetChildren()) do
            local targetPart, realName = getOreDisplayInfo(ore)
            if targetPart and not oreESPObjects[targetPart] then
                createOreBillboard(targetPart, realName)
            end
        end
    end
    local function watchOreSpawns()
        if oreESPConn then
            oreESPConn:Disconnect()
            oreESPConn = nil
        end
        local oreSpawns = workspace:FindFirstChild("OreSpawns")
        if oreSpawns then
            oreESPConn = oreSpawns.ChildAdded:Connect(function()
                task.wait(0.2)
                scanOres()
            end)
        end
    end
    scanOres()
    watchOreSpawns()
    if oreSpawnsWatchConn then
        oreSpawnsWatchConn:Disconnect()
    end
    oreSpawnsWatchConn = workspace.ChildAdded:Connect(function(child)
        if child.Name == "OreSpawns" then
            task.wait(0.2)
            watchOreSpawns()
            scanOres()
        end
    end)
    task.spawn(function()
        while oreESPActive do
            task.wait(1.5)
            scanOres()
        end
    end)
end
disableOreESP = function()
    oreESPActive = false
    if oreESPConn then
        oreESPConn:Disconnect()
        oreESPConn = nil
    end
    if oreSpawnsWatchConn then
        oreSpawnsWatchConn:Disconnect()
        oreSpawnsWatchConn = nil
    end
    clearAllOreESP()
end
local lootESPActive = false
local lootESPConn = nil
local lootESPObjects = {}
local lootESPSettings = {
    ShowName = true,
    ShowDistance = true,
    MaxDistance = 5000,
    Color = Color3.fromRGB(0, 255, 0),
}
local function createLootBillboard(part)
    if lootESPObjects[part] then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "LootESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = lootESPSettings.MaxDistance
    billboard.Parent = part
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboard
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 16)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = lootESPSettings.Color
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Text = part.Name
    nameLabel.Parent = frame
    local distLabel = Instance.new("TextLabel")
    distLabel.Position = UDim2.new(0, 0, 0, 15)
    distLabel.Size = UDim2.new(1, 0, 0, 15)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = lootESPSettings.Color
    distLabel.TextSize = 12
    distLabel.Font = Enum.Font.SourceSansBold
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLabel.Text = ""
    distLabel.Parent = frame
    lootESPObjects[part] = { Billboard = billboard, NameLabel = nameLabel, DistLabel = distLabel }
end
local function removeLootBillboard(part)
    if lootESPObjects[part] then
        lootESPObjects[part].Billboard:Destroy()
        lootESPObjects[part] = nil
    end
end
local function clearAllLootESP()
    for part, _ in pairs(lootESPObjects) do
        removeLootBillboard(part)
    end
    lootESPObjects = {}
end
local function enableLootESP()
    lootESPActive = true
    local function scanLoot()
        local lootSpawns = workspace:FindFirstChild("LootSpawns")
        if not lootSpawns then return end
        for _, loot in ipairs(lootSpawns:GetChildren()) do
            if loot:IsA("Model") or loot:IsA("Part") then
                local part = loot:IsA("Model") and loot:FindFirstChildWhichIsA("Part") or loot
                if part and not lootESPObjects[part] then
                    createLootBillboard(part)
                end
            end
        end
    end
    scanLoot()
    local lootSpawns = workspace:FindFirstChild("LootSpawns")
    if lootSpawns then
        lootESPConn = lootSpawns.ChildAdded:Connect(function()
            task.wait(0.1)
            scanLoot()
        end)
    end
end
disableLootESP = function()
    lootESPActive = false
    if lootESPConn then
        lootESPConn:Disconnect()
        lootESPConn = nil
    end
    clearAllLootESP()
end
Chams = {
    Enabled             = false,
    Mode                = "Highlight",
    FillColor           = Color3.fromRGB(138, 43, 226),
    OutlineColor        = Color3.fromRGB(75, 0, 130),
    FillTransparency    = 0.5,
    OutlineTransparency = 0,
    TeamCheck           = false,
    AnimSpeed           = 3,
    PulseSpeed          = 2
}
ChamsObjects = {}
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local function IsAlive(char)
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    return hum and hrp and hum.Health > 0
end
local function NextRainbow(speed)
    local hue = (tick() * (speed or 3) * 0.12) % 1
    return Color3.fromHSV(hue, 1, 1)
end
local function PulseTrans(speed)
    return 0.4 + math.sin(tick() * speed * math.pi) * 0.35
end
local LIMB_NAMES = {
    "Head", "UpperTorso", "LowerTorso",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftHand", "RightHand",
    "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot"
}
local function CreateChams(player)
    if ChamsObjects[player] then return end
    ChamsObjects[player] = { HL = nil, WireHLs = {}, Active = false }
end
local function ClearChams(player)
    local c = ChamsObjects[player]
    if not c then return end
    if c.HL and c.HL.Parent then c.HL:Destroy(); c.HL = nil end
    for _, v in pairs(c.WireHLs) do
        if v and v.Parent then v:Destroy() end
    end
    c.WireHLs = {}
    c.Active = false
end
RemoveChams = function(player)
    ClearChams(player)
    ChamsObjects[player] = nil
end
local function BuildWireHL(player)
    local c = ChamsObjects[player]
    local char = player.Character
    if not char then return end
    for _, name in ipairs(LIMB_NAMES) do
        local part = char:FindFirstChild(name)
        if part then
            local hl = Instance.new("Highlight")
            hl.Adornee             = part
            hl.Parent              = part
            hl.DepthMode           = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillTransparency    = 1
            hl.OutlineTransparency = 0
            hl.OutlineColor        = Chams.FillColor
            hl.Enabled             = true
            table.insert(c.WireHLs, hl)
        end
    end
end
local function EnsureHL(player)
    local c = ChamsObjects[player]
    local char = player.Character
    if not char then return nil end
    if not c.HL or not c.HL.Parent then
        local hl = Instance.new("Highlight")
        hl.Adornee   = char
        hl.Parent    = char
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Enabled   = true
        c.HL = hl
    else
        c.HL.Adornee = char
    end
    return c.HL
end
local function UpdateChams(player)
    local c = ChamsObjects[player]
    if not c then return end
    if not Chams.Enabled then
        if c.HL and c.HL.Parent then c.HL.Enabled = false end
        for _, v in pairs(c.WireHLs) do if v and v.Parent then v.Enabled = false end end
        c.Active = false
        return
    end
    local char = player.Character
    if not char or not IsAlive(char) then
        if c.HL and c.HL.Parent then c.HL.Enabled = false end
        for _, v in pairs(c.WireHLs) do if v and v.Parent then v.Enabled = false end end
        c.Active = false
        return
    end
    if Chams.TeamCheck and player.Team == LocalPlayer.Team then
        if c.HL and c.HL.Parent then c.HL.Enabled = false end
        for _, v in pairs(c.WireHLs) do if v and v.Parent then v.Enabled = false end end
        c.Active = false
        return
    end
    local mode = Chams.Mode
    if mode == "Wireframe" then
        if c.HL and c.HL.Parent then c.HL.Enabled = false end
        if #c.WireHLs == 0 then BuildWireHL(player) end
        local wColor = Chams.FillColor
        for _, hl in pairs(c.WireHLs) do
            if hl and hl.Parent then
                hl.OutlineColor     = wColor
                hl.FillTransparency = 1
                hl.OutlineTransparency = 0
                hl.Enabled = true
            end
        end
        c.Active = true
        return
    end
    for _, v in pairs(c.WireHLs) do if v and v.Parent then v:Destroy() end end
    c.WireHLs = {}
    local hl = EnsureHL(player)
    if not hl then return end
    if mode == "Highlight" then
        hl.FillColor           = Chams.FillColor
        hl.OutlineColor        = Chams.OutlineColor
        hl.FillTransparency    = Chams.FillTransparency
        hl.OutlineTransparency = Chams.OutlineTransparency
        hl.Enabled             = true
    elseif mode == "Rainbow" then
        local col = NextRainbow(Chams.AnimSpeed)
        hl.FillColor           = col
        hl.OutlineColor        = col
        hl.FillTransparency    = Chams.FillTransparency
        hl.OutlineTransparency = Chams.OutlineTransparency
        hl.Enabled             = true
    elseif mode == "Pulsing" then
        hl.FillColor           = Chams.FillColor
        hl.OutlineColor        = Chams.OutlineColor
        hl.FillTransparency    = PulseTrans(Chams.PulseSpeed)
        hl.OutlineTransparency = Chams.OutlineTransparency
        hl.Enabled             = true
    elseif mode == "Gradient" then
        local t = tick() * Chams.AnimSpeed * 0.04
        local baseH, baseS, baseV = Chams.FillColor:ToHSV()
        local newH = (baseH + math.sin(t * math.pi * 2) * 0.15) % 1
        hl.FillColor           = Color3.fromHSV(newH, baseS, baseV)
        hl.OutlineColor        = Chams.OutlineColor
        hl.FillTransparency    = Chams.FillTransparency
        hl.OutlineTransparency = Chams.OutlineTransparency
        hl.Enabled             = true
    end
    c.Active = true
end
local boatESPActive = false
local boatESPConn = nil
local boatESPObjects = {}
local boatESPSettings = {
    ShowName = true,
    ShowDistance = true,
    MaxDistance = 5000,
    Color = Color3.fromRGB(0, 150, 255),
}
PlayerESP = {
    Enabled = false,
    Boxes = false,
    Mode = "Box",
    MaxDistance = 5000,
    BoxColor = Color3.fromRGB(255, 255, 255),
    BoxFilled = false,
    BoxFillColor = Color3.fromRGB(0, 0, 0),
    BoxFillTransparency = 0.5,
    Names = false,
    NameColor = Color3.fromRGB(255, 255, 255),
    Health = false,
    HealthColor1 = Color3.fromRGB(0, 255, 120),
    HealthColor2 = Color3.fromRGB(255, 45, 45),
}
local function getHealthGradient(percent)
    local c1 = PlayerESP.HealthColor1 or Color3.fromRGB(0, 255, 120)
    local c2 = PlayerESP.HealthColor2 or Color3.fromRGB(255, 45, 45)
    if percent >= 0.5 then
        local t = (percent - 0.5) * 2
        local midR = math.floor((c1.R * 255 + c2.R * 255) / 2)
        local midG = math.floor((c1.G * 255 + c2.G * 255) / 2)
        local midB = math.floor((c1.B * 255 + c2.B * 255) / 2)
        return Color3.fromRGB(
            math.floor(midR * (1 - t) + c1.R * 255 * t),
            math.floor(midG * (1 - t) + c1.G * 255 * t),
            math.floor(midB * (1 - t) + c1.B * 255 * t)
        )
    else
        local t = percent * 2
        local midR = math.floor((c1.R * 255 + c2.R * 255) / 2)
        local midG = math.floor((c1.G * 255 + c2.G * 255) / 2)
        local midB = math.floor((c1.B * 255 + c2.B * 255) / 2)
        return Color3.fromRGB(
            math.floor(c2.R * 255 * (1 - t) + midR * t),
            math.floor(c2.G * 255 * (1 - t) + midG * t),
            math.floor(c2.B * 255 * (1 - t) + midB * t)
        )
    end
end
PlayerESPObjects = {}
globalDrawingPool = {}
local function D(t)
    local obj = Drawing.new(t)
    table.insert(globalDrawingPool, obj)
    return obj
end
local EDGES_3D = {
    {1, 2}, {2, 3}, {3, 4}, {4, 1},
    {5, 6}, {6, 7}, {7, 8}, {8, 5},
    {1, 5}, {2, 6}, {3, 7}, {4, 8}
}
local function CreatePlayerESP(player)
    if PlayerESPObjects[player] then return end
    local corners = {}
    for i = 1, 8 do
        local l = D("Line")
        l.Thickness = 1.5
        l.Visible = false
        l.Transparency = 1
        l.ZIndex = 2
        corners[i] = l
    end
    local lines3d = {}
    for i = 1, 12 do
        local l = D("Line")
        l.Thickness = 1.5
        l.Visible = false
        l.Transparency = 1
        l.ZIndex = 2
        lines3d[i] = l
    end
    local box = D("Square")
    box.Thickness = 1.5
    box.Filled = false
    box.Visible = false
    box.Transparency = 1
    box.ZIndex = 2
    local boxFill = D("Square")
    boxFill.Thickness = 0
    boxFill.Filled = true
    boxFill.Visible = false
    boxFill.Transparency = 0.5
    boxFill.ZIndex = 1
    local nameText = D("Text")
    nameText.Size = 13
    nameText.Center = true
    nameText.Outline = true
    nameText.OutlineColor = Color3.fromRGB(0, 0, 0)
    nameText.Font = 2
    nameText.Visible = false
    nameText.Transparency = 1
    nameText.ZIndex = 2
    local healthBarOutline = D("Square")
    healthBarOutline.Thickness = 1
    healthBarOutline.Filled = true
    healthBarOutline.Color = Color3.fromRGB(0, 0, 0)
    healthBarOutline.Visible = false
    healthBarOutline.Transparency = 1
    healthBarOutline.ZIndex = 2
    local healthBarFill = D("Square")
    healthBarFill.Thickness = 1
    healthBarFill.Filled = true
    healthBarFill.Visible = false
    healthBarFill.Transparency = 1
    healthBarFill.ZIndex = 3
    local healthText = D("Text")
    healthText.Size = 12
    healthText.Center = false
    healthText.Outline = true
    healthText.OutlineColor = Color3.fromRGB(0, 0, 0)
    healthText.Font = 2
    healthText.Visible = false
    healthText.Transparency = 1
    healthText.ZIndex = 4
    PlayerESPObjects[player] = {
        Box = box,
        BoxFill = boxFill,
        Corners = corners,
        Lines3D = lines3d,
        Name = nameText,
        HealthOutline = healthBarOutline,
        HealthFill = healthBarFill,
        HealthText = healthText,
    }
end
local function HidePlayerESP(player)
    local esp = PlayerESPObjects[player]
    if not esp then return end
    if esp.Box then esp.Box.Visible = false end
    if esp.BoxFill then esp.BoxFill.Visible = false end
    if esp.Corners then
        for _, l in ipairs(esp.Corners) do
            l.Visible = false
        end
    end
    if esp.Lines3D then
        for _, l in ipairs(esp.Lines3D) do
            l.Visible = false
        end
    end
    if esp.Name then esp.Name.Visible = false end
    if esp.HealthOutline then esp.HealthOutline.Visible = false end
    if esp.HealthFill then esp.HealthFill.Visible = false end
    if esp.HealthText then esp.HealthText.Visible = false end
end
RemovePlayerESP = function(player)
    local esp = PlayerESPObjects[player]
    if not esp then return end
    if esp.Box then
        pcall(function() esp.Box.Visible = false; esp.Box:Remove() end)
    end
    if esp.BoxFill then
        pcall(function() esp.BoxFill.Visible = false; esp.BoxFill:Remove() end)
    end
    if esp.Corners then
        for _, l in ipairs(esp.Corners) do
            pcall(function() l.Visible = false; l:Remove() end)
        end
    end
    if esp.Lines3D then
        for _, l in ipairs(esp.Lines3D) do
            pcall(function() l.Visible = false; l:Remove() end)
        end
    end
    if esp.Name then
        pcall(function() esp.Name.Visible = false; esp.Name:Remove() end)
    end
    if esp.HealthOutline then
        pcall(function() esp.HealthOutline.Visible = false; esp.HealthOutline:Remove() end)
    end
    if esp.HealthFill then
        pcall(function() esp.HealthFill.Visible = false; esp.HealthFill:Remove() end)
    end
    if esp.HealthText then
        pcall(function() esp.HealthText.Visible = false; esp.HealthText:Remove() end)
    end
    PlayerESPObjects[player] = nil
end
local function getPlayerTag(player)
    local dName = player.DisplayName
    if dName and dName ~= "" then
        local valid = true
        for i = 1, #dName do
            if string.byte(dName, i) > 127 then
                valid = false
                break
            end
        end
        if valid then
            return dName
        end
    end
    return player.Name
end
local function UpdatePlayerESP(player)
    local esp = PlayerESPObjects[player]
    if not esp then return end
    if not PlayerESP.Enabled or (not PlayerESP.Boxes and not PlayerESP.Names) then
        HidePlayerESP(player)
        return
    end
    local char = player.Character
    if not char then HidePlayerESP(player); return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    if not hum or not hrp or hum.Health <= 0 then
        HidePlayerESP(player)
        return
    end
    local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
    if dist > PlayerESP.MaxDistance then
        HidePlayerESP(player)
        return
    end
    local headPos = head and (head.Position + Vector3.new(0, head.Size.Y / 2 + 0.3, 0)) or (hrp.Position + Vector3.new(0, 2.5, 0))
    local feetPos = hrp.Position - Vector3.new(0, 3.2, 0)
    local headScreen, headVis = Camera:WorldToViewportPoint(headPos)
    local feetScreen, feetVis = Camera:WorldToViewportPoint(feetPos)
    if not headVis and not feetVis then
        HidePlayerESP(player)
        return
    end
    local rightPos = hrp.Position + Camera.CFrame.RightVector * 2.2
    local leftPos = hrp.Position - Camera.CFrame.RightVector * 2.2
    local rightScreen = Camera:WorldToViewportPoint(rightPos)
    local leftScreen = Camera:WorldToViewportPoint(leftPos)
    local rootScreen = Camera:WorldToViewportPoint(hrp.Position)
    local boxH = math.abs(feetScreen.Y - headScreen.Y)
    local boxW = math.max(math.abs(rightScreen.X - leftScreen.X), math.floor(boxH / 1.4), 6)
    local boxX = math.floor(rootScreen.X - boxW / 2)
    local boxY = math.floor(math.min(headScreen.Y, feetScreen.Y))
    if PlayerESP.Boxes then
        if PlayerESP.Mode == "3D" then
            if esp.Box then esp.Box.Visible = false end
            if esp.Corners then
                for _, l in ipairs(esp.Corners) do l.Visible = false end
            end
            local cframe, size = char:GetBoundingBox()
            local extX = size.X / 2
            local extY = size.Y / 2
            local extZ = size.Z / 2
            local corners = {
                cframe * Vector3.new(-extX, -extY, -extZ),
                cframe * Vector3.new(-extX,  extY, -extZ),
                cframe * Vector3.new( extX,  extY, -extZ),
                cframe * Vector3.new( extX, -extY, -extZ),
                cframe * Vector3.new(-extX, -extY,  extZ),
                cframe * Vector3.new(-extX,  extY,  extZ),
                cframe * Vector3.new( extX,  extY,  extZ),
                cframe * Vector3.new( extX, -extY,  extZ),
            }
            local screenPoints = {}
            local allInFront = true
            local anyOnScreen = false
            for i = 1, 8 do
                local screenPos, onScreen = Camera:WorldToViewportPoint(corners[i])
                if screenPos.Z <= 0 then
                    allInFront = false
                    break
                end
                screenPoints[i] = Vector2.new(screenPos.X, screenPos.Y)
                if onScreen then
                    anyOnScreen = true
                end
            end
            if allInFront and anyOnScreen then
                for i, edge in ipairs(EDGES_3D) do
                    local line = esp.Lines3D[i]
                    line.From = screenPoints[edge[1]]
                    line.To = screenPoints[edge[2]]
                    line.Color = PlayerESP.BoxColor
                    line.Thickness = 1.5
                    line.Transparency = 1
                    line.Visible = true
                end
            else
                for _, l in ipairs(esp.Lines3D) do l.Visible = false end
            end
        else
            for _, l in ipairs(esp.Lines3D) do l.Visible = false end
            if PlayerESP.BoxFilled and esp.BoxFill then
                esp.BoxFill.Position = Vector2.new(boxX, boxY)
                esp.BoxFill.Size = Vector2.new(boxW, boxH)
                esp.BoxFill.Color = PlayerESP.BoxFillColor
                esp.BoxFill.Transparency = PlayerESP.BoxFillTransparency
                esp.BoxFill.Visible = true
            elseif esp.BoxFill then
                esp.BoxFill.Visible = false
            end
            if PlayerESP.Mode == "Box" then
                if esp.Corners then
                    for _, l in ipairs(esp.Corners) do l.Visible = false end
                end
                esp.Box.Position = Vector2.new(boxX, boxY)
                esp.Box.Size = Vector2.new(boxW, boxH)
                esp.Box.Color = PlayerESP.BoxColor
                esp.Box.Thickness = 1.5
                esp.Box.Transparency = 1
                esp.Box.Visible = true
            elseif PlayerESP.Mode == "Corner" then
                if esp.Box then esp.Box.Visible = false end
                local cornerLenX = math.clamp(math.floor(boxW / 3.5), 3, 14)
                local cornerLenY = math.clamp(math.floor(boxH / 4), 3, 14)
                if cornerLenX * 2 >= boxW then
                    cornerLenX = math.max(1, math.floor(boxW / 2) - 1)
                end
                if cornerLenY * 2 >= boxH then
                    cornerLenY = math.max(1, math.floor(boxH / 2) - 1)
                end
                local cornerThickness = 1.5
                esp.Corners[1].From = Vector2.new(boxX, boxY)
                esp.Corners[1].To = Vector2.new(boxX + cornerLenX, boxY)
                esp.Corners[2].From = Vector2.new(boxX, boxY)
                esp.Corners[2].To = Vector2.new(boxX + cornerLenY)
                esp.Corners[3].From = Vector2.new(boxX + boxW, boxY)
                esp.Corners[3].To = Vector2.new(boxX + boxW - cornerLenX, boxY)
                esp.Corners[4].From = Vector2.new(boxX + boxW, boxY)
                esp.Corners[4].To = Vector2.new(boxX + boxW, boxY + cornerLenY)
                esp.Corners[5].From = Vector2.new(boxX, boxY + boxH)
                esp.Corners[5].To = Vector2.new(boxX + cornerLenX, boxY + boxH)
                esp.Corners[6].From = Vector2.new(boxX, boxY + boxH)
                esp.Corners[6].To = Vector2.new(boxX, boxY + boxH - cornerLenY)
                esp.Corners[7].From = Vector2.new(boxX + boxW, boxY + boxH)
                esp.Corners[7].To = Vector2.new(boxX + boxW - cornerLenX, boxY + boxH)
                esp.Corners[8].From = Vector2.new(boxX + boxW, boxY + boxH)
                esp.Corners[8].To = Vector2.new(boxX + boxW, boxY + boxH - cornerLenY)
                for i = 1, 8 do
                    local l = esp.Corners[i]
                    l.Color = PlayerESP.BoxColor
                    l.Thickness = cornerThickness
                    l.Transparency = 1
                    l.Visible = true
                end
            else
                if esp.Box then esp.Box.Visible = false end
                if esp.Corners then
                    for _, l in ipairs(esp.Corners) do l.Visible = false end
                end
            end
        end
    else
        if esp.Box then esp.Box.Visible = false end
        if esp.BoxFill then esp.BoxFill.Visible = false end
        if esp.Corners then
            for _, l in ipairs(esp.Corners) do l.Visible = false end
        end
        if esp.Lines3D then
            for _, l in ipairs(esp.Lines3D) do l.Visible = false end
        end
    end
    if PlayerESP.Names and esp.Name then
        local tag = getPlayerTag(player)
        esp.Name.Text = tag
        esp.Name.Color = PlayerESP.NameColor
        esp.Name.Position = Vector2.new(boxX + boxW / 2, boxY - 16)
        esp.Name.Visible = true
    elseif esp.Name then
        esp.Name.Visible = false
    end
    if PlayerESP.Health and esp.HealthOutline and esp.HealthFill then
        local maxHp = hum.MaxHealth > 0 and hum.MaxHealth or 100
        local hp = math.clamp(hum.Health, 0, maxHp)
        local hpPercent = math.clamp(hp / maxHp, 0, 1)
        local barW = 3
        local barX = boxX - 6
        local barY = boxY
        local barH = boxH
        local fillH = math.floor(barH * hpPercent)
        local fillY = barY + barH - fillH
        esp.HealthOutline.Position = Vector2.new(barX - 1, barY - 1)
        esp.HealthOutline.Size = Vector2.new(barW + 2, barH + 2)
        esp.HealthOutline.Color = Color3.fromRGB(0, 0, 0)
        esp.HealthOutline.Visible = true
        esp.HealthFill.Position = Vector2.new(barX, fillY)
        esp.HealthFill.Size = Vector2.new(barW, fillH)
        esp.HealthFill.Color = getHealthGradient(hpPercent)
        esp.HealthFill.Visible = (fillH > 0)
        if hpPercent < 0.999 and esp.HealthText then
            local tb = esp.HealthText.TextBounds
            local textW = tb and tb.X or 0
            esp.HealthText.Text = tostring(math.floor(hp))
            esp.HealthText.Position = Vector2.new(barX - textW - 3, fillY - 4)
            esp.HealthText.Color = Color3.fromRGB(255, 255, 255)
            esp.HealthText.Visible = true
        elseif esp.HealthText then
            esp.HealthText.Visible = false
        end
    else
        if esp.HealthOutline then esp.HealthOutline.Visible = false end
        if esp.HealthFill then esp.HealthFill.Visible = false end
        if esp.HealthText then esp.HealthText.Visible = false end
    end
end
local function createBoatBillboard(part)
    if boatESPObjects[part] then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "BoatESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = boatESPSettings.MaxDistance
    billboard.Parent = part
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboard
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 16)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = boatESPSettings.Color
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Text = part.Name
    nameLabel.Parent = frame
    local distLabel = Instance.new("TextLabel")
    distLabel.Position = UDim2.new(0, 0, 0, 15)
    distLabel.Size = UDim2.new(1, 0, 0, 15)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = boatESPSettings.Color
    distLabel.TextSize = 12
    distLabel.Font = Enum.Font.SourceSansBold
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLabel.Text = ""
    distLabel.Parent = frame
    boatESPObjects[part] = { Billboard = billboard, NameLabel = nameLabel, DistLabel = distLabel }
end
local function removeBoatBillboard(part)
    if boatESPObjects[part] then
        boatESPObjects[part].Billboard:Destroy()
        boatESPObjects[part] = nil
    end
end
local function clearAllBoatESP()
    for part, _ in pairs(boatESPObjects) do
        removeBoatBillboard(part)
    end
    boatESPObjects = {}
end
local function enableBoatESP()
    boatESPActive = true
    local function scanBoats()
        local boatSpawns = workspace:FindFirstChild("BoatSpawns")
        if not boatSpawns then return end
        for _, boat in ipairs(boatSpawns:GetChildren()) do
            if boat:IsA("Model") or boat:IsA("Part") then
                local part = boat:IsA("Model") and boat:FindFirstChildWhichIsA("Part") or boat
                if part and not boatESPObjects[part] then
                    createBoatBillboard(part)
                end
            end
        end
    end
    scanBoats()
    local boatSpawns = workspace:FindFirstChild("BoatSpawns")
    if boatSpawns then
        boatESPConn = boatSpawns.ChildAdded:Connect(function()
            task.wait(0.1)
            scanBoats()
        end)
    end
end
disableBoatESP = function()
    boatESPActive = false
    if boatESPConn then
        boatESPConn:Disconnect()
        boatESPConn = nil
    end
    clearAllBoatESP()
end
local espUpdateTimer = 0
local espUpdateInterval = 0.25
local function updateESPSet(objects, settings, removeFunc)
    local player = Players.LocalPlayer
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for part, data in pairs(objects) do
        if part and part.Parent and part:IsDescendantOf(workspace) then
            local partPos = part.Position
            if not partPos then
                local model = part:FindFirstAncestorWhichIsA("Model")
                if model then
                    partPos = model:GetPivot().Position
                end
            end
            if partPos then
                local dist = math.floor((hrp.Position - partPos).Magnitude)
                if dist > settings.MaxDistance then
                    if data.Billboard.Enabled then
                        data.Billboard.Enabled = false
                    end
                else
                    if not data.Billboard.Enabled then
                        data.Billboard.Enabled = true
                    end
                    if data.Billboard.MaxDistance ~= settings.MaxDistance then
                        data.Billboard.MaxDistance = settings.MaxDistance
                    end
                    if data.NameLabel.Visible ~= settings.ShowName then
                        data.NameLabel.Visible = settings.ShowName
                    end
                    if data.NameLabel.TextColor3 ~= settings.Color then
                        data.NameLabel.TextColor3 = settings.Color
                    end
                    if data.DistLabel.Visible ~= settings.ShowDistance then
                        data.DistLabel.Visible = settings.ShowDistance
                    end
                    if data.DistLabel.TextColor3 ~= settings.Color then
                        data.DistLabel.TextColor3 = settings.Color
                    end
                    if settings.ShowDistance then
                        local distText = tostring(dist) .. "m"
                        if data.lastDist ~= distText then
                            data.DistLabel.Text = distText
                            data.lastDist = distText
                        end
                    end
                end
            end
        else
            removeFunc(part)
        end
    end
end
local originalCameraFOV = Camera.FieldOfView
targetFOV = 70
fovChangerActive = false
enableFOVChanger = function(val)
    fovChangerActive = true
    targetFOV = val or targetFOV
    Camera.FieldOfView = targetFOV
end
disableFOVChanger = function()
    fovChangerActive = false
    Camera.FieldOfView = originalCameraFOV
end
thirdPersonSettings = {
    Enabled = false,
    MasterEnabled = false,
    Distance = 9.5,
    Side = -0.4,
    Height = 1.2,
    Key = Enum.KeyCode.V,
}
disableThirdPerson = function()
    thirdPersonSettings.Enabled = false
    pcall(function()
        RunService:UnbindFromRenderStep("FakeThirdPersonCentered")
    end)
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.AutoRotate = true
            hum.CameraOffset = Vector3.new(0, 0, 0)
        end
    end
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end
enableThirdPerson = function()
    thirdPersonSettings.Enabled = true
    pcall(function()
        RunService:BindToRenderStep("FakeThirdPersonCentered", 3000, function()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            local cam = workspace.CurrentCamera
            if not hum or not root or not cam or hum.Health <= 0 then return end
            if thirdPersonSettings.Enabled then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.LocalTransparencyModifier = 0
                    end
                end
                UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
                hum.CameraOffset = Vector3.new(0, 0, 0)
                hum.AutoRotate = false
                local camLook = cam.CFrame.LookVector
                local lookFlat = Vector3.new(camLook.X, 0, camLook.Z).Unit
                if lookFlat.Magnitude > 0 then
                    root.CFrame = CFrame.lookAt(root.Position, root.Position + lookFlat)
                end
                cam.CFrame = cam.CFrame * CFrame.new(thirdPersonSettings.Side or -0.4, thirdPersonSettings.Height or 1.2, thirdPersonSettings.Distance or 9.5)
            else
                hum.AutoRotate = true
                hum.CameraOffset = Vector3.new(0, 0, 0)
            end
        end)
    end)
end
toggleThirdPerson = function()
    if thirdPersonSettings.Enabled then
        disableThirdPerson()
    else
        enableThirdPerson()
    end
end
freecamSettings = {
    Enabled = false,
    MasterEnabled = false,
    Speed = 1,
    Key = Enum.KeyCode.B,
    ServerPosColor = Color3.fromRGB(0, 255, 120),
    ShowTracer = true,
}
local freecamState = {
    active = false,
    cframe = nil,
    keys = { W = false, S = false, A = false, D = false, Space = false, LeftShift = false },
    pan = Vector2.new(0, 0),
    isPanning = false,
    serverGhost = nil,
    tracerLines = {},
}
local function removeFreecamTracer()
    if freecamState.tracerLines then
        for _, l in ipairs(freecamState.tracerLines) do
            pcall(function() l.Visible = false; l:Remove() end)
        end
        freecamState.tracerLines = {}
    end
end
local function removeServerGhost()
    if freecamState.serverGhost then
        for _, p in ipairs(freecamState.serverGhost) do
            if p and p.Parent then p:Destroy() end
        end
        freecamState.serverGhost = nil
    end
    removeFreecamTracer()
end
local function createServerGhost(char)
    removeServerGhost()
    local parts = {}
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("BasePart") and child.Transparency < 1 and child.Name ~= "HumanoidRootPart" then
            local ghost = Instance.new("Part")
            ghost.Name = "OverflowServerPosGhost"
            ghost.Size = child.Size
            ghost.CFrame = child.CFrame
            ghost.Material = Enum.Material.ForceField
            ghost.Color = freecamSettings.ServerPosColor
            ghost.Transparency = 0.4
            ghost.CanCollide = false
            ghost.CanQuery = false
            ghost.CanTouch = false
            ghost.Anchored = true
            ghost.CastShadow = false
            ghost.Parent = Camera
            local hl = Instance.new("Highlight")
            hl.Adornee = ghost
            hl.Parent = ghost
            hl.FillColor = freecamSettings.ServerPosColor
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.FillTransparency = 0.5
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            table.insert(parts, ghost)
        end
    end
    freecamState.serverGhost = parts
    local MAX_DASHES = 35
    local lines = {}
    for i = 1, MAX_DASHES do
        local outline = D("Line")
        outline.Thickness = 3.5
        outline.Color = Color3.fromRGB(0, 0, 0)
        outline.Transparency = 1
        outline.Visible = false
        outline.ZIndex = 3
        local inline = D("Line")
        inline.Thickness = 1.5
        inline.Color = Color3.fromRGB(255, 255, 255)
        inline.Transparency = 1
        inline.Visible = false
        inline.ZIndex = 4
        table.insert(lines, outline)
        table.insert(lines, inline)
    end
    freecamState.tracerLines = lines
end
local function updateFreecamTracer(cam)
    if not freecamState.active or not freecamSettings.ShowTracer or not freecamState.tracerLines or #freecamState.tracerLines == 0 then
        if freecamState.tracerLines then
            for _, l in ipairs(freecamState.tracerLines) do l.Visible = false end
        end
        return
    end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        for _, l in ipairs(freecamState.tracerLines) do l.Visible = false end
        return
    end
    local serverPos = hrp.Position
    local screenPos, onScreen = cam:WorldToViewportPoint(serverPos)
    if not onScreen or screenPos.Z <= 0 then
        for _, l in ipairs(freecamState.tracerLines) do l.Visible = false end
        return
    end
    local screenCenter = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local targetPos = Vector2.new(screenPos.X, screenPos.Y)
    local diff = targetPos - screenCenter
    local totalDist = diff.Magnitude
    if totalDist < 4 then
        for _, l in ipairs(freecamState.tracerLines) do l.Visible = false end
        return
    end
    local dir = diff.Unit
    local dashLength = 12
    local gapLength = 8
    local step = dashLength + gapLength
    local count = math.floor(totalDist / step)
    local maxPairs = #freecamState.tracerLines / 2
    local lineIndex = 1
    for i = 0, count do
        if lineIndex / 2 >= maxPairs then break end
        local startDist = i * step
        local endDist = math.min(startDist + dashLength, totalDist)
        if startDist < totalDist then
            local fromPt = screenCenter + dir * startDist
            local toPt = screenCenter + dir * endDist
            local outline = freecamState.tracerLines[lineIndex]
            local inline = freecamState.tracerLines[lineIndex + 1]
            if outline and inline then
                outline.From = fromPt
                outline.To = toPt
                outline.Visible = true
                inline.From = fromPt
                inline.To = toPt
                inline.Visible = true
            end
            lineIndex = lineIndex + 2
        end
    end
    for i = lineIndex, #freecamState.tracerLines do
        local l = freecamState.tracerLines[i]
        if l then l.Visible = false end
    end
end
disableFreecam = function()
    freecamState.active = false
    pcall(function()
        RunService:UnbindFromRenderStep("OverflowFreecam")
    end)
    removeServerGhost()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end
toggleFreecam = function()
    freecamState.active = not freecamState.active
    if not freecamState.active then
        disableFreecam()
    else
        local cam = workspace.CurrentCamera
        if cam then
            freecamState.cframe = cam.CFrame
        end
        local char = LocalPlayer.Character
        if char then
            createServerGhost(char)
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = true
            end
        end
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        pcall(function()
            RunService:BindToRenderStep("OverflowFreecam", Enum.RenderPriority.Camera.Value + 200, function(dt)
                if not freecamState.active then
                    RunService:UnbindFromRenderStep("OverflowFreecam")
                    return
                end
                local cam = workspace.CurrentCamera
                if not cam then return end
                local mouseDelta = UserInputService:GetMouseDelta()
                local rotX = -mouseDelta.Y * 0.003
                local rotY = -mouseDelta.X * 0.003
                local rotCFrame = CFrame.Angles(0, rotY, 0) * freecamState.cframe * CFrame.Angles(rotX, 0, 0)
                local pos = freecamState.cframe.Position
                freecamState.cframe = CFrame.new(pos) * rotCFrame.Rotation
                local move = Vector3.new(0, 0, 0)
                if freecamState.keys.W then move = move + freecamState.cframe.LookVector end
                if freecamState.keys.S then move = move - freecamState.cframe.LookVector end
                if freecamState.keys.A then move = move - freecamState.cframe.RightVector end
                if freecamState.keys.D then move = move + freecamState.cframe.RightVector end
                if freecamState.keys.Space then move = move + Vector3.new(0, 1, 0) end
                if freecamState.keys.LeftShift then move = move - Vector3.new(0, 1, 0) end
                local speed = (freecamSettings.Speed or 1) * 45
                if move.Magnitude > 0 then
                    freecamState.cframe = freecamState.cframe + (move.Unit * speed * (dt or 0.016))
                end
                cam.CFrame = freecamState.cframe
            end)
        end)
    end
end
orbsSettings = {
    Enabled = false,
    Count = 3,
    Radius = 4,
    Speed = 2,
    Height = 2,
    Colors = {
        Color3.fromRGB(100, 150, 255),
        Color3.fromRGB(200, 100, 255),
        Color3.fromRGB(255, 150, 50),
    }
}
local activeOrbs = {}
local orbsAngle = 0
local function createInvokerOrb(index)
    local col = orbsSettings.Colors[((index - 1) % #orbsSettings.Colors) + 1]
    local orb = Instance.new("Part")
    orb.Name = "OverflowOrb"
    orb.Shape = Enum.PartType.Ball
    orb.Size = Vector3.new(1.5, 1.5, 1.5)
    orb.Material = Enum.Material.Neon
    orb.Color = col
    orb.CanCollide = false
    orb.Anchored = true
    orb.CastShadow = false
    orb.Parent = workspace
    local light = Instance.new("PointLight")
    light.Color = col
    light.Brightness = 2
    light.Range = 10
    light.Parent = orb
    local particles = Instance.new("ParticleEmitter")
    particles.Color = ColorSequence.new(col)
    particles.Size = NumberSequence.new(0.3)
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Lifetime = NumberRange.new(0.5, 1)
    particles.Rate = 20
    particles.Speed = NumberRange.new(0.5)
    particles.SpreadAngle = Vector2.new(180, 180)
    particles.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    particles.Parent = orb
    return orb
end
clearOrbs = function()
    for _, orb in ipairs(activeOrbs) do
        if orb and orb.Parent then
            pcall(function() orb:Destroy() end)
        end
    end
    activeOrbs = {}
end
refreshOrbs = function()
    clearOrbs()
    if not orbsSettings.Enabled then return end
    for i = 1, orbsSettings.Count do
        table.insert(activeOrbs, createInvokerOrb(i))
    end
end
updateOrbs = function(dt)
    if not orbsSettings.Enabled or #activeOrbs == 0 then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    orbsAngle = orbsAngle + (orbsSettings.Speed * (dt or 0.016))
    local count = #activeOrbs
    for i, orb in ipairs(activeOrbs) do
        if orb and orb.Parent then
            local orbAngle = orbsAngle + ((i - 1) * (math.pi * 2 / count))
            local offsetX = math.cos(orbAngle) * orbsSettings.Radius
            local offsetZ = math.sin(orbAngle) * orbsSettings.Radius
            local bobbing = math.sin(orbsAngle * 3 + i) * 0.3
            orb.Position = hrp.Position + Vector3.new(offsetX, orbsSettings.Height + bobbing, offsetZ)
        end
    end
end
disableOrbs = function()
    orbsSettings.Enabled = false
    clearOrbs()
end
viewmodelChamsSettings = {
    Enabled = false,
    Mode = "Highlight",
    FillColor = Color3.fromRGB(255, 0, 0),
    OutlineColor = Color3.fromRGB(255, 255, 255),
    FillTransparency = 0.2,
    OutlineTransparency = 0,
    AnimSpeed = 3,
    PulseSpeed = 2,
}
local viewmodelChamsConn = nil
enableViewmodelChams = function()
    viewmodelChamsSettings.Enabled = true
    if viewmodelChamsConn then
        viewmodelChamsConn:Disconnect()
    end
    viewmodelChamsConn = RunService.RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera
        if not cam then return end
        local mode = viewmodelChamsSettings.Mode
        local wire = mode == "Wireframe"
        for _, child in pairs(cam:GetChildren()) do
            if child:IsA("BasePart") or child:IsA("Model") then
                local hl = child:FindFirstChild("VM_Highlight")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "VM_Highlight"
                    hl.Parent = child
                end
                hl.Adornee = child
                if wire then
                    hl.Enabled = false
                else
                    if mode == "Outline" then
                        hl.FillColor = viewmodelChamsSettings.FillColor
                        hl.OutlineColor = viewmodelChamsSettings.OutlineColor
                        hl.FillTransparency = 1
                        hl.OutlineTransparency = viewmodelChamsSettings.OutlineTransparency
                    elseif mode == "Rainbow" then
                        local col = NextRainbow(viewmodelChamsSettings.AnimSpeed)
                        hl.FillColor = col
                        hl.OutlineColor = col
                        hl.FillTransparency = viewmodelChamsSettings.FillTransparency
                        hl.OutlineTransparency = viewmodelChamsSettings.OutlineTransparency
                    elseif mode == "Pulsing" then
                        hl.FillColor = viewmodelChamsSettings.FillColor
                        hl.OutlineColor = viewmodelChamsSettings.OutlineColor
                        hl.FillTransparency = PulseTrans(viewmodelChamsSettings.PulseSpeed)
                        hl.OutlineTransparency = viewmodelChamsSettings.OutlineTransparency
                    elseif mode == "Gradient" then
                        local t = tick() * viewmodelChamsSettings.AnimSpeed * 0.04
                        local baseH, baseS, baseV = viewmodelChamsSettings.FillColor:ToHSV()
                        local newH = (baseH + math.sin(t * math.pi * 2) * 0.15) % 1
                        hl.FillColor = Color3.fromHSV(newH, baseS, baseV)
                        hl.OutlineColor = viewmodelChamsSettings.OutlineColor
                        hl.FillTransparency = viewmodelChamsSettings.FillTransparency
                        hl.OutlineTransparency = viewmodelChamsSettings.OutlineTransparency
                    else
                        hl.FillColor = viewmodelChamsSettings.FillColor
                        hl.OutlineColor = viewmodelChamsSettings.OutlineColor
                        hl.FillTransparency = viewmodelChamsSettings.FillTransparency
                        hl.OutlineTransparency = viewmodelChamsSettings.OutlineTransparency
                    end
                    hl.Enabled = true
                end
                if child:IsA("Model") then
                    local parts = child:GetDescendants()
                    if wire then
                        for _, part in pairs(parts) do
                            if part:IsA("BasePart") then
                                local phl = part:FindFirstChild("VM_Part_Highlight")
                                if not phl then
                                    phl = Instance.new("Highlight")
                                    phl.Name = "VM_Part_Highlight"
                                    phl.Parent = part
                                end
                                phl.Adornee = part
                                phl.FillColor = viewmodelChamsSettings.FillColor
                                phl.OutlineColor = viewmodelChamsSettings.FillColor
                                phl.FillTransparency = 1
                                phl.OutlineTransparency = 0
                                phl.Enabled = true
                            end
                        end
                    else
                        for _, part in pairs(parts) do
                            local phl = part:FindFirstChild("VM_Part_Highlight")
                            if phl then
                                phl:Destroy()
                            end
                        end
                    end
                end
            end
        end
    end)
end
disableViewmodelChams = function()
    viewmodelChamsSettings.Enabled = false
    if viewmodelChamsConn then
        viewmodelChamsConn:Disconnect()
        viewmodelChamsConn = nil
    end
    local cam = workspace.CurrentCamera
    if cam then
        for _, child in pairs(cam:GetChildren()) do
            local hl = child:FindFirstChild("VM_Highlight")
            if hl then
                hl:Destroy()
            end
            if child:IsA("Model") then
                for _, part in pairs(child:GetDescendants()) do
                    local phl = part:FindFirstChild("VM_Part_Highlight")
                    if phl then
                        phl:Destroy()
                    end
                end
            end
        end
    end
end
speedHackSettings = {
    Enabled = false,
    Key = Enum.KeyCode.V,
    Multiplier = 3,
}
local speedHackConn = nil
enableSpeedHack = function()
    speedHackSettings.Enabled = true
    if speedHackConn then
        speedHackConn:Disconnect()
    end
    speedHackConn = RunService.Heartbeat:Connect(function(dt)
        if not speedHackSettings.Enabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp or hum.Health <= 0 then return end
        local keyFlag = Library.Flags["speedhack_key"]
        local key = (type(keyFlag) == "table" and keyFlag.Key) or (keyFlag and typeof(keyFlag) == "EnumItem" and keyFlag) or speedHackSettings.Key
        local mode = (type(keyFlag) == "table" and keyFlag.Mode) or "Hold"
        local active = false
        if mode == "Always" then
            active = true
        elseif mode == "Hold" then
            active = isInputHeld(key)
        else
            active = (type(keyFlag) == "table" and keyFlag.Active == true) or false
        end
        if not active then return end
        local moveDir = hum.MoveDirection
        if moveDir.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (moveDir * speedHackSettings.Multiplier * dt * 50)
        end
    end)
end
disableSpeedHack = function()
    speedHackSettings.Enabled = false
    if speedHackConn then
        speedHackConn:Disconnect()
        speedHackConn = nil
    end
end
viewmodelPosSettings = {
    Enabled = false,
    OffsetX = 0,
    OffsetY = 0,
    OffsetZ = 0,
}
local viewmodelPosConn = nil
enableViewmodelPos = function()
    viewmodelPosSettings.Enabled = true
    if viewmodelPosConn then
        viewmodelPosConn:Disconnect()
    end
    viewmodelPosConn = RunService.RenderStepped:Connect(function()
        if not viewmodelPosSettings.Enabled then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local offset = CFrame.new(viewmodelPosSettings.OffsetX, viewmodelPosSettings.OffsetY, viewmodelPosSettings.OffsetZ)
        for _, child in pairs(cam:GetChildren()) do
            if child:IsA("Model") then
                local cname = child.Name:lower()
                local looksLikeVM = cname:find("viewmodel") or cname:find("hand") or cname:find("arm") or child:FindFirstChild("Handle")
                if looksLikeVM then
                    local primary = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart") or child:FindFirstChild("Handle")
                    if primary then
                        pcall(function()
                            child:SetPrimaryPartCFrame(cam.CFrame * offset)
                        end)
                    end
                end
            end
        end
        local char = LocalPlayer.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                pcall(function()
                    tool.Handle.CFrame = cam.CFrame * offset
                end)
            end
        end
    end)
end
disableViewmodelPos = function()
    viewmodelPosSettings.Enabled = false
    if viewmodelPosConn then
        viewmodelPosConn:Disconnect()
        viewmodelPosConn = nil
    end
end
aimbotSettings = {
    Enabled = false,
    Locked = false,
    Key = Enum.KeyCode.E,
    Hitbox = "Head",
    FOVRadius = 90,
    Smoothness = 5,
    ShowFOVCircle = true,
    FOVCircleColor = Color3.fromRGB(255, 255, 255),
    ShowFOVFill = false,
    FOVFillColor = Color3.fromRGB(0, 0, 0),
    FOVFillTransparency = 0.5,
    ShowTracer = false,
    TracerColor = Color3.fromRGB(255, 45, 45),
}
aimbotFOVCircle = D("Circle")
aimbotFOVCircle.Thickness = 1.5
aimbotFOVCircle.Filled = false
aimbotFOVCircle.Visible = false
aimbotFOVCircle.Transparency = 1
aimbotFOVCircle.ZIndex = 5
silentAimFOVCircle = D("Circle")
silentAimFOVCircle.Thickness = 1.5
silentAimFOVCircle.Filled = false
silentAimFOVCircle.Visible = false
silentAimFOVCircle.Transparency = 1
silentAimFOVCircle.ZIndex = 5
aimbotFOVFill = D("Circle")
aimbotFOVFill.Thickness = 0
aimbotFOVFill.Filled = true
aimbotFOVFill.Visible = false
aimbotFOVFill.Transparency = 0.5
aimbotFOVFill.ZIndex = 4
aimbotTracerLine = D("Line")
aimbotTracerLine.Thickness = 1.5
aimbotTracerLine.Visible = false
aimbotTracerLine.Transparency = 1
aimbotTracerLine.ZIndex = 6
disableAimbot = function()
    aimbotSettings.Locked = false
    if aimbotFOVCircle then aimbotFOVCircle.Visible = false end
    if aimbotFOVFill then aimbotFOVFill.Visible = false end
    if aimbotTracerLine then aimbotTracerLine.Visible = false end
end
local function getTargetHitboxPart(char, mode)
    if not char then return nil end
    if mode == "Head" then
        return char:FindFirstChild("Head")
    elseif mode == "Body" then
        return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    elseif mode == "Random" then
        local parts = {}
        for _, n in ipairs({"Head", "HumanoidRootPart", "UpperTorso", "Torso", "RightUpperArm", "LeftUpperArm"}) do
            local p = char:FindFirstChild(n)
            if p then table.insert(parts, p) end
        end
        if #parts > 0 then
            return parts[math.random(1, #parts)]
        end
        return char:FindFirstChild("Head")
    end
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end
local function findBestAimbotTarget()
    local cam = workspace.CurrentCamera
    if not cam then return nil, nil, 999999 end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local bestTarget = nil
    local bestPart = nil
    local bestDist = aimbotSettings.FOVRadius or 90
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local part = getTargetHitboxPart(char, aimbotSettings.Hitbox)
                if part then
                    local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                    if onScreen and screenPos.Z > 0 then
                        local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                        local dist = (screenVec - center).Magnitude
                        if dist <= bestDist then
                            bestDist = dist
                            bestTarget = p
                            bestPart = part
                        end
                    end
                end
            end
        end
    end
    return bestTarget, bestPart, bestDist
end
local function updateAimbot()
    local cam = workspace.CurrentCamera
    if not cam then return end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    if aimbotSettings.Enabled and (aimbotSettings.ShowFOVCircle or aimbotSettings.ShowFOVFill) then
        local radius = aimbotSettings.FOVRadius or 90
        if aimbotSettings.ShowFOVCircle and aimbotFOVCircle then
            aimbotFOVCircle.Position = center
            aimbotFOVCircle.Radius = radius
            aimbotFOVCircle.Color = aimbotSettings.FOVCircleColor
            aimbotFOVCircle.Visible = true
        elseif aimbotFOVCircle then
            aimbotFOVCircle.Visible = false
        end
        if aimbotSettings.ShowFOVFill and aimbotFOVFill then
            aimbotFOVFill.Position = center
            aimbotFOVFill.Radius = radius
            aimbotFOVFill.Color = aimbotSettings.FOVFillColor
            aimbotFOVFill.Transparency = aimbotSettings.FOVFillTransparency
            aimbotFOVFill.Visible = true
        elseif aimbotFOVFill then
            aimbotFOVFill.Visible = false
        end
    else
        if aimbotFOVCircle then aimbotFOVCircle.Visible = false end
        if aimbotFOVFill then aimbotFOVFill.Visible = false end
    end
    if not aimbotSettings.Enabled then
        if aimbotTracerLine then aimbotTracerLine.Visible = false end
        return
    end
    local targetPlayer, targetPart, targetDist = findBestAimbotTarget()
    if aimbotSettings.ShowTracer and targetPart and aimbotTracerLine then
        local screenPos, onScreen = cam:WorldToViewportPoint(targetPart.Position)
        if onScreen and screenPos.Z > 0 then
            aimbotTracerLine.From = center
            aimbotTracerLine.To = Vector2.new(screenPos.X, screenPos.Y)
            aimbotTracerLine.Color = aimbotSettings.TracerColor
            aimbotTracerLine.Visible = true
        else
            aimbotTracerLine.Visible = false
        end
    elseif aimbotTracerLine then
        aimbotTracerLine.Visible = false
    end
    local aimKey = Library.Flags["aimbot_key"]
    local currentAimKey = (type(aimKey) == "table" and aimKey.Key) or (aimKey and typeof(aimKey) == "EnumItem" and aimKey) or aimbotSettings.Key
    local aimMode = (type(aimKey) == "table" and aimKey.Mode) or "Hold"
    if aimMode == "Hold" then
        aimbotSettings.Locked = isInputHeld(currentAimKey)
    elseif aimMode == "Always" then
        aimbotSettings.Locked = true
    end
    if aimbotSettings.Locked and targetPart then
        local targetCFrame = CFrame.lookAt(cam.CFrame.Position, targetPart.Position)
        local smoothFactor = math.clamp(aimbotSettings.Smoothness or 1, 1, 25)
        if smoothFactor <= 1.05 then
            cam.CFrame = targetCFrame
        else
            cam.CFrame = cam.CFrame:Lerp(targetCFrame, 1 / smoothFactor)
        end
    end
end
local function setupAimSystems()
silentAimSettings = {
    Enabled = false,
    Hitbox = "Head",
    FOV = 90,
    RemoteName = "Shot",
    AutoDetect = true,
    BallisticComp = false,
    DropComp = 10,
    ShowFOVCircle = true,
    FOVCircleColor = Color3.fromRGB(255, 255, 255),
}
local silentAimHook = nil
local silentAimHooked = false
local function silentAimTargetPart()
    local cam = workspace.CurrentCamera
    if not cam then
        print("[SilentAim] no camera")
        return nil
    end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local best = nil
    local bestDist = silentAimSettings.FOV
    local seen = 0
    local alive = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                alive = alive + 1
                local part = getTargetHitboxPart(char, silentAimSettings.Hitbox)
                if part then
                    local sp, on = cam:WorldToViewportPoint(part.Position)
                    if on and sp.Z > 0 then
                        seen = seen + 1
                        local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        print("[SilentAim] candidate " .. p.Name .. " dist " .. math.floor(d) .. " fov " .. silentAimSettings.FOV)
                        if d <= bestDist then
                            bestDist = d
                            best = part
                        end
                    end
                end
            end
        end
    end
    print("[SilentAim] target scan: alive " .. alive .. " seen " .. seen)
    return best
end
local function remoteMatches(self)
    if not self or not self.Name then return false end
    local n = self.Name:lower()
    local parent = self.Parent
    local parentName = parent and parent.Name:lower() or ""
    if silentAimSettings.RemoteName ~= "" then
        local want = silentAimSettings.RemoteName:lower()
        if n:find(want, 1, true) then
            return true
        end
        if parentName:find(want, 1, true) then
            return true
        end
    end
    if silentAimSettings.AutoDetect then
        if n:find("shoot") or n:find("fire") or n:find("gun") or n:find("weapon") or n:find("bullet") or n:find("hit") then
            return true
        end
        if parentName:find("gunsystem") or parentName:find("remote") then
            return true
        end
    end
    return false
end
local function modifySilentArgs(args, targetPart)
    if not targetPart then return end
    local cam = workspace.CurrentCamera
    local tp = targetPart.Position
    print("[SilentAim] modifySilentArgs: " .. select("#", args) .. " args, target: " .. tostring(tp))
    for i = 1, #args do
        local v = args[i]
        if typeof(v) == "CFrame" then
            args[i] = CFrame.lookAt(v.Position, tp)
            print("[SilentAim] replaced CFrame arg " .. i)
            return
        elseif typeof(v) == "Vector3" then
            local origin = cam and cam.CFrame.Position or tp
            args[i] = (tp - origin).Unit * v.Magnitude
            print("[SilentAim] replaced Vector3 arg " .. i)
            return
        elseif type(v) == "table" then
            if typeof(v.CameraDirection) == "Vector3" then
                local origin = v.CameraOrigin
                if typeof(origin) ~= "Vector3" and typeof(v.MuzzleOrigin) == "Vector3" then
                    origin = v.MuzzleOrigin
                end
                if typeof(origin) ~= "Vector3" then
                    origin = cam and cam.CFrame.Position or tp
                end
                local dir = (tp - origin).Unit
                if silentAimSettings.BallisticComp then
                    local dist = (tp - origin).Magnitude
                    local aim = (tp - origin) + Vector3.new(0, dist * silentAimSettings.DropComp * 0.001, 0)
                    dir = aim.Unit
                    print("[SilentAim] ballistic comp applied, dist: " .. math.floor(dist))
                end
                local newArgs = {}
                for k, val in pairs(v) do
                    newArgs[k] = val
                end
                newArgs.CameraDirection = dir
                args[i] = newArgs
                print("[SilentAim] replaced CameraDirection: " .. tostring(dir))
                return
            end
            for k, val in pairs(v) do
                if typeof(val) == "CFrame" then
                    v[k] = CFrame.lookAt(val.Position, tp)
                    print("[SilentAim] replaced table CFrame " .. tostring(k))
                    return
                elseif typeof(val) == "Vector3" then
                    v[k] = tp
                    print("[SilentAim] replaced table Vector3 " .. tostring(k))
                    return
                end
            end
        end
    end
    print("[SilentAim] WARNING: no CFrame/Vector3/CameraDirection found in args")
end
enableSilentAim = function()
    print("[SilentAim] enableSilentAim called")
    print("[SilentAim] hookfunction:", type(hookfunction), "hookmetamethod:", type(hookmetamethod))
    pcall(function()
        local found = 0
        local stack = { ReplicatedStorage }
        while #stack > 0 do
            local node = table.remove(stack)
            local okKids, kids = pcall(function() return node:GetChildren() end)
            if okKids then
                for _, child in ipairs(kids) do
                    if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                        found = found + 1
                        print("[SilentAim] REMOTE: " .. child:GetFullName())
                    end
                    table.insert(stack, child)
                end
            end
        end
        print("[SilentAim] total remotes: " .. found)
    end)
    silentAimSettings.Enabled = true
    if silentAimHooked then
        print("[SilentAim] already hooked, skip")
        return
    end
    local hookedRemote = false
    if hookfunction then
        local foundRemote = nil
        local ok, remote = pcall(function()
            local ev = ReplicatedStorage
            local gs = ev:FindFirstChild("GunSystem")
            if gs then
                local re = gs:FindFirstChild("RemoteEvents")
                if re then
                    return re:FindFirstChild("Shot")
                end
            end
            return ev:FindFirstChild("Shot")
        end)
        if ok and remote and typeof(remote) == "Instance" and remote:IsA("RemoteEvent") then
            foundRemote = remote
        else
            local okScan, found = pcall(function()
                local stack = { ReplicatedStorage }
                while #stack > 0 do
                    local node = table.remove(stack)
                    local okKids, kids = pcall(function() return node:GetChildren() end)
                    if okKids then
                        for _, child in ipairs(kids) do
                            if child:IsA("RemoteEvent") and child.Name == "Shot" then
                                return child
                            end
                            table.insert(stack, child)
                        end
                    end
                end
                return nil
            end)
            if okScan and found then
                foundRemote = found
            end
        end
        if foundRemote and typeof(foundRemote) == "Instance" and foundRemote:IsA("RemoteEvent") then
            local oldFire = foundRemote.FireServer
            if type(oldFire) == "function" then
                local hookRemote = foundRemote
                local hookS = nil
                print("[SilentAim] Remote found: " .. foundRemote:GetFullName())
                Library:Notify({ Title = "SilentAim hooked: " .. foundRemote.Name, Lifetime = 3 })
                hookS = hookfunction(oldFire, function(...)
                    print("[SilentAim] FireServer hooked " .. hookRemote.Name .. " args: " .. select("#", ...))
                    if silentAimSettings.Enabled then
                        local all = { ... }
                        local args = {}
                        for i = 2, #all do
                            args[#args + 1] = all[i]
                        end
                        if #args == 0 then
                            args = all
                        end
                        local target = silentAimTargetPart()
                        if target then
                            print("[SilentAim] Target found: " .. target.Name)
                            modifySilentArgs(args, target)
                            print("[SilentAim] Args modified, firing")
                            return hookS(hookRemote, unpack(args))
                        else
                            print("[SilentAim] No target in FOV, firing normally")
                        end
                    else
                        print("[SilentAim] Disabled, passing through")
                    end
                    return hookS(hookRemote, ...)
                end)
                silentAimHooked = true
                hookedRemote = true
            end
        end
    end
    if hookedRemote then
        print("[SilentAim] hooked via hookfunction")
        return
    end
    if not hookfunction then
        Library:Notify({ Title = "hook not supported", Lifetime = 3 })
        print("[SilentAim] FAILED: no hookfunction")
        return
    end
end
disableSilentAim = function()
    silentAimSettings.Enabled = false
end
end
setupAimSystems()
local morphPresets = {
    ["tung tung sahur"] = "rbxassetid://138151705692565",
    ["стульчанский"] = "rbxassetid://71941307275902",
    ["pig"] = "rbxassetid://18525349193",
}

morphSettings = {
    Enabled = false,
    Preset = "tung tung sahur",
    LoadedAssets = {},
    CurrentClone = nil,
}

removeMorph = function()
    local char = LocalPlayer.Character
    if char then
        local old = char:FindFirstChild("ForceMorphModel")
        if old then old:Destroy() end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
                local dec = part:FindFirstChildOfClass("Decal")
                if dec then dec.Transparency = 0 end
            end
        end
    end
    morphSettings.CurrentClone = nil
end

local function getOrLoadAsset(assetId)
    if morphSettings.LoadedAssets[assetId] then
        return morphSettings.LoadedAssets[assetId]
    end
    local success, objects = pcall(function()
        return game:GetObjects(assetId)
    end)
    if success and objects and objects[1] then
        local loadedAsset = objects[1]
        for _, v in pairs(loadedAsset:GetDescendants()) do
            if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("Humanoid") then
                v:Destroy()
            end
        end
        morphSettings.LoadedAssets[assetId] = loadedAsset
        return loadedAsset
    end
    return nil
end

applyMorph = function(char)
    if not morphSettings.Enabled then return end
    char = char or LocalPlayer.Character
    if not char then return end
    local root = char:WaitForChild("HumanoidRootPart", 5)
    local hum = char:WaitForChild("Humanoid", 5)
    if not root or not hum then return end

    local assetId = morphPresets[morphSettings.Preset] or "rbxassetid://138151705692565"
    local loadedAsset = getOrLoadAsset(assetId)
    if not loadedAsset then return end

    local old = char:FindFirstChild("ForceMorphModel")
    if old then old:Destroy() end

    local clone = loadedAsset:Clone()
    clone.Name = "ForceMorphModel"

    local primaryPart = nil
    if clone:IsA("Model") then
        primaryPart = clone.PrimaryPart or clone:FindFirstChild("HumanoidRootPart") or clone:FindFirstChild("Torso") or clone:FindFirstChild("UpperTorso")
    end

    for _, part in pairs(clone:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.Massless = true
            part.Anchored = false
        end
    end

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
            local dec = part:FindFirstChildOfClass("Decal")
            if dec then dec.Transparency = 1 end
        end
    end

    if clone:IsA("Model") then
        if not primaryPart then
            for _, p in pairs(clone:GetDescendants()) do
                if p:IsA("BasePart") then
                    primaryPart = p
                    break
                end
            end
        end
        if primaryPart then
            clone:PivotTo(root.CFrame)
            for _, part in pairs(clone:GetDescendants()) do
                if part:IsA("BasePart") and part ~= primaryPart then
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = primaryPart
                    weld.Part1 = part
                    weld.Parent = primaryPart
                end
            end
            local rootWeld = Instance.new("WeldConstraint")
            rootWeld.Part0 = root
            rootWeld.Part1 = primaryPart
            rootWeld.Parent = root
        end
    elseif clone:IsA("BasePart") then
        clone.CFrame = root.CFrame
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = root
        weld.Part1 = clone
        weld.Parent = root
    end

    clone.Parent = char
    morphSettings.CurrentClone = clone
end

disableMorph = function()
    morphSettings.Enabled = false
    removeMorph()
end

hitboxExpanderSettings = {
    Enabled = false,
    Hitbox = "Head",
    Size = 8,
    Transparency = 0.5,
}
local originalHitboxProps = {}
local function restoreHitboxPart(part)
    local orig = originalHitboxProps[part]
    if orig and part and part.Parent then
        pcall(function()
            part.Size = orig.Size
            part.Transparency = orig.Transparency
            part.CanCollide = orig.CanCollide
            part.Massless = orig.Massless
        end)
    end
    originalHitboxProps[part] = nil
end
updateHitboxExpander = function()
    if not hitboxExpanderSettings.Enabled then return end
    local targetSize = Vector3.new(hitboxExpanderSettings.Size or 8, hitboxExpanderSettings.Size or 8, hitboxExpanderSettings.Size or 8)
    local targetTrans = hitboxExpanderSettings.Transparency or 0.5
    local currentHitboxMode = hitboxExpanderSettings.Hitbox or "Head"
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local head = char:FindFirstChild("Head")
                local root = char:FindFirstChild("HumanoidRootPart")
                if currentHitboxMode == "Head" then
                    if head and head:IsA("BasePart") then
                        if not originalHitboxProps[head] then
                            originalHitboxProps[head] = {
                                Size = head.Size,
                                Transparency = head.Transparency,
                                CanCollide = head.CanCollide,
                                Massless = head.Massless,
                            }
                        end
                        head.Size = targetSize
                        head.Transparency = targetTrans
                        head.CanCollide = false
                        head.Massless = true
                    end
                    if root and originalHitboxProps[root] then
                        restoreHitboxPart(root)
                    end
                elseif currentHitboxMode == "Body" then
                    local bodyPart = root or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                    if bodyPart and bodyPart:IsA("BasePart") then
                        if not originalHitboxProps[bodyPart] then
                            originalHitboxProps[bodyPart] = {
                                Size = bodyPart.Size,
                                Transparency = bodyPart.Transparency,
                                CanCollide = bodyPart.CanCollide,
                                Massless = bodyPart.Massless,
                            }
                        end
                        bodyPart.Size = targetSize
                        bodyPart.Transparency = targetTrans
                        bodyPart.CanCollide = false
                        bodyPart.Massless = true
                    end
                    if head and originalHitboxProps[head] then
                        restoreHitboxPart(head)
                    end
                end
            end
        end
    end
end
disableHitboxExpander = function()
    for part, _ in pairs(originalHitboxProps) do
        restoreHitboxPart(part)
    end
    originalHitboxProps = {}
end
table.insert(scriptConnections, RunService.RenderStepped:Connect(function(dt)
    local m4 = false
    local m5 = false
    if isKeyFunc then
        m4 = pcall(function() return isKeyFunc(0x05) end) and isKeyFunc(0x05) or false
        m5 = pcall(function() return isKeyFunc(0x06) end) and isKeyFunc(0x06) or false
    end
    if mouseBackEnum then
        local okB, backBtn = pcall(function() return UserInputService:IsKeyDown(mouseBackEnum) end)
        if okB and backBtn == true then
            m4 = true
        end
    end
    inputState.custom["MB4"] = m4
    inputState.custom["MB5"] = m5
    for player, esp in pairs(PlayerESPObjects) do
        if player and player.Parent then
            pcall(UpdatePlayerESP, player)
        else
            HidePlayerESP(player)
        end
    end
    for player in pairs(ChamsObjects) do
        if player and player.Parent then
            pcall(UpdateChams, player)
        end
    end
    if fovChangerActive then
        Camera.FieldOfView = targetFOV
    end
    if orbsSettings and orbsSettings.Enabled then
        pcall(updateOrbs, dt)
    end
    if aimbotSettings and aimbotSettings.Enabled then
        pcall(updateAimbot)
    elseif aimbotFOVCircle and aimbotFOVCircle.Visible then
        aimbotFOVCircle.Visible = false
        if aimbotFOVFill then aimbotFOVFill.Visible = false end
        if aimbotTracerLine then aimbotTracerLine.Visible = false end
    end
    if silentAimSettings and silentAimSettings.Enabled and silentAimFOVCircle then
        if silentAimSettings.ShowFOVCircle then
            local cam = workspace.CurrentCamera
            if cam then
                silentAimFOVCircle.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                silentAimFOVCircle.Radius = silentAimSettings.FOV
                silentAimFOVCircle.Color = silentAimSettings.FOVCircleColor
                silentAimFOVCircle.Visible = true
            end
        else
            silentAimFOVCircle.Visible = false
        end
    elseif silentAimFOVCircle then
        silentAimFOVCircle.Visible = false
    end
    if hitboxExpanderSettings and hitboxExpanderSettings.Enabled then
        pcall(updateHitboxExpander)
    end
    if freecamState and freecamState.active then
        pcall(updateFreecamTracer, Camera)
    elseif freecamState and freecamState.tracerLines then
        for _, l in ipairs(freecamState.tracerLines) do
            if l.Visible then l.Visible = false end
        end
    end
end))
table.insert(scriptConnections, RunService.Heartbeat:Connect(function(dt)
    espUpdateTimer = espUpdateTimer + dt
    if espUpdateTimer < espUpdateInterval then return end
    espUpdateTimer = 0
    if oreESPActive then
        updateESPSet(oreESPObjects, oreESPSettings, removeOreBillboard)
    end
    if lootESPActive then
        updateESPSet(lootESPObjects, lootESPSettings, removeLootBillboard)
    end
    if boatESPActive then
        updateESPSet(boatESPObjects, boatESPSettings, removeBoatBillboard)
    end
end))
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        CreateChams(p)
        CreatePlayerESP(p)
    end
end
table.insert(scriptConnections, Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        CreateChams(player)
        CreatePlayerESP(player)
    end
end))
table.insert(scriptConnections, Players.PlayerRemoving:Connect(function(player)
    RemoveChams(player)
    RemovePlayerESP(player)
end))
local fullbrightConnections = {}
local fullbrightActive = false
local function applyFullbright()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
end
local function enableFullbright()
    fullbrightActive = true
    applyFullbright()
    table.insert(fullbrightConnections, Lighting.Changed:Connect(function()
        if fullbrightActive then
            task.spawn(function()
                task.wait()
                if fullbrightActive then
                    applyFullbright()
                end
            end)
        end
    end))
end
disableFullbright = function()
    fullbrightActive = false
    for _, conn in ipairs(fullbrightConnections) do
        conn:Disconnect()
    end
    fullbrightConnections = {}
    Lighting.Brightness = originalLighting.Brightness
    Lighting.ClockTime = originalLighting.ClockTime
    Lighting.FogEnd = originalLighting.FogEnd
    Lighting.GlobalShadows = originalLighting.GlobalShadows
    Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
    Lighting.Ambient = originalLighting.Ambient
end
local originalGetRecoil = nil
local originalRecoilTables = {}
local noRecoilActive = false
local function applyNoRecoil()
    local recoilConfig = ReplicatedStorage:FindFirstChild("RecoilConfig")
    if recoilConfig and recoilConfig:IsA("ModuleScript") then
        local ok, module = pcall(require, recoilConfig)
        if ok and type(module) == "table" then
            if module.GetRecoil and not originalGetRecoil then
                originalGetRecoil = module.GetRecoil
            end
            module.GetRecoil = function(p1, p2)
                return Vector3.new(0, 0, 0)
            end
            for weaponName, patternTable in pairs(module) do
                if type(patternTable) == "table" then
                    if not originalRecoilTables[weaponName] then
                        originalRecoilTables[weaponName] = {
                            Modifier = patternTable.Modifier,
                        }
                    end
                    patternTable.Modifier = 0
                    for k, v in pairs(patternTable) do
                        if typeof(v) == "Vector3" then
                            if originalRecoilTables[weaponName][k] == nil then
                                originalRecoilTables[weaponName][k] = v
                            end
                            patternTable[k] = Vector3.new(0, 0, 0)
                        end
                    end
                end
            end
        end
    end
end
local function enableNoRecoil()
    noRecoilActive = true
    applyNoRecoil()
end
disableNoRecoil = function()
    noRecoilActive = false
    local recoilConfig = ReplicatedStorage:FindFirstChild("RecoilConfig")
    if recoilConfig and recoilConfig:IsA("ModuleScript") then
        local ok, module = pcall(require, recoilConfig)
        if ok and type(module) == "table" then
            if originalGetRecoil then
                module.GetRecoil = originalGetRecoil
            end
            for weaponName, origData in pairs(originalRecoilTables) do
                local patternTable = module[weaponName]
                if type(patternTable) == "table" then
                    if origData.Modifier ~= nil then
                        patternTable.Modifier = origData.Modifier
                    end
                    for k, v in pairs(origData) do
                        if k ~= "Modifier" and typeof(v) == "Vector3" then
                            patternTable[k] = v
                        end
                    end
                end
            end
        end
    end
    originalRecoilTables = {}
end
local FlyConfig = {
    Enabled = false,
    Speed = 1,
    Key = Enum.KeyCode.E,
}
flyState = {
    flying = false,
    conn = nil,
    character = nil,
    hrp = nil,
    humanoid = nil,
    camera = workspace.CurrentCamera,
    keys = { W = false, S = false, A = false, D = false, Space = false, LeftShift = false },
}
local function startFly()
    flyState.flying = true
    if flyState.conn then
        flyState.conn:Disconnect()
        flyState.conn = nil
    end
    local player = Players.LocalPlayer
    local initialChar = player and player.Character
    if initialChar then
        local hum = initialChar:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = true end
    end
    flyState.conn = RunService.RenderStepped:Connect(function()
        if not flyState.flying then return end
        local player = Players.LocalPlayer
        local char = player and player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        local cam = workspace.CurrentCamera
        if not hrp or not hum or hum.Health <= 0 or not cam then return end
        hum.PlatformStand = true
        local moveDirection = Vector3.new(0, 0, 0)
        if flyState.keys.W then moveDirection = moveDirection + cam.CFrame.LookVector end
        if flyState.keys.S then moveDirection = moveDirection - cam.CFrame.LookVector end
        if flyState.keys.A then moveDirection = moveDirection - cam.CFrame.RightVector end
        if flyState.keys.D then moveDirection = moveDirection + cam.CFrame.RightVector end
        if flyState.keys.Space then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
        if flyState.keys.LeftShift then moveDirection = moveDirection - Vector3.new(0, 1, 0) end
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit * FlyConfig.Speed
        end
        hrp.CFrame = CFrame.new(hrp.Position + moveDirection, hrp.Position + cam.CFrame.LookVector * 50)
        hrp.Velocity = Vector3.new(0, 0, 0)
    end)
end
stopFly = function()
    flyState.flying = false
    if flyState.conn then
        flyState.conn:Disconnect()
        flyState.conn = nil
    end
    local player = Players.LocalPlayer
    local char = player and player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end
end
local function toggleFly()
    if flyState.flying then
        stopFly()
    else
        startFly()
    end
end
local function updateCharacter()
    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return end
    flyState.character = char
    flyState.hrp = char:FindFirstChild("HumanoidRootPart")
    flyState.humanoid = char:FindFirstChildOfClass("Humanoid")
    flyState.camera = workspace.CurrentCamera
    if flyState.flying and not flyState.hrp then
        stopFly()
    end
end
do
    local player = Players.LocalPlayer
    if player.Character then
        updateCharacter()
    end
    table.insert(scriptConnections, player.CharacterAdded:Connect(function(newChar)
        task.wait(0.1)
        updateCharacter()
        if morphSettings and morphSettings.Enabled then
            task.wait(0.1)
            applyMorph(newChar)
        end
        if orbsSettings and orbsSettings.Enabled then
            task.wait(0.1)
            refreshOrbs()
        end
    end))
    table.insert(scriptConnections, player.CharacterRemoving:Connect(function()
        clearOrbs()
    end))
end
local LastCfgFile = "Overflow.gg/LastConfig.cfg"
local function exportConfig()
    local config = Library:GetConfig()
    if writefile then
        pcall(writefile, LastCfgFile, config)
    end
    if setclipboard then
        pcall(setclipboard, config)
    end
    Library:Notify({ Title = "Config exported!", Lifetime = 3 })
end
local function importConfig()
    local rawData = nil
    if isfile and readfile and isfile(LastCfgFile) then
        local ok, res = pcall(readfile, LastCfgFile)
        if ok then
            rawData = res
        end
    end
    if (not rawData or rawData == "") and getclipboard then
        local ok, res = pcall(getclipboard)
        if ok and type(res) == "string" then
            rawData = res
        end
    end
    if not rawData or rawData == "" then
        Library:Notify({ Title = "No config found", Lifetime = 3 })
        return
    end
    rawData = string.match(rawData, "{.*}") or rawData
    local ok = pcall(function()
        Library:LoadConfig(rawData)
    end)
    if ok then
        Library:Notify({ Title = "Config imported!", Lifetime = 3 })
    else
        Library:Notify({ Title = "Invalid config data", Lifetime = 3 })
    end
end
Window = Library:CreateWindow({
    Title = "Overflow.gg",
    SubText = "Decay",
    Image = LogoAsset or "rbxassetid://95259225424429",
    IsMobile = false,
})
local function setupWindowExtras()
if Library.Window and Library.Window.Items and Library.Window.Items.Watermark and Library.Window.Items.Watermark.Instance then
    local wmInstance = Library.Window.Items.Watermark.Instance
    local layout = wmInstance:FindFirstChildOfClass("UIListLayout")
    if not layout then
        layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Horizontal
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = wmInstance
    end
    layout.Padding = UDim.new(0, 3)
    local titleLabel = wmInstance:FindFirstChildOfClass("TextLabel")
    if titleLabel then
        local titlePadding = titleLabel:FindFirstChildOfClass("UIPadding")
        if titlePadding then
            titlePadding.PaddingLeft = UDim.new(0, 2)
            titlePadding.PaddingRight = UDim.new(0, 6)
        end
    end
    local wmLogo = Instance.new("ImageLabel")
    wmLogo.Name = "WatermarkLogo"
    wmLogo.LayoutOrder = 0
    wmLogo.Size = UDim2.fromOffset(15, 15)
    wmLogo.BackgroundTransparency = 1
    wmLogo.Image = (isfile and isfile(logoPath) and getcustomasset and getcustomasset(logoPath)) or LogoAsset or "rbxassetid://95259225424429"
    wmLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
    wmLogo.Parent = wmInstance
    Library.Window.Items.WatermarkLogo = { Instance = wmLogo }
end
if Library.Window and Library.Window.Items then
    if Library.Window.Items.Watermark and Library.Window.Items.Watermark.Instance then
        Library.Window.Items.Watermark.Instance.Visible = false
    end
    if Library.Window.Items.KeybindList and Library.Window.Items.KeybindList.Instance then
        Library.Window.Items.KeybindList.Instance.Visible = false
    end
    if Library.Window.Items.ModList and Library.Window.Items.ModList.Instance then
        Library.Window.Items.ModList.Instance.Visible = false
    end
end
end
setupWindowExtras()
local function buildUI()
local AimPage = Window:AddTab({
    Text = "Combat",
    Icon = "rbxassetid://10734975692",
    Pages = {"Aimbot"},
})
do
    local GunModSection = AimPage:AddSection({
        Title = "Gun Mod",
        Side = "Left",
    })
    GunModSection:AddToggle({
        Text = "No Recoil",
        Flag = "no_recoil",
        Default = false,
        Callback = function(value)
            if value then
                enableNoRecoil()
            else
                disableNoRecoil()
            end
        end,
    })
    GunModSection:AddToggle({
        Text = "Hitbox Expander",
        Flag = "hitbox_expander_enabled",
        Default = false,
        Callback = function(value)
            hitboxExpanderSettings.Enabled = value
            if not value then
                disableHitboxExpander()
            end
        end,
    })
    GunModSection:AddDropdown({
        Text = "Hitbox Part",
        Flag = "hitbox_expander_part",
        Options = {"Head", "Body"},
        Default = "Head",
        Callback = function(value)
            hitboxExpanderSettings.Hitbox = value
        end,
    })
    GunModSection:AddSlider({
        Text = "Hitbox Size",
        Flag = "hitbox_expander_size",
        Min = 2,
        Max = 7,
        Default = 7,
        Suffix = " studs",
        Callback = function(value)
            hitboxExpanderSettings.Size = value
        end,
    })
    GunModSection:AddSlider({
        Text = "Hitbox Transparency",
        Flag = "hitbox_expander_trans",
        Min = 0,
        Max = 100,
        Default = 50,
        Suffix = "%",
        Callback = function(value)
            hitboxExpanderSettings.Transparency = value / 100
        end,
    })
    local SilentSection = AimPage:AddSection({
        Title = "Silent Aim",
        Side = "Left",
    })
    SilentSection:AddToggle({
        Text = "Enabled",
        Flag = "silentaim_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableSilentAim()
            else
                disableSilentAim()
            end
        end,
    })
    SilentSection:AddDropdown({
        Text = "Hitbox",
        Flag = "silentaim_hitbox",
        Options = {"Head", "Body", "Random"},
        Default = "Head",
        Callback = function(value)
            silentAimSettings.Hitbox = value
        end,
    })
    SilentSection:AddSlider({
        Text = "FOV",
        Flag = "silentaim_fov",
        Min = 10,
        Max = 180,
        Default = 90,
        Suffix = "°",
        Callback = function(value)
            silentAimSettings.FOV = value
        end,
    })
    SilentSection:AddToggle({
        Text = "FOV Circle",
        Flag = "silentaim_fov_circle",
        Default = true,
        Callback = function(value)
            silentAimSettings.ShowFOVCircle = value
            if not value and silentAimFOVCircle then
                silentAimFOVCircle.Visible = false
            end
        end,
    })
    SilentSection:AddColorPicker({
        Text = "FOV Circle Color",
        Flag = "silentaim_fov_circle_color",
        Default = Color3.fromRGB(255, 255, 255),
        Transparency = 0,
        Callback = function(color)
            silentAimSettings.FOVCircleColor = color
        end,
    })
    SilentSection:AddToggle({
        Text = "Ballistic Comp",
        Flag = "silentaim_ballistic",
        Default = false,
        Callback = function(value)
            silentAimSettings.BallisticComp = value
        end,
    })
    SilentSection:AddSlider({
        Text = "Drop Comp",
        Flag = "silentaim_dropcomp",
        Min = 1,
        Max = 100,
        Default = 10,
        Callback = function(value)
            silentAimSettings.DropComp = value
        end,
    })
    local AimbotSection = AimPage:AddSection({
        Title = "Aimbot",
        Side = "Right",
    })
    AimbotSection:AddToggle({
        Text = "Aim Lock",
        Flag = "aimbot_enabled",
        Default = false,
        Callback = function(value)
            aimbotSettings.Enabled = value
            if not value then
                disableAimbot()
            end
        end,
    })
    AimbotSection:AddKeyPicker({
        Text = "Aim Lock Key",
        Flag = "aimbot_key",
        Default = Enum.UserInputType.MouseButton2,
        Mode = "Hold",
        Callback = function(value)
            aimbotSettings.Key = value
        end,
    })
    local hitboxOptions = {"Head", "Body", "Random"}
    AimbotSection:AddDropdown({
        Text = "Hitbox",
        Flag = "aimbot_hitbox",
        Options = hitboxOptions,
        Default = "Head",
        Callback = function(value)
            aimbotSettings.Hitbox = value
        end,
    })
    AimbotSection:AddSlider({
        Text = "FOV Radius",
        Flag = "aimbot_fov",
        Min = 10,
        Max = 180,
        Default = 90,
        Suffix = "°",
        Callback = function(value)
            aimbotSettings.FOVRadius = value
        end,
    })
    AimbotSection:AddSlider({
        Text = "Smoothness",
        Flag = "aimbot_smooth",
        Min = 1,
        Max = 20,
        Default = 5,
        Callback = function(value)
            aimbotSettings.Smoothness = value
        end,
    })
    AimbotSection:AddToggle({
        Text = "FOV Circle",
        Flag = "aimbot_fov_circle",
        Default = true,
        Callback = function(value)
            aimbotSettings.ShowFOVCircle = value
            if not value and aimbotFOVCircle then
                aimbotFOVCircle.Visible = false
            end
        end,
    })
    AimbotSection:AddColorPicker({
        Text = "FOV Circle Color",
        Flag = "aimbot_fov_circle_color",
        Default = Color3.fromRGB(255, 255, 255),
        Transparency = 0,
        Callback = function(color)
            aimbotSettings.FOVCircleColor = color
        end,
    })
    AimbotSection:AddToggle({
        Text = "FOV Field Circle",
        Flag = "aimbot_fov_fill",
        Default = false,
        Callback = function(value)
            aimbotSettings.ShowFOVFill = value
            if not value and aimbotFOVFill then
                aimbotFOVFill.Visible = false
            end
        end,
    })
    AimbotSection:AddColorPicker({
        Text = "FOV Field Color",
        Flag = "aimbot_fov_fill_color",
        Default = Color3.fromRGB(0, 0, 0),
        Transparency = 0.5,
        Callback = function(color, alpha)
            aimbotSettings.FOVFillColor = color
            if alpha ~= nil then
                aimbotSettings.FOVFillTransparency = alpha
            end
        end,
    })
    AimbotSection:AddSlider({
        Text = "FOV Field Transparency",
        Flag = "aimbot_fov_fill_trans",
        Min = 0,
        Max = 100,
        Default = 50,
        Suffix = "%",
        Callback = function(value)
            aimbotSettings.FOVFillTransparency = value / 100
        end,
    })
    AimbotSection:AddToggle({
        Text = "Tracer to Target in FOV",
        Flag = "aimbot_tracer",
        Default = false,
        Callback = function(value)
            aimbotSettings.ShowTracer = value
            if not value and aimbotTracerLine then
                aimbotTracerLine.Visible = false
            end
        end,
    })
    AimbotSection:AddColorPicker({
        Text = "Tracer Color",
        Flag = "aimbot_tracer_color",
        Default = Color3.fromRGB(255, 45, 45),
        Transparency = 0,
        Callback = function(color)
            aimbotSettings.TracerColor = color
        end,
    })
end
local VisualsPlayersPage, VisualsWorldPage, VisualsLocalPage = Window:AddTab({
    Text = "Visuals",
    Icon = "rbxassetid://10723345749",
    Pages = {"Players", "World", "Local"},
})
do
    local ESPSection = VisualsPlayersPage:AddSection({
        Title = "ESP",
        Side = "Left",
    })
    ESPSection:AddToggle({
        Text = "Enable ESP",
        Flag = "player_esp_enabled",
        Default = false,
        Callback = function(value)
            PlayerESP.Enabled = value
            if not value then
                for p in pairs(PlayerESPObjects) do
                    HidePlayerESP(p)
                end
            end
        end,
    })
    ESPSection:AddToggle({
        Text = "Show Boxes",
        Flag = "player_esp_boxes",
        Default = false,
        Callback = function(value)
            PlayerESP.Boxes = value
            if not value then
                for _, esp in pairs(PlayerESPObjects) do
                    if esp.Box then esp.Box.Visible = false end
                    if esp.Corners then
                        for _, l in ipairs(esp.Corners) do l.Visible = false end
                    end
                    if esp.Lines3D then
                        for _, l in ipairs(esp.Lines3D) do l.Visible = false end
                    end
                end
            end
        end,
    })
    local espModes = {"Box", "Corner", "3D"}
    ESPSection:AddDropdown({
        Text = "Mode",
        Flag = "player_esp_mode",
        Options = espModes,
        Default = "Box",
        Callback = function(value)
            PlayerESP.Mode = value
            for p in pairs(PlayerESPObjects) do
                HidePlayerESP(p)
            end
        end,
    })
    ESPSection:AddSlider({
        Text = "Max Distance",
        Flag = "player_esp_maxdist",
        Min = 100,
        Max = 5000,
        Default = 5000,
        Callback = function(value)
            PlayerESP.MaxDistance = value
        end,
    })
    ESPSection:AddColorPicker({
        Text = "Box Color",
        Flag = "player_esp_color",
        Default = Color3.fromRGB(255, 255, 255),
        Transparency = 0,
        Callback = function(color)
            PlayerESP.BoxColor = color
        end,
    })
    ESPSection:AddToggle({
        Text = "Box Fill",
        Flag = "player_esp_boxfill",
        Default = false,
        Callback = function(value)
            PlayerESP.BoxFilled = value
            if not value then
                for _, esp in pairs(PlayerESPObjects) do
                    if esp.BoxFill then esp.BoxFill.Visible = false end
                end
            end
        end,
    })
    ESPSection:AddColorPicker({
        Text = "Box Fill Color",
        Flag = "player_esp_boxfill_color",
        Default = Color3.fromRGB(0, 0, 0),
        Transparency = 0,
        Callback = function(color)
            PlayerESP.BoxFillColor = color
        end,
    })
    ESPSection:AddSlider({
        Text = "Box Fill Transparency",
        Flag = "player_esp_boxfill_trans",
        Min = 0,
        Max = 100,
        Default = 50,
        Callback = function(value)
            PlayerESP.BoxFillTransparency = value / 100
        end,
    })
    ESPSection:AddToggle({
        Text = "Show Names",
        Flag = "player_esp_names",
        Default = false,
        Callback = function(value)
            PlayerESP.Names = value
            if not value then
                for _, esp in pairs(PlayerESPObjects) do
                    if esp.Name then esp.Name.Visible = false end
                end
            end
        end,
    })
    ESPSection:AddColorPicker({
        Text = "Name Color",
        Flag = "player_esp_namecolor",
        Default = Color3.fromRGB(255, 255, 255),
        Transparency = 0,
        Callback = function(color)
            PlayerESP.NameColor = color
        end,
    })
    ESPSection:AddToggle({
        Text = "Show Health",
        Flag = "player_esp_health",
        Default = false,
        Callback = function(value)
            PlayerESP.Health = value
            if not value then
                for _, esp in pairs(PlayerESPObjects) do
                    if esp.HealthOutline then esp.HealthOutline.Visible = false end
                    if esp.HealthFill then esp.HealthFill.Visible = false end
                    if esp.HealthText then esp.HealthText.Visible = false end
                end
            end
        end,
    })
    ESPSection:AddColorPicker({
        Text = "Health Color (High HP)",
        Flag = "player_esp_health_col1",
        Default = Color3.fromRGB(0, 255, 120),
        Transparency = 0,
        Callback = function(color)
            PlayerESP.HealthColor1 = color
        end,
    })
    ESPSection:AddColorPicker({
        Text = "Health Color (Low HP)",
        Flag = "player_esp_health_col2",
        Default = Color3.fromRGB(255, 45, 45),
        Transparency = 0,
        Callback = function(color)
            PlayerESP.HealthColor2 = color
        end,
    })
end
do
    local ChamsSec = VisualsPlayersPage:AddSection({
        Title = "Chams",
        Side = "Right",
    })
    ChamsSec:AddToggle({
        Text = "Enable Chams",
        Flag = "chams_enabled",
        Default = false,
        Callback = function(value)
            Chams.Enabled = value
        end,
    })
    local chamsModes = {"Highlight", "Wireframe", "Rainbow", "Pulsing", "Gradient"}
    ChamsSec:AddDropdown({
        Text = "Mode",
        Flag = "chams_mode",
        Options = chamsModes,
        Default = "Highlight",
        Callback = function(value)
            Chams.Mode = value
            for player in pairs(ChamsObjects) do
                ClearChams(player)
                CreateChams(player)
                UpdateChams(player)
            end
        end,
    })
    ChamsSec:AddColorPicker({
        Text = "Fill Color",
        Flag = "chams_fillcolor",
        Default = Color3.fromRGB(138, 43, 226),
        Transparency = 0,
        Callback = function(color)
            Chams.FillColor = color
            for _, c in pairs(ChamsObjects) do
                if c.HL and c.HL.Parent then c.HL.FillColor = color end
                for _, w in pairs(c.WireHLs) do if w and w.Parent then w.OutlineColor = color end end
            end
        end,
    })
    ChamsSec:AddColorPicker({
        Text = "Outline Color",
        Flag = "chams_outlinecolor",
        Default = Color3.fromRGB(75, 0, 130),
        Transparency = 0,
        Callback = function(color)
            Chams.OutlineColor = color
            for _, c in pairs(ChamsObjects) do
                if c.HL and c.HL.Parent then c.HL.OutlineColor = color end
            end
        end,
    })
    ChamsSec:AddSlider({
        Text = "Fill Transparency",
        Flag = "chams_filltrans",
        Min = 0,
        Max = 100,
        Default = 50,
        Callback = function(value)
            Chams.FillTransparency = value / 100
            for _, c in pairs(ChamsObjects) do
                if c.HL and c.HL.Parent then c.HL.FillTransparency = value / 100 end
            end
        end,
    })
    ChamsSec:AddSlider({
        Text = "Outline Transparency",
        Flag = "chams_outlinetrans",
        Min = 0,
        Max = 100,
        Default = 0,
        Callback = function(value)
            Chams.OutlineTransparency = value / 100
            for _, c in pairs(ChamsObjects) do
                if c.HL and c.HL.Parent then c.HL.OutlineTransparency = value / 100 end
            end
        end,
    })
    ChamsSec:AddSlider({
        Text = "Anim Speed",
        Flag = "chams_animspeed",
        Min = 1,
        Max = 15,
        Default = 3,
        Callback = function(value)
            Chams.AnimSpeed = value
        end,
    })
    ChamsSec:AddSlider({
        Text = "Pulse Speed",
        Flag = "chams_pulsespeed",
        Min = 1,
        Max = 10,
        Default = 2,
        Callback = function(value)
            Chams.PulseSpeed = value
        end,
    })
end
do
    local FogSection = VisualsWorldPage:AddSection({
        Title = "Fog",
        Side = "Left",
    })
    FogSection:AddToggle({
        Text = "Fog Delete",
        Flag = "fog_delete",
        Default = false,
        Callback = function(value)
            if value then
                enableFogDelete()
            else
                disableFogDelete()
            end
        end,
    })
end
do
    local FullbrightSection = VisualsWorldPage:AddSection({
        Title = "Fullbright",
        Side = "Left",
    })
    FullbrightSection:AddToggle({
        Text = "Enabled",
        Flag = "fullbright_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableFullbright()
            else
                disableFullbright()
            end
        end,
    })
end
do
    local TimeSection = VisualsWorldPage:AddSection({
        Title = "Time Changer",
        Side = "Right",
    })
    TimeSection:AddToggle({
        Text = "Enabled",
        Flag = "timechanger_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableTimeChanger(Library.Flags["time_changer"] or 14)
            else
                disableTimeChanger()
            end
        end,
    })
    TimeSection:AddSlider({
        Text = "Time",
        Flag = "time_changer",
        Min = 0,
        Max = 24,
        Default = 14,
        Callback = function(value)
            if timeChangerActive then
                if Library.Flags["skybox_enabled"] then
                    value = math.clamp(value, 8, 18)
                end
                Lighting.ClockTime = value
            end
        end,
    })
end
do
    local SkyboxSection = VisualsWorldPage:AddSection({
        Title = "Skybox",
        Side = "Right",
    })
    local skyboxOptions = {}
    for name, _ in pairs(skyboxPresets) do
        table.insert(skyboxOptions, name)
    end
    table.sort(skyboxOptions)
    SkyboxSection:AddToggle({
        Text = "Enabled",
        Flag = "skybox_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableSkybox(Library.Flags["skybox_select"] or skyboxOptions[1])
            else
                disableSkybox()
            end
        end,
    })
    SkyboxSection:AddDropdown({
        Text = "Skybox",
        Flag = "skybox_select",
        Options = skyboxOptions,
        Default = skyboxOptions[1] or "Purple Nebula",
        Callback = function(value)
            if Library.Flags["skybox_enabled"] then
                applySkybox(value)
            end
        end,
    })
end
do
    local OreESPSection = VisualsWorldPage:AddSection({
        Title = "Ore ESP",
        Side = "Left",
    })
    OreESPSection:AddToggle({
        Text = "Enabled",
        Flag = "oreesp_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableOreESP()
            else
                disableOreESP()
            end
        end,
    })
    OreESPSection:AddToggle({
        Text = "Show Name",
        Flag = "oreesp_name",
        Default = true,
        Callback = function(value)
            oreESPSettings.ShowName = value
        end,
    })
    OreESPSection:AddToggle({
        Text = "Show Distance",
        Flag = "oreesp_distance",
        Default = true,
        Callback = function(value)
            oreESPSettings.ShowDistance = value
        end,
    })
    OreESPSection:AddSlider({
        Text = "Max Distance",
        Flag = "oreesp_maxdist",
        Min = 100,
        Max = 5000,
        Default = 5000,
        Callback = function(value)
            oreESPSettings.MaxDistance = value
        end,
    })
    OreESPSection:AddColorPicker({
        Text = "Color",
        Flag = "oreesp_color",
        Default = Color3.fromRGB(255, 255, 255),
        Transparency = 0,
        Callback = function(color)
            oreESPSettings.Color = color
        end,
    })
end
do
    local LootESPSection = VisualsWorldPage:AddSection({
        Title = "Loot ESP",
        Side = "Right",
    })
    LootESPSection:AddToggle({
        Text = "Enabled",
        Flag = "lootesp_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableLootESP()
            else
                disableLootESP()
            end
        end,
    })
    LootESPSection:AddToggle({
        Text = "Show Name",
        Flag = "lootesp_name",
        Default = true,
        Callback = function(value)
            lootESPSettings.ShowName = value
        end,
    })
    LootESPSection:AddToggle({
        Text = "Show Distance",
        Flag = "lootesp_distance",
        Default = true,
        Callback = function(value)
            lootESPSettings.ShowDistance = value
        end,
    })
    LootESPSection:AddSlider({
        Text = "Max Distance",
        Flag = "lootesp_maxdist",
        Min = 100,
        Max = 5000,
        Default = 5000,
        Callback = function(value)
            lootESPSettings.MaxDistance = value
        end,
    })
    LootESPSection:AddColorPicker({
        Text = "Color",
        Flag = "lootesp_color",
        Default = Color3.fromRGB(0, 255, 0),
        Transparency = 0,
        Callback = function(color)
            lootESPSettings.Color = color
        end,
    })
end
do
    local BoatESPSection = VisualsWorldPage:AddSection({
        Title = "Boat ESP",
        Side = "Left",
    })
    BoatESPSection:AddToggle({
        Text = "Enabled",
        Flag = "boatesp_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableBoatESP()
            else
                disableBoatESP()
            end
        end,
    })
    BoatESPSection:AddToggle({
        Text = "Show Name",
        Flag = "boatesp_name",
        Default = true,
        Callback = function(value)
            boatESPSettings.ShowName = value
        end,
    })
    BoatESPSection:AddToggle({
        Text = "Show Distance",
        Flag = "boatesp_distance",
        Default = true,
        Callback = function(value)
            boatESPSettings.ShowDistance = value
        end,
    })
    BoatESPSection:AddSlider({
        Text = "Max Distance",
        Flag = "boatesp_maxdist",
        Min = 100,
        Max = 5000,
        Default = 5000,
        Callback = function(value)
            boatESPSettings.MaxDistance = value
        end,
    })
    BoatESPSection:AddColorPicker({
        Text = "Color",
        Flag = "boatesp_color",
        Default = Color3.fromRGB(0, 150, 255),
        Transparency = 0,
        Callback = function(color)
            boatESPSettings.Color = color
        end,
    })
end
do
    local CameraSec = VisualsLocalPage:AddSection({
        Title = "Camera",
        Side = "Left",
    })
    CameraSec:AddToggle({
        Text = "FOV Changer",
        Flag = "fov_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableFOVChanger(Library.Flags["fov_val"] or 70)
            else
                disableFOVChanger()
            end
        end,
    })
    CameraSec:AddSlider({
        Text = "Field of View",
        Flag = "fov_val",
        Min = 30,
        Max = 120,
        Default = 70,
        Callback = function(value)
            targetFOV = value
            if fovChangerActive then
                Camera.FieldOfView = value
            end
        end,
    })
    CameraSec:AddToggle({
        Text = "Third Person",
        Flag = "thirdperson_enabled",
        Default = false,
        Callback = function(value)
            thirdPersonSettings.MasterEnabled = value
            if value then
                enableThirdPerson()
            else
                disableThirdPerson()
            end
        end,
    })
    CameraSec:AddKeyPicker({
        Text = "Third Person Key",
        Flag = "thirdperson_key",
        Default = Enum.KeyCode.V,
        Mode = "Toggle",
        Callback = function(value)
            thirdPersonSettings.Key = value
        end,
    })
    CameraSec:AddSlider({
        Text = "Camera Distance",
        Flag = "thirdperson_dist",
        Min = 1,
        Max = 50,
        Default = 10,
        Suffix = " studs",
        Callback = function(value)
            thirdPersonSettings.Distance = value
        end,
    })
    CameraSec:AddSlider({
        Text = "Camera Height",
        Flag = "thirdperson_height",
        Min = -2,
        Max = 8,
        Default = 1.2,
        Callback = function(value)
            thirdPersonSettings.Height = value
        end,
    })
    CameraSec:AddToggle({
        Text = "Freecam",
        Flag = "freecam_enabled",
        Default = false,
        Callback = function(value)
            freecamSettings.MasterEnabled = value
            if value then
                if not freecamState.active then toggleFreecam() end
            else
                if freecamState.active then disableFreecam() end
            end
        end,
    })
    CameraSec:AddKeyPicker({
        Text = "Freecam Key",
        Flag = "freecam_key",
        Default = Enum.KeyCode.B,
        Mode = "Toggle",
        Callback = function(value)
            freecamSettings.Key = value
        end,
    })
    CameraSec:AddSlider({
        Text = "Freecam Speed",
        Flag = "freecam_speed",
        Min = 1,
        Max = 10,
        Default = 2,
        Callback = function(value)
            freecamSettings.Speed = value
        end,
    })
    CameraSec:AddColorPicker({
        Text = "Server Position Color",
        Flag = "freecam_serverpos_color",
        Default = Color3.fromRGB(0, 255, 120),
        Transparency = 0,
        Callback = function(color)
            freecamSettings.ServerPosColor = color
            if freecamState.serverGhost then
                for _, ghost in ipairs(freecamState.serverGhost) do
                    ghost.Color = color
                    local hl = ghost:FindFirstChildOfClass("Highlight")
                    if hl then hl.FillColor = color end
                end
            end
        end,
    })
    CameraSec:AddToggle({
        Text = "Server Pos Tracer",
        Flag = "freecam_tracer",
        Default = true,
        Callback = function(value)
            freecamSettings.ShowTracer = value
            if not value and freecamState.tracerLines then
                for _, l in ipairs(freecamState.tracerLines) do
                    l.Visible = false
                end
            end
        end,
    })
    local ArmChamsSection = VisualsLocalPage:AddSection({
        Title = "Arm Chams",
        Side = "Right",
    })
    ArmChamsSection:AddToggle({
        Text = "Enabled",
        Flag = "armchams_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableViewmodelChams()
            else
                disableViewmodelChams()
            end
        end,
    })
    ArmChamsSection:AddDropdown({
        Text = "Mode",
        Flag = "armchams_mode",
        Options = {"Highlight", "Outline", "Wireframe", "Rainbow", "Pulsing", "Gradient"},
        Default = "Highlight",
        Callback = function(value)
            viewmodelChamsSettings.Mode = value
        end,
    })
    ArmChamsSection:AddColorPicker({
        Text = "Fill Color",
        Flag = "armchams_fillcolor",
        Default = Color3.fromRGB(255, 0, 0),
        Transparency = 0,
        Callback = function(color)
            viewmodelChamsSettings.FillColor = color
        end,
    })
    ArmChamsSection:AddColorPicker({
        Text = "Outline Color",
        Flag = "armchams_outlinecolor",
        Default = Color3.fromRGB(255, 255, 255),
        Transparency = 0,
        Callback = function(color)
            viewmodelChamsSettings.OutlineColor = color
        end,
    })
    ArmChamsSection:AddSlider({
        Text = "Fill Transparency",
        Flag = "armchams_filltrans",
        Min = 0,
        Max = 100,
        Default = 20,
        Callback = function(value)
            viewmodelChamsSettings.FillTransparency = value / 100
        end,
    })
    ArmChamsSection:AddSlider({
        Text = "Outline Transparency",
        Flag = "armchams_outlinetrans",
        Min = 0,
        Max = 100,
        Default = 0,
        Callback = function(value)
            viewmodelChamsSettings.OutlineTransparency = value / 100
        end,
    })
    ArmChamsSection:AddSlider({
        Text = "Anim Speed",
        Flag = "armchams_animspeed",
        Min = 1,
        Max = 15,
        Default = 3,
        Callback = function(value)
            viewmodelChamsSettings.AnimSpeed = value
        end,
    })
    ArmChamsSection:AddSlider({
        Text = "Pulse Speed",
        Flag = "armchams_pulsespeed",
        Min = 1,
        Max = 10,
        Default = 2,
        Callback = function(value)
            viewmodelChamsSettings.PulseSpeed = value
        end,
    })
    local ViewmodelSection = VisualsLocalPage:AddSection({
        Title = "Viewmodel",
        Side = "Left",
    })
    ViewmodelSection:AddToggle({
        Text = "Enable Hand Pos",
        Flag = "viewmodel_pos_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableViewmodelPos()
            else
                disableViewmodelPos()
            end
        end,
    })
    local ViewmodelX = ViewmodelSection:AddSlider({
        Text = "Offset X (Left / Right)",
        Flag = "viewmodel_pos_x",
        Min = -3,
        Max = 3,
        Default = 0,
        Decimal = 0.1,
        Callback = function(value)
            viewmodelPosSettings.OffsetX = value
        end,
    })
    local ViewmodelY = ViewmodelSection:AddSlider({
        Text = "Offset Y (Up / Down)",
        Flag = "viewmodel_pos_y",
        Min = -3,
        Max = 3,
        Default = 0,
        Decimal = 0.1,
        Callback = function(value)
            viewmodelPosSettings.OffsetY = value
        end,
    })
    local ViewmodelZ = ViewmodelSection:AddSlider({
        Text = "Offset Z (Forward / Back)",
        Flag = "viewmodel_pos_z",
        Min = -3,
        Max = 3,
        Default = 0,
        Decimal = 0.1,
        Callback = function(value)
            viewmodelPosSettings.OffsetZ = value
        end,
    })
    ViewmodelSection:AddButton({
        Text = "Reset Offsets",
        Callback = function()
            viewmodelPosSettings.OffsetX = 0
            viewmodelPosSettings.OffsetY = 0
            viewmodelPosSettings.OffsetZ = 0
            ViewmodelX.Set(0)
            ViewmodelY.Set(0)
            ViewmodelZ.Set(0)
        end,
    })
    local OrbsSection = VisualsLocalPage:AddSection({
        Title = "Invoker Orbs",
        Side = "Right",
    })
    OrbsSection:AddToggle({
        Text = "Enabled",
        Flag = "orbs_enabled",
        Default = false,
        Callback = function(value)
            orbsSettings.Enabled = value
            if value then
                refreshOrbs()
            else
                clearOrbs()
            end
        end,
    })
    OrbsSection:AddSlider({
        Text = "Count",
        Flag = "orbs_count",
        Min = 1,
        Max = 10,
        Default = 3,
        Callback = function(value)
            orbsSettings.Count = value
            if orbsSettings.Enabled then
                refreshOrbs()
            end
        end,
    })
    OrbsSection:AddSlider({
        Text = "Radius",
        Flag = "orbs_radius",
        Min = 1,
        Max = 15,
        Default = 4,
        Callback = function(value)
            orbsSettings.Radius = value
        end,
    })
    OrbsSection:AddSlider({
        Text = "Speed",
        Flag = "orbs_speed",
        Min = 1,
        Max = 10,
        Default = 2,
        Callback = function(value)
            orbsSettings.Speed = value
        end,
    })
    OrbsSection:AddSlider({
        Text = "Height",
        Flag = "orbs_height",
        Min = -2,
        Max = 8,
        Default = 2,
        Callback = function(value)
            orbsSettings.Height = value
        end,
    })

    local MorphSection = VisualsLocalPage:AddSection({
        Title = "Model Changer",
        Side = "Right",
    })
    MorphSection:AddToggle({
        Text = "Enable Changer",
        Flag = "morph_enabled",
        Default = false,
        Callback = function(value)
            morphSettings.Enabled = value
            if value then
                applyMorph()
            else
                removeMorph()
            end
        end,
    })
    local morphPresetList = {"tung tung sahur", "стульчанский", "pig"}
    MorphSection:AddDropdown({
        Text = "Select Model",
        Flag = "morph_preset",
        Options = morphPresetList,
        Default = "tung tung sahur",
        Callback = function(value)
            morphSettings.Preset = value
            if morphSettings.Enabled then
                applyMorph()
            end
        end,
    })
end
local MiscPage = Window:AddTab({
    Text = "Misc",
    Icon = "rbxassetid://108020878442937",
    Pages = {"Misc"},
})
do
    local FlySection = MiscPage:AddSection({
        Title = "Fly Hack",
        Side = "Left",
    })
    FlySection:AddToggle({
        Text = "Enabled",
        Flag = "flyhack_enabled",
        Default = false,
        Callback = function(value)
            FlyConfig.Enabled = value
            if not value and flyState.flying then
                stopFly()
            end
        end,
    })
    FlySection:AddKeyPicker({
        Text = "Fly Key",
        Flag = "flyhack_key",
        Default = Enum.KeyCode.E,
        Mode = "Toggle",
        Callback = function(value)
            FlyConfig.Key = value
        end,
    })
    FlySection:AddSlider({
        Text = "Speed",
        Flag = "flyhack_speed",
        Min = 1,
        Max = 100,
        Default = 1,
        Callback = function(value)
            FlyConfig.Speed = value
        end,
    })
end
do
    local SpeedSection = MiscPage:AddSection({
        Title = "Speed Hack",
        Side = "Right",
    })
    SpeedSection:AddToggle({
        Text = "Enabled",
        Flag = "speedhack_enabled",
        Default = false,
        Callback = function(value)
            if value then
                enableSpeedHack()
            else
                disableSpeedHack()
            end
        end,
    })
    SpeedSection:AddKeyPicker({
        Text = "Speed Key",
        Flag = "speedhack_key",
        Default = Enum.KeyCode.V,
        Mode = "Hold",
        Callback = function(value)
            speedHackSettings.Key = value
        end,
    })
    SpeedSection:AddSlider({
        Text = "Speed Multiplier",
        Flag = "speedhack_speed",
        Min = 1,
        Max = 20,
        Default = 3,
        Callback = function(value)
            speedHackSettings.Multiplier = value
        end,
    })
end
local ConfigPage = Window:AddTab({
    Text = "Config",
    Icon = "rbxassetid://117366234081415",
    Pages = {"Config"},
})
do
    local ClipSection = ConfigPage:AddSection({
        Title = "Clipboard Config",
        Side = "Left",
    })
    ClipSection:AddButton({
        Text = "Export to Clipboard",
        Callback = function()
            exportConfig()
        end,
    })
    ClipSection:AddButton({
        Text = "Import from Clipboard",
        Callback = function()
            importConfig()
        end,
    })
    local ThemeSection = ConfigPage:AddSection({
        Title = "Theming",
        Side = "Right",
    })
    ThemeSection:AddColorPicker({
        Text = "Accent Color",
        Flag = "theme_accent",
        Default = Color3.fromRGB(255, 182, 193),
        Transparency = 0,
        Callback = function(color)
            Library:Refresh("Accent", color)
        end,
    })
    local OtherSection = ConfigPage:AddSection({
        Title = "Other",
        Side = "Right",
    })
    OtherSection:AddKeyPicker({
        Text = "Menu Bind",
        Flag = "menu_bind",
        Default = Enum.KeyCode.Insert,
        Mode = "Toggle",
        ShowInList = false,
        Callback = function(value)
            Window.SetVisible(value)
        end,
    })
    OtherSection:AddToggle({
        Text = "Watermark",
        Flag = "watermark",
        Default = false,
        Callback = function(value)
            Library.Window.Items.Watermark.Instance.Visible = value
        end,
    })
    OtherSection:AddToggle({
        Text = "Keybind List",
        Flag = "keybind_list",
        Default = false,
        Callback = function(value)
            Library.Window.Items.KeybindList.Instance.Visible = value
        end,
    })
    OtherSection:AddButton({
        Text = "Save Layout",
        Callback = function()
            saveLayout()
            Library:Notify({ Title = "Layout saved!", Lifetime = 3 })
        end,
    })
    OtherSection:AddButton({
        Text = "Unload",
        Callback = function()
            saveLayout()
            unloadScript()
        end,
    })
end
end
buildUI()
table.insert(scriptConnections, UserInputService.InputBegan:Connect(function(input, gpe)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        inputState.keys[input.KeyCode] = true
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton3 then
        inputState.mouseButtons[input.UserInputType] = true
    end
    local menuFlag = Library.Flags["menu_bind"]
    local currentMenuKey = (type(menuFlag) == "table" and menuFlag.Key) or (menuFlag and typeof(menuFlag) == "EnumItem" and menuFlag) or Enum.KeyCode.Insert
    if checkInputMatch(input, currentMenuKey) then
        Window.SetVisible(not Window.Visible)
        return
    end
    local aimKey = Library.Flags["aimbot_key"]
    local currentAimKey = (type(aimKey) == "table" and aimKey.Key) or (aimKey and typeof(aimKey) == "EnumItem" and aimKey) or aimbotSettings.Key
    local aimMode = (type(aimKey) == "table" and aimKey.Mode) or "Hold"
    if checkInputMatch(input, currentAimKey) and aimbotSettings.Enabled then
        if aimMode == "Toggle" then
            aimbotSettings.Locked = not aimbotSettings.Locked
        elseif aimMode == "Hold" then
            aimbotSettings.Locked = true
        end
    end
    local tpKey = Library.Flags["thirdperson_key"]
    local currentTpKey = (type(tpKey) == "table" and tpKey.Key) or (tpKey and typeof(tpKey) == "EnumItem" and tpKey) or thirdPersonSettings.Key
    if checkInputMatch(input, currentTpKey) and thirdPersonSettings.MasterEnabled then
        toggleThirdPerson()
    end
    local fcKey = Library.Flags["freecam_key"]
    local currentFcKey = (type(fcKey) == "table" and fcKey.Key) or (fcKey and typeof(fcKey) == "EnumItem" and fcKey) or freecamSettings.Key
    if checkInputMatch(input, currentFcKey) and freecamSettings.MasterEnabled then
        toggleFreecam()
    end
    if freecamState.active then
        if input.KeyCode == Enum.KeyCode.W then freecamState.keys.W = true
        elseif input.KeyCode == Enum.KeyCode.S then freecamState.keys.S = true
        elseif input.KeyCode == Enum.KeyCode.A then freecamState.keys.A = true
        elseif input.KeyCode == Enum.KeyCode.D then freecamState.keys.D = true
        elseif input.KeyCode == Enum.KeyCode.Space then freecamState.keys.Space = true
        elseif input.KeyCode == Enum.KeyCode.LeftShift then freecamState.keys.LeftShift = true
        end
    end
    local flyKey = Library.Flags["flyhack_key"]
    local currentKey = (type(flyKey) == "table" and flyKey.Key) or (flyKey and typeof(flyKey) == "EnumItem" and flyKey) or FlyConfig.Key
    if checkInputMatch(input, currentKey) and FlyConfig.Enabled then
        toggleFly()
    end
    if flyState and flyState.flying then
        if input.KeyCode == Enum.KeyCode.W then flyState.keys.W = true
        elseif input.KeyCode == Enum.KeyCode.S then flyState.keys.S = true
        elseif input.KeyCode == Enum.KeyCode.A then flyState.keys.A = true
        elseif input.KeyCode == Enum.KeyCode.D then flyState.keys.D = true
        elseif input.KeyCode == Enum.KeyCode.Space then flyState.keys.Space = true
        elseif input.KeyCode == Enum.KeyCode.LeftShift then flyState.keys.LeftShift = true
        end
    end
end))
table.insert(scriptConnections, UserInputService.InputEnded:Connect(function(input, gpe)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        inputState.keys[input.KeyCode] = false
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton3 then
        inputState.mouseButtons[input.UserInputType] = false
    end
    local aimKey = Library.Flags["aimbot_key"]
    local currentAimKey = (type(aimKey) == "table" and aimKey.Key) or (aimKey and typeof(aimKey) == "EnumItem" and aimKey) or aimbotSettings.Key
    local aimMode = (type(aimKey) == "table" and aimKey.Mode) or "Hold"
    if aimMode == "Hold" and checkInputMatch(input, currentAimKey) then
        aimbotSettings.Locked = false
    end
    if input.KeyCode == Enum.KeyCode.W then
        freecamState.keys.W = false
        if flyState then flyState.keys.W = false end
    elseif input.KeyCode == Enum.KeyCode.S then
        freecamState.keys.S = false
        if flyState then flyState.keys.S = false end
    elseif input.KeyCode == Enum.KeyCode.A then
        freecamState.keys.A = false
        if flyState then flyState.keys.A = false end
    elseif input.KeyCode == Enum.KeyCode.D then
        freecamState.keys.D = false
        if flyState then flyState.keys.D = false end
    elseif input.KeyCode == Enum.KeyCode.Space then
        freecamState.keys.Space = false
        if flyState then flyState.keys.Space = false end
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        freecamState.keys.LeftShift = false
        if flyState then flyState.keys.LeftShift = false end
    end
end))
loadLayout()
Window.SetVisible(true)
Library:Notify({
    Title = "Overflow.gg loaded successfully!",
    Lifetime = 4,
})
getgenv().OverflowUnload = unloadScript
getgenv().OverflowLibrary = Library
getgenv().OverflowWindow = Window
