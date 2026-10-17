local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CharactersFolder = workspace:FindFirstChild("Characters") or workspace:WaitForChild("Characters", 5)

local function sendDiscordInvite(text)
    --[[ 
        
    ]]
end

local notificationCallback = Instance.new("BindableFunction")
notificationCallback.OnInvoke = function(selected)
    if selected == "Join" then
        --[[
        
        ]]
    end
end

task.spawn(function()
    for attempt = 1, 20 do
        local success = pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "Axion",
                Text = "Join our Discord server for updates & giveaways",
                Duration = 8,
                Icon = "rbxassetid://11401835376",
                Button1 = "Join",
                Callback = notificationCallback
            })
        end)
        if success then break end
        task.wait(0.25)
    end
end)

local currentLanguage = "en"

local Localization = {
    en = {
        tab_esp = "ESP",
        tab_aim = "Aimbot",
        tab_sky = "Sky",
        tab_settings = "Settings",
        esp_enabled = "Enable ESP",
        esp_enabled_desc = "Draws boxes, names and info over enemies.",
        esp_box = "2D Box",
        esp_box_desc = "Draws a box around the player.",
        esp_box_color = "Box Color",
        esp_box_color_desc = "Color of the box lines.",
        esp_name = "Player Name",
        esp_name_desc = "Shows name and nickname above player.",
        esp_name_color = "Name Color",
        esp_name_color_desc = "Color of the name text.",
        esp_distance = "Distance",
        esp_distance_desc = "Shows distance to the target.",
        esp_distance_color = "Distance Color",
        esp_distance_color_desc = "Color of the distance text.",
        esp_tracers = "Tracers",
        esp_tracers_desc = "Line from bottom of screen to the player.",
        esp_tracer_color = "Tracer Color",
        esp_tracer_color_desc = "Color of the tracer line.",
        esp_highlight = "Highlight ESP",
        esp_highlight_desc = "Highlights enemy models through walls.",
        set_wide = "Screen Stretch",
        set_wide_desc = "Enable vertical screen stretch.",
        set_wide_scale = "Stretch Strength",
        set_wide_scale_desc = "Adjust screen stretch strength.",
        esp_max_dist = "Max Distance",
        esp_max_dist_desc = "Maximum studs to draw.",
        aim_enabled = "Enable Aimbot (WIP)",
        aim_enabled_desc = "Coming soon — currently disabled.",
        aim_mode = "Mode",
        aim_mode_desc = "Hold - while key held. Always On - always.",
        aim_key = "Aim Key",
        aim_fov = "FOV",
        aim_fov_desc = "Radius from screen center.",
        aim_smooth = "Smoothness",
        aim_smooth_desc = "Higher = smoother aim.",
        aim_bone = "Target Bone",
        aim_bone_desc = "Body part the camera locks onto.",
        aim_show_fov = "Show FOV Circle",
        aim_show_fov_desc = "Draws a circle around screen center.",
        aim_fov_color = "FOV Circle Color",
        aim_fov_color_desc = "Color of the circle line.",
        aim_fov_thickness = "FOV Circle Thickness",
        aim_fov_thickness_desc = "Thickness of the circle line.",
        set_language = "Language",
        set_language_desc = "Interface language.",
        set_menu_key = "Menu Toggle Key",
        set_reset = "Reset",
        set_reset_desc = "Restore default values.",
        set_about = "Made with ♥ for Axion Kontra.",
        sky_preset = "Preset",
        sky_preset_desc = "Ready-made sky & lighting presets.",
        sky_sec_lighting = "Lighting",
        sky_sec_sky = "Skybox",
        sky_sec_atmo = "Atmosphere",
        sky_sec_fx = "Post-FX",
        sky_sec_cfg = "Config",
        sky_ambient = "Ambient",
        sky_ambient_desc = "Indoor ambient light color.",
        sky_outdoor_ambient = "Outdoor Ambient",
        sky_outdoor_ambient_desc = "Outdoor ambient light color.",
        sky_brightness = "Brightness",
        sky_brightness_desc = "Overall scene brightness.",
        sky_clock_time = "Clock Time",
        sky_clock_time_desc = "Time of day (0-24).",
        sky_geo_lat = "Geographic Latitude",
        sky_geo_lat_desc = "Sun position latitude.",
        sky_fog_end = "Fog End",
        sky_fog_end_desc = "Distance where fog fully obscures.",
        sky_fog_start = "Fog Start",
        sky_fog_start_desc = "Distance where fog begins.",
        sky_fog_color = "Fog Color",
        sky_fog_color_desc = "Color of the fog.",
        sky_exposure = "Exposure",
        sky_exposure_desc = "Overall brightness compensation.",
        sky_env_diffuse = "Env Diffuse",
        sky_env_diffuse_desc = "Environment diffuse scale.",
        sky_env_specular = "Env Specular",
        sky_env_specular_desc = "Environment specular scale.",
        sky_global_shadows = "Global Shadows",
        sky_global_shadows_desc = "Enable dynamic shadows.",
        sky_shadow_softness = "Shadow Softness",
        sky_shadow_softness_desc = "Softness of shadow edges.",
        sky_color_top = "ColorShift Top",
        sky_color_top_desc = "Top sky tint.",
        sky_color_bottom = "ColorShift Bottom",
        sky_color_bottom_desc = "Bottom sky tint.",
        sky_skybox_bk = "Skybox Bk",
        sky_skybox_bk_desc = "Back face texture.",
        sky_skybox_dn = "Skybox Dn",
        sky_skybox_dn_desc = "Down face texture.",
        sky_skybox_ft = "Skybox Ft",
        sky_skybox_ft_desc = "Front face texture.",
        sky_skybox_lf = "Skybox Lf",
        sky_skybox_lf_desc = "Left face texture.",
        sky_skybox_rt = "Skybox Rt",
        sky_skybox_rt_desc = "Right face texture.",
        sky_skybox_up = "Skybox Up",
        sky_skybox_up_desc = "Up face texture.",
        sky_sun_size = "Sun Size",
        sky_sun_size_desc = "Angular size of the sun.",
        sky_moon_size = "Moon Size",
        sky_moon_size_desc = "Angular size of the moon.",
        sky_star_count = "Star Count",
        sky_star_count_desc = "Number of stars in the sky.",
        sky_atmo_density = "Density",
        sky_atmo_density_desc = "Atmosphere density.",
        sky_atmo_offset = "Offset",
        sky_atmo_offset_desc = "Atmosphere vertical offset.",
        sky_atmo_color = "Color",
        sky_atmo_color_desc = "Atmosphere color.",
        sky_atmo_decay = "Decay",
        sky_atmo_decay_desc = "Atmosphere decay color.",
        sky_atmo_glare = "Glare",
        sky_atmo_glare_desc = "Atmosphere glare strength.",
        sky_atmo_haze = "Haze",
        sky_atmo_haze_desc = "Atmosphere haze strength.",
        sky_bloom_enabled = "Bloom",
        sky_bloom_enabled_desc = "Enable bloom effect.",
        sky_bloom_intensity = "Bloom Intensity",
        sky_bloom_intensity_desc = "Strength of bloom.",
        sky_bloom_size = "Bloom Size",
        sky_bloom_size_desc = "Size of bloom.",
        sky_bloom_threshold = "Bloom Threshold",
        sky_bloom_threshold_desc = "Threshold for bloom.",
        sky_cc_enabled = "Color Correction",
        sky_cc_enabled_desc = "Enable color correction.",
        sky_cc_brightness = "CC Brightness",
        sky_cc_brightness_desc = "Color correction brightness.",
        sky_cc_contrast = "CC Contrast",
        sky_cc_contrast_desc = "Color correction contrast.",
        sky_cc_saturation = "CC Saturation",
        sky_cc_saturation_desc = "Color correction saturation.",
        sky_cc_tint = "CC Tint",
        sky_cc_tint_desc = "Color correction tint.",
        cfg_name = "Config Name",
        cfg_name_desc = "Name of the config file.",
        cfg_save = "Save Config",
        cfg_save_desc = "Save all settings to file.",
        cfg_load = "Load Config",
        cfg_load_desc = "Load settings from file.",
        cfg_delete = "Delete Config",
        cfg_delete_desc = "Delete the config file.",
        cfg_refresh = "Refresh UI",
        cfg_refresh_desc = "Re-apply the loaded config."
    },
    ru = {
        tab_esp = "ESP",
        tab_aim = "Аимлок",
        tab_sky = "Небо",
        tab_settings = "Настройки",
        esp_enabled = "Включить ESP",
        esp_enabled_desc = "Рисует рамки, имена и инфу над врагами.",
        esp_box = "2D Рамка",
        esp_box_desc = "Отображает рамку вокруг игрока.",
        esp_box_color = "Цвет рамки",
        esp_box_color_desc = "Цвет линий рамки.",
        esp_name = "Имя игрока",
        esp_name_desc = "Показывает имя и ник над игроком.",
        esp_name_color = "Цвет имени",
        esp_name_color_desc = "Цвет текста имени.",
        esp_distance = "Дистанция",
        esp_distance_desc = "Показывает расстояние до цели.",
        esp_distance_color = "Цвет дистанции",
        esp_distance_color_desc = "Цвет текста дистанции.",
        esp_tracers = "Трассеры",
        esp_tracers_desc = "Линия от низа экрана к игроку.",
        esp_tracer_color = "Цвет трассеров",
        esp_tracer_color_desc = "Цвет линии трассера.",
        esp_highlight = "Highlight ESP",
        esp_highlight_desc = "Подсветка моделей врагов сквозь стены.",
        set_wide = "Растяжение экрана",
        set_wide_desc = "Включить вертикальное растяжение экрана.",
        set_wide_scale = "Сила растяжения",
        set_wide_scale_desc = "Настройка силы растяжения экрана.",
        esp_max_dist = "Макс. дистанция",
        esp_max_dist_desc = "Максимум studs для отрисовки.",
        aim_enabled = "Включить аимлок (WIP)",
        aim_enabled_desc = "Скоро — пока отключено.",
        aim_mode = "Режим",
        aim_mode_desc = "Hold - по удержанию. Always On - всегда.",
        aim_key = "Клавиша аима",
        aim_fov = "FOV",
        aim_fov_desc = "Радиус от центра экрана.",
        aim_smooth = "Плавность",
        aim_smooth_desc = "Больше - плавнее наведение.",
        aim_bone = "Кость цели",
        aim_bone_desc = "Часть тела, куда лочится камера.",
        aim_show_fov = "Показывать FOV круг",
        aim_show_fov_desc = "Рисует круг вокруг центра экрана.",
        aim_fov_color = "Цвет FOV круга",
        aim_fov_color_desc = "Цвет линии круга.",
        aim_fov_thickness = "Толщина FOV круга",
        aim_fov_thickness_desc = "Толщина линии круга.",
        set_language = "Язык",
        set_language_desc = "Язык интерфейса.",
        set_menu_key = "Клавиша меню",
        set_reset = "Сбросить",
        set_reset_desc = "Вернуть значения по умолчанию.",
        set_about = "Сделано с ♥ для Axion Kontra.",
        sky_preset = "Пресет",
        sky_preset_desc = "Готовые пресеты неба и освещения.",
        sky_sec_lighting = "Освещение",
        sky_sec_sky = "Скайбокс",
        sky_sec_atmo = "Атмосфера",
        sky_sec_fx = "Пост-эффекты",
        sky_sec_cfg = "Конфиг",
        sky_ambient = "Ambient",
        sky_ambient_desc = "Цвет ambient освещения.",
        sky_outdoor_ambient = "Outdoor Ambient",
        sky_outdoor_ambient_desc = "Цвет уличного ambient.",
        sky_brightness = "Яркость",
        sky_brightness_desc = "Общая яркость сцены.",
        sky_clock_time = "Время суток",
        sky_clock_time_desc = "Время суток (0-24).",
        sky_geo_lat = "Геогр. широта",
        sky_geo_lat_desc = "Широта положения солнца.",
        sky_fog_end = "Конец тумана",
        sky_fog_end_desc = "Дистанция полного тумана.",
        sky_fog_start = "Начало тумана",
        sky_fog_start_desc = "Дистанция начала тумана.",
        sky_fog_color = "Цвет тумана",
        sky_fog_color_desc = "Цвет тумана.",
        sky_exposure = "Экспозиция",
        sky_exposure_desc = "Компенсация яркости.",
        sky_env_diffuse = "Env Diffuse",
        sky_env_diffuse_desc = "Маштаб рассеянного света.",
        sky_env_specular = "Env Specular",
        sky_env_specular_desc = "Маштаб зеркального света.",
        sky_global_shadows = "Глобальные тени",
        sky_global_shadows_desc = "Включить динамические тени.",
        sky_shadow_softness = "Мягкость теней",
        sky_shadow_softness_desc = "Мягкость краёв теней.",
        sky_color_top = "ColorShift Top",
        sky_color_top_desc = "Оттенок верхней части неба.",
        sky_color_bottom = "ColorShift Bottom",
        sky_color_bottom_desc = "Оттенок нижней части неба.",
        sky_skybox_bk = "Skybox Bk",
        sky_skybox_bk_desc = "Текстура задней грани.",
        sky_skybox_dn = "Skybox Dn",
        sky_skybox_dn_desc = "Текстура нижней грани.",
        sky_skybox_ft = "Skybox Ft",
        sky_skybox_ft_desc = "Текстура передней грани.",
        sky_skybox_lf = "Skybox Lf",
        sky_skybox_lf_desc = "Текстура левой грани.",
        sky_skybox_rt = "Skybox Rt",
        sky_skybox_rt_desc = "Текстура правой грани.",
        sky_skybox_up = "Skybox Up",
        sky_skybox_up_desc = "Текстура верхней грани.",
        sky_sun_size = "Размер солнца",
        sky_sun_size_desc = "Угловой размер солнца.",
        sky_moon_size = "Размер луны",
        sky_moon_size_desc = "Угловой размер луны.",
        sky_star_count = "Кол-во звёзд",
        sky_star_count_desc = "Количество звёзд на небе.",
        sky_atmo_density = "Плотность",
        sky_atmo_density_desc = "Плотность атмосферы.",
        sky_atmo_offset = "Смещение",
        sky_atmo_offset_desc = "Вертикальное смещение.",
        sky_atmo_color = "Цвет",
        sky_atmo_color_desc = "Цвет атмосферы.",
        sky_atmo_decay = "Затухание",
        sky_atmo_decay_desc = "Цвет затухания.",
        sky_atmo_glare = "Блик",
        sky_atmo_glare_desc = "Сила блика.",
        sky_atmo_haze = "Дымка",
        sky_atmo_haze_desc = "Сила дымки.",
        sky_bloom_enabled = "Bloom",
        sky_bloom_enabled_desc = "Включить bloom.",
        sky_bloom_intensity = "Интенсивность Bloom",
        sky_bloom_intensity_desc = "Сила свечения.",
        sky_bloom_size = "Размер Bloom",
        sky_bloom_size_desc = "Размер свечения.",
        sky_bloom_threshold = "Порог Bloom",
        sky_bloom_threshold_desc = "Порог срабатывания.",
        sky_cc_enabled = "Коррекция цвета",
        sky_cc_enabled_desc = "Включить коррекцию цвета.",
        sky_cc_brightness = "Яркость CC",
        sky_cc_brightness_desc = "Яркость коррекции.",
        sky_cc_contrast = "Контраст CC",
        sky_cc_contrast_desc = "Контраст коррекции.",
        sky_cc_saturation = "Насыщенность CC",
        sky_cc_saturation_desc = "Насыщенность коррекции.",
        sky_cc_tint = "Оттенок CC",
        sky_cc_tint_desc = "Оттенок коррекции.",
        cfg_name = "Имя конфига",
        cfg_name_desc = "Имя файла конфига.",
        cfg_save = "Сохранить конфиг",
        cfg_save_desc = "Сохранить все настройки в файл.",
        cfg_load = "Загрузить конфиг",
        cfg_load_desc = "Загрузить настройки из файла.",
        cfg_delete = "Удалить конфиг",
        cfg_delete_desc = "Удалить файл конфига.",
        cfg_refresh = "Обновить UI",
        cfg_refresh_desc = "Применить загруженный конфиг."
    }
}

local function translate(key)
    local langTable = Localization[currentLanguage]
    return (langTable and langTable[key]) or (Localization.en[key]) or key
end

local localizedLabels = {}

local function registerLocalizedLabel(label, key)
    if not label or not key then return end
    table.insert(localizedLabels, { label = label, key = key })
end

local function refreshLocalization()
    for _, entry in ipairs(localizedLabels) do
        if entry.label and entry.label.Parent then
            entry.label.Text = translate(entry.key)
        end
    end
end

local Theme = {
    bg = Color3.fromHex("#0c0c0c"),
    card = Color3.fromHex("#141414"),
    hover = Color3.fromHex("#1b1b1b"),
    raised = Color3.fromHex("#2a2a2a"),
    line = Color3.fromHex("#232323"),
    text = Color3.fromHex("#ededed"),
    muted = Color3.fromHex("#8b8b8b"),
    dim = Color3.fromHex("#5c5c5c")
}

local NotifyColors = {
    info = Color3.fromHex("#ededed"),
    success = Color3.fromHex("#3ecf8e"),
    warning = Color3.fromHex("#f5a524"),
    error = Color3.fromHex("#ef5350")
}

local function getFontFamily(fontName)
    local success, family = pcall(function()
        return Font.fromEnum(Enum.Font[fontName]).Family
    end)
    return success and family or nil
end

local defaultFontFamily = getFontFamily("BuilderSans")
    or getFontFamily("Gotham")
    or "rbxasset://fonts/families/GothamSSm.json"

local function font(weight)
    return Font.new(defaultFontFamily, weight or Enum.FontWeight.Regular)
end

local function create(className, properties, parent)
    local instance = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        instance[prop] = value
    end
    if parent then
        instance.Parent = parent
    end
    return instance
end

local function tween(instance, properties, duration, easingStyle, easingDirection)
    TweenService:Create(
        instance,
        TweenInfo.new(
            duration or 0.18,
            easingStyle or Enum.EasingStyle.Quint,
            easingDirection or Enum.EasingDirection.Out
        ),
        properties
    ):Play()
end

local function addCorner(parent, radius)
    return create("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function addStroke(parent, color)
    return create("UIStroke", {
        Color = color or Theme.line,
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }, parent)
end

local function addPadding(parent, top, right, bottom, left)
    return create("UIPadding", {
        PaddingTop = UDim.new(0, top),
        PaddingRight = UDim.new(0, right or top),
        PaddingBottom = UDim.new(0, bottom or top),
        PaddingLeft = UDim.new(0, left or right or top)
    }, parent)
end

local function textLabel(parent, text, size, color, weight)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextSize = size,
        TextColor3 = color,
        FontFace = font(weight),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0)
    }, parent)
end

local function isPrimaryClick(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
end

local function isMoveInput(input)
    return input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
end

local function bindDrag(dragArea, onMove, onStateChange)
    local dragging = false
    dragArea.InputBegan:Connect(function(input)
        if isPrimaryClick(input) then
            dragging = true
            if onStateChange then onStateChange(true) end
            onMove(input.Position.X, input.Position.Y)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and isMoveInput(input) then
            onMove(input.Position.X, input.Position.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if dragging and isPrimaryClick(input) then
            dragging = false
            if onStateChange then onStateChange(false) end
        end
    end)
end

local function luminance(color)
    return 0.299 * color.R + 0.587 * color.G + 0.114 * color.B
end

local Library = {}
Library.__index = Library

local Window = {}
Window.__index = Window

local Page = {}
Page.__index = Page

function Library:SetFont(fontName)
    local family = getFontFamily(fontName)
    if family then
        defaultFontFamily = family
        return true
    end
    return false
end

function Library:Window(title, subtitle, accentColor, toggleKey)
    accentColor = accentColor or Color3.fromHex("#ededed")
    toggleKey = toggleKey or Enum.KeyCode.RightShift

    local screenGui = create("ScreenGui", {
        Name = "Axion",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999
    })

    local attached = pcall(function()
        screenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    end)
    if not attached or not screenGui.Parent then
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local mainFrame = create("Frame", {
        Name = "Main",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(600, 460),
        BackgroundColor3 = Theme.bg,
        ClipsDescendants = true
    }, screenGui)
    addCorner(mainFrame, 12)
    addStroke(mainFrame)

    local uiScale = create("UIScale", { Scale = 0.96 }, mainFrame)
    tween(uiScale, { Scale = 1 }, 0.3)

    local titleBar = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 52)
    }, mainFrame)
    addPadding(titleBar, 0, 20, 0, 20)

    local titleContainer = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }, titleBar)
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, titleContainer)

    create("TextLabel", {
        BackgroundTransparency = 1,
        Text = title,
        TextSize = 14,
        TextColor3 = Theme.text,
        FontFace = font(Enum.FontWeight.SemiBold),
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 1, 0),
        LayoutOrder = 1
    }, titleContainer)

    create("TextLabel", {
        BackgroundTransparency = 1,
        Text = subtitle or "",
        TextSize = 13,
        TextColor3 = Theme.dim,
        FontFace = font(),
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 1, 0),
        LayoutOrder = 2
    }, titleContainer)

    local toggleLabel = create("TextLabel", {
        BackgroundTransparency = 1,
        Text = toggleKey.Name,
        TextSize = 12,
        TextColor3 = Theme.dim,
        FontFace = font(),
        TextXAlignment = Enum.TextXAlignment.Right,
        Size = UDim2.fromScale(1, 1)
    }, titleBar)

    create("Frame", {
        BackgroundColor3 = Theme.line,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 52),
        Size = UDim2.new(1, 0, 0, 1)
    }, mainFrame)

    do
        local dragging, dragStart, startPos = false, nil, nil
        titleBar.InputBegan:Connect(function(input)
            if isPrimaryClick(input) then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and isMoveInput(input) then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if isPrimaryClick(input) then
                dragging = false
            end
        end)
    end

    local contentArea = create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 53),
        Size = UDim2.new(1, 0, 1, -53)
    }, mainFrame)

    local indicator = create("Frame", {
        BackgroundColor3 = Theme.hover,
        Position = UDim2.fromOffset(10, 12),
        Size = UDim2.fromOffset(132, 30),
        Visible = false
    }, contentArea)
    addCorner(indicator, 6)
    create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.fromOffset(2, 14),
        BackgroundColor3 = accentColor
    }, indicator)

    local sidebar = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 152, 1, 0)
    }, contentArea)
    addPadding(sidebar, 12, 10, 12, 10)
    create("UIListLayout", {
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, sidebar)

    create("Frame", {
        BackgroundColor3 = Theme.line,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(152, 0),
        Size = UDim2.new(0, 1, 1, 0)
    }, contentArea)

    local pagesContainer = create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(153, 0),
        Size = UDim2.new(1, -153, 1, 0),
        ClipsDescendants = true
    }, contentArea)

    local toastsContainer = create("Frame", {
        Name = "Toasts",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -20, 0, 20),
        Size = UDim2.new(0, 300, 1, -40)
    }, screenGui)
    create("UIListLayout", {
        Padding = UDim.new(0, 0),
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder
    }, toastsContainer)

    self._toasts = toastsContainer
    self._toastN = 0
    self._active = {}

    local windowInstance = setmetatable({
        lib = self,
        gui = screenGui,
        main = mainFrame,
        side = sidebar,
        pages = pagesContainer,
        indicator = indicator,
        accent = accentColor,
        onAccent = luminance(accentColor) > 0.55 and Theme.bg or Color3.new(1, 1, 1),
        tabs = {},
        current = nil,
        toggleKey = toggleKey,
        toggleLabel = toggleLabel
    }, Window)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == windowInstance.toggleKey then
            mainFrame.Visible = not mainFrame.Visible
            if mainFrame.Visible then
                uiScale.Scale = 0.96
                tween(uiScale, { Scale = 1 }, 0.25)
            end
        end
    end)

    return windowInstance
end

function Library:Notify(options)
    if not self._toasts then return end
    if type(options) == "string" then
        options = { Text = options }
    end

    local color = NotifyColors[options.Type or "info"] or NotifyColors.info
    local duration = options.Duration or 4

    if #self._active >= 5 then
        self._active[1]()
    end

    self._toastN += 1
    local toastContainer = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = self._toastN
    }, self._toasts)

    local toastGroup = create("CanvasGroup", {
        BackgroundColor3 = Theme.card,
        GroupTransparency = 1,
        Position = UDim2.fromOffset(48, 0),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }, toastContainer)
    addCorner(toastGroup, 10)
    local toastStroke = addStroke(toastGroup, Color3.fromHex("#333333"))
    toastStroke.Transparency = 1

    local content = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }, toastGroup)
    addPadding(content, 12, 34, 12, 14)
    create("UIListLayout", {
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, content)

    if options.Title then
        textLabel(content, options.Title, 13, color, Enum.FontWeight.Medium).LayoutOrder = 1
        textLabel(content, options.Text or "", 12, Theme.muted).LayoutOrder = 2
    else
        textLabel(content, options.Text or "", 13, Theme.text, Enum.FontWeight.Medium).LayoutOrder = 1
    end

    local clickArea = create("TextButton", {
        BackgroundTransparency = 1,
        Text = "",
        Size = UDim2.fromScale(1, 1),
        ZIndex = 2,
        AutoButtonColor = false
    }, toastGroup)

    local closeButton = create("TextLabel", {
        BackgroundTransparency = 1,
        Text = "×",
        TextSize = 18,
        TextColor3 = Theme.dim,
        FontFace = font(),
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 8),
        Size = UDim2.fromOffset(18, 18),
        ZIndex = 3
    }, toastGroup)

    local dismissed = false
    local hovering = false

    local function dismiss()
        if dismissed then return end
        dismissed = true
        local idx = table.find(self._active, dismiss)
        if idx then
            table.remove(self._active, idx)
        end
        tween(toastGroup, { GroupTransparency = 1 }, 0.25, Enum.EasingStyle.Quad)
        tween(toastStroke, { Transparency = 1 }, 0.25, Enum.EasingStyle.Quad)
        task.delay(0.12, function()
            tween(toastContainer, { Size = UDim2.new(1, 0, 0, 0) }, 0.3)
        end)
        task.delay(0.5, function()
            toastContainer:Destroy()
        end)
    end

    table.insert(self._active, dismiss)

    clickArea.MouseEnter:Connect(function()
        hovering = true
        tween(closeButton, { TextColor3 = Theme.text })
    end)
    clickArea.MouseLeave:Connect(function()
        hovering = false
        tween(closeButton, { TextColor3 = Theme.dim })
    end)
    clickArea.MouseButton1Click:Connect(dismiss)

    task.spawn(function()
        local height = 0
        for _ = 1, 5 do
            RunService.Heartbeat:Wait()
            height = toastGroup.AbsoluteSize.Y
            if height > 0 then break end
        end
        if dismissed then return end
        tween(toastContainer, { Size = UDim2.new(1, 0, 0, height + 8) }, 0.3)
        tween(toastGroup, { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) }, 0.45)
        tween(toastStroke, { Transparency = 0 }, 0.45)

        local elapsed = 0
        while not dismissed and elapsed < duration do
            local dt = RunService.Heartbeat:Wait()
            if not hovering then
                elapsed += dt
            end
        end
        dismiss()
    end)
end

function Window:Tab(tabName)
    local window = self

    local tabButton = create("TextButton", {
        BackgroundTransparency = 1,
        Text = translate(tabName),
        TextSize = 13,
        TextColor3 = Theme.muted,
        FontFace = font(Enum.FontWeight.Medium),
        AutoButtonColor = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 0, 30),
        LayoutOrder = #self.tabs + 1
    }, self.side)
    addPadding(tabButton, 0, 10, 0, 12)
    registerLocalizedLabel(tabButton, tabName)

    local group = create("CanvasGroup", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Visible = false,
        GroupTransparency = 1
    }, self.pages)

    local scroll = create("ScrollingFrame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.raised,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, group)
    local scrollPadding = addPadding(scroll, 16)
    local layout = create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, scroll)

    local page = setmetatable({
        win = window,
        page = scroll,
        group = group,
        n = 0,
        btn = tabButton
    }, Page)
    table.insert(self.tabs, page)

    local tabIndex = #self.tabs

    local function selectTab()
        if window.current == page then return end
        local firstTime = window.current == nil
        for _, other in ipairs(window.tabs) do
            if other ~= page then
                other.group.Visible = false
                tween(other.btn, { TextColor3 = Theme.muted })
            end
        end
        window.current = page
        tween(tabButton, { TextColor3 = Theme.text })

        local indicatorPos = UDim2.fromOffset(10, 12 + (tabIndex - 1) * 32)
        if firstTime then
            window.indicator.Position = indicatorPos
            window.indicator.Visible = true
        else
            tween(window.indicator, { Position = indicatorPos }, 0.35, Enum.EasingStyle.Quint)
        end

        group.Visible = true
        group.GroupTransparency = 1
        scrollPadding.PaddingTop = UDim.new(0, 30)
        scroll.CanvasPosition = Vector2.zero
        tween(group, { GroupTransparency = 0 }, 0.3)
        tween(scrollPadding, { PaddingTop = UDim.new(0, 16) }, 0.4)
    end

    tabButton.MouseButton1Click:Connect(selectTab)
    tabButton.MouseEnter:Connect(function()
        if window.current ~= page then
            tween(tabButton, { TextColor3 = Theme.text })
        end
    end)
    tabButton.MouseLeave:Connect(function()
        if window.current ~= page then
            tween(tabButton, { TextColor3 = Theme.muted })
        end
    end)

    if tabIndex == 1 then
        selectTab()
    end

    return page
end

local function nextOrder(page)
    page.n += 1
    return page.n
end

local function createCard(page, titleKey, descKey, rightOffset, height)
    local card = create("Frame", {
        BackgroundColor3 = Theme.card,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = nextOrder(page)
    }, page.page)
    addCorner(card, 8)
    addStroke(card)
    addPadding(card, 12, 14)
    create("UIListLayout", {
        Padding = UDim.new(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, card)

    local header = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, height or 20),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1
    }, card)

    local headerContent = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -((rightOffset or 0) + 12), 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }, header)
    create("UIListLayout", {
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, headerContent)

    local titleLabel = textLabel(headerContent, translate(titleKey), 13, Theme.text, Enum.FontWeight.Medium)
    titleLabel.LayoutOrder = 1
    registerLocalizedLabel(titleLabel, titleKey)

    if descKey and descKey ~= "" then
        local descLabel = textLabel(headerContent, translate(descKey), 12, Theme.muted)
        descLabel.LayoutOrder = 2
        registerLocalizedLabel(descLabel, descKey)
    end

    return card, header
end

local function createHoverButton(headerFrame, cardFrame, disabled)
    if disabled then
        return create("TextButton", {
            BackgroundTransparency = 1,
            Text = "",
            Size = UDim2.fromScale(1, 1),
            ZIndex = 5,
            AutoButtonColor = false,
            Active = false
        }, headerFrame)
    end

    local stroke = cardFrame:FindFirstChildOfClass("UIStroke")
    local button = create("TextButton", {
        BackgroundTransparency = 1,
        Text = "",
        Size = UDim2.fromScale(1, 1),
        ZIndex = 5,
        AutoButtonColor = false
    }, headerFrame)

    button.MouseEnter:Connect(function()
        tween(cardFrame, { BackgroundColor3 = Theme.hover })
        tween(stroke, { Color = Theme.raised })
    end)
    button.MouseLeave:Connect(function()
        tween(cardFrame, { BackgroundColor3 = Theme.card })
        tween(stroke, { Color = Theme.line })
    end)

    return button
end

local function rightLabel(parent, text, width)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextSize = 12,
        TextColor3 = Theme.muted,
        FontFace = font(),
        TextXAlignment = Enum.TextXAlignment.Right,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.new(0, width, 0, 16)
    }, parent)
end

function Page:Header(titleKey)
    local label = create("TextLabel", {
        BackgroundTransparency = 1,
        Text = translate(titleKey),
        TextSize = 11,
        TextColor3 = Theme.dim,
        FontFace = font(Enum.FontWeight.SemiBold),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 0, 20),
        LayoutOrder = nextOrder(self)
    }, self.page)
    registerLocalizedLabel(label, titleKey)
    return label
end

function Page:Button(titleKey, descKey, callback)
    callback = callback or function() end

    local card, header = createCard(self, titleKey, descKey, 20)
    local arrow = rightLabel(header, "→", 20)
    arrow.TextXAlignment = Enum.TextXAlignment.Center

    local clickLayer = createHoverButton(header, card)
    clickLayer.MouseEnter:Connect(function()
        tween(arrow, { Position = UDim2.new(1, 4, 0.5, 0), TextColor3 = Theme.text }, 0.25)
    end)
    clickLayer.MouseLeave:Connect(function()
        tween(arrow, { Position = UDim2.fromScale(1, 0.5), TextColor3 = Theme.muted }, 0.25)
    end)
    clickLayer.MouseButton1Click:Connect(function()
        tween(card, { BackgroundColor3 = Theme.raised }, 0.08)
        task.delay(0.1, function()
            tween(card, { BackgroundColor3 = Theme.hover }, 0.25)
        end)
        task.spawn(callback)
    end)
end

function Page:Label(textKey)
    local label = textLabel(self.page, translate(textKey), 12, Theme.muted)
    label.LayoutOrder = nextOrder(self)
    registerLocalizedLabel(label, textKey)
    return label
end

function Page:Line()
    create("Frame", {
        BackgroundColor3 = Theme.line,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        LayoutOrder = nextOrder(self)
    }, self.page)
end

function Page:Toggle(titleKey, descKey, defaultValue, callback, disabled)
    callback = callback or function() end
    local accent = self.win.accent
    local onAccent = self.win.onAccent

    local card, header = createCard(self, titleKey, descKey, 36)

    if disabled then
        card.BackgroundColor3 = Theme.card
        local cardStroke = card:FindFirstChildOfClass("UIStroke")
        if cardStroke then
            cardStroke.Color = Theme.line
        end
        for _, label in ipairs(header:GetDescendants()) do
            if label:IsA("TextLabel") then
                label.TextColor3 = Theme.dim
            end
        end
    end

    local toggleTrack = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(34, 20),
        BackgroundColor3 = disabled and Theme.hover or Theme.raised
    }, header)
    addCorner(toggleTrack, 10)

    local toggleKnob = create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 3, 0.5, 0),
        Size = UDim2.fromOffset(14, 14),
        BackgroundColor3 = disabled and Theme.dim or Theme.muted
    }, toggleTrack)
    addCorner(toggleKnob, 7)

    local state = defaultValue == true
    if disabled then state = false end

    local function setState(newState, fireCallback)
        if disabled then newState = false end
        state = newState

        if disabled then
            tween(toggleTrack, { BackgroundColor3 = Theme.hover }, 0.25)
            tween(toggleKnob, {
                Position = newState and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
                BackgroundColor3 = Theme.dim
            }, 0.35, Enum.EasingStyle.Back)
        else
            tween(toggleTrack, { BackgroundColor3 = newState and accent or Theme.raised }, 0.25)
            tween(toggleKnob, {
                Position = newState and UDim2.new(1, -17, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
                BackgroundColor3 = newState and onAccent or Theme.muted
            }, 0.35, Enum.EasingStyle.Back)
        end

        if fireCallback ~= false then
            task.spawn(callback, newState)
        end
    end

    local clickLayer = createHoverButton(header, card, disabled)
    if not disabled then
        clickLayer.MouseButton1Click:Connect(function()
            setState(not state)
        end)
    end

    if disabled then
        tween(toggleTrack, { BackgroundColor3 = Theme.hover }, 0)
        tween(toggleKnob, { BackgroundColor3 = Theme.dim, Position = UDim2.new(0, 3, 0.5, 0) }, 0)
    elseif state then
        setState(true, false)
    end

    return {
        Set = function(value) setState(value, true) end,
        Get = function() return state end,
        Disabled = disabled and true or false
    }
end

function Page:Slider(titleKey, descKey, minValue, maxValue, defaultValue, callback)
    callback = callback or function() end

    local card, header = createCard(self, titleKey, descKey, 50)
    local valueLabel = rightLabel(header, "", 50)
    valueLabel.TextColor3 = Theme.text

    local track = create("TextButton", {
        BackgroundTransparency = 1,
        Text = "",
        Size = UDim2.new(1, 0, 0, 16),
        LayoutOrder = 2,
        AutoButtonColor = false
    }, card)

    local trackBar = create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.new(1, 0, 0, 4),
        BackgroundColor3 = Theme.raised
    }, track)
    addCorner(trackBar, 2)

    local fill = create("Frame", {
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = self.win.accent
    }, trackBar)
    addCorner(fill, 2)

    local knob = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Color3.new(1, 1, 1)
    }, fill)
    addCorner(knob, 8)
    addStroke(knob, Theme.bg)

    local currentValue

    local function setValue(newValue, fireCallback)
        newValue = math.clamp(math.floor(newValue + 0.5), minValue, maxValue)
        tween(fill, { Size = UDim2.fromScale((newValue - minValue) / (maxValue - minValue), 1) }, 0.08)
        valueLabel.Text = tostring(newValue)
        if newValue ~= currentValue then
            currentValue = newValue
            if fireCallback then
                task.spawn(callback, newValue)
            end
        end
    end

    bindDrag(track, function(mouseX)
        local pct = math.clamp(
            (mouseX - trackBar.AbsolutePosition.X) / math.max(trackBar.AbsoluteSize.X, 1),
            0, 1
        )
        setValue(minValue + (maxValue - minValue) * pct, true)
    end, function(isDragging)
        tween(knob, { Size = isDragging and UDim2.fromOffset(16, 16) or UDim2.fromOffset(12, 12) }, 0.2, Enum.EasingStyle.Back)
        tween(valueLabel, { TextColor3 = isDragging and self.win.accent or Theme.text }, 0.2)
    end)

    setValue(defaultValue or minValue, false)

    return {
        Set = function(value) setValue(value, true) end,
        Get = function() return currentValue end
    }
end

function Page:Dropdown(titleKey, descKey, options, defaultOption, callback)
    callback = callback or function() end

    local card, header = createCard(self, titleKey, descKey, 140)

    local selectedLabel = rightLabel(header, defaultOption or options[1] or "", 120)
    selectedLabel.Position = UDim2.new(1, -16, 0.5, 0)

    local arrow = create("TextLabel", {
        BackgroundTransparency = 1,
        Text = "‹",
        TextSize = 16,
        TextColor3 = Theme.dim,
        FontFace = font(),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(12, 16),
        Rotation = 90
    }, header)

    local listHeight = #options * 30 - 2

    local container = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        ClipsDescendants = true,
        LayoutOrder = 2,
        ZIndex = 40
    }, card)

    local list = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, listHeight),
        ZIndex = 41
    }, container)
    create("UIListLayout", {
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, list)

    local expanded = false

    local function setExpanded(value)
        expanded = value
        tween(arrow, { Rotation = value and -90 or 90 }, 0.3, Enum.EasingStyle.Back)
        tween(container, { Size = UDim2.new(1, 0, 0, value and listHeight or 0) }, 0.3, Enum.EasingStyle.Quint)
    end

    local optionButtons = {}
    for order, option in ipairs(options) do
        local optionBtn = create("TextButton", {
            BackgroundColor3 = Theme.hover,
            BackgroundTransparency = 1,
            Text = option,
            TextSize = 12,
            TextColor3 = option == (defaultOption or options[1]) and Theme.text or Theme.muted,
            FontFace = font(),
            AutoButtonColor = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1, 0, 0, 28),
            LayoutOrder = order,
            ZIndex = 42
        }, list)
        addCorner(optionBtn, 6)
        addPadding(optionBtn, 0, 10, 0, 10)
        optionButtons[option] = optionBtn

        optionBtn.MouseEnter:Connect(function()
            tween(optionBtn, { BackgroundTransparency = 0 })
        end)
        optionBtn.MouseLeave:Connect(function()
            tween(optionBtn, { BackgroundTransparency = 1 })
        end)
        optionBtn.MouseButton1Click:Connect(function()
            for _, btn in pairs(optionButtons) do
                tween(btn, { TextColor3 = Theme.muted })
            end
            tween(optionBtn, { TextColor3 = Theme.text })
            selectedLabel.Text = option
            setExpanded(false)
            task.spawn(callback, option)
        end)
    end

    createHoverButton(header, card).MouseButton1Click:Connect(function()
        setExpanded(not expanded)
    end)

    return {
        Set = function(value)
            local btn = optionButtons[value]
            if not btn then return end
            for _, other in pairs(optionButtons) do
                tween(other, { TextColor3 = Theme.muted })
            end
            tween(btn, { TextColor3 = Theme.text })
            selectedLabel.Text = value
            task.spawn(callback, value)
        end,
        Get = function() return selectedLabel.Text end
    }
end

function Page:Colorpicker(titleKey, descKey, defaultColor, callback)
    callback = callback or function() end
    defaultColor = defaultColor or Color3.new(1, 1, 1)

    local hue, sat, val = defaultColor:ToHSV()

    local card, header = createCard(self, titleKey, descKey, 40)

    local preview = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(28, 16),
        BackgroundColor3 = defaultColor
    }, header)
    addCorner(preview, 4)
    addStroke(preview, Theme.raised)

    local container = create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        ClipsDescendants = true,
        LayoutOrder = 2,
        ZIndex = 40
    }, card)

    local pickerGroup = create("CanvasGroup", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 110),
        GroupTransparency = 0,
        ZIndex = 41
    }, container)

    local saturationValue = create("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
        Size = UDim2.new(1, -28, 0, 110),
        ZIndex = 42
    }, pickerGroup)
    addCorner(saturationValue, 6)

    local whiteGradient = create("Frame", {
        BackgroundColor3 = Color3.new(1, 1, 1),
        Size = UDim2.fromScale(1, 1),
        Active = false
    }, saturationValue)
    addCorner(whiteGradient, 6)
    create("UIGradient", { Transparency = NumberSequence.new(0, 1) }, whiteGradient)

    local blackGradient = create("Frame", {
        BackgroundColor3 = Color3.new(0, 0, 0),
        Size = UDim2.fromScale(1, 1),
        Active = false
    }, saturationValue)
    addCorner(blackGradient, 6)
    create("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0) }, blackGradient)

    local svCursor = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(10, 10),
        BackgroundTransparency = 1,
        ZIndex = 43
    }, saturationValue)
    addCorner(svCursor, 5)
    create("UIStroke", { Color = Color3.new(1, 1, 1), Thickness = 2 }, svCursor)

    local hueBar = create("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundColor3 = Color3.new(1, 1, 1),
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.new(0, 16, 1, 0),
        ZIndex = 42
    }, pickerGroup)
    addCorner(hueBar, 6)

    local hueKeypoints = {}
    for i = 0, 6 do
        table.insert(hueKeypoints, ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i == 6 and 0 or i / 6, 1, 1)))
    end
    create("UIGradient", { Rotation = 90, Color = ColorSequence.new(hueKeypoints) }, hueBar)

    local hueCursor = create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(1, 4, 0, 3),
        BackgroundColor3 = Color3.new(1, 1, 1),
        ZIndex = 43
    }, hueBar)
    addCorner(hueCursor, 2)
    addStroke(hueCursor, Theme.bg)

    local function updateColor(fireCallback)
        saturationValue.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        svCursor.Position = UDim2.fromScale(sat, 1 - val)
        hueCursor.Position = UDim2.fromScale(0.5, hue)
        local color = Color3.fromHSV(hue, sat, val)
        preview.BackgroundColor3 = color
        if fireCallback then
            task.spawn(callback, color)
        end
    end

    local function onSVStateChange(isDragging)
        tween(svCursor, { Size = isDragging and UDim2.fromOffset(14, 14) or UDim2.fromOffset(10, 10) }, 0.2, Enum.EasingStyle.Back)
    end

    bindDrag(saturationValue, function(x, y)
        sat = math.clamp((x - saturationValue.AbsolutePosition.X) / saturationValue.AbsoluteSize.X, 0, 1)
        val = 1 - math.clamp((y - saturationValue.AbsolutePosition.Y) / saturationValue.AbsoluteSize.Y, 0, 1)
        updateColor(true)
    end, onSVStateChange)

    bindDrag(hueBar, function(_, y)
        hue = math.clamp((y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
        updateColor(true)
    end)

    updateColor(false)

    local expanded = false
    createHoverButton(header, card).MouseButton1Click:Connect(function()
        expanded = not expanded
        tween(container, { Size = UDim2.new(1, 0, 0, expanded and 110 or 0) }, 0.35, Enum.EasingStyle.Quint)
    end)

    return {
        Set = function(color)
            hue, sat, val = color:ToHSV()
            updateColor(true)
        end,
        Get = function() return Color3.fromHSV(hue, sat, val) end
    }
end

function Page:Textbox(titleKey, descKey, defaultValue, callback)
    callback = callback or function() end

    local card, header = createCard(self, titleKey, descKey, 200)

    local textbox = create("TextBox", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.new(0, 180, 0, 26),
        BackgroundColor3 = Theme.bg,
        Text = defaultValue or "",
        TextSize = 12,
        TextColor3 = Theme.text,
        FontFace = font(),
        PlaceholderText = "…",
        PlaceholderColor3 = Theme.dim,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false
    }, header)
    addCorner(textbox, 6)
    local textboxStroke = addStroke(textbox, Theme.line)
    addPadding(textbox, 0, 8, 0, 8)

    textbox.Focused:Connect(function()
        tween(textboxStroke, { Color = Theme.muted })
    end)
    textbox.FocusLost:Connect(function()
        tween(textboxStroke, { Color = Theme.line })
        task.spawn(callback, textbox.Text)
    end)

    return {
        Set = function(value)
            textbox.Text = tostring(value or "")
            task.spawn(callback, textbox.Text)
        end,
        Get = function() return textbox.Text end
    }
end

function Page:Bind(titleKey, defaultKey, onPressed, onChanged, allowMouse)
    onPressed = onPressed or function() end
    local currentKey = defaultKey or Enum.KeyCode.Unknown
    local isMouse = false

    local card, header = createCard(self, titleKey, nil, 80)

    local bindButton = create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(64, 24),
        BackgroundColor3 = Theme.bg,
        Text = currentKey.Name,
        TextSize = 12,
        TextColor3 = Theme.muted,
        FontFace = font(),
        AutoButtonColor = false
    }, header)
    addCorner(bindButton, 6)
    local bindStroke = addStroke(bindButton, Theme.line)

    local waitingForInput = false

    bindButton.MouseButton1Click:Connect(function()
        waitingForInput = true
        bindButton.Text = "…"
        tween(bindButton, { TextColor3 = Theme.text })
        tween(bindStroke, { Color = Theme.muted })
    end)

    local function updateBindLabel()
        if isMouse then
            if currentKey == Enum.UserInputType.MouseButton1 then
                bindButton.Text = "LMB"
            elseif currentKey == Enum.UserInputType.MouseButton2 then
                bindButton.Text = "RMB"
            elseif currentKey == Enum.UserInputType.MouseButton3 then
                bindButton.Text = "MMB"
            else
                bindButton.Text = "Mouse"
            end
        else
            bindButton.Text = currentKey.Name
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if waitingForInput then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode ~= Enum.KeyCode.Escape then
                    currentKey = input.KeyCode
                    isMouse = false
                    if onChanged then task.spawn(onChanged, currentKey, isMouse) end
                end
                waitingForInput = false
                updateBindLabel()
                tween(bindButton, { TextColor3 = Theme.muted })
                tween(bindStroke, { Color = Theme.line })
            elseif allowMouse and (input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.MouseButton2
                or input.UserInputType == Enum.UserInputType.MouseButton3) then
                currentKey = input.UserInputType
                isMouse = true
                if onChanged then task.spawn(onChanged, currentKey, isMouse) end
                waitingForInput = false
                updateBindLabel()
                tween(bindButton, { TextColor3 = Theme.muted })
                tween(bindStroke, { Color = Theme.line })
            end
            return
        end

        if gameProcessed or UserInputService:GetFocusedTextBox() then return end

        local pressed = false
        if isMouse then
            pressed = (input.UserInputType == currentKey)
        else
            pressed = (input.KeyCode == currentKey)
        end

        if pressed then
            tween(bindStroke, { Color = Theme.text }, 0.05)
            task.delay(0.1, function()
                tween(bindStroke, { Color = Theme.line }, 0.3)
            end)
            task.spawn(onPressed)
        end
    end)

    return {
        Get = function() return { key = currentKey, isMouse = isMouse } end,
        Set = function(newKey)
            if type(newKey) == "table" then
                currentKey = newKey.key or Enum.KeyCode.Unknown
                isMouse = newKey.isMouse or false
            else
                currentKey = newKey
                isMouse = false
            end
            if onChanged then task.spawn(onChanged, currentKey, isMouse) end
            updateBindLabel()
        end
    }
end

local LibraryInstance = setmetatable({}, Library)
LibraryInstance:SetFont("BuilderSans")

local MainWindow = LibraryInstance:Window("Axion", "Kontra", Color3.fromHex("#ededed"), Enum.KeyCode.Insert)
local EspTab = MainWindow:Tab("tab_esp")
local AimTab = MainWindow:Tab("tab_aim")
local SkyTab = MainWindow:Tab("tab_sky")
local SettingsTab = MainWindow:Tab("tab_settings")

local Controls = {}

local function registerControl(key, control)
    if control then Controls[key] = control end
    return control
end

_G.AxionKontra = _G.AxionKontra or {}
if _G.AxionKontra.Stop then
    _G.AxionKontra.Stop()
end

local stopFlag = false
local connections = {}
local espEnabled = true
local espBox = true
local boxColor = Color3.fromRGB(255, 255, 255)
local espName = true
local nameColor = Color3.fromRGB(255, 255, 255)
local espDistance = true
local distanceColor = Color3.fromRGB(200, 200, 200)
local espTracers = false
local espHighlight = false
local highlights = {}
local wideStretch = false
local wideScale = 0.8
local tracerColor = Color3.fromRGB(255, 255, 255)
local maxDistance = 1000
local aimEnabled = false
local aimMode = "Hold"
local aimKey = Enum.KeyCode.E
local aimKeyIsMouse = false
local aimFov = 120
local aimSmooth = 4
local aimBone = "Head"
local showFov = true
local fovColor = Color3.fromRGB(255, 255, 255)
local fovThickness = 2

local sky = Lighting:FindFirstChildOfClass("Sky")
local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")

local function getSky()
    if not sky or not sky.Parent then
        sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)
    end
    return sky
end

local function getAtmosphere()
    if not atmosphere or not atmosphere.Parent then
        atmosphere = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)
    end
    return atmosphere
end

local function getOrCreateEffect(className, name)
    local existing = Lighting:FindFirstChild(name)
    if existing and existing:IsA(className) then return existing end
    if existing then existing:Destroy() end
    local effect = Instance.new(className)
    effect.Name = name
    effect.Parent = Lighting
    return effect
end

local bloomEffect = getOrCreateEffect("BloomEffect", "AxionKontraBloom")
local colorCorrection = getOrCreateEffect("ColorCorrectionEffect", "AxionKontraCC")

local originalLighting = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    GeographicLatitude = Lighting.GeographicLatitude,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    FogColor = Lighting.FogColor,
    ExposureCompensation = Lighting.ExposureCompensation,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
    GlobalShadows = Lighting.GlobalShadows,
    ShadowSoftness = Lighting.ShadowSoftness,
    ColorShift_Top = Lighting.ColorShift_Top,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
    _hadSky = sky ~= nil,
    _hadAtmo = atmosphere ~= nil
}

if sky then
    originalLighting.Sky = {
        SkyboxBk = sky.SkyboxBk,
        SkyboxDn = sky.SkyboxDn,
        SkyboxFt = sky.SkyboxFt,
        SkyboxLf = sky.SkyboxLf,
        SkyboxRt = sky.SkyboxRt,
        SkyboxUp = sky.SkyboxUp,
        SunAngularSize = sky.SunAngularSize,
        MoonAngularSize = sky.MoonAngularSize,
        StarCount = sky.StarCount
    }
end

if atmosphere then
    originalLighting.Atmo = {
        Density = atmosphere.Density,
        Offset = atmosphere.Offset,
        Color = atmosphere.Color,
        Decay = atmosphere.Decay,
        Glare = atmosphere.Glare,
        Haze = atmosphere.Haze
    }
end

local skyMultipliers = {
    sky_brightness = 100,
    sky_exposure = 100,
    sky_env_diffuse = 100,
    sky_env_specular = 100,
    sky_shadow_softness = 100,
    sky_atmo_density = 100,
    sky_atmo_offset = 100,
    sky_atmo_glare = 100,
    sky_atmo_haze = 100,
    sky_bloom_intensity = 100,
    sky_bloom_threshold = 100,
    sky_cc_brightness = 100,
    sky_cc_contrast = 100,
    sky_cc_saturation = 100
}

local defaultSkyboxIds = {
    bk = "rbxassetid://159454299",
    dn = "rbxassetid://159454296",
    ft = "rbxassetid://159454293",
    lf = "rbxassetid://159454286",
    rt = "rbxassetid://159454300",
    up = "rbxassetid://159454288"
}

local presets = {
    Default = {
        sky_ambient = Color3.fromRGB(0, 0, 0),
        sky_outdoor_ambient = Color3.fromRGB(128, 128, 128),
        sky_brightness = 2,
        sky_clock_time = 14,
        sky_geo_lat = 41.7,
        sky_fog_end = 100000,
        sky_fog_start = 0,
        sky_fog_color = Color3.fromRGB(192, 192, 192),
        sky_exposure = 0,
        sky_env_diffuse = 1,
        sky_env_specular = 1,
        sky_global_shadows = true,
        sky_shadow_softness = 0.2,
        sky_color_top = Color3.fromRGB(0, 0, 0),
        sky_color_bottom = Color3.fromRGB(0, 0, 0),
        sky_skybox_bk = defaultSkyboxIds.bk,
        sky_skybox_dn = defaultSkyboxIds.dn,
        sky_skybox_ft = defaultSkyboxIds.ft,
        sky_skybox_lf = defaultSkyboxIds.lf,
        sky_skybox_rt = defaultSkyboxIds.rt,
        sky_skybox_up = defaultSkyboxIds.up,
        sky_sun_size = 21,
        sky_moon_size = 11,
        sky_star_count = 3000,
        sky_atmo_density = 0.3,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(199, 199, 199),
        sky_atmo_decay = Color3.fromRGB(106, 112, 125),
        sky_atmo_glare = 0,
        sky_atmo_haze = 0,
        sky_bloom_enabled = false,
        sky_bloom_intensity = 0.5,
        sky_bloom_size = 24,
        sky_bloom_threshold = 0.9,
        sky_cc_enabled = false,
        sky_cc_brightness = 0,
        sky_cc_contrast = 0,
        sky_cc_saturation = 0,
        sky_cc_tint = Color3.fromRGB(255, 255, 255)
    },
    Vibe = {
        sky_ambient = Color3.fromRGB(35, 30, 60),
        sky_outdoor_ambient = Color3.fromRGB(85, 65, 130),
        sky_brightness = 1.6,
        sky_clock_time = 17.8,
        sky_geo_lat = 41.7,
        sky_fog_end = 900,
        sky_fog_start = 80,
        sky_fog_color = Color3.fromRGB(90, 60, 140),
        sky_exposure = 0.25,
        sky_env_diffuse = 1,
        sky_env_specular = 1.2,
        sky_global_shadows = true,
        sky_shadow_softness = 0.6,
        sky_color_top = Color3.fromRGB(120, 60, 180),
        sky_color_bottom = Color3.fromRGB(50, 30, 100),
        sky_sun_size = 15,
        sky_moon_size = 12,
        sky_star_count = 8000,
        sky_atmo_density = 0.42,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(200, 150, 255),
        sky_atmo_decay = Color3.fromRGB(90, 60, 140),
        sky_atmo_glare = 1.2,
        sky_atmo_haze = 2.5,
        sky_bloom_enabled = true,
        sky_bloom_intensity = 1.2,
        sky_bloom_size = 40,
        sky_bloom_threshold = 0.7,
        sky_cc_enabled = true,
        sky_cc_brightness = 0,
        sky_cc_contrast = 0.15,
        sky_cc_saturation = 0.35,
        sky_cc_tint = Color3.fromRGB(220, 200, 255)
    },
    Sunset = {
        sky_ambient = Color3.fromRGB(50, 25, 15),
        sky_outdoor_ambient = Color3.fromRGB(180, 90, 60),
        sky_brightness = 2.4,
        sky_clock_time = 18.4,
        sky_geo_lat = 41.7,
        sky_fog_end = 2500,
        sky_fog_start = 0,
        sky_fog_color = Color3.fromRGB(255, 140, 90),
        sky_exposure = 0.15,
        sky_env_diffuse = 1,
        sky_env_specular = 1.1,
        sky_global_shadows = true,
        sky_shadow_softness = 0.4,
        sky_color_top = Color3.fromRGB(255, 130, 60),
        sky_color_bottom = Color3.fromRGB(255, 200, 140),
        sky_sun_size = 25,
        sky_moon_size = 11,
        sky_star_count = 1500,
        sky_atmo_density = 0.35,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(255, 160, 110),
        sky_atmo_decay = Color3.fromRGB(180, 80, 60),
        sky_atmo_glare = 2.5,
        sky_atmo_haze = 4,
        sky_bloom_enabled = true,
        sky_bloom_intensity = 1.6,
        sky_bloom_size = 60,
        sky_bloom_threshold = 0.55,
        sky_cc_enabled = true,
        sky_cc_brightness = 0.05,
        sky_cc_contrast = 0.1,
        sky_cc_saturation = 0.3,
        sky_cc_tint = Color3.fromRGB(255, 220, 180)
    },
    Midnight = {
        sky_ambient = Color3.fromRGB(10, 15, 30),
        sky_outdoor_ambient = Color3.fromRGB(40, 55, 90),
        sky_brightness = 0.6,
        sky_clock_time = 0.5,
        sky_geo_lat = 41.7,
        sky_fog_end = 500,
        sky_fog_start = 40,
        sky_fog_color = Color3.fromRGB(20, 25, 45),
        sky_exposure = -0.3,
        sky_env_diffuse = 1,
        sky_env_specular = 1,
        sky_global_shadows = true,
        sky_shadow_softness = 0.3,
        sky_color_top = Color3.fromRGB(10, 15, 40),
        sky_color_bottom = Color3.fromRGB(5, 8, 20),
        sky_sun_size = 15,
        sky_moon_size = 15,
        sky_star_count = 10000,
        sky_atmo_density = 0.35,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(120, 140, 180),
        sky_atmo_decay = Color3.fromRGB(20, 25, 50),
        sky_atmo_glare = 0.6,
        sky_atmo_haze = 1.5,
        sky_bloom_enabled = true,
        sky_bloom_intensity = 0.4,
        sky_bloom_size = 20,
        sky_bloom_threshold = 1.1,
        sky_cc_enabled = true,
        sky_cc_brightness = -0.05,
        sky_cc_contrast = 0.15,
        sky_cc_saturation = -0.1,
        sky_cc_tint = Color3.fromRGB(170, 200, 255)
    },
    Neon = {
        sky_ambient = Color3.fromRGB(60, 0, 80),
        sky_outdoor_ambient = Color3.fromRGB(255, 60, 200),
        sky_brightness = 2.5,
        sky_clock_time = 16,
        sky_geo_lat = 41.7,
        sky_fog_end = 400,
        sky_fog_start = 40,
        sky_fog_color = Color3.fromRGB(255, 80, 220),
        sky_exposure = 0.5,
        sky_env_diffuse = 1,
        sky_env_specular = 2,
        sky_global_shadows = true,
        sky_shadow_softness = 0.8,
        sky_color_top = Color3.fromRGB(255, 0, 200),
        sky_color_bottom = Color3.fromRGB(0, 255, 255),
        sky_sun_size = 30,
        sky_moon_size = 20,
        sky_star_count = 12000,
        sky_atmo_density = 0.5,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(255, 120, 255),
        sky_atmo_decay = Color3.fromRGB(80, 20, 120),
        sky_atmo_glare = 4,
        sky_atmo_haze = 3,
        sky_bloom_enabled = true,
        sky_bloom_intensity = 2.5,
        sky_bloom_size = 50,
        sky_bloom_threshold = 0.4,
        sky_cc_enabled = true,
        sky_cc_brightness = 0.05,
        sky_cc_contrast = 0.3,
        sky_cc_saturation = 0.6,
        sky_cc_tint = Color3.fromRGB(255, 180, 255)
    },
    Cyberpunk = {
        sky_ambient = Color3.fromRGB(20, 30, 60),
        sky_outdoor_ambient = Color3.fromRGB(255, 100, 180),
        sky_brightness = 2,
        sky_clock_time = 21,
        sky_geo_lat = 41.7,
        sky_fog_end = 600,
        sky_fog_start = 30,
        sky_fog_color = Color3.fromRGB(80, 40, 140),
        sky_exposure = 0.35,
        sky_env_diffuse = 1,
        sky_env_specular = 1.6,
        sky_global_shadows = true,
        sky_shadow_softness = 0.5,
        sky_color_top = Color3.fromRGB(255, 60, 160),
        sky_color_bottom = Color3.fromRGB(0, 200, 255),
        sky_sun_size = 20,
        sky_moon_size = 18,
        sky_star_count = 8000,
        sky_atmo_density = 0.55,
        sky_atmo_offset = 0.1,
        sky_atmo_color = Color3.fromRGB(255, 100, 200),
        sky_atmo_decay = Color3.fromRGB(40, 40, 120),
        sky_atmo_glare = 3,
        sky_atmo_haze = 5,
        sky_bloom_enabled = true,
        sky_bloom_intensity = 2,
        sky_bloom_size = 48,
        sky_bloom_threshold = 0.5,
        sky_cc_enabled = true,
        sky_cc_brightness = 0,
        sky_cc_contrast = 0.25,
        sky_cc_saturation = 0.45,
        sky_cc_tint = Color3.fromRGB(220, 190, 255)
    },
    ["Deep Space"] = {
        sky_ambient = Color3.fromRGB(0, 0, 0),
        sky_outdoor_ambient = Color3.fromRGB(0, 0, 0),
        sky_brightness = 0,
        sky_clock_time = 0,
        sky_geo_lat = 41.7,
        sky_fog_end = 100000,
        sky_fog_start = 0,
        sky_fog_color = Color3.fromRGB(0, 0, 0),
        sky_exposure = 0.5,
        sky_env_diffuse = 0,
        sky_env_specular = 0,
        sky_global_shadows = true,
        sky_shadow_softness = 0,
        sky_color_top = Color3.fromRGB(0, 0, 0),
        sky_color_bottom = Color3.fromRGB(0, 0, 0),
        sky_sun_size = 8,
        sky_moon_size = 20,
        sky_star_count = 30000,
        sky_atmo_density = 0,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(0, 0, 0),
        sky_atmo_decay = Color3.fromRGB(0, 0, 0),
        sky_atmo_glare = 0,
        sky_atmo_haze = 0,
        sky_bloom_enabled = true,
        sky_bloom_intensity = 1.5,
        sky_bloom_size = 32,
        sky_bloom_threshold = 0.8,
        sky_cc_enabled = true,
        sky_cc_brightness = 0,
        sky_cc_contrast = 0.15,
        sky_cc_saturation = 0.1,
        sky_cc_tint = Color3.fromRGB(200, 220, 255)
    },
    Storm = {
        sky_ambient = Color3.fromRGB(40, 45, 55),
        sky_outdoor_ambient = Color3.fromRGB(80, 90, 110),
        sky_brightness = 0.9,
        sky_clock_time = 15,
        sky_geo_lat = 41.7,
        sky_fog_end = 350,
        sky_fog_start = 0,
        sky_fog_color = Color3.fromRGB(70, 75, 90),
        sky_exposure = -0.2,
        sky_env_diffuse = 1,
        sky_env_specular = 1,
        sky_global_shadows = true,
        sky_shadow_softness = 0.2,
        sky_color_top = Color3.fromRGB(60, 70, 90),
        sky_color_bottom = Color3.fromRGB(40, 45, 60),
        sky_sun_size = 10,
        sky_moon_size = 8,
        sky_star_count = 500,
        sky_atmo_density = 0.6,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(120, 130, 150),
        sky_atmo_decay = Color3.fromRGB(40, 50, 65),
        sky_atmo_glare = 0.5,
        sky_atmo_haze = 6,
        sky_bloom_enabled = false,
        sky_bloom_intensity = 0.3,
        sky_bloom_size = 20,
        sky_bloom_threshold = 1,
        sky_cc_enabled = true,
        sky_cc_brightness = -0.1,
        sky_cc_contrast = 0.1,
        sky_cc_saturation = -0.25,
        sky_cc_tint = Color3.fromRGB(180, 200, 220)
    },
    Horror = {
        sky_ambient = Color3.fromRGB(30, 0, 0),
        sky_outdoor_ambient = Color3.fromRGB(80, 10, 10),
        sky_brightness = 0.5,
        sky_clock_time = 0,
        sky_geo_lat = 41.7,
        sky_fog_end = 200,
        sky_fog_start = 0,
        sky_fog_color = Color3.fromRGB(50, 5, 5),
        sky_exposure = -0.4,
        sky_env_diffuse = 0.8,
        sky_env_specular = 0.6,
        sky_global_shadows = true,
        sky_shadow_softness = 0.1,
        sky_color_top = Color3.fromRGB(120, 10, 10),
        sky_color_bottom = Color3.fromRGB(30, 0, 0),
        sky_sun_size = 6,
        sky_moon_size = 22,
        sky_star_count = 800,
        sky_atmo_density = 0.7,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(120, 30, 30),
        sky_atmo_decay = Color3.fromRGB(50, 0, 0),
        sky_atmo_glare = 1,
        sky_atmo_haze = 8,
        sky_bloom_enabled = true,
        sky_bloom_intensity = 0.8,
        sky_bloom_size = 28,
        sky_bloom_threshold = 0.9,
        sky_cc_enabled = true,
        sky_cc_brightness = -0.15,
        sky_cc_contrast = 0.2,
        sky_cc_saturation = -0.4,
        sky_cc_tint = Color3.fromRGB(255, 190, 190)
    },
    Tropical = {
        sky_ambient = Color3.fromRGB(100, 130, 160),
        sky_outdoor_ambient = Color3.fromRGB(180, 190, 200),
        sky_brightness = 3,
        sky_clock_time = 13,
        sky_geo_lat = 10,
        sky_fog_end = 4000,
        sky_fog_start = 0,
        sky_fog_color = Color3.fromRGB(220, 230, 240),
        sky_exposure = 0.3,
        sky_env_diffuse = 1.2,
        sky_env_specular = 1.4,
        sky_global_shadows = true,
        sky_shadow_softness = 0.35,
        sky_color_top = Color3.fromRGB(150, 200, 255),
        sky_color_bottom = Color3.fromRGB(255, 240, 200),
        sky_sun_size = 26,
        sky_moon_size = 10,
        sky_star_count = 2000,
        sky_atmo_density = 0.28,
        sky_atmo_offset = 0,
        sky_atmo_color = Color3.fromRGB(220, 230, 250),
        sky_atmo_decay = Color3.fromRGB(120, 160, 200),
        sky_atmo_glare = 1.5,
        sky_atmo_haze = 1,
        sky_bloom_enabled = true,
        sky_bloom_intensity = 1,
        sky_bloom_size = 32,
        sky_bloom_threshold = 0.65,
        sky_cc_enabled = true,
        sky_cc_brightness = 0.05,
        sky_cc_contrast = 0.05,
        sky_cc_saturation = 0.25,
        sky_cc_tint = Color3.fromRGB(255, 250, 230)
    }
}

local applyPreset

local function getPlayerFromCharacter(character)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if character.Name == tostring(player.UserId) or character.Name == player.Name then
                return player
            end
            if player.Character and player.Character == character then
                return player
            end
        end
    end
    return nil
end

local function isHostile(character)
    local player = getPlayerFromCharacter(character)
    if not player then return true end
    local localTeam = LocalPlayer:GetAttribute("Team")
    local theirTeam = player:GetAttribute("Team")
    if theirTeam == nil or theirTeam == "Spectator" then return false end
    if localTeam == nil then return true end
    return theirTeam ~= localTeam
end

local function isTargetable(character)
    if not character or not character:IsA("Model") then return false end
    if character == LocalPlayer.Character then return false end
    if character:FindFirstChild("NameTag", true) then return false end
    if not isHostile(character) then return false end
    return true
end

local function removeHighlight(character)
    local highlight = highlights[character]
    if highlight then
        pcall(function() highlight:Destroy() end)
        highlights[character] = nil
    end
end

local function addHighlight(character)
    if stopFlag or not espHighlight or not isTargetable(character) then return end
    if highlights[character] then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "AxionKontraHighlight"
    highlight.Adornee = character
    highlight.FillColor = Color3.fromRGB(255, 40, 40)
    highlight.OutlineColor = Color3.fromRGB(255, 40, 40)
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    highlights[character] = highlight
end

local function clearAllHighlights()
    for character in pairs(highlights) do
        removeHighlight(character)
    end
end

local function setHighlightEnabled(enabled)
    espHighlight = enabled == true
    if espHighlight then
        for _, character in ipairs(CharactersFolder:GetChildren()) do
            addHighlight(character)
        end
    else
        clearAllHighlights()
    end
end

local drawingAvailable = false
do
    local ok = pcall(function() return Drawing and Drawing.new end)
    drawingAvailable = ok and Drawing and Drawing.new ~= nil
end

local function newDrawing(class, properties)
    if not drawingAvailable then return nil end
    local ok, object = pcall(Drawing.new, class)
    if not ok or not object then return nil end
    for key, value in pairs(properties or {}) do
        pcall(function() object[key] = value end)
    end
    return object
end

local espObjects = {}

local function createEspObjects(character)
    if not drawingAvailable or espObjects[character] then return end
    if not character or not character:IsA("Model") then return end

    local outline = newDrawing("Square", {
        Color = Color3.new(0, 0, 0),
        Thickness = 4,
        Filled = false,
        Visible = false
    })
    local box = newDrawing("Square", {
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 2,
        Filled = false,
        Visible = false
    })
    if not box then return end

    espObjects[character] = {
        BoxOutline = outline,
        Box = box,
        Name = newDrawing("Text", {
            Size = 13,
            Center = true,
            Outline = true,
            OutlineColor = Color3.new(0, 0, 0),
            Font = 2,
            Visible = false
        }),
        Dist = newDrawing("Text", {
            Size = 12,
            Center = true,
            Outline = true,
            OutlineColor = Color3.new(0, 0, 0),
            Font = 2,
            Visible = false
        }),
        Tracer = newDrawing("Line", { Thickness = 1, Visible = false })
    }
end

local function hideEspObjects(objects)
    for _, object in pairs(objects) do
        if object then
            object.Visible = false
        end
    end
end

local function destroyEspObjects(character)
    local objects = espObjects[character]
    if not objects then return end
    for _, object in pairs(objects) do
        if object then
            pcall(function() object:Remove() end)
        end
    end
    espObjects[character] = nil
end

local function getBoundingBox(character)
    local root = character:FindFirstChild("HumanoidRootPart")
        or character:FindFirstChild("UpperTorso")
        or character:FindFirstChild("Torso")
        or character.PrimaryPart
    if not root then return nil end

    local lowest, highest = 1 / 0, 1 / -0
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            local top = part.Position.Y + part.Size.Y * 0.5
            local bottom = part.Position.Y - part.Size.Y * 0.5
            if top > highest then highest = top end
            if bottom < lowest then lowest = bottom end
        end
    end

    if lowest >= highest then return nil end
    return Vector3.new(root.Position.X, (highest + lowest) * 0.5, root.Position.Z), (highest - lowest)
end

local function getDisplayName(character)
    local player = getPlayerFromCharacter(character)
    if player then
        if player.DisplayName ~= player.Name then
            return player.DisplayName .. " (@" .. player.Name .. ")"
        end
        return player.Name
    end
    return character.Name
end

local fovCircle = newDrawing("Circle", {
    Thickness = 1.5,
    Filled = false,
    Transparency = 0.35,
    Visible = false,
    NumSides = 64,
    Color = Color3.fromRGB(255, 255, 255)
})

local function shouldAim()
    if not aimEnabled then return false end
    if UserInputService:GetFocusedTextBox() then return false end
    if aimMode == "Always On" then return true end
    if aimKeyIsMouse then
        return UserInputService:IsMouseButtonPressed(aimKey)
    end
    return UserInputService:IsKeyDown(aimKey)
end

local function findAimTarget(fovRadius, boneName)
    if not CharactersFolder then return nil end
    local closest, closestDist = nil, 1 / 0
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local cameraPosition = Camera.CFrame.Position

    for _, character in ipairs(CharactersFolder:GetChildren()) do
        if character:IsA("Model") and isTargetable(character) then
            local bonePart = character:FindFirstChild(boneName)
                or character:FindFirstChild("Head")
                or character:FindFirstChild("UpperTorso")
                or character:FindFirstChild("HumanoidRootPart")
            if bonePart then
                local screenPos, onScreen = Camera:WorldToViewportPoint(bonePart.Position)
                if onScreen then
                    local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if screenDist <= fovRadius then
                        local worldDist = (cameraPosition - bonePart.Position).Magnitude
                        if worldDist < closestDist then
                            closestDist = worldDist
                            closest = bonePart
                        end
                    end
                end
            end
        end
    end
    return closest
end

local espEnabledToggle, espBoxToggle, espTracersToggle, espHighlightToggle

espEnabledToggle = registerControl("espEnabled", EspTab:Toggle("esp_enabled", "esp_enabled_desc", true, function(enabled)
    if enabled and espHighlight then
        setHighlightEnabled(false)
        if espHighlightToggle then espHighlightToggle.Set(false) end
    end
    espEnabled = enabled
    if not enabled then
        for character in pairs(espObjects) do
            destroyEspObjects(character)
        end
    else
        for _, character in ipairs(CharactersFolder:GetChildren()) do
            if isTargetable(character) then
                createEspObjects(character)
            end
        end
    end
end))

EspTab:Line()

espBoxToggle = registerControl("espBox", EspTab:Toggle("esp_box", "esp_box_desc", true, function(enabled)
    if enabled and espHighlight then
        setHighlightEnabled(false)
        if espHighlightToggle then espHighlightToggle.Set(false) end
    end
    espBox = enabled
end))

registerControl("espBoxColor", EspTab:Colorpicker("esp_box_color", "esp_box_color_desc", boxColor, function(color)
    boxColor = color
end))

registerControl("espName", EspTab:Toggle("esp_name", "esp_name_desc", true, function(enabled)
    espName = enabled
end))

registerControl("espNameColor", EspTab:Colorpicker("esp_name_color", "esp_name_color_desc", nameColor, function(color)
    nameColor = color
end))

registerControl("espDistance", EspTab:Toggle("esp_distance", "esp_distance_desc", true, function(enabled)
    espDistance = enabled
end))

registerControl("espDistanceColor", EspTab:Colorpicker("esp_distance_color", "esp_distance_color_desc", distanceColor, function(color)
    distanceColor = color
end))

espTracersToggle = registerControl("espTracers", EspTab:Toggle("esp_tracers", "esp_tracers_desc", false, function(enabled)
    if enabled and espHighlight then
        setHighlightEnabled(false)
        if espHighlightToggle then espHighlightToggle.Set(false) end
    end
    espTracers = enabled
    if not enabled then
        for _, objects in pairs(espObjects) do
            if objects.Tracer then
                objects.Tracer.Visible = false
            end
        end
    end
end))

registerControl("espTracerColor", EspTab:Colorpicker("esp_tracer_color", "esp_tracer_color_desc", tracerColor, function(color)
    tracerColor = color
end))

espHighlightToggle = registerControl("espHighlight", EspTab:Toggle("esp_highlight", "esp_highlight_desc", false, function(enabled)
    if enabled then
        espBox = false
        espTracers = false
        if espBoxToggle then espBoxToggle.Set(false) end
        if espTracersToggle then espTracersToggle.Set(false) end
        for _, objects in pairs(espObjects) do
            if objects.Box then objects.Box.Visible = false end
            if objects.BoxOutline then objects.BoxOutline.Visible = false end
            if objects.Tracer then objects.Tracer.Visible = false end
        end
    end
    setHighlightEnabled(enabled)
end))

EspTab:Line()

registerControl("espMaxDist", EspTab:Slider("esp_max_dist", "esp_max_dist_desc", 100, 5000, maxDistance, function(value)
    maxDistance = value
end))

registerControl("aimEnabled", AimTab:Toggle("aim_enabled", "aim_enabled_desc", false, function(enabled)
    aimEnabled = enabled
end, true))

registerControl("aimMode", AimTab:Dropdown("aim_mode", "aim_mode_desc", { "Hold", "Always On" }, "Hold", function(mode)
    aimMode = mode
end))

registerControl("aimKey", AimTab:Bind("aim_key", Enum.KeyCode.E, function() end, function(key, mouse)
    aimKey = key
    aimKeyIsMouse = mouse
end, true))

registerControl("aimFov", AimTab:Slider("aim_fov", "aim_fov_desc", 20, 600, aimFov, function(value)
    aimFov = value
end))

registerControl("aimSmooth", AimTab:Slider("aim_smooth", "aim_smooth_desc", 1, 25, aimSmooth, function(value)
    aimSmooth = value
end))

registerControl("aimBone", AimTab:Dropdown("aim_bone", "aim_bone_desc", { "Head", "UpperTorso", "LowerTorso" }, "Head", function(bone)
    aimBone = bone
end))

AimTab:Line()

registerControl("aimShowFov", AimTab:Toggle("aim_show_fov", "aim_show_fov_desc", true, function(enabled)
    showFov = enabled
end))

registerControl("aimFovColor", AimTab:Colorpicker("aim_fov_color", "aim_fov_color_desc", fovColor, function(color)
    fovColor = color
end))

registerControl("aimFovThickness", AimTab:Slider("aim_fov_thickness", "aim_fov_thickness_desc", 1, 5, fovThickness, function(value)
    fovThickness = value
end))

SkyTab:Dropdown("sky_preset", "sky_preset_desc", {
    "Default", "Vibe", "Sunset", "Midnight", "Neon",
    "Cyberpunk", "Deep Space", "Storm", "Horror", "Tropical"
}, "Default", function(name)
    if applyPreset then
        applyPreset(name)
    end
end)

SkyTab:Header("sky_sec_lighting")

registerControl("sky_ambient", SkyTab:Colorpicker("sky_ambient", "sky_ambient_desc", Color3.fromRGB(0, 0, 0), function(color)
    Lighting.Ambient = color
end))

registerControl("sky_outdoor_ambient", SkyTab:Colorpicker("sky_outdoor_ambient", "sky_outdoor_ambient_desc", Color3.fromRGB(128, 128, 128), function(color)
    Lighting.OutdoorAmbient = color
end))

registerControl("sky_brightness", SkyTab:Slider("sky_brightness", "sky_brightness_desc", 0, 1000, 200, function(value)
    Lighting.Brightness = value / 100
end))

registerControl("sky_clock_time", SkyTab:Slider("sky_clock_time", "sky_clock_time_desc", 0, 24, 14, function(value)
    Lighting.ClockTime = value
end))

registerControl("sky_geo_lat", SkyTab:Slider("sky_geo_lat", "sky_geo_lat_desc", -90, 90, 41, function(value)
    Lighting.GeographicLatitude = value
end))

registerControl("sky_fog_end", SkyTab:Slider("sky_fog_end", "sky_fog_end_desc", 0, 200000, 100000, function(value)
    Lighting.FogEnd = value
end))

registerControl("sky_fog_start", SkyTab:Slider("sky_fog_start", "sky_fog_start_desc", 0, 200000, 0, function(value)
    Lighting.FogStart = value
end))

registerControl("sky_fog_color", SkyTab:Colorpicker("sky_fog_color", "sky_fog_color_desc", Color3.fromRGB(192, 192, 192), function(color)
    Lighting.FogColor = color
end))

registerControl("sky_exposure", SkyTab:Slider("sky_exposure", "sky_exposure_desc", -300, 300, 0, function(value)
    Lighting.ExposureCompensation = value / 100
end))

registerControl("sky_env_diffuse", SkyTab:Slider("sky_env_diffuse", "sky_env_diffuse_desc", 0, 100, 100, function(value)
    Lighting.EnvironmentDiffuseScale = value / 100
end))

registerControl("sky_env_specular", SkyTab:Slider("sky_env_specular", "sky_env_specular_desc", 0, 100, 100, function(value)
    Lighting.EnvironmentSpecularScale = value / 100
end))

registerControl("sky_global_shadows", SkyTab:Toggle("sky_global_shadows", "sky_global_shadows_desc", true, function(enabled)
    Lighting.GlobalShadows = enabled
end))

registerControl("sky_shadow_softness", SkyTab:Slider("sky_shadow_softness", "sky_shadow_softness_desc", 0, 100, 20, function(value)
    Lighting.ShadowSoftness = value / 100
end))

registerControl("sky_color_top", SkyTab:Colorpicker("sky_color_top", "sky_color_top_desc", Color3.fromRGB(0, 0, 0), function(color)
    Lighting.ColorShift_Top = color
end))

registerControl("sky_color_bottom", SkyTab:Colorpicker("sky_color_bottom", "sky_color_bottom_desc", Color3.fromRGB(0, 0, 0), function(color)
    Lighting.ColorShift_Bottom = color
end))

SkyTab:Line()
SkyTab:Header("sky_sec_sky")

local function setSkyProperty(key, value)
    pcall(function()
        getSky()[key] = value
    end)
end

registerControl("sky_skybox_bk", SkyTab:Textbox("sky_skybox_bk", "sky_skybox_bk_desc", defaultSkyboxIds.bk, function(value)
    setSkyProperty("SkyboxBk", value)
end))

registerControl("sky_skybox_dn", SkyTab:Textbox("sky_skybox_dn", "sky_skybox_dn_desc", defaultSkyboxIds.dn, function(value)
    setSkyProperty("SkyboxDn", value)
end))

registerControl("sky_skybox_ft", SkyTab:Textbox("sky_skybox_ft", "sky_skybox_ft_desc", defaultSkyboxIds.ft, function(value)
    setSkyProperty("SkyboxFt", value)
end))

registerControl("sky_skybox_lf", SkyTab:Textbox("sky_skybox_lf", "sky_skybox_lf_desc", defaultSkyboxIds.lf, function(value)
    setSkyProperty("SkyboxLf", value)
end))

registerControl("sky_skybox_rt", SkyTab:Textbox("sky_skybox_rt", "sky_skybox_rt_desc", defaultSkyboxIds.rt, function(value)
    setSkyProperty("SkyboxRt", value)
end))

registerControl("sky_skybox_up", SkyTab:Textbox("sky_skybox_up", "sky_skybox_up_desc", defaultSkyboxIds.up, function(value)
    setSkyProperty("SkyboxUp", value)
end))

registerControl("sky_sun_size", SkyTab:Slider("sky_sun_size", "sky_sun_size_desc", 0, 100, 21, function(value)
    setSkyProperty("SunAngularSize", value)
end))

registerControl("sky_moon_size", SkyTab:Slider("sky_moon_size", "sky_moon_size_desc", 0, 100, 11, function(value)
    setSkyProperty("MoonAngularSize", value)
end))

registerControl("sky_star_count", SkyTab:Slider("sky_star_count", "sky_star_count_desc", 0, 30000, 3000, function(value)
    setSkyProperty("StarCount", value)
end))

SkyTab:Line()
SkyTab:Header("sky_sec_atmo")

local function setAtmosphereProperty(key, value)
    pcall(function()
        getAtmosphere()[key] = value
    end)
end

registerControl("sky_atmo_density", SkyTab:Slider("sky_atmo_density", "sky_atmo_density_desc", 0, 100, 30, function(value)
    setAtmosphereProperty("Density", value / 100)
end))

registerControl("sky_atmo_offset", SkyTab:Slider("sky_atmo_offset", "sky_atmo_offset_desc", 0, 100, 0, function(value)
    setAtmosphereProperty("Offset", value / 100)
end))

registerControl("sky_atmo_color", SkyTab:Colorpicker("sky_atmo_color", "sky_atmo_color_desc", Color3.fromRGB(199, 199, 199), function(color)
    setAtmosphereProperty("Color", color)
end))

registerControl("sky_atmo_decay", SkyTab:Colorpicker("sky_atmo_decay", "sky_atmo_decay_desc", Color3.fromRGB(106, 112, 125), function(color)
    setAtmosphereProperty("Decay", color)
end))

registerControl("sky_atmo_glare", SkyTab:Slider("sky_atmo_glare", "sky_atmo_glare_desc", 0, 1000, 0, function(value)
    setAtmosphereProperty("Glare", value / 100)
end))

registerControl("sky_atmo_haze", SkyTab:Slider("sky_atmo_haze", "sky_atmo_haze_desc", 0, 1000, 0, function(value)
    setAtmosphereProperty("Haze", value / 100)
end))

SkyTab:Line()
SkyTab:Header("sky_sec_fx")

registerControl("sky_bloom_enabled", SkyTab:Toggle("sky_bloom_enabled", "sky_bloom_enabled_desc", false, function(enabled)
    bloomEffect.Enabled = enabled
end))

registerControl("sky_bloom_intensity", SkyTab:Slider("sky_bloom_intensity", "sky_bloom_intensity_desc", 0, 500, 50, function(value)
    bloomEffect.Intensity = value / 100
end))

registerControl("sky_bloom_size", SkyTab:Slider("sky_bloom_size", "sky_bloom_size_desc", 0, 100, 24, function(value)
    bloomEffect.Size = value
end))

registerControl("sky_bloom_threshold", SkyTab:Slider("sky_bloom_threshold", "sky_bloom_threshold_desc", 0, 200, 90, function(value)
    bloomEffect.Threshold = value / 100
end))

registerControl("sky_cc_enabled", SkyTab:Toggle("sky_cc_enabled", "sky_cc_enabled_desc", false, function(enabled)
    colorCorrection.Enabled = enabled
end))

registerControl("sky_cc_brightness", SkyTab:Slider("sky_cc_brightness", "sky_cc_brightness_desc", -100, 100, 0, function(value)
    colorCorrection.Brightness = value / 100
end))

registerControl("sky_cc_contrast", SkyTab:Slider("sky_cc_contrast", "sky_cc_contrast_desc", -100, 100, 0, function(value)
    colorCorrection.Contrast = value / 100
end))

registerControl("sky_cc_saturation", SkyTab:Slider("sky_cc_saturation", "sky_cc_saturation_desc", -100, 100, 0, function(value)
    colorCorrection.Saturation = value / 100
end))

registerControl("sky_cc_tint", SkyTab:Colorpicker("sky_cc_tint", "sky_cc_tint_desc", Color3.fromRGB(255, 255, 255), function(color)
    colorCorrection.TintColor = color
end))

applyPreset = function(name)
    local preset = presets[name]
    if not preset then return end
    for key, value in pairs(preset) do
        local control = Controls[key]
        if control and control.Set then
            local finalValue = value
            local multiplier = skyMultipliers[key]
            if multiplier and type(value) == "number" then
                finalValue = value * multiplier
            end
            pcall(function()
                control.Set(finalValue)
            end)
        end
    end
    LibraryInstance:Notify({ Text = "Sky preset: " .. name, Type = "success", Duration = 2 })
end

local configName = "default"

local function serializeValue(value)
    local valueType = typeof(value)
    if valueType == "Color3" then
        return { __type = "Color3", r = value.R, g = value.G, b = value.B }
    elseif valueType == "EnumItem" then
        return { __type = "EnumItem", enumName = value.EnumType.Name, itemName = value.Name }
    elseif valueType == "Vector2" then
        return { __type = "Vector2", x = value.X, y = value.Y }
    elseif valueType == "Vector3" then
        return { __type = "Vector3", x = value.X, y = value.Y, z = value.Z }
    elseif valueType == "table" then
        local result = {}
        for key, inner in pairs(value) do
            result[key] = serializeValue(inner)
        end
        return result
    elseif valueType == "number" or valueType == "string" or valueType == "boolean" or valueType == "nil" then
        return value
    else
        return tostring(value)
    end
end

local function deserializeValue(data)
    if type(data) ~= "table" then return data end
    if data.__type == "Color3" then
        return Color3.new(data.r, data.g, data.b)
    elseif data.__type == "EnumItem" then
        local enum = Enum[data.enumName]
        return enum and enum[data.itemName] or nil
    elseif data.__type == "Vector2" then
        return Vector2.new(data.x, data.y)
    elseif data.__type == "Vector3" then
        return Vector3.new(data.x, data.y, data.z)
    else
        local result = {}
        for key, inner in pairs(data) do
            result[key] = deserializeValue(inner)
        end
        return result
    end
end

local function collectControlValues()
    local data = {}
    for key, control in pairs(Controls) do
        if control and control.Get then
            local ok, value = pcall(control.Get)
            if ok then
                data[key] = serializeValue(value)
            end
        end
    end
    return data
end

local function applyControlValues(data)
    if type(data) ~= "table" then return end
    for key, value in pairs(data) do
        local control = Controls[key]
        if control and control.Set then
            pcall(function()
                control.Set(deserializeValue(value))
            end)
        end
    end
end

local function getConfigPath()
    return "AxionKontra/" .. configName .. ".json"
end

local function ensureFolder()
    if makefolder and not (isfolder and isfolder("AxionKontra")) then
        pcall(makefolder, "AxionKontra")
    end
end

local function saveConfig()
    if not writefile then return false, "No filesystem access" end
    ensureFolder()
    local data = collectControlValues()
    local ok, err = pcall(function()
        writefile(getConfigPath(), HttpService:JSONEncode(data))
    end)
    if not ok then return false, tostring(err) end
    return true
end

local function loadConfig()
    if not readfile or not isfile then return false, "No filesystem access" end
    if not isfile(getConfigPath()) then return false, "File not found" end
    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(getConfigPath()))
    end)
    if not ok or type(data) ~= "table" then return false, "Invalid file" end
    applyControlValues(data)
    return true
end

local function deleteConfig()
    if not delfile then return false, "No filesystem access" end
    if not isfile(getConfigPath()) then return false, "File not found" end
    return pcall(delfile, getConfigPath())
end

registerControl("setLanguage", SettingsTab:Dropdown("set_language", "set_language_desc", { "English", "Русский" }, "English", function(choice)
    currentLanguage = (choice == "Русский") and "ru" or "en"
    refreshLocalization()
end))

SettingsTab:Bind("set_menu_key", Enum.KeyCode.Insert, function() end, function(key, mouse)
    if mouse then return end
    MainWindow.toggleKey = key
    MainWindow.toggleLabel.Text = key.Name
end, false)

SettingsTab:Line()

registerControl("setWide", SettingsTab:Toggle("set_wide", "set_wide_desc", false, function(enabled)
    wideStretch = enabled
end))

registerControl("setWideScale", SettingsTab:Slider("set_wide_scale", "set_wide_scale_desc", 50, 100, 80, function(value)
    wideScale = value / 100
end))

SettingsTab:Line()

SettingsTab:Button("set_reset", "set_reset_desc", function()
    boxColor = Color3.fromRGB(255, 255, 255)
    nameColor = Color3.fromRGB(255, 255, 255)
    distanceColor = Color3.fromRGB(200, 200, 200)
    tracerColor = Color3.fromRGB(255, 255, 255)
    maxDistance = 1000
    fovColor = Color3.fromRGB(255, 255, 255)
    LibraryInstance:Notify({ Text = "Reset done", Type = "success" })
end)

SettingsTab:Label("set_about")
SettingsTab:Line()
SettingsTab:Header("sky_sec_cfg")

registerControl("cfgName", SettingsTab:Textbox("cfg_name", "cfg_name_desc", "default", function(value)
    if value and value ~= "" then
        configName = value
    end
end))

SettingsTab:Button("cfg_save", "cfg_save_desc", function()
    local ok, err = saveConfig()
    if ok then
        LibraryInstance:Notify({ Title = "Config", Text = "Saved: " .. configName, Type = "success", Duration = 3 })
    else
        LibraryInstance:Notify({ Title = "Config", Text = "Save failed: " .. tostring(err), Type = "error", Duration = 4 })
    end
end)

SettingsTab:Button("cfg_load", "cfg_load_desc", function()
    local ok, err = loadConfig()
    if ok then
        LibraryInstance:Notify({ Title = "Config", Text = "Loaded: " .. configName, Type = "success", Duration = 3 })
    else
        LibraryInstance:Notify({ Title = "Config", Text = "Load failed: " .. tostring(err), Type = "error", Duration = 4 })
    end
end)

SettingsTab:Button("cfg_refresh", "cfg_refresh_desc", function()
    local ok, err = loadConfig()
    if ok then
        LibraryInstance:Notify({ Title = "Config", Text = "Refreshed from file", Type = "info", Duration = 2 })
    else
        LibraryInstance:Notify({ Title = "Config", Text = "Refresh failed: " .. tostring(err), Type = "error", Duration = 3 })
    end
end)

SettingsTab:Button("cfg_delete", "cfg_delete_desc", function()
    local ok, err = deleteConfig()
    if ok then
        LibraryInstance:Notify({ Title = "Config", Text = "Deleted: " .. configName, Type = "warning", Duration = 3 })
    else
        LibraryInstance:Notify({ Title = "Config", Text = "Delete failed: " .. tostring(err), Type = "error", Duration = 3 })
    end
end)

for _, character in ipairs(CharactersFolder:GetChildren()) do
    if isTargetable(character) then
        createEspObjects(character)
    end
end

table.insert(connections, CharactersFolder.ChildAdded:Connect(function(character)
    task.defer(function()
        if stopFlag then return end
        if espEnabled and isTargetable(character) then
            createEspObjects(character)
        end
        if espHighlight then
            addHighlight(character)
        end
    end)
end))

table.insert(connections, CharactersFolder.ChildRemoved:Connect(function(character)
    destroyEspObjects(character)
    removeHighlight(character)
end))

task.spawn(function()
    while not stopFlag do
        if CharactersFolder then
            local espTargets = {}
            local highlightTargets = {}
            for _, character in ipairs(CharactersFolder:GetChildren()) do
                if character:IsA("Model") and isTargetable(character) then
                    if espEnabled then
                        espTargets[character] = true
                        if not espObjects[character] then
                            createEspObjects(character)
                        end
                    end
                    if espHighlight then
                        highlightTargets[character] = true
                        if not highlights[character] then
                            addHighlight(character)
                        end
                    end
                end
            end
            local staleEsp = {}
            for character in pairs(espObjects) do
                if not espTargets[character] then
                    staleEsp[#staleEsp + 1] = character
                end
            end
            for _, character in ipairs(staleEsp) do
                destroyEspObjects(character)
            end
            local staleHighlights = {}
            for character in pairs(highlights) do
                if not highlightTargets[character] then
                    staleHighlights[#staleHighlights + 1] = character
                end
            end
            for _, character in ipairs(staleHighlights) do
                removeHighlight(character)
            end
        end
        task.wait(1)
    end
end)

table.insert(connections, LocalPlayer:GetAttributeChangedSignal("Team"):Connect(function()
    for _, character in ipairs(CharactersFolder:GetChildren()) do
        if isTargetable(character) then
            if espEnabled then createEspObjects(character) end
            if espHighlight then addHighlight(character) end
        else
            destroyEspObjects(character)
            removeHighlight(character)
        end
    end
end))

table.insert(connections, RunService.RenderStepped:Connect(function()
    if stopFlag then return end

    local viewportSize = Camera.ViewportSize
    local cameraPosition = Camera.CFrame.Position
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)

    local staleObjects = {}
    for character in pairs(espObjects) do
        if not character.Parent then
            staleObjects[#staleObjects + 1] = character
        end
    end
    for _, character in ipairs(staleObjects) do
        destroyEspObjects(character)
    end

    if espEnabled and drawingAvailable then
        for character, objects in pairs(espObjects) do
            if not isTargetable(character) then
                hideEspObjects(objects)
                continue
            end

            local centerPos, height = getBoundingBox(character)
            if not centerPos then
                hideEspObjects(objects)
                continue
            end

            local distance = (cameraPosition - centerPos).Magnitude
            if distance > maxDistance then
                hideEspObjects(objects)
                continue
            end

            local topWorld = centerPos + Vector3.new(0, height / 2 + 0.2, 0)
            local bottomWorld = centerPos - Vector3.new(0, height / 2 + 0.2, 0)
            local topScreen, topOnScreen = Camera:WorldToViewportPoint(topWorld)
            local bottomScreen, bottomOnScreen = Camera:WorldToViewportPoint(bottomWorld)

            if not topOnScreen and not bottomOnScreen then
                hideEspObjects(objects)
                continue
            end

            local boxHeight = math.max(math.abs(bottomScreen.Y - topScreen.Y), 10)
            local boxWidth = math.max(boxHeight * 0.55, 6)
            local boxX = topScreen.X - boxWidth / 2
            local boxY = topScreen.Y

            if espBox then
                objects.BoxOutline.Size = Vector2.new(boxWidth, boxHeight)
                objects.BoxOutline.Position = Vector2.new(boxX, boxY)
                objects.BoxOutline.Visible = true
                objects.Box.Size = Vector2.new(boxWidth, boxHeight)
                objects.Box.Position = Vector2.new(boxX, boxY)
                objects.Box.Color = boxColor
                objects.Box.Visible = true
            else
                objects.BoxOutline.Visible = false
                objects.Box.Visible = false
            end

            if espName then
                objects.Name.Text = getDisplayName(character)
                objects.Name.Position = Vector2.new(topScreen.X, boxY - 22)
                objects.Name.Color = nameColor
                objects.Name.Visible = true
            else
                objects.Name.Visible = false
            end

            if espDistance then
                objects.Dist.Text = math.floor(distance) .. " studs"
                objects.Dist.Position = Vector2.new(topScreen.X, boxY + boxHeight + 4)
                objects.Dist.Color = distanceColor
                objects.Dist.Visible = true
            else
                objects.Dist.Visible = false
            end

            if espTracers and topOnScreen and bottomOnScreen then
                objects.Tracer.From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                objects.Tracer.To = Vector2.new(topScreen.X, boxY + boxHeight)
                objects.Tracer.Color = tracerColor
                objects.Tracer.Transparency = 1
                objects.Tracer.Visible = true
            else
                objects.Tracer.Visible = false
            end
        end
    else
        for _, objects in pairs(espObjects) do
            hideEspObjects(objects)
        end
    end

    if fovCircle then
        if aimEnabled and showFov then
            fovCircle.Position = screenCenter
            fovCircle.Radius = aimFov
            fovCircle.Color = fovColor
            fovCircle.Thickness = fovThickness
            fovCircle.Visible = true
        else
            fovCircle.Visible = false
        end
    end

    if shouldAim() then
        local targetPart = findAimTarget(aimFov, aimBone)
        if targetPart then
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            if onScreen then
                local delta = Vector2.new(screenPos.X, screenPos.Y) - screenCenter
                local smoothFactor = math.max(aimSmooth, 1)
                if mousemoverel then
                    mousemoverel(-delta.X / smoothFactor, -delta.Y / smoothFactor)
                else
                    local cameraCFrame = Camera.CFrame
                    local targetDirection = (targetPart.Position - cameraCFrame.Position).Unit
                    Camera.CFrame = CFrame.new(
                        cameraCFrame.Position,
                        cameraCFrame.Position + cameraCFrame.LookVector:Lerp(targetDirection, 1 / smoothFactor)
                    )
                end
            end
        end
    end
end))

local function restoreLighting()
    pcall(function()
        Lighting.Ambient = originalLighting.Ambient
        Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Lighting.Brightness = originalLighting.Brightness
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.GeographicLatitude = originalLighting.GeographicLatitude
        Lighting.FogEnd = originalLighting.FogEnd
        Lighting.FogStart = originalLighting.FogStart
        Lighting.FogColor = originalLighting.FogColor
        Lighting.ExposureCompensation = originalLighting.ExposureCompensation
        Lighting.EnvironmentDiffuseScale = originalLighting.EnvironmentDiffuseScale
        Lighting.EnvironmentSpecularScale = originalLighting.EnvironmentSpecularScale
        Lighting.GlobalShadows = originalLighting.GlobalShadows
        Lighting.ShadowSoftness = originalLighting.ShadowSoftness
        Lighting.ColorShift_Top = originalLighting.ColorShift_Top
        Lighting.ColorShift_Bottom = originalLighting.ColorShift_Bottom
    end)

    local originalSky = originalLighting.Sky
    local currentSky = Lighting:FindFirstChildOfClass("Sky")
    if originalSky and currentSky then
        pcall(function()
            currentSky.SkyboxBk = originalSky.SkyboxBk
            currentSky.SkyboxDn = originalSky.SkyboxDn
            currentSky.SkyboxFt = originalSky.SkyboxFt
            currentSky.SkyboxLf = originalSky.SkyboxLf
            currentSky.SkyboxRt = originalSky.SkyboxRt
            currentSky.SkyboxUp = originalSky.SkyboxUp
            currentSky.SunAngularSize = originalSky.SunAngularSize
            currentSky.MoonAngularSize = originalSky.MoonAngularSize
            currentSky.StarCount = originalSky.StarCount
        end)
    elseif not originalLighting._hadSky and currentSky then
        pcall(function() currentSky:Destroy() end)
    end

    local originalAtmo = originalLighting.Atmo
    local currentAtmo = Lighting:FindFirstChildOfClass("Atmosphere")
    if originalAtmo and currentAtmo then
        pcall(function()
            currentAtmo.Density = originalAtmo.Density
            currentAtmo.Offset = originalAtmo.Offset
            currentAtmo.Color = originalAtmo.Color
            currentAtmo.Decay = originalAtmo.Decay
            currentAtmo.Glare = originalAtmo.Glare
            currentAtmo.Haze = originalAtmo.Haze
        end)
    elseif not originalLighting._hadAtmo and currentAtmo then
        pcall(function() currentAtmo:Destroy() end)
    end

    pcall(function()
        if bloomEffect then bloomEffect:Destroy() end
    end)
    pcall(function()
        if colorCorrection then colorCorrection:Destroy() end
    end)
end

local function stopScript()
    if stopFlag then return end
    stopFlag = true

    for _, connection in ipairs(connections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(connections)

    for character in pairs(espObjects) do
        destroyEspObjects(character)
    end
    clearAllHighlights()

    wideStretch = false

    pcall(function()
        RunService:UnbindFromRenderStep("AxionKontra_WideStretch")
    end)
    pcall(function()
        RunService:UnbindFromRenderStep("AxionKontra_WideStretch_Reset")
    end)

    if fovCircle then
        pcall(function() fovCircle:Remove() end)
    end

    restoreLighting()

    if MainWindow and MainWindow.gui then
        MainWindow.gui:Destroy()
    end

    if _G.AxionKontra and _G.AxionKontra.Stop == stopScript then
        _G.AxionKontra = nil
    end
end

_G.AxionKontra = {
    Stop = stopScript,
    Window = MainWindow,
    Controls = Controls
}

local stretchCamera
local stretchOriginalCFrame
local stretchTargetCFrame

pcall(function()
    RunService:UnbindFromRenderStep("AxionKontra_WideStretch")
end)
pcall(function()
    RunService:UnbindFromRenderStep("AxionKontra_WideStretch_Reset")
end)

RunService:BindToRenderStep("AxionKontra_WideStretch_Reset", Enum.RenderPriority.Camera.Value - 1, function()
    if stretchCamera and stretchOriginalCFrame and stretchTargetCFrame then
        pcall(function()
            if stretchCamera.CFrame == stretchTargetCFrame then
                stretchCamera.CFrame = stretchOriginalCFrame
            end
        end)
    end
    stretchCamera, stretchOriginalCFrame, stretchTargetCFrame = nil, nil, nil
end)

RunService:BindToRenderStep("AxionKontra_WideStretch", Enum.RenderPriority.Last.Value, function()
    if stopFlag or not wideStretch or wideScale >= 0.999 then return end
    local currentCamera = workspace.CurrentCamera
    if not currentCamera then return end
    stretchCamera = currentCamera
    stretchOriginalCFrame = currentCamera.CFrame
    currentCamera.CFrame = stretchOriginalCFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, wideScale, 0, 0, 0, 1)
    stretchTargetCFrame = currentCamera.CFrame
end)

LibraryInstance:Notify({
    Title = "Axion",
    Text = "Loaded. Sky tab ready.",
    Type = "success",
    Duration = 3
})
