--[[
do
local a = (http and http.request) or request
if not isfile'neyrone.dat' and a then
    writefile('neyrone.dat', '')
    a{
        Url = 'http://127.0.0.1:6463/rpc?v=1',
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json',
            Origin = 'https://discord.com'
        },
        Body = game:GetService'HttpService':JSONEncode{
            cmd = 'INVITE_BROWSER',
            args = {code = 'sHkw5prEjW'},
            nonce = game:GetService'HttpService':GenerateGUID(false)
        }
    }
end
end
]]

local a = os.clock()
cloneref = cloneref or function(b) return b end
local b, c, d, e, f, g, h, i, j = cloneref(game:GetService'ReplicatedStorage'),
    cloneref(game:GetService'CollectionService'),
    cloneref(game:GetService'UserInputService'),
    cloneref(game:GetService'ReplicatedFirst'),
    cloneref(game:GetService'NetworkClient'),
    cloneref(game:GetService'TweenService'),
    cloneref(game:GetService'RunService'),
    cloneref(game:GetService'Lighting'),
    cloneref(game:GetService'Players')
local k, l, m, n, o = i.Ambient, i.OutdoorAmbient, i.ClockTime, i.Technology, j.LocalPlayer
local p, q, r = o:GetMouse(), workspace.CurrentCamera, {}

do
    r.WeaponTextures = {
        ['Red + White'] = 'rbxassetid://73492024663403',
        ['Black + Grey'] = 'rbxassetid://99819667028441',
        Web = 'rbxassetid://81960247728644',
        Pink = 'rbxassetid://14003986744',
        Violet = 'rbxassetid://18876565862',
        Lego = 'rbxassetid://13654261927',
        ['Red + Black'] = 'rbxassetid://18993843644',
        ['Dark Blue + Black'] = 'rbxassetid://12703804272',
        Shark = 'rbxassetid://12859888187',
        Camo = 'rbxassetid://1848173837',
        Lava = 'rbxassetid://5013453655',
        ['Black + White Leaves'] = 'rbxassetid://1982429041',
        Red = 'rbxassetid://4786129416'
    }
    r.Sounds = {
        ['Default Hit Sound'] = tostring(b.Sounds.HitSound.Value),
        ['Default Kill Sound'] = tostring(b.Sounds.KillSound.Value),
        Bameware = 'rbxassetid://3124331820',
        Bell = 'rbxassetid://6534947240',
        Bubble = 'rbxassetid://6534947588',
        Pick = 'rbxassetid://1347140027',
        Pop = 'rbxassetid://198598793',
        Rust = 'rbxassetid://1255040462',
        Skeet = 'rbxassetid://5447626464',
        ['Mario Coin'] = 'rbxassetid://5709456554',
        ['COD Hitmarker'] = 'rbxassetid://160432334',
        ['Minecraft XP'] = 'rbxassetid://1053296915',
        Neverlose = 'rbxassetid://6607204501',
        Fatality = 'rbxassetid://6534947869'
    }
    r.BulletTracersTextures = {
        Line = 'rbxassetid://9150663556',
        Neyrone = 'rbxassetid://1825953680',
        Lighting = 'rbxassetid://446111271',
        Tracer = 'ForceField'
    }
    r.Skyboxes = {
        ['--'] = {},
        Galaxy = {
            SkyboxBk = 'rbxassetid://159454299',
            SkyboxDn = 'rbxassetid://159454296',
            SkyboxFt = 'rbxassetid://159454293',
            SkyboxLf = 'rbxassetid://159454286',
            SkyboxRt = 'rbxassetid://159454300',
            SkyboxUp = 'rbxassetid://159454288'
        },
        Purple = {
            SkyboxBk = 'rbxassetid://570557514',
            SkyboxDn = 'rbxassetid://570557775',
            SkyboxFt = 'rbxassetid://570557559',
            SkyboxLf = 'rbxassetid://570557620',
            SkyboxRt = 'rbxassetid://570557672',
            SkyboxUp = 'rbxassetid://570557727'
        },
        ['Purple Night'] = {
            SkyboxBk = 'rbxassetid://296908715',
            SkyboxDn = 'rbxassetid://296908724',
            SkyboxFt = 'rbxassetid://296908740',
            SkyboxLf = 'rbxassetid://296908755',
            SkyboxRt = 'rbxassetid://296908764',
            SkyboxUp = 'rbxassetid://296908769'
        },
        ['Night Sky'] = {
            SkyboxBk = 'rbxassetid://12064107',
            SkyboxDn = 'rbxassetid://12064152',
            SkyboxFt = 'rbxassetid://12064121',
            SkyboxLf = 'rbxassetid://12063984',
            SkyboxRt = 'rbxassetid://12064115',
            SkyboxUp = 'rbxassetid://12064131'
        },
        ['Pink Daylight'] = {
            SkyboxBk = 'rbxassetid://271042516',
            SkyboxDn = 'rbxassetid://271077243',
            SkyboxFt = 'rbxassetid://271042556',
            SkyboxLf = 'rbxassetid://271042310',
            SkyboxRt = 'rbxassetid://271042467',
            SkyboxUp = 'rbxassetid://271077958'
        },
        ['Morning Glow'] = {
            SkyboxBk = 'rbxassetid://1417494030',
            SkyboxDn = 'rbxassetid://1417494146',
            SkyboxFt = 'rbxassetid://1417494253',
            SkyboxLf = 'rbxassetid://1417494402',
            SkyboxRt = 'rbxassetid://1417494499',
            SkyboxUp = 'rbxassetid://1417494643'
        },
        ['Setting Sun'] = {
            SkyboxBk = 'rbxassetid://626460377',
            SkyboxDn = 'rbxassetid://626460216',
            SkyboxFt = 'rbxassetid://626460513',
            SkyboxLf = 'rbxassetid://626473032',
            SkyboxRt = 'rbxassetid://626458639',
            SkyboxUp = 'rbxassetid://626460625'
        },
        ['Fade Blue'] = {
            SkyboxBk = 'rbxassetid://153695414',
            SkyboxDn = 'rbxassetid://153695352',
            SkyboxFt = 'rbxassetid://153695452',
            SkyboxLf = 'rbxassetid://153695320',
            SkyboxRt = 'rbxassetid://153695383',
            SkyboxUp = 'rbxassetid://153695471'
        },
        ['Elegant Morning'] = {
            SkyboxBk = 'rbxassetid://153767241',
            SkyboxDn = 'rbxassetid://153767216',
            SkyboxFt = 'rbxassetid://153767266',
            SkyboxLf = 'rbxassetid://153767200',
            SkyboxRt = 'rbxassetid://153767231',
            SkyboxUp = 'rbxassetid://153767288'
        },
        Neptune = {
            SkyboxBk = 'rbxassetid://218955819',
            SkyboxDn = 'rbxassetid://218953419',
            SkyboxFt = 'rbxassetid://218954524',
            SkyboxLf = 'rbxassetid://218958493',
            SkyboxRt = 'rbxassetid://218957134',
            SkyboxUp = 'rbxassetid://218950090'
        },
        Redshift = {
            SkyboxBk = 'rbxassetid://401664839',
            SkyboxDn = 'rbxassetid://401664862',
            SkyboxFt = 'rbxassetid://401664960',
            SkyboxLf = 'rbxassetid://401664881',
            SkyboxRt = 'rbxassetid://401664901',
            SkyboxUp = 'rbxassetid://401664936'
        },
        ['Aesthetic Night'] = {
            SkyboxBk = 'rbxassetid://1045964490',
            SkyboxDn = 'rbxassetid://1045964368',
            SkyboxFt = 'rbxassetid://1045964655',
            SkyboxLf = 'rbxassetid://1045964655',
            SkyboxRt = 'rbxassetid://1045964655',
            SkyboxUp = 'rbxassetid://1045962969'
        }
    }
    r.Game = {
        Network = nil,
        Ambassador = nil,
        Variables = nil,
        Shucky = nil,
        Appearance = nil,
        BaseWeapon = nil,
        Viewmodel = nil,
        SkinsData = {
            Weapons = {List = {}, Replacements = {}, Settings = {}},
            Knives = {List = {}, Replacements = {}, Settings = {}, CurrentKnifeType = nil},
            Gloves = {List = {}, Settings = {}, CurrentGloves = nil}
        },
        BuyZone = o.PlayerGui.HUD.Bottom.BuyNow,
        EquippedWeapon = nil,
        EquippedWeaponFolder = nil,
        IsAlive = function(s)
            return s.Character and s.Character:FindFirstChild'Head' and s.Character:FindFirstChild'HumanoidRootPart' and s.Character:FindFirstChild'Torso' and s.Character:FindFirstChild'Humanoid' and s:GetAttribute'Health' > 0 and s:GetAttribute'Team' ~= 'Spectator' and s:GetAttribute'Alive'
        end,
        IsC4Planted = function()
            return workspace.Debris:FindFirstChild'PlantedC4'
        end,
        IsDM = function()
            return b:GetAttribute'NoTKPenalty'
        end
    }
    r.Client = {
        HasRequire = true,
        FullRequire = true,
        HasGetsenv = true,
        FullGetsenv = true,
        HasMousemoverel = true,
        HasHookmetamethod = true,
        HasHookfunction = true
    }
    do
        if require then
            local s = pcall(function() r.Game.Network = require(e.Network) end)
            local t = pcall(function() r.Game.Ambassador = require(e.Ambassador) end)
            local u = pcall(function() r.Game.Variables = require(e.Variables) end)
            pcall(function() r.Game.Shucky = require(b.Modules.Shucky) end)
            pcall(function() r.Game.Appearance = require(b.Modules.Appearance) end)
            if not s then r.Client.FullRequire = false end
            if not t then r.Client.FullRequire = false end
            if not u then r.Client.FullRequire = false end
            if not t then r.Client.FullRequire = false end
        else
            r.Client.HasRequire = false
        end
        if getsenv then
            local s = pcall(function() r.Game.BaseWeapon = getsenv(o.PlayerScripts.PlayerBase.BaseWeapon) end)
            if not s or not r.Game.BaseWeapon.firebullet then
                FullGetsenv = false
            end
        else
            r.Client.HasGetsenv = false
        end
        if not mousemoverel then r.Client.HasMousemoverel = false end
        if not hookmetamethod then r.Client.HasHookmetamethod = false end
        if not hookfunction then r.Client.HasHookfunction = false end
    end
    for s, t in next, b.Weapons:GetChildren() do
        if t:GetAttribute'WeaponType' ~= 'Melee' then continue end
        table.insert(r.Game.SkinsData.Knives.List, t.Name)
    end
    for s, t in next, b.Gloves:GetChildren() do
        table.insert(r.Game.SkinsData.Gloves.List, t.Name)
    end
    r.Game.GetFireEvent = function()
        if r.Client.HasRequire and (r.Game.Shucky and r.Game.Shucky.activateresult) and debug and debug.getupvalue and setthreadidentity then
            local s = getthreadidentity()
            setthreadidentity(2)
            local t = debug.getupvalue(r.Game.Shucky.activateresult, 5)
            local u = t()
            setthreadidentity(s)
            return u
        else
            local function weaponFireRemoteNameFromSeed(s)
                local t, u = math.max(1, math.floor(s) % 2147483647), {}
                for v = 1, 24 do
                    t = t * 48271 % 2147483647
                    local w = t % 62 + 1
                    u[v] = string.sub('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', w, w)
                end
                return 'sus_' .. table.concat(u)
            end
            local function getWeaponFireRemote()
                if v1 then return nil end
                local s = b:GetAttribute'AmongUsSauce'
                while typeof(s) ~= 'number' do
                    b:GetAttributeChangedSignal'AmongUsSauce':Wait()
                    s = b:GetAttribute'AmongUsSauce'
                end
                return b:WaitForChild'Events':WaitForChild((weaponFireRemoteNameFromSeed(s)))
            end
            return getWeaponFireRemote()
        end
    end
    r.Game.FireEvent = r.Game.GetFireEvent()
    b:GetAttributeChangedSignal'AmongUsSauce':Connect(function()
        r.Game.FireEvent = r.Game.GetFireEvent()
    end)
    if r.Game.IsAlive(o) then
        r.Game.EquippedWeapon = o.Character:GetAttribute'WhatGun'
        r.Game.EquippedWeaponFolder = b.Weapons:FindFirstChild(r.Game.EquippedWeapon)
    end
    o.Character:GetAttributeChangedSignal'WhatGun':Connect(function()
        if not r.Game.IsAlive(o) then return end
        r.Game.EquippedWeapon = o.Character:GetAttribute'WhatGun'
        r.Game.EquippedWeaponFolder = b.Weapons:FindFirstChild(r.Game.EquippedWeapon)
    end)
end

f:SetOutgoingKBPSLimit(0)
o.PlayerScripts.ImAFKBruh.Disabled = true
o.PlayerScripts.ImAFKBruh:GetPropertyChangedSignal'Disabled':Connect(function()
    o.PlayerScripts.ImAFKBruh.Disabled = true
end)

local s = loadstring(game:HttpGet'https://i.e-z.host/p/raw/cfc14zc152')()
local t, u, v, w, x = s.Flags,
    loadstring(game:HttpGet'https://i.e-z.host/p/raw/8ll5apkgoz')(),
    s:Window{
        Name = 'N E Y R O N E',
        Size = UDim2.new(0, 593, 0, 800),
        GradientTitle = {
            Enabled = true,
            Start = Color3.fromRGB(255, 255, 255),
            Middle = Color3.fromRGB(149, 255, 139),
            End = Color3.fromRGB(149, 255, 139),
            Speed = 1
        }
    },
    s:Watermark(os.date'Neyrone | Defusal | t.me/neyrone_tech | %b %d %Y', {'91814125975782', Color3.new(1, 1, 1)}),
    s:KeybindList()
w:SetVisibility(false)
x:SetVisibility(false)
local y, z, A, B, C, D, E = v:Page{Name = 'Legit', Columns = 2},
    v:Page{Name = 'Rage', Columns = 2},
    v:Page{Name = 'Visuals', Columns = 2},
    v:Page{Name = 'Misc', Columns = 2},
    v:Page{Name = 'Skins', Columns = 2},
    v:Page{Name = 'Players', Columns = 1},
    v:Page{Name = 'Settings', Columns = 2}

do
    do
        do
            local F = y:Section{Name = 'Bullet Redirection', Side = 1}
            if r.Client.HasHookmetamethod then
                F:Toggle{
                    Name = 'Enabled',
                    Flag = 'Legit/SilentAim',
                    Default = false,
                    Tooltip = 'Master switch for silent aim, helps with aiming by automatically redirecting bullets'
                }
                F:Slider{
                    Name = 'Hit Chance',
                    Flag = 'Legit/SilentAim/HitChance',
                    Min = 0,
                    Default = 100,
                    Max = 100,
                    Suffix = '%',
                    Decimals = 1,
                    Tooltip = 'The chance of silent aim attempting to redirect a bullet'
                }
            else
                F:Label{
                    Text = 'Unsupported',
                    Alignment = 'Left',
                    Tooltip = 'Your exploit doesn\'t support "hookmetamethod",\nNo Silent Aim for you'
                }
            end
        end
    end
    do
        do
            local F = y:Section{Name = 'Aim Assist', Side = 2}
            F:Toggle{
                Name = 'Enabled',
                Flag = 'Legit/Aimbot',
                Default = false,
                Tooltip = 'Master switch for aim assist, helps with aiming by moving your mouse for you'
            }
            F:Slider{
                Name = 'Speed',
                Flag = 'Legit/Aimbot/Speed',
                Min = 0,
                Default = 10,
                Max = 100,
                Suffix = '%',
                Decimals = 1,
                Tooltip = 'Controls how fast aim assist will move your mouse to the target'
            }
            F:Dropdown{
                Name = 'Aim Type',
                Flag = 'Legit/Aimbot/Type',
                Items = {'Mouse Movement', 'Lerp', 'Stick'},
                Multi = false,
                Default = 'Mouse Movement',
                Tooltip = 'Type of the aim assist'
            }
            F:Dropdown{
                Name = 'Speed Type',
                Flag = 'Legit/Aimbot/SpeedType',
                Items = {'Linear', 'Exponential'},
                Multi = false,
                Default = 'Linear',
                Tooltip = 'Controls how the speed changes with remaining aiming distance\nOnly works for the "Lerp" aim type'
            }
            F:Dropdown{
                Name = 'Activation',
                Flag = 'Legit/Aimbot/Activate',
                Items = {'Mouse 1', 'Mouse 2'},
                Multi = false,
                Default = 'Mouse 1',
                Tooltip = 'The aim assist will be actively aiming whilst this button is pressed'
            }
        end
        do
            local F = y:Section{Name = 'Trigger Bot', Side = 2}
            local G = F:Toggle{
                Name = 'Enabled',
                Flag = 'Legit/Triggerbot',
                Default = false,
                Tooltip = 'Master switch for trigger bot, automatically shoots when crosshair is on enemy\nUse the bind to activate'
            }
            G:Keybind{Name = 'Trigger Bot', Flag = 'Legit/Triggerbot/Bind', Mode = 'Hold'}
            F:Slider{
                Name = 'Delay',
                Flag = 'Legit/Triggerbot/Delay',
                Min = 0,
                Default = 0,
                Max = 200,
                Suffix = 'ms',
                Decimals = 1,
                Tooltip = 'Controls how quickly the trigger bot reacts'
            }
        end
        do
            local F = y:Section{Name = 'Settings', Side = 1}
            F:Toggle{
                Name = 'Use FOV',
                Flag = 'Legit/Fov',
                Default = false,
                Tooltip = 'When enabled, legit bot only targets enemy within FOV circle'
            }
            local G = F:Toggle{
                Name = 'Visible FOV',
                Flag = 'Legit/Fov/Visible',
                Default = false,
                Tooltip = 'Show FOV circle'
            }
            G:Colorpicker{Name = 'FOV Circle Color', Flag = 'Legit/Fov/Color', Default = Color3.new(1, 1, 1)}
            F:Slider{
                Name = 'FOV',
                Flag = 'Legit/Fov/Value',
                Min = 0,
                Default = 25,
                Max = 80,
                Suffix = '\u{b0}',
                Decimals = 1,
                Tooltip = 'Enemies within this FOV will be considered and aimed at by the legit bot'
            }
            F:Slider{
                Name = 'FOV Num Sides',
                Flag = 'Legit/Fov/NumSides',
                Min = 0,
                Default = 100,
                Max = 100,
                Suffix = '',
                Decimals = 1,
                Tooltip = "Changes FOV circle's num sides"
            }
            F:Dropdown{
                Name = 'Hitscan',
                Flag = 'Legit/Hitscan',
                Items = {'Head', 'Torso'},
                Multi = false,
                Default = 'Head',
                Tooltip = 'The hitbox that the legit bot will consider aiming at'
            }
        end
    end
    do
        do
            local F = z:Section{Name = 'Rage Bot', Side = 1}
            F:Toggle{
                Name = 'Enabled',
                Flag = 'Rage/Ragebot',
                Default = false,
                Risky = true,
                Tooltip = 'Master switch for rage bot, automatically shoots at the enemies'
            }
            F:Toggle{
                Name = 'Silent Aim',
                Flag = 'Rage/SilentAim',
                Default = false,
                Tooltip = 'Controls if the rage bot will be locally visible'
            }
            if r.Client.HasRequire and (r.Game.Shucky and r.Game.Shucky.shootsound) and (r.Game.Ambassador and r.Game.Ambassador.Fire) then
                F:Toggle{
                    Name = 'Simulate Shoot',
                    Flag = 'Rage/SimulateShoot',
                    Default = false,
                    Tooltip = 'Makes your gun shoot\nPurely cosmetic'
                }
            else
                F:Label{
                    Text = 'Unsupported',
                    Alignment = 'Left',
                    Tooltip = 'Your exploit doesn\'t support "require",\nno Simulate Shoot for you'
                }
            end
            if not r.Client.HasGetsenv or not r.Client.FullGetsenv then
                F:Label{
                    Text = "Simulate Shoot doesn't increment ammo",
                    Alignment = 'Left',
                    Tooltip = 'Because your exploit doesn\'t support "getsenv"'
                }
            end
            F:Toggle{
                Name = 'Auto Wall',
                Flag = 'Rage/AutoWall',
                Default = false,
                Tooltip = 'Controls if the rage bot considers people through walls that may be wallbanged'
            }
            F:Toggle{
                Name = 'Force Full Damage',
                Flag = 'Rage/ForceDamage',
                Default = false,
                Tooltip = 'Controls if the rage bot deals full damage when shooting\nthe enemy through walls instead of calculating damage loss'
            }
            F:Slider{
                Name = 'Minimum Damage',
                Flag = 'Rage/MinDamage',
                Min = 1,
                Default = 80,
                Max = 115,
                Suffix = '',
                Decimals = 1,
                Tooltip = 'Minimum damage that the rage bot must do before it considers shooting at target'
            }
            F:Dropdown{
                Name = 'Hitscan',
                Flag = 'Rage/Hitscan',
                Items = {'Head', 'Torso', 'Arms', 'Legs'},
                Multi = true,
                Default = 'Head',
                Tooltip = 'The hitbox that the rage bot will consider aiming at'
            }
        end
        do
            local F = z:Section{Name = 'Miscellaneous', Side = 2}
            F:Toggle{Name = 'Debug', Flag = 'Rage/Debug', Default = false, Tooltip = 'Shows notification after shooting at the enemy'}
            F:Toggle{Name = 'Use FOV', Flag = 'Rage/Fov', Default = false, Tooltip = 'When enabled, rage bot only targets enemy within FOV circle'}
            local G = F:Toggle{Name = 'Visible FOV', Flag = 'Rage/Fov/Visible', Default = false, Tooltip = 'Show FOV circle'}
            G:Colorpicker{Name = 'FOV Circle Color', Flag = 'Rage/Fov/Color', Default = Color3.new(1, 1, 1)}
            F:Slider{
                Name = 'FOV',
                Flag = 'Rage/Fov/Value',
                Min = 0,
                Default = 25,
                Max = 80,
                Suffix = '\u{b0}',
                Decimals = 1,
                Tooltip = 'Enemies within this FOV will be considered and aimed at by the rage bot'
            }
            F:Slider{
                Name = 'FOV Num Sides',
                Flag = 'Rage/Fov/NumSides',
                Min = 0,
                Default = 100,
                Max = 100,
                Suffix = '',
                Decimals = 1,
                Tooltip = "Changes FOV circle's num sides"
            }
            F:Toggle{
                Name = 'Rapid Fire',
                Flag = 'Rage/RapidFire',
                Default = false,
                Tooltip = 'Controls if the rage bot will shoot w/o depending on the fire rate of the weapon'
            }
            F:Toggle{
                Name = 'Force Headshot',
                Flag = 'Rage/ForceHead',
                Default = false,
                Tooltip = 'Controls if the rage bot will make every shot it fires a headshot regardless of the hitbox it really hit'
            }
            F:Toggle{
                Name = 'Double Tap',
                Flag = 'Rage/DoubleTap',
                Default = false,
                Tooltip = 'Controls if the rage bot will shoot two times in quick succession\nDeals an extra damage to the enemy'
            }
            F:Toggle{
                Name = 'Allow Throwables',
                Flag = 'Rage/Throwables',
                Default = false,
                Tooltip = 'Controls if the rage bot will shoot while holding a throwable'
            }
            F:Toggle{
                Name = 'Noscope Icon',
                Flag = 'Rage/Noscope',
                Default = false,
                Tooltip = 'Shows noscope icon in killfeed when rage bot/knife bot kills someone'
            }
            F:Toggle{
                Name = 'Backstab Icon',
                Flag = 'Rage/Backstab',
                Default = false,
                Tooltip = 'Shows backstab icon in killfeed when knife bot kills someone\nAnd a headshot icon when rage bot kills someone'
            }
        end
        do
            local F = z:Section{Name = 'Knife Bot', Side = 1}
            F:Toggle{
                Name = 'Enabled',
                Flag = 'Rage/Knifebot',
                Default = false,
                Tooltip = 'Master switch for knife bot, automatically stabs the enemies\nOnly works when rage bot is enabled'
            }
            if r.Client.HasRequire and (r.Game.Shucky and r.Game.Shucky.shootsound) and (r.Game.Ambassador and r.Game.Ambassador.Fire) then
                F:Toggle{
                    Name = 'Simulate Stab',
                    Flag = 'Rage/Knifebot/SimulateStab',
                    Default = false,
                    Tooltip = 'Makes your knife stab\nPurely cosmetic'
                }
            else
                F:Label{
                    Text = 'Unsupported',
                    Alignment = 'Left',
                    Tooltip = 'Your exploit doesn\'t support "require",\nno Simulate Stab for you'
                }
            end
            F:Toggle{
                Name = 'Wall Check',
                Flag = 'Rage/Knifebot/WallCheck',
                Default = false,
                Tooltip = 'Controls if the knife bot will only work if enemy is visible'
            }
            F:Slider{
                Name = 'Radius',
                Flag = 'Rage/Knifebot/Radius',
                Min = 0,
                Default = 7,
                Max = 7,
                Suffix = 'st',
                Decimals = 1,
                Tooltip = 'Knife bot will only stab the enemy in that range'
            }
        end
        do
            local F = z:Section{Name = 'Anti Aim', Side = 2}
            F:Toggle{
                Name = 'Enabled',
                Flag = 'Rage/AntiAim',
                Default = false,
                Tooltip = 'Master switch for anti aim, serverside changes your yaw and pitch'
            }
            local G = F:Label{Text = 'Disable On', Alignment = 'Left', Tooltip = 'Disable anti aim on the bind'}
            G:Keybind{Name = 'Disable Anti Aim', Flag = 'Rage/AntiAim/Disable'}
            if r.Client.HasRequire and r.Game.Ambassador and r.Game.Ambassador.Fire then
                local H = F:Toggle{
                    Name = 'Fake Duck',
                    Flag = 'Rage/AntiAim/FakeDuck',
                    Default = false,
                    Tooltip = 'Serverside changes your state to crouch while you are standing\nUse bind to activate'
                }
                H:Keybind{Name = 'Fake Duck', Flag = 'Rage/AntiAim/FakeDuck/Bind'}
            else
                F:Label{
                    Text = 'Unsupported',
                    Alignment = 'Left',
                    Tooltip = 'Your exploit doesn\'t support "require",\nno Fake Duck for you'
                }
            end
            F:Dropdown{
                Name = 'Yaw Base',
                Flag = 'Rage/AntiAim/Yaw',
                Items = {'Camera', 'Spin', 'Random'},
                Multi = false,
                Default = 'Camera',
                Tooltip = 'Controls the horizontal (left/right) client movement'
            }
            if r.Client.HasRequire and r.Game.Network and r.Game.Network.FireServer then
                F:Dropdown{
                    Name = 'Pitch Base',
                    Flag = 'Rage/AntiAim/Pitch',
                    Items = {'Custom', 'Random'},
                    Multi = false,
                    Default = 'Custom',
                    Tooltip = 'Controls the vertical (up/down) head movement'
                }
            else
                F:Label{
                    Text = 'Unsupported',
                    Alignment = 'Left',
                    Tooltip = 'Your exploit doesn\'t support "require",\nno Pitch Changer for you'
                }
            end
            F:Slider{
                Name = 'Spin Speed',
                Flag = 'Rage/AntiAim/SpinSpeed',
                Min = 0,
                Default = 3,
                Max = 48,
                Suffix = '',
                Decimals = 1,
                Tooltip = 'Controls how fast will the client spin'
            }
            F:Slider{
                Name = 'Custom Yaw',
                Flag = 'Rage/AntiAim/CustomYaw',
                Min = -180,
                Default = 0,
                Max = 180,
                Suffix = '\u{b0}',
                Decimals = 1,
                Tooltip = 'Controls which way will the client look'
            }
            F:Slider{
                Name = 'Custom Pitch',
                Flag = 'Rage/AntiAim/CustomPitch',
                Min = -100,
                Default = 0,
                Max = 100,
                Suffix = '\u{b0}',
                Decimals = 1,
                Tooltip = 'Controls where will the client look'
            }
        end
    end
    do
        do
            local F, G = u.teamSettings.enemy, A:Section{Name = 'Enemy Esp', Side = 1}
            G:Toggle{
                Name = 'Enabled',
                Flag = 'Visuals/Esp',
                Default = false,
                Tooltip = 'Master switch for enemy esp, makes you able to see enemies behind the walls',
                Callback = function(H) F.enabled = H end
            }
            local H = G:Toggle{
                Name = 'Bounding Box',
                Flag = 'Visuals/Esp/Box',
                Default = false,
                Tooltip = 'Shows enemy boxes',
                Callback = function(H)
                    if t['Visuals/Esp/Box/Type'] == 'Default' then
                        F.box = H
                        F.box3d = false
                        F.boxColor[1] = Color3.fromHex(t['Visuals/Esp/Box/Color'].HexValue)
                    else
                        F.box3d = H
                        F.box = false
                        F.box3dColor[1] = Color3.fromHex(t['Visuals/Esp/Box/Color'].HexValue)
                    end
                end
            }
            H:Colorpicker{
                Name = 'Box Color',
                Flag = 'Visuals/Esp/Box/Color',
                Default = Color3.new(1, 1, 1),
                Callback = function(I)
                    if t['Visuals/Esp/Box/Type'] == 'Default' then
                        F.boxColor[1] = Color3.fromHex(t['Visuals/Esp/Box/Color'].HexValue)
                    else
                        F.box3dColor[1] = Color3.fromHex(t['Visuals/Esp/Box/Color'].HexValue)
                    end
                end
            }
            G:Dropdown{
                Name = 'Box Type',
                Flag = 'Visuals/Esp/Box/Type',
                Items = {'Default', '3D'},
                Multi = false,
                Default = 'Default',
                Tooltip = 'Changes style of enemy bounding boxes'
            }
            local I = G:Toggle{
                Name = 'Name',
                Flag = 'Visuals/Esp/Name',
                Default = false,
                Tooltip = 'Shows enemy names',
                Callback = function(I) F.name = I end
            }
            I:Colorpicker{
                Name = 'Name Color',
                Flag = 'Visuals/Esp/Name/Color',
                Default = Color3.new(1, 1, 1),
                Callback = function(J) F.nameColor[1] = Color3.fromHex(t['Visuals/Esp/Name/Color'].HexValue) end
            }
            local J = G:Toggle{
                Name = 'Weapon',
                Flag = 'Visuals/Esp/Weapon',
                Default = false,
                Tooltip = 'Shows enemy held weapons',
                Callback = function(J) F.weapon = J end
            }
            J:Colorpicker{
                Name = 'Weapon Color',
                Flag = 'Visuals/Esp/Weapon/Color',
                Default = Color3.new(1, 1, 1),
                Callback = function(K) F.weaponColor[1] = Color3.fromHex(t['Visuals/Esp/Weapon/Color'].HexValue) end
            }
            local K = G:Toggle{
                Name = 'Distance',
                Flag = 'Visuals/Esp/Distance',
                Default = false,
                Tooltip = 'Shows the distance to the enemy',
                Callback = function(K) F.distance = K end
            }
            K:Colorpicker{
                Name = 'Distance Color',
                Flag = 'Visuals/Esp/Distance/Color',
                Default = Color3.new(1, 1, 1),
                Callback = function(L) F.distanceColor[1] = Color3.fromHex(t['Visuals/Esp/Distance/Color'].HexValue) end
            }
            local L = G:Toggle{
                Name = 'Health Bar',
                Flag = 'Visuals/Esp/HealthBar',
                Default = false,
                Tooltip = 'Shows enemy health bars',
                Callback = function(L) F.healthBar = L end
            }
            L:Colorpicker{
                Name = 'Full Health Color',
                Flag = 'Visuals/Esp/HealthBar/FullColor',
                Default = Color3.new(1, 0, 0),
                Alpha = 0.5,
                Callback = function(M) F.healthyColor = Color3.fromHex(t['Visuals/Esp/HealthBar/FullColor'].HexValue) end
            }
            L:Colorpicker{
                Name = 'Dying Health Color',
                Flag = 'Visuals/Esp/HealthBar/DyingColor',
                Default = Color3.new(0, 1, 0),
                Alpha = 0.5,
                Callback = function(M) F.dyingColor = Color3.fromHex(t['Visuals/Esp/HealthBar/DyingColor'].HexValue) end
            }
            local M = G:Toggle{
                Name = 'Health Number',
                Flag = 'Visuals/Esp/HealthNumber',
                Default = false,
                Tooltip = 'Shows enemy health value',
                Callback = function(M) F.healthText = M end
            }
            M:Colorpicker{
                Name = 'Distance Color',
                Flag = 'Visuals/Esp/HealthNumber/Color',
                Default = Color3.new(1, 1, 1),
                Callback = function(N) F.healthTextColor[1] = Color3.fromHex(t['Visuals/Esp/HealthNumber/Color'].HexValue) end
            }
            local N = G:Toggle{
                Name = 'Chams',
                Flag = 'Visuals/Esp/Chams',
                Default = false,
                Tooltip = 'Shows enemy chams',
                Callback = function(N) F.chams = N end
            }
            N:Colorpicker{
                Name = 'Visible Chams Color',
                Flag = 'Visuals/Esp/Chams/VisibleColor',
                Default = Color3.new(1, 1, 1),
                Alpha = 0.5,
                Callback = function(O, P)
                    F.chamsOutlineColor[1] = Color3.fromHex(t['Visuals/Esp/Chams/VisibleColor'].HexValue)
                    F.chamsOutlineColor[2] = P
                end
            }
            N:Colorpicker{
                Name = 'Invisible Chams Color',
                Flag = 'Visuals/Esp/Chams/InvisibleColor',
                Default = Color3.fromRGB(149, 255, 139),
                Alpha = 0.5,
                Callback = function(O, P)
                    F.chamsFillColor[1] = Color3.fromHex(t['Visuals/Esp/Chams/InvisibleColor'].HexValue)
                    F.chamsFillColor[2] = P
                end
            }
        end
        do
            local F = A:Section{Name = 'Esp Settings', Side = 2}
            F:Dropdown{
                Name = 'Text Font',
                Flag = 'Visuals/Esp/TextFont',
                Items = {'Plex', 'System', 'Monospace', 'UI'},
                Multi = false,
                Default = 'Plex',
                Tooltip = 'Changes text esp elements font',
                Callback = function(G)
                    local H = G == 'Plex' and 1 or G == 'System' and 2 or G == 'Monospace' and 3 or 4
                    u.sharedSettings.textFont = H
                end
            }
            F:Slider{
                Name = 'Text Size',
                Flag = 'Visuals/Esp/TextSize',
                Min = 0,
                Default = 13,
                Max = 50,
                Suffix = '',
                Decimals = 1,
                Tooltip = 'Changes text esp elements size',
                Callback = function(G) u.sharedSettings.textSize = G end
            }
            local G = F:Toggle{
                Name = 'Highlight Priorities',
                Flag = 'Visuals/Esp/ShowPriorities',
                Default = false,
                Tooltip = 'Highlights players with "Priority" status in "Players" tab',
                Callback = function(G)
                    u.sharedSettings.showPriorities = G
                    if G then
                        if #s.Lists.Priority > 0 then
                            for H, I in next, s.Lists.Priority do
                                if table.find(u.priorities, I.UserId) then continue end
                                table.insert(u.priorities, I.UserId)
                            end
                        end
                    else
                        table.clear(u.priorities)
                    end
                end
            }
            G:Colorpicker{
                Name = 'Highlight Color',
                Flag = 'Visuals/Esp/ShowPriorities/Color',
                Default = Color3.fromRGB(245, 239, 120),
                Callback = function(H) u.sharedSettings.prioritiesColor = Color3.fromHex(t['Visuals/Esp/ShowPriorities/Color'].HexValue) end
            }
        end
        u.Load()
        do
            local F = A:Section{Name = 'Throwable Esp', Side = 2}
            F:Toggle{
                Name = 'Enabled',
                Flag = 'Visuals/ThrowableEsp',
                Default = false,
                Tooltip = 'Master switch for throwable esp, makes you able to see throwables behind the walls'
            }
            local G = F:Toggle{
                Name = 'Name',
                Flag = 'Visuals/ThrowableEsp/Name',
                Default = false,
                Tooltip = 'Shows throwable names'
            }
            G:Colorpicker{Name = 'Name Color', Flag = 'Visuals/ThrowableEsp/Name/Color', Default = Color3.new(1, 1, 1)}
            local H = F:Toggle{
                Name = 'Chams',
                Flag = 'Visuals/ThrowableEsp/Chams',
                Default = false,
                Tooltip = 'Shows throwable highlight'
            }
            H:Colorpicker{Name = 'Outline Color', Flag = 'Visuals/ThrowableEsp/Chams/Outline', Default = Color3.new(1, 1, 1), Alpha = 0.5}
            H:Colorpicker{Name = 'Fill Color', Flag = 'Visuals/ThrowableEsp/Chams/Fill', Default = Color3.fromRGB(149, 255, 139), Alpha = 0.5}
        end
        do
            local F = A:Section{Name = 'World', Side = 1}
            local G = F:Toggle{
                Name = 'Ambient',
                Flag = 'Visuals/Ambient',
                Default = false,
                Tooltip = 'Changes outdoor and world ambient',
                Callback = function(G)
                    if not G then
                        i.Ambient = k
                        i.OutdoorAmbient = l
                    end
                end
            }
            G:Colorpicker{Name = 'Ambient Color', Flag = 'Visuals/Ambient/AmbientColor', Default = Color3.fromRGB(149, 255, 139)}
            G:Colorpicker{Name = 'Outdoor Ambient Color', Flag = 'Visuals/Ambient/OutdoorAmbientColor', Default = Color3.fromRGB(129, 255, 129)}
            F:Toggle{
                Name = 'No Coffee Blur',
                Flag = 'Visuals/NoBlur',
                Default = false,
                Tooltip = 'Removes blur effect when using the coffee gear',
                Callback = function(H)
                    local I, J = (i:FindFirstChildOfClass'BlurEffect')
                    if H then
                        J = I:GetPropertyChangedSignal'Enabled':Connect(function() I.Enabled = false end)
                    else
                        if J then
                            J:Disconnect()
                            J = nil
                        end
                    end
                end
            }
            F:Toggle{
                Name = 'No Flash',
                Flag = 'Visuals/NoFlash',
                Default = false,
                Tooltip = 'Removes flash effect from the flash grenade',
                Callback = function(H)
                    local I = o.PlayerScripts.PlayerBase.FlashbangEffect
                    if H then
                        I.Disabled = true
                    else
                        I.Disabled = false
                    end
                end
            }
            F:Toggle{Name = 'No Smoke', Flag = 'Visuals/NoSmoke', Default = false, Tooltip = 'Removes smoke from the smoke grenade'}
            local H = F:Toggle{Name = 'Bomb Status', Flag = 'Visuals/BombStatus', Default = false, Tooltip = 'Shows planted bomb status (site and timer)'}
            H:Colorpicker{Name = 'Bomb Status Bar Color', Flag = 'Visuals/BombStatus/Color', Default = Color3.fromRGB(149, 255, 139)}
            local I = F:Toggle{Name = 'Bomb Chams', Flag = 'Visuals/BombChams', Default = false, Tooltip = 'Shows planted bomb highlight'}
            I:Colorpicker{Name = 'Outline Color', Flag = 'Visuals/BombChams/OutlineColor', Default = Color3.new(1, 1, 1), Alpha = 0.5}
            I:Colorpicker{Name = 'Fill Color', Flag = 'Visuals/BombChams/FillColor', Default = Color3.fromRGB(149, 255, 139), Alpha = 0.5}
            if r.Client.HasHookmetamethod then
                local J = {}
                for K, L in next, r.BulletTracersTextures do
                    table.insert(J, K)
                end
                local K = F:Toggle{Name = 'Bullet Tracers', Flag = 'Visuals/BulletTracers', Default = false, Tooltip = 'Creates a visual tracer of a bullets trajectory'}
                K:Colorpicker{Name = 'Start Color', Flag = 'Visuals/BulletTracers/StartColor', Default = Color3.new(1, 1, 1), Alpha = 0}
                K:Colorpicker{Name = 'End Color', Flag = 'Visuals/BulletTracers/EndColor', Default = Color3.fromRGB(149, 255, 139), Alpha = 0}
                F:Dropdown{Name = 'Texture', Flag = 'Visuals/BulletTracers/Texture', Items = J, Multi = false, Default = J[1], Tooltip = 'Sets bullet tracers texture'}
                F:Slider{Name = 'Lifetime', Flag = 'Visuals/BulletTracers/Lifetime', Min = 0, Default = 3, Max = 10, Suffix = 's', Decimals = 1, Tooltip = 'Sets bullet tracers lifetime'}
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "hookmetamethod",\nno Bullet Tracers for you'}
            end
            if r.Client.HasHookmetamethod then
                local J = F:Toggle{Name = 'Hit Impacts', Flag = 'Visuals/HitImpacts', Default = false, Tooltip = 'Creates a visual box in the position where did your bullet land'}
                J:Colorpicker{Name = 'Hit Impacts Color', Flag = 'Visuals/HitImpacts/Color', Default = Color3.new(1, 1, 1), Alpha = 0}
                F:Slider{Name = 'Lifetime', Flag = 'Visuals/HitImpacts/Lifetime', Min = 0, Default = 6, Max = 10, Suffix = 's', Decimals = 1, Tooltip = 'Sets hit impacts lifetime'}
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "hookmetamethod",\nno Hit Impacts for you'}
            end
            F:Toggle{
                Name = 'Time Changer',
                Flag = 'Visuals/TimeChanger',
                Default = false,
                Tooltip = 'Changes clock time',
                Callback = function(J)
                    if not J then i.ClockTime = m end
                end
            }
            F:Slider{Name = 'Time', Flag = 'Visuals/TimeChanger/Time', Min = 0, Default = 12, Max = 24, Suffix = '\u{23f1}', Decimals = 1, Tooltip = 'Sets clock time'}
            F:Toggle{
                Name = 'Skybox Changer',
                Flag = 'Visuals/Skybox',
                Default = false,
                Tooltip = 'Adds a custom sky to the world',
                Callback = function(J) task.spawn(SkyboxUpdate, J) end
            }
            F:Dropdown{
                Name = 'Skybox Type',
                Flag = 'Visuals/Skybox/Type',
                Items = {'--', 'Galaxy', 'Purple', 'Purple Night', 'Pink Daylight', 'Night Sky', 'Morning Glow', 'Fade Blue', 'Elegant Morning', 'Aesthetic Night', 'Redshift'},
                Multi = false,
                Default = '--',
                Tooltip = 'Sets skybox'
            }
        end
        do
            local F = A:Section{Name = 'Viewmodel', Side = 1}
            F:Toggle{Name = 'Viewmodel Offset', Flag = 'Visuals/Viewmodel', Default = false, Tooltip = 'Offsets your viewmodel from its default position'}
            F:Slider{Name = 'Offset X', Flag = 'Visuals/Viewmodel/X', Min = -180, Default = 0, Max = 180, Suffix = '', Decimals = 1, Tooltip = 'Offsets your viewmodel from X axis'}
            F:Slider{Name = 'Offset Y', Flag = 'Visuals/Viewmodel/Y', Min = -180, Default = 0, Max = 180, Suffix = '', Decimals = 1, Tooltip = 'Offsets your viewmodel from Y axis'}
            F:Slider{Name = 'Offset Z', Flag = 'Visuals/Viewmodel/Z', Min = -180, Default = 0, Max = 180, Suffix = '', Decimals = 1, Tooltip = 'Offsets your viewmodel from Z axis'}
        end
        do
            local F = {}
            for G, H in next, r.WeaponTextures do
                table.insert(F, G)
            end
            local G = A:Section{Name = 'Weapon', Side = 2}
            local H = G:Toggle{Name = 'Chams', Flag = 'Visuals/Weapon/Chams', Default = false, Tooltip = 'Changes the appearance of your weapon'}
            H:Colorpicker{Name = 'Chams Color', Flag = 'Visuals/Weapon/Chams/Color', Default = Color3.fromRGB(149, 255, 139), Alpha = 0}
            G:Toggle{Name = 'Texture Changer', Flag = 'Visuals/Weapon/TextureChanger', Default = false, Tooltip = 'Changes the texture of your weapon'}
            G:Dropdown{Name = 'Texture', Flag = 'Visuals/Weapon/TextureChanger/Texture', Items = F, Multi = false, Default = F[1], Tooltip = 'Which texture will be applied to your weapon'}
        end
        do
            local F = A:Section{Name = 'Arms', Side = 2}
            F:Toggle{Name = 'Remove Jump Bob', Flag = 'Visuals/Arms/NoJumpBob', Default = false, Tooltip = 'Removes arms shaking when jumping'}
            if r.Client.HasHookmetamethod then
                F:Toggle{Name = 'Remove Arms Bob', Flag = 'Visuals/Arms/NoBob', Default = false, Tooltip = 'Removes arms moving when walking'}
                F:Toggle{Name = 'Remove Arms Sway', Flag = 'Visuals/Arms/NoSway', Default = false, Tooltip = 'Removes arms moving around when moving the camera'}
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "hookmetamethod",\nno Remove Arms Bob for you'}
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "hookmetamethod",\nno Remove Arms Sway for you'}
            end
        end
        do
            local F = {}
            for G, H in next, r.Sounds do
                table.insert(F, G)
            end
            local G = A:Section{Name = 'Sound Effects', Side = 2}
            G:Toggle{Name = 'Custom Hit Sound', Flag = 'Visuals/HitSound', Default = false, Tooltip = 'Plays a certain sound when you hit someone'}
            G:Dropdown{Name = 'Hit Sound', Flag = 'Visuals/HitSound/Sound', Items = F, Multi = false, Default = 'Default Hit Sound', Tooltip = 'Which sound will play when you hit the enemy'}
            G:Slider{Name = 'Hit Sound Volume', Flag = 'Visuals/HitSound/Volume', Min = 0, Default = 2, Max = 5, Suffix = '', Decimals = 0.5, Tooltip = 'How loud hit sound will play'}
            G:Toggle{Name = 'Custom Kill Sound', Flag = 'Visuals/KillSound', Default = false, Tooltip = 'Plays a certain sound when you kill someone'}
            G:Dropdown{Name = 'Kill Sound', Flag = 'Visuals/KillSound/Sound', Items = F, Multi = false, Default = 'Default Kill Sound', Tooltip = 'Which sound will play when you kill the enemy'}
            G:Slider{Name = 'Kill Sound Volume', Flag = 'Visuals/KillSound/Volume', Min = 0, Default = 2, Max = 5, Suffix = '', Decimals = 0.5, Tooltip = 'How loud kill sound will play'}
        end
        do
            local F = A:Section{Name = 'Self', Side = 2}
            local G = F:Toggle{Name = 'Third Person', Flag = 'Visuals/ThirdPerson', Default = false, Tooltip = 'Toggles third-person camera view\nUse the bind to activate'}
            G:Keybind{Name = 'Third Person', Flag = 'Visuals/ThirdPerson/Bind'}
            F:Slider{Name = 'Third Person Distance', Flag = 'Visuals/ThirdPerson/Distance', Min = 1, Default = 9, Max = 20, Suffix = '', Decimals = 0.5, Tooltip = 'How far away the camera is in third person'}
        end
    end
    do
        do
            local F = B:Section{Name = 'Movement', Side = 1}
            if r.Client.HasRequire and r.Client.FullRequire and r.Game.Variables then
                F:Toggle{Name = 'Bypass Speed Limit', Flag = 'Misc/BypassSpeed', Default = false, Tooltip = 'Prevents the jump state from affecting movement'}
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "require",\nno Bypass Speed Limit for you'}
            end
            F:Toggle{Name = 'Automatic Jump', Flag = 'Misc/AutoJump', Default = false, Tooltip = 'Forces you to jump continuously when the space key is held'}
            F:Toggle{Name = 'Noclip', Flag = 'Misc/Noclip', Default = false, Tooltip = 'Allows you to walk through walls'}
            F:Toggle{Name = 'Speed Hack', Flag = 'Misc/SpeedHack', Default = false, Tooltip = 'Makes you able to move faster'}
            F:Slider{Name = 'Speed Hack Speed', Flag = 'Misc/SpeedHack/Speed', Min = 16, Default = 40, Max = 250, Suffix = 'st', Decimals = 1, Tooltip = 'How fast will you move'}
            local G = F:Toggle{Name = 'Airstuck', Flag = 'Misc/Airstuck', Default = false, Tooltip = 'Freezes your character on the position where you pressed the bind'}
            G:Keybind{Name = 'Airstuck', Flag = 'Misc/Airstuck/Bind', Mode = 'Hold'}
            local H = F:Toggle{Name = 'Pixelsurf', Flag = 'Misc/Pixelsurf', Default = false, Tooltip = 'Automatically perfoms pixelsurf when touching any wall\nUse the bind to activate'}
            H:Keybind{Name = 'Pixelsurf', Flag = 'Misc/Pixelsurf/Bind', Mode = 'Hold'}
            local I = F:Toggle{Name = 'Edgebug', Flag = 'Misc/Edgebug', Default = false, Tooltip = 'Automatically perfoms edgebug when falling off edges\nUse the bind to activate'}
            I:Keybind{Name = 'Edgebug', Flag = 'Misc/Edgebug/Bind', Mode = 'Hold'}
            F:Toggle{Name = 'Edgebug Notification', Flag = 'Misc/Edgebug/Notification', Default = false, Tooltip = 'Shows a notification when perfoming edgebug'}
            F:Slider{Name = 'Edgebug Debounce', Flag = 'Misc/Edgebug/Debounce', Min = 0, Default = 0.2, Max = 0.8, Suffix = 's', Decimals = 0.05, Tooltip = 'Edgebug debounce time delay in seconds'}
        end
        do
            local F = B:Section{Name = 'Exploits', Side = 1}
            F:Label{Text = 'EXTREMELY DETECTED', Alignment = 'Left', Tooltip = 'Defusal got Kill All detection handled on the server\nI highly recommend to use priority kill if you need to kill someone'}
            F:Toggle{Name = 'Kill All', Flag = 'Misc/KillAll', Default = false, Risky = true, Tooltip = 'Instantly eliminates all enemies'}
            F:Slider{Name = 'Hit Per Second', Flag = 'Misc/KillAll/HPS', Min = 1, Default = 1, Max = 10, Suffix = 'hps', Decimals = 0.5, Tooltip = 'Hit rate multiplier'}
            F:Toggle{Name = 'Anti Spectate', Flag = 'Misc/AntiSpectate', Default = false, Risky = true, Tooltip = 'Makes other players unable to spectate you in the first-person'}
            F:Dropdown{Name = 'Type', Flag = 'Misc/AntiSpectate/Type', Items = {'Low Fov', 'Freeze'}, Multi = false, Default = 'Low Fov', Tooltip = 'Low Fov - makes spectators think like you are playing with 0 fov\nFreeze - breaks your first-person camera completely'}
            F:Button{
                Name = 'Flashbang Enemies',
                Tooltip = 'Flashbangs every enemy without a need to throw the flashbang grenade\nOnly gives them white effect in eyes and a ring effect in ears',
                Callback = function()
                    if not r.Game.IsAlive(o) then return s:Notification('You are dead!', 5, Color3.fromRGB(149, 255, 139)) end
                    if b:GetAttribute'Preparation' then return s:Notification('Let the round start!', 5, Color3.fromRGB(149, 255, 139)) end
                    if r.Game.EquippedWeapon ~= 'Flashbang' then return s:Notification('Hold the flashbang grenade in your hands!', 6, Color3.fromRGB(149, 255, 139)) end
                    s:Notification('Flashbanging enemies...', 5, Color3.fromRGB(149, 255, 139))
                    for G, H in next, j:GetPlayers() do
                        if H == o or not r.Game.IsAlive(H) or H.Character:FindFirstChildWhichIsA'ForceField' then continue end
                        if r.Game.EquippedWeapon ~= 'Flashbang' then return end
                        local I = t['Misc/Flashbang/Intensity'] > 1 and t['Misc/Flashbang/Intensity'] or 1
                        for J = 1, I do
                            r.Game.FireEvent:FireServer({
                                Normal = Vector3.zero,
                                Position = H.Character.Torso.Position + Vector3.one,
                                Hit = H.Character,
                                cCF = q.CFrame,
                                hS = H.Character.Torso.Size and H.Character.Torso.Size.Magnitude,
                                hP = H.Character.Torso.Position,
                                PartName = 'Torso',
                                BlindLevel = 1
                            }, r.Game.EquippedWeaponFolder, nil, true, q.CFrame, H.Character.Torso.Position, nil, nil)
                        end
                    end
                end
            }
            F:Slider{Name = 'Flashbang Intensity', Flag = 'Misc/Flashbang/Intensity', Min = 1, Default = 1, Max = 10, Suffix = '', Decimals = 0.5, Tooltip = 'Flashbang Enemies intensity'}
            if sethiddenproperty then
                F:Button{
                    Name = 'Basketball',
                    Tooltip = 'Continously teleports the ball in your camera direction\nWhich looks like you are playing basketball',
                    Callback = function()
                        if not r.Game.IsAlive(o) then return s:Notification('You are dead!', 5, Color3.fromRGB(149, 255, 139)) end
                        local G = workspace.Map:FindFirstChild'Regen'
                        if not G then return s:Notification('No workspace.Map.Regen folder, are you sure you are playing on the Dust II map?', 7, Color3.fromRGB(149, 255, 139)) end
                        local H = G:FindFirstChild'Ball'
                        if not H then return s:Notification('The ball was not found, are you sure you are playing on the Dust II map?', 7, Color3.fromRGB(149, 255, 139)) end
                        while h.Heartbeat:Wait() do
                            if not r.Game.IsAlive(o) or not H or (b:GetAttribute'RoundOver' or b:GetAttribute'GameOver') then return end
                            sethiddenproperty(o.Character.HumanoidRootPart, 'PhysicsRepRootPart', H)
                            H.CFrame = CFrame.new(o.Character.HumanoidRootPart.Position + (o.Character.Head.CFrame.LookVector * 7))
                        end
                    end
                }
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "sethiddenproperty",\nno Basketball for you'}
            end
            F:Button{
                Name = 'Lag Server',
                Risky = true,
                Tooltip = 'Lags the server using smoke grenades\nMake sure you have enough money to buy a lot of smoke grenades!',
                Callback = function()
                    if not r.Game.IsAlive(o) then return s:Notification('You are dead!', 5, Color3.fromRGB(149, 255, 139)) end
                    if not r.Game.BuyZone.Visible then return s:Notification('You are not in the buy zone!', 6, Color3.fromRGB(149, 255, 139)) end
                    if o:GetAttribute'Money' < 300 then return s:Notification("You don't have money to buy atleast 1 smoke grenade!", 6, Color3.fromRGB(149, 255, 139)) end
                    s:Notification('Buying and throwing smoke grenades...', 6, Color3.fromRGB(149, 255, 139))
                    for G = 1, 10 do
                        if not r.Game.IsAlive(o) or o:GetAttribute'Money' < 300 then return end
                        b.Events.BuyWeapon:FireServer'Smoke Grenade'
                        local H = {[1] = '4_1', [2] = o.Character:GetPivot(), [3] = -100}
                        b.Events.Throwable:FireServer(unpack(H))
                        task.wait(0.2)
                    end
                end
            }
            F:Button{
                Name = 'Crash Server',
                Risky = true,
                Tooltip = 'After a some time everyone on the server gets kicked\nor teleported to other server (serverhopped)',
                Callback = function()
                    s:Notification('Crashing the server...', 6, Color3.fromRGB(149, 255, 139))
                    b.Events.UpdateSetting:FireServer('Graphics', 'Ragdolls', string.rep('discord.gg/sHkw5prEjW', 99000))
                    b.Events.UpdateSetting:FireServer('Graphics', 'Voices', string.rep('discord.gg/sHkw5prEjW', 99000))
                    b.Events.UpdateSetting:FireServer('Graphics', 'Tracers', string.rep('discord.gg/sHkw5prEjW', 99000))
                    b.Events.UpdateSetting:FireServer('Graphics', 'Shadows', string.rep('discord.gg/sHkw5prEjW', 99000))
                    b.Events.UpdateSetting:FireServer('Graphics', 'Muzzle Flash', string.rep('discord.gg/sHkw5prEjW', 99000))
                    h.PreRender:Connect(function()
                        for G = 1, 99999 do
                            f:SetOutgoingKBPSLimit(math.huge * math.huge)
                            b.Events.GetSettings:InvokeServer()
                        end
                    end)
                end
            }
        end
        do
            local F = B:Section{Name = 'Client', Side = 1}
            F:Toggle{Name = 'Auto Join Team', Flag = 'Misc/JoinTeam', Default = false, Tooltip = 'Automatically deploys into selected team'}
            F:Dropdown{Name = 'Team', Flag = 'Misc/JoinTeam/Team', Items = {'Operators', 'Militia'}, Multi = false, Default = 'Operators', Tooltip = 'Select a team'}
        end
        do
            local F = B:Section{Name = 'Chat', Side = 2}
            if r.Client.HasRequire and r.Game.Network and r.Game.Network.FireServer then
                F:Toggle{Name = 'Chat Spammer', Flag = 'Misc/ChatSpam', Default = false, Tooltip = 'Spams a certain chat message'}
                F:Dropdown{Name = 'Message Type', Flag = 'Misc/ChatSpam/Type', Items = {'Neyrone', 'Advertise', 'Japanese', 'Custom'}, Multi = false, Default = 'Neyrone', Tooltip = 'What type of message will be sent'}
                F:Textbox{Name = 'Custom Message', Flag = 'Misc/ChatSpam/Custom', Default = 'Neyrone on top!!', 'Input'}
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "require",\nno Chat Spammer for you'}
            end
        end
        do
            local F = B:Section{Name = 'C4', Side = 2}
            F:Dropdown{Name = 'Site', Flag = 'Misc/PlantC4/Site', Items = {'A', 'B'}, Multi = false, Default = 'A', Tooltip = 'On which site the bomb will be planted'}
            F:Button{
                Name = 'Plant',
                Tooltip = 'Plants the bomb on the site of your choice',
                Callback = function()
                    if not r.Game.IsAlive(o) then return s:Notification('You are dead!', 5, Color3.fromRGB(149, 255, 139)) end
                    if o:GetAttribute'Team' ~= 'T' then return s:Notification('You are not in the Militia team!', 5, Color3.fromRGB(149, 255, 139)) end
                    if b:GetAttribute'HasBomb' ~= o.Name then return s:Notification("You don't have the bomb!", 5, Color3.fromRGB(149, 255, 139)) end
                    if b:GetAttribute'Preparation' then return s:Notification('Let the round start!', 5, Color3.fromRGB(149, 255, 139)) end
                    local G, H, I = o.Character.HumanoidRootPart.CFrame, (workspace.Map), false
                    task.wait(0.1)
                    Site = t['Misc/PlantC4/Site'] == 'A' and 'BombA' or 'BombB'
                    o.Character.HumanoidRootPart.CFrame = H.Markers[Site].CFrame - Vector3.new(0, -1, 0)
                    task.wait(0.3)
                    b.Events.PlantC4:FireServer()
                    o.Character.HumanoidRootPart.CFrame = G
                    I = true
                    s:Notification(`Bomb has been planted on the {t['Misc/PlantC4/Site']} site`, 5, Color3.fromRGB(149, 255, 139))
                end
            }
            if r.Client.HasRequire and r.Game.Ambassador and r.Game.Ambassador.Fire then
                F:Button{
                    Name = 'Defuse',
                    Tooltip = 'Plants the bomb on the site of your choice',
                    Callback = function()
                        if not r.Game.IsAlive(o) then return s:Notification('You are dead!', 5, Color3.fromRGB(149, 255, 139)) end
                        if o:GetAttribute'Team' ~= 'CT' then return s:Notification('You are not in the Operators team!', 5, Color3.fromRGB(149, 255, 139)) end
                        if not r.Game.IsC4Planted() then return s:Notification("Bomb hasn't been planted!", 5, Color3.fromRGB(149, 255, 139)) end
                        b.Events.StartDefuse:FireServer()
                        r.Game.Ambassador.Fire'UpdateDefuse'
                        b.Events.StartDefuse:FireServer()
                        r.Game.Ambassador.Fire'StopDefuse'
                        s:Notification('Defusing the bomb, wait 8 seconds', 6, Color3.fromRGB(149, 255, 139))
                    end
                }
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "require",\nno Defuse C4 for you'}
            end
        end
        do
            local F = B:Section{Name = 'Gun Mods', Side = 2}
            F:Toggle{Name = 'No Recoil', Flag = 'Misc/GunMods/NoRecoil', Default = false, Tooltip = 'Your camera no longer moves after you shoot'}
            F:Toggle{Name = 'No Spread', Flag = 'Misc/GunMods/NoSpread', Default = false, Tooltip = 'Every shot lands exactly where aimed'}
            F:Toggle{Name = 'Full Auto', Flag = 'Misc/GunMods/FullAuto', Default = false, Tooltip = 'Makes every gun fully automatic and able to continously shoot when mouse 1 is held'}
            F:Toggle{Name = 'Rapid Fire', Flag = 'Misc/GunMods/RapidFire', Default = false, Tooltip = 'Changes the speed that your weapon fires at to maximum'}
            F:Toggle{Name = 'Stored Ammo -> Ammo', Flag = 'Misc/GunMods/ConvertAmmo', Default = false, Tooltip = 'Converts stored ammo into primary ammo\nRequires reload'}
            F:Toggle{Name = 'Infinite Ammo', Flag = 'Misc/GunMods/InfAmmo', Default = false, Tooltip = 'Freezes your current ammo count'}
        end
        do
            local F = B:Section{Name = 'Throwables', Side = 2}
            F:Dropdown{Name = 'Activation Type', Flag = 'Misc/Throwables/Activate/Type', Items = {'Touch', 'Shoot'}, Multi = false, Default = 'Touch', Tooltip = 'Touch - works only on enemys laser mines\nShoot - works on yours and enemys laser mines'}
            F:Toggle{Name = 'Auto Activate Laser Mines', Flag = 'Misc/Throwables/Activate', Default = false, Tooltip = 'Automatically activates laser mines as soon they spawns'}
            F:Toggle{Name = 'Allow Yours Laser Mines', Flag = 'Misc/Throwables/AllowSelf', Default = false, Tooltip = 'Allows cheat to shoot at yours laser mines with "Shoot" activation type'}
            F:Toggle{Name = 'Remove Laser from the Laser Mines', Flag = 'Misc/Throwables/RemoveLaser', Default = false, Tooltip = "Removes laser from the laser mine so you can't activate it if you walk through it\nYou can still activate the laser mine if you shoot at it"}
            if r.Client.HasHookmetamethod then
                F:Toggle{Name = 'Teleport', Flag = 'Misc/Throwables/Teleport', Default = false, Tooltip = 'Teleports throwable to the closest enemy to your crosshair\n(Enemy should be on screen)'}
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "hookmetamethod",\nno Teleport Throwables for you'}
            end
        end
    end
    do
        do
            local F = C:Section{Name = 'Skin Changer', Side = 1}
            if r.Client.HasRequire and r.Game.Appearance and r.Game.Appearance.MapGunSkin then
                GetWeaponSkins = function()
                    local G = {}
                    for H, I in next, b.Skins:GetChildren() do
                        if I:IsA'Folder' and not table.find(r.Game.SkinsData.Knives.List, I.Name) and not table.find(r.Game.SkinsData.Gloves.List, I.Name) then
                            local J = {}
                            for K, L in next, I:GetChildren() do
                                if L:IsA'Folder' then
                                    table.insert(J, L.Name)
                                end
                            end
                            if #J > 0 then
                                G[I.Name] = J
                            end
                        end
                    end
                    return G
                end
                ApplyWeaponSkin = function(G, H)
                    local I = q:FindFirstChild'Arms'
                    if not r.Game.IsAlive(o) or not I or not G or not H then return end
                    local J = `{G}_{H}`
                    r.Game.SkinsData.Weapons.Replacements[G] = J
                    o.Character:SetAttribute('WhatSkin', J)
                    r.Game.Appearance.MapGunSkin(I, J, false, 0, false, o, r.Game.EquippedWeaponFolder, nil)
                end
                ApplyCurrentWeaponSkin = function()
                    if not r.Game.IsAlive(o) or not r.Game.EquippedWeapon or r.Game.EquippedWeapon == 'C4' or not r.Game.EquippedWeaponFolder or r.Game.EquippedWeaponFolder:GetAttribute'WeaponType' == 'Throwable' then return end
                    if r.Game.SkinsData.Weapons.Settings[r.Game.EquippedWeapon] and r.Game.SkinsData.Weapons.Settings[r.Game.EquippedWeapon].Enabled then
                        ApplyWeaponSkin(r.Game.EquippedWeapon, r.Game.SkinsData.Weapons.Settings[r.Game.EquippedWeapon].Skin)
                    end
                end
                local G = GetWeaponSkins()
                for H, I in next, G do
                    r.Game.SkinsData.Weapons.Settings[H] = {Enabled = false, Skin = I[1]}
                    local J = ''
                    if b.Weapons:FindFirstChild(H) and b.Weapons:FindFirstChild(H):GetAttribute'DisplayName' ~= nil then
                        J = b.Weapons:FindFirstChild(H):GetAttribute'DisplayName'
                    end
                    F:Toggle{
                        Name = J ~= '' and J or H,
                        Flag = `Skins/{H}`,
                        Default = false,
                        Tooltip = `Applies skin of your choice to {H}`,
                        Callback = function(K)
                            r.Game.SkinsData.Weapons.Settings[H].Enabled = K
                            if K then
                                ApplyWeaponSkin(H, r.Game.SkinsData.Weapons.Settings[H].Skin)
                            end
                        end
                    }
                    F:Dropdown{
                        Name = 'Skin',
                        Flag = `Skins/{H}/Skin`,
                        Items = I,
                        Multi = false,
                        Default = I[1],
                        Tooltip = `Select skin for {H}`,
                        Callback = function(K)
                            r.Game.SkinsData.Weapons.Settings[H].Skin = K
                            if r.Game.SkinsData.Weapons.Settings[H].Enabled then
                                ApplyWeaponSkin(H, K)
                            end
                        end
                    }
                end
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "require",\nno Skin Changer for you'}
            end
        end
        do
            local F = C:Section{Name = 'Knife Changer', Side = 2}
            r.Game.SkinsData.Knives.CurrentKnifeType = r.Game.SkinsData.Knives.List[1]
            ApplyKnifeSkin = function()
                if not r.Game.IsAlive(o) or not t['Skins/Knife'] then return end
                if not r.Game.EquippedWeapon or not table.find(r.Game.SkinsData.Knives.List, r.Game.EquippedWeapon) then return end
                o:SetAttribute('KnifeType', r.Game.SkinsData.Knives.CurrentKnifeType)
                local G = 'Stock'
                if r.Game.SkinsData.Knives.Settings[r.Game.SkinsData.Knives.CurrentKnifeType] and r.Game.SkinsData.Knives.Settings[r.Game.SkinsData.Knives.CurrentKnifeType].Enabled then
                    G = r.Game.SkinsData.Knives.Settings[r.Game.SkinsData.Knives.CurrentKnifeType].Skin
                end
                if not G then return end
                local H = `{r.Game.SkinsData.Knives.CurrentKnifeType}_{G}`
                o:SetAttribute('KnifeSkin', H)
                local I = q:FindFirstChild'Arms'
                if not I then return end
                if r.Client.HasRequire and r.Game.Appearance and r.Game.Appearance.MapGunSkin then
                    r.Game.SkinsData.Knives.Replacements[r.Game.SkinsData.Knives.CurrentKnifeType] = H
                    r.Game.Appearance.MapGunSkin(I, H, false, 0, false, o, r.Game.EquippedWeaponFolder, nil)
                end
            end
            F:Toggle{
                Name = 'Enabled',
                Flag = 'Skins/Knife',
                Default = false,
                'Changes your current knife to the selected knife\nReequip your knife to apply',
                Callback = function(G)
                    if G then
                        ApplyKnifeSkin()
                    else
                        if not r.Game.IsAlive(o) then return end
                        if r.Game.EquippedWeapon and table.find(r.Game.SkinsData.Knives.List, r.Game.EquippedWeapon) then
                            o:SetAttribute('KnifeType', r.Game.EquippedWeapon)
                            o:SetAttribute('KnifeSkin', `{r.Game.EquippedWeapon}_Stock`)
                            local H = q:FindFirstChild'Arms'
                            if not H then return end
                            if r.Client.HasRequire and r.Game.Appearance and r.Game.Appearance.MapGunSkin then
                                r.Game.Appearance.MapGunSkin(H, `{r.Game.EquippedWeapon}_Stock`, false, 0, false, o, r.Game.EquippedWeaponFolder, nil)
                            end
                        end
                    end
                end
            }
            F:Dropdown{
                Name = 'Knife',
                Flag = 'Skins/Knife/Type',
                Items = r.Game.SkinsData.Knives.List,
                Multi = false,
                Default = r.Game.SkinsData.Knives.List[1],
                Tooltip = 'Select knife',
                Callback = function(G)
                    r.Game.SkinsData.Knives.CurrentKnifeType = G
                    if t['Skins/Knife'] then ApplyKnifeSkin() end
                end
            }
            if r.Client.HasRequire and r.Game.Appearance and r.Game.Appearance.MapGunSkin then
                GetKnivesSkins = function()
                    local G = {}
                    for H, I in next, b.Skins:GetChildren() do
                        if I:IsA'Folder' and table.find(r.Game.SkinsData.Knives.List, I.Name) then
                            local J = {}
                            for K, L in next, I:GetChildren() do
                                if L:IsA'Folder' then
                                    table.insert(J, L.Name)
                                end
                            end
                            if #J > 0 then
                                G[I.Name] = J
                            end
                        end
                    end
                    return G
                end
                local G = GetKnivesSkins()
                for H, I in next, G do
                    r.Game.SkinsData.Knives.Settings[H] = {Enabled = false, Skin = I[1]}
                    F:Toggle{
                        Name = H,
                        Flag = `Skins/Knife/{H}`,
                        Default = false,
                        Tooltip = `Applies skin of your choice to {H}`,
                        Callback = function(J)
                            r.Game.SkinsData.Knives.Settings[H].Enabled = J
                            if J and t['Skins/Knife'] and r.Game.SkinsData.Knives.CurrentKnifeType == H then
                                ApplyKnifeSkin()
                            end
                        end
                    }
                    F:Dropdown{
                        Name = 'Skin',
                        Flag = `Skins/Knife/{H}/Skin`,
                        Items = I,
                        Multi = false,
                        Default = I[1],
                        Tooltip = `Select skin for {H}`,
                        Callback = function(J)
                            r.Game.SkinsData.Knives.Settings[H].Skin = J
                            if r.Game.SkinsData.Knives.Settings[H].Enabled and t['Skins/Knife'] and r.Game.SkinsData.Knives.CurrentKnifeType == H then
                                ApplyKnifeSkin()
                            end
                        end
                    }
                end
            else
                F:Label{Text = 'Unsupported', Alignment = 'Left', Tooltip = 'Your exploit doesn\'t support "require",\nno Knife Skin Changer for you'}
            end
        end
        do
            local F = C:Section{Name = 'Gloves Changer', Side = 2}
            r.Game.SkinsData.Gloves.CurrentGlove = r.Game.SkinsData.Gloves.List[1]
            ApplyGloves = function()
                if not r.Game.IsAlive(o) or not t['Skins/Glove'] then return end
                o:SetAttribute('CTGloves', `{r.Game.SkinsData.Gloves.CurrentGlove}_Stock`)
                o:SetAttribute('TGloves', `{r.Game.SkinsData.Gloves.CurrentGlove}_Stock`)
                o.Character:SetAttribute('CTGloves', `{r.Game.SkinsData.Gloves.CurrentGlove}_Stock`)
                o.Character:SetAttribute('TGloves', `{r.Game.SkinsData.Gloves.CurrentGlove}_Stock`)
                local G = 'Stock'
                if r.Game.SkinsData.Gloves.Settings[r.Game.SkinsData.Gloves.CurrentGlove] and r.Game.SkinsData.Gloves.Settings[r.Game.SkinsData.Gloves.CurrentGlove].Enabled then
                    G = r.Game.SkinsData.Gloves.Settings[r.Game.SkinsData.Gloves.CurrentGlove].Skin
                end
                o:SetAttribute('CTGloves', `{r.Game.SkinsData.Gloves.CurrentGlove}_{G}`)
                o:SetAttribute('TGloves', `{r.Game.SkinsData.Gloves.CurrentGlove}_{G}`)
                o.Character:SetAttribute('CTGloves', `{r.Game.SkinsData.Gloves.CurrentGlove}_{G}`)
                o.Character:SetAttribute('TGloves', `{r.Game.SkinsData.Gloves.CurrentGlove}_{G}`)
            end
            F:Toggle{
                Name = 'Enabled',
                Flag = 'Skins/Glove',
                Default = false,
                'Changes your current gloves to the selected gloves\nReequip your weapon to apply',
                Callback = function(G)
                    if G then
                        ApplyGloves()
                    else
                        o:SetAttribute('CTGloves', 'Glove_Stock')
                        o:SetAttribute('TGloves', 'Glove_Stock')
                        o.Character:SetAttribute('CTGloves', 'Glove_Stock')
                        o.Character:SetAttribute('TGloves', 'Glove_Stock')
                    end
                end
            }
            F:Dropdown{
                Name = 'Gloves',
                Flag = 'Skins/Glove/Type',
                Items = r.Game.SkinsData.Gloves.List,
                Multi = false,
                Default = r.Game.SkinsData.Gloves.List[1],
                Tooltip = 'Select gloves',
                Callback = function(G)
                    r.Game.SkinsData.Gloves.CurrentGlove = G
                    if t['Skins/Glove/Type'] then ApplyGloves() end
                end
            }
            GetGlovesSkins = function()
                local G = {}
                for H, I in next, b.Skins:GetChildren() do
                    if I:IsA'Folder' and table.find(r.Game.SkinsData.Gloves.List, I.Name) then
                        local J = {}
                        for K, L in next, I:GetChildren() do
                            if L:IsA'Folder' then
                                table.insert(J, L.Name)
                            end
                        end
                        if #J > 0 then
                            G[I.Name] = J
                        end
                    end
                end
                return G
            end
            local G = GetGlovesSkins()
            for H, I in next, G do
                r.Game.SkinsData.Gloves.Settings[H] = {Enabled = false, Skin = I[1]}
                F:Toggle{
                    Name = H,
                    Flag = `Skins/Glove/{H}`,
                    Default = false,
                    Tooltip = `Applies skin of your choice to {H}`,
                    Callback = function(J)
                        r.Game.SkinsData.Gloves.Settings[H].Enabled = J
                        if J and t['Skins/Glove'] and r.Game.SkinsData.Gloves.CurrentGlove == H then
                            ApplyGloves()
                        end
                    end
                }
                F:Dropdown{
                    Name = 'Skin',
                    Flag = `Skins/Glove/{H}/Skin`,
                    Items = I,
                    Multi = false,
                    Default = I[1],
                    Tooltip = `Select skin for {H}`,
                    Callback = function(J)
                        r.Game.SkinsData.Gloves.Settings[H].Skin = J
                        if r.Game.SkinsData.Gloves.Settings[H].Enabled and t['Skins/Glove'] and r.Game.SkinsData.Gloves.CurrentGloves == H then
                            ApplyGloves()
                        end
                    end
                }
            end
        end
    end
    do
        do
            D:PlayerList{Name = 'Player List', Flag = 'PlayerList'}
        end
        do
            local F = D:Section{Name = 'Priority', Side = 1}
            F:Toggle{Name = 'Kill', Flag = 'Players/Priority/Kill', Default = false, Tooltip = 'Eliminates players with "Priority" status'}
            F:Slider{Name = 'Hit Per Second', Flag = 'Players/Priority/Kill/HPS', Min = 1, Default = 1, Max = 10, Suffix = 'hps', Decimals = 0.5, Tooltip = 'Hit rate multiplier'}
            F:Button{
                Name = 'Flashbang',
                Tooltip = 'Flashbangs priority player without a need to throw the flashbang grenade\nOnly gives them white effect in eyes and a ring effect in ears',
                Callback = function()
                    if not r.Game.IsAlive(o) then return s:Notification('You are dead!', 5, Color3.fromRGB(149, 255, 139)) end
                    if #s.Lists.Priority < 1 then return s:Notification('There are no players with "Priority" status', 6, Color3.fromRGB(149, 255, 139)) end
                    if b:GetAttribute'Preparation' then return s:Notification('Let the round start!', 5, Color3.fromRGB(149, 255, 139)) end
                    if r.Game.EquippedWeapon ~= 'Flashbang' then return s:Notification('Hold the flashbang grenade in your hands!', 6, Color3.fromRGB(149, 255, 139)) end
                    s:Notification('Flashbanging enemies...', 5, Color3.fromRGB(149, 255, 139))
                    for G, H in next, s.Lists.Priority do
                        if H == o or not r.Game.IsAlive(H) or H.Character:FindFirstChildWhichIsA'ForceField' then continue end
                        if r.Game.EquippedWeapon ~= 'Flashbang' then return end
                        local I = t['Players/Priority/Flashbang/Intensity'] > 1 and t['Players/Priority/Flashbang/Intensity'] or 1
                        for J = 1, I do
                            r.Game.FireEvent:FireServer({
                                Normal = Vector3.zero,
                                Position = H.Character.Torso.Position + Vector3.one,
                                Hit = H.Character,
                                cCF = q.CFrame,
                                hS = H.Character.Torso.Size and H.Character.Torso.Size.Magnitude,
                                hP = H.Character.Torso.Position,
                                PartName = 'Torso',
                                BlindLevel = 1
                            }, r.Game.EquippedWeaponFolder, nil, true, q.CFrame, H.Character.Torso.Position, nil, nil)
                        end
                    end
                end
            }
            F:Slider{Name = 'Flashbang Intensity', Flag = 'Players/Priority/Flashbang/Intensity', Min = 1, Default = 1, Max = 10, Suffix = '', Decimals = 0.5, Tooltip = 'Flashbang Enemies intensity'}
        end
    end
    do
        local F = E:Section{Name = 'Settings', Side = 1}
        for G, H in next, s.Theme do
            s.ThemeColorpickers[G] = F:Label{Text = G, Alignment = 'Left'}:Colorpicker{
                Name = G,
                Flag = 'Theme' .. G,
                Default = H,
                Callback = function(I)
                    s.Theme[G] = I
                    s:ChangeTheme(G, I)
                end
            }
        end
        F:Dropdown{
            Name = 'Themes list',
            Items = {'Default', 'Bitchbot', 'Onetap', 'Aqua'},
            Default = 'Default',
            Callback = function(G)
                local H = s.Themes[G]
                if not H then return end
                for I, J in next, s.Theme do
                    s.Theme[I] = H[I]
                    s:ChangeTheme(I, H[I])
                    s.ThemeColorpickers[I]:Set(H[I])
                end
                task.wait(0.3)
                s:Thread(function()
                    for I, J in next, s.Theme do
                        s.Theme[I] = s.Flags['Theme' .. I].Color
                        s:ChangeTheme(I, s.Flags['Theme' .. I].Color)
                    end
                end)
            end
        }
        local G, H
        local I = F:Listbox{
            Name = 'Themes List',
            Flag = 'Themes List',
            Items = {},
            Multi = false,
            Default = nil,
            Callback = function(I) H = I end
        }
        F:Textbox{
            Name = 'Name',
            Flag = 'Theme Name',
            Default = '',
            Placeholder = '. . .',
            Callback = function(J) G = J end
        }
        F:Button{
            Name = 'Save Theme',
            Callback = function()
                if G == '' then return end
                if not isfile(s.Folders.Themes .. '/' .. G .. '.json') then
                    writefile(s.Folders.Themes .. '/' .. G .. '.json', s:GetTheme())
                    s:RefreshThemeList(I)
                else
                    s:Notification("Theme '" .. G .. ".json' already exists", 3, Color3.fromRGB(255, 0, 0))
                    return
                end
            end
        }:SubButton{
            Name = 'Load Theme',
            Callback = function()
                if H then
                    s:LoadTheme(readfile(s.Folders.Themes .. '/' .. H))
                end
            end
        }
        F:Button{
            Name = 'Refresh Themes',
            Callback = function() s:RefreshThemeList(I) end
        }
        s:RefreshThemeList(I)
    end
    do
        local F, G, H = (E:Section{Name = 'Configs', Side = 2})
        local I = F:Listbox{
            Name = 'Configs list',
            Flag = 'configs_list',
            Items = {},
            Multi = false,
            Default = nil,
            Callback = function(I) H = I end
        }
        F:Textbox{
            Name = 'Name',
            Flag = 'Config Name',
            Default = '',
            Placeholder = '. . .',
            Callback = function(J) G = J end
        }
        F:Button{
            Name = 'Load Config',
            Callback = function()
                if H then
                    s:LoadConfig(readfile(s.Folders.Configs .. '/' .. H))
                end
                s:Thread(function()
                    task.wait(0.1)
                    for J, K in next, s.Theme do
                        s.Theme[J] = s.Flags['Theme' .. J].Color
                        s:ChangeTheme(J, s.Flags['Theme' .. J].Color)
                    end
                end)
            end
        }:SubButton{
            Name = 'Save Config',
            Callback = function()
                if H then s:SaveConfig(H) end
            end
        }
        F:Button{
            Name = 'Create Config',
            Callback = function()
                if G == '' then return end
                if not isfile(s.Folders.Configs .. '/' .. G .. '.json') then
                    writefile(s.Folders.Configs .. '/' .. G .. '.json', s:GetConfig())
                    s:RefreshConfigsList(I)
                else
                    s:Notification("Config '" .. G .. ".json' already exists", 3, Color3.fromRGB(255, 0, 0))
                    return
                end
            end
        }:SubButton{
            Name = 'Delete Config',
            Callback = function()
                if H then
                    s:DeleteConfig(H)
                    s:RefreshConfigsList(I)
                end
            end
        }
        F:Button{
            Name = 'Refresh Configs',
            Callback = function() s:RefreshConfigsList(I) end
        }
        s:RefreshConfigsList(I)
        F:Label{Text = 'Menu Keybind', Alignment = 'Left'}:Keybind{
            Name = 'Menu',
            Flag = 'menu_keybind',
            Default = Enum.KeyCode.RightShift,
            Mode = 'Toggle',
            Callback = function(J) s.MenuKeybind = t.menu_keybind.Key end
        }
        F:Toggle{
            Name = 'Watermark',
            Flag = 'watermark',
            Default = false,
            Callback = function(J) w:SetVisibility(J) end
        }
        F:Toggle{
            Name = 'Keybind List',
            Flag = 'keybind_list',
            Default = false,
            Callback = function(J) x:SetVisibility(J) end
        }
        F:Dropdown{
            Name = 'Style',
            Flag = 'tweening_style',
            Default = 'Exponential',
            Items = {'Linear', 'Sine', 'Quad', 'Cubic', 'Quart', 'Quint', 'Exponential', 'Circular', 'Back', 'Elastic', 'Bounce'},
            Callback = function(J) s.Tween.Style = Enum.EasingStyle[J] end
        }
        F:Dropdown{
            Name = 'Direction',
            Flag = 'tweening_direction',
            Default = 'Out',
            Items = {'In', 'Out', 'InOut'},
            Callback = function(J) s.Tween.Direction = Enum.EasingDirection[J] end
        }
        F:Slider{
            Name = 'Tweening Time',
            Min = 0,
            Max = 5,
            Default = 0.12,
            Decimals = 0.01,
            Flag = 'tweening_time',
            Callback = function(J) s.Tween.Time = J end
        }
        F:Button{
            Name = 'Rejoin',
            Callback = function()
                game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, game.JobId, o)
            end
        }
        F:Button{
            Name = 'Unload Library',
            Callback = function() s:Unload() end
        }
    end
end

local F, G, H, I, J, K = false, (Drawing.new'Circle')
G.ZIndex = 2
G.Visible = false
G.Thickness = 1
G.Color = Color3.new(255, 255, 255)
G.NumSides = 100
G.Filled = false
local L = {}

do
    L.Hitboxes = {Head = 'Head', Torso = 'HumanoidRootPart'}
    function L.GetTarget(M, N)
        local O, P = M and N or math.huge
        for Q, R in next, j:GetPlayers() do
            if R == o or not r.Game.IsAlive(R) or (not b:GetAttribute'NoTKPenalty' and R:GetAttribute'Team' == o:GetAttribute'Team') or R.Character:FindFirstChildWhichIsA'ForceField' then continue end
            local S, T, U = d:GetMouseLocation(), q:WorldToViewportPoint(R.Character[L.Hitboxes[t['Legit/Hitscan']]].Position)
            local V = (Vector2.new(T.X, T.Y) - S).Magnitude
            if (V <= O) and U then
                O = V
                P = R
            end
        end
        return P
    end
end

local M = Drawing.new'Circle'
M.ZIndex = 2
M.Visible = false
M.Thickness = 1
M.Color = Color3.new(255, 255, 255)
M.NumSides = 100
M.Filled = false
local N = {LastShotTick = 0, LastReloadTick = 0}

do
    N.HitboxMultipliers = {Head = 1.75, Torso = 1.25, ['Left Arm'] = 1, ['Right Arm'] = 1, ['Left Leg'] = 0.75, ['Right Leg'] = 0.75}
    N.DefaultValues = {Range = 8192, Penetration = 300, ArmorPenetration = 80, Damage = 50, Bullets = 1}
    N.GetHitboxes = function(O, P)
        local Q = {}
        if not r.Game.IsAlive(O) then return Q end
        if type(P) == 'string' then P = {P} end
        for R, S in next, P do
            if S == 'Head' then
                if O.Character:FindFirstChild'Head' then table.insert(Q, O.Character.Head) end
            end
            if S == 'Torso' then
                if O.Character:FindFirstChild'Torso' then table.insert(Q, O.Character.Torso) end
            end
            if S == 'Arms' then
                if O.Character:FindFirstChild'Left Arm' then table.insert(Q, O.Character['Left Arm']) end
                if O.Character:FindFirstChild'Right Arm' then table.insert(Q, O.Character['Right Arm']) end
            end
            if S == 'Legs' then
                if O.Character:FindFirstChild'Left Leg' then table.insert(Q, O.Character['Left Leg']) end
                if O.Character:FindFirstChild'Right Leg' then table.insert(Q, O.Character['Right Leg']) end
            end
        end
        return Q
    end
    N.IncrementAmmo = function(O)
        if not r.Client.HasGetsenv or not r.Client.FullGetsenv or not r.Game.BaseWeapon then return end
        local P = debug.getupvalue(r.Game.BaseWeapon.firebullet, 3)
        if not P then return end
        local Q = r.Game.Variables.equipped
        local R = P[Q]
        if not (R and R.Ammo) then return end
        local S = t['Misc/GunMods/InfAmmo'] and 0 or t['Rage/DoubleTap'] and 2 or 1
        if not O then
            R.Ammo -= S
            if R.Ammo <= 0 then
                R.Ammo = 0
                N.LastReloadTick = tick()
                r.Game.Ambassador.Fire'ReloadWeapon'
            end
        end
        r.Game.Ambassador.Fire('UpdateAmmo', R)
    end
    N.FakeShoot = function(O, P)
        if not r.Client.HasRequire or not r.Game.Shucky or not r.Game.Shucky.shootsound or not r.Game.Ambassador or not r.Game.Ambassador.Fire or (not P and not t['Rage/SimulateShoot']) or (P and not t['Rage/Knifebot/SimulateStab']) or O:GetAttribute'WeaponType' == 'Throwable' or not O:FindFirstChild'Model' then return end
        r.Game.Shucky.shootsound(O.Model, q)
        b.URE_ViewmodelAnimStream:FireServer(true, 'fire', 'fire', nil, nil, nil)
        local Q = math.random(1, 2)
        local R = Q == 1 and '' or tostring(Q)
        r.Game.Ambassador.Fire('VPlay', ('2fire'), 'fire')
        r.Game.Ambassador.Fire('WPlay', R, 'Fire')
        task.spawn(N.IncrementAmmo, P)
    end
    N.FireEvent = function(O, P, Q, R, S, T, U)
        local V = t['Rage/DoubleTap'] and 2 or 1
        for W = 1, V do
            for X = 1, S do
                r.Game.FireEvent:FireServer({
                    Normal = Vector3.zero,
                    Position = P.Position + Vector3.one,
                    Hit = P.Parent,
                    cCF = q.CFrame,
                    hS = P.Size and P.Size.Magnitude,
                    hP = P.Position,
                    PartName = (t['Rage/ForceHead'] or P.Name:find'Head') and 'Head' or P.Name,
                    Wallbang = R,
                    Noscope = T or false,
                    Backstab = U or false,
                    Ratio = Q
                }, O, nil, true, q.CFrame, P.Position, nil, nil)
            end
        end
    end
    N.ArmorDamageLoss = function(O, P)
        if not P then return 1 end
        return 0.01 * O
    end
    N.DistanceDamageLoss = function(O, P)
        return math.clamp((P / 100) ^ (O / 34.7), 0.45, 1)
    end
    N.ShootTarget = function(O, P, Q, R, S, T, U, V)
        local W, X, Y, Z, _, aa, ab, ac, ad, ae, af = t['Rage/Noscope'],
            t['Rage/Backstab'],
            R:GetAttribute'Armor' > 0,
            R:GetAttribute'Helmet',
            O:GetAttribute'ArmorPenetration' or N.DefaultValues.ArmorPenetration,
            O:GetAttribute'RangeModifier',
            O:GetAttribute'DMG' or N.DefaultValues.Damage,
            O:GetAttribute'Bullets' or N.DefaultValues.Bullets,
            O:GetAttribute'HighHS' and 15 or 0,
            N.HitboxMultipliers[S.Name],
            (Q - R.Character.HumanoidRootPart.Position).Magnitude
        local ag, ah = aa and N.DistanceDamageLoss(af, aa) or 1, N.ArmorDamageLoss(_, Y)
        local ai = ac * ab * U * ae * ah * ag + (S.Name:find'Head' and ad or 0)
        if T or ai >= t['Rage/MinDamage'] then
            if not t['Rage/SilentAim'] then
                q.CFrame = CFrame.new(q.CFrame.Position, S.Position)
            end
            if t['Rage/Debug'] then
                s:Notification(`Shot at {R.Name}'s {S} with {O} | Approximate Damage: {ai} | Ratio: {U} | Distance Damage Loss: {ag}`, 5, Color3.fromRGB(149, 255, 139))
            end
            if O:GetAttribute'Scoped' then
                if r.Game.Variables and r.Game.Variables.scoped ~= nil then
                    if r.Game.Variables.scoped then
                        W = t['Rage/Noscope'] or false
                    else
                        W = t['Rage/Noscope'] or true
                    end
                else
                    W = t['Rage/Noscope'] or false
                end
            end
            task.spawn(N.FakeShoot, O, P)
            task.spawn(N.FireEvent, O, S, U, V, ac, W, X)
            return true
        end
        return false
    end
    N.AutoWall = function(aa, ab, ac, ad)
        local ae, af, ag = {}, (ac.Position - ab).Unit, aa:GetAttribute'Range' or 8000
        local ah = ag / 8 or 1000
        local ai, O = af * ah, aa:GetAttribute'Penetration' or 0
        local P, Q = O > 0 and O * 0.02 or 0, RaycastParams.new()
        Q.FilterType = Enum.RaycastFilterType.Exclude
        Q.FilterDescendantsInstances = ad
        Q.IgnoreWater = true
        local R, S, T, U, V, W, X, Y, Z, _, aj = Q.FilterDescendantsInstances, workspace:Raycast(ab, ai, Q), 0, 0, 4, 0, false, 0, false, 4, 0
        repeat
            aj = aj + 1
            if aj >= _ then break end
            local ak, al
            if S then
                ak = S.Instance
                al = S.Position
            else
                al = ab + ai
                ak = nil
            end
            local am = {Hit = ak, Position = al, Normal = S and S.Normal or Vector3.new(0, 1, 0)}
            if Z then am.Wallbang = true end
            if am.Hit then table.insert(ae, am) end
            if P == 0 then break end
            if ak then
                local an, ao, ap, aq = 0, ak.Parent:FindFirstChild'Humanoid', (ak.Parent:GetAttribute'Streak')
                Z = true
                if ao or ap then
                    aq = ak.Parent
                    Y = Y + 1
                else
                    local ar, as, at = al + af * 10, -af * 20, RaycastParams.new()
                    at.FilterType = Enum.RaycastFilterType.Include
                    at.FilterDescendantsInstances = {ak}
                    local au = workspace:Raycast(ar, as, at)
                    local av, aw, ax, ay, az = au and au.Instance or nil, au and au.Position or nil, au and au.Normal or nil, ak:GetAttribute'PeneValue' or 1, ak.Material
                    local aA = ay
                    if az == Enum.Material.DiamondPlate then
                        aA = 3
                    elseif az == Enum.Material.CorrodedMetal or az == Enum.Material.Metal then
                        aA = 2
                    elseif az == Enum.Material.Concrete or az == Enum.Material.Brick then
                        aA = 2
                    elseif ak.Name == 'Grate' or az == Enum.Material.Wood or az == Enum.Material.WoodPlanks then
                        aA = 0.5
                    elseif az == Enum.Material.Fabric or az == Enum.Material.Sand or az == Enum.Material.Grass or az == Enum.Material.LeafyGrass or az == Enum.Material.Ground then
                        aA = 0.1
                    elseif ak.Transparency == 1 or not ak.CanCollide or ak.Name == 'Glass' or ak.Name == 'Cardboard' then
                        aA = 0
                    end
                    if ak.Name == 'nowallbang' then T = P end
                    local aB = av and (aw - al).Magnitude or 1
                    an = aB * aA
                    aq = ak
                    if aw and ax then
                        am.Endposition = aw
                        am.Endnormal = ax
                    end
                end
                table.insert(R, aq)
                Q = RaycastParams.new()
                Q.FilterType = Enum.RaycastFilterType.Exclude
                Q.FilterDescendantsInstances = R
                Q.IgnoreWater = true
                if T > 0 and ao then am.Ratio = 1 - T / P end
                T = T + an
                S = workspace:Raycast(ab, ai, Q)
            end
            if not ak or (P < Y or P <= T) then break end
        until nil
        return ae
    end
    N.Init = function(aa, ab, ac)
        if not workspace:FindFirstChild'Map' then return end
        if b:GetAttribute'RoundOver' or b:GetAttribute'Preparation' or b:GetAttribute'GameOver' then return end
        local ad = aa:GetAttribute'FireRate' or 0.1
        local ae, af = aa:GetAttribute'ScopedFireRate' or ad, ad
        if o.Character:GetAttribute'Aiming' then af = ae end
        af = t['Rage/RapidFire'] and 0.01 or af
        local ag, ah = aa:GetAttribute'ReloadTime' or 0, tick()
        if ah - N.LastShotTick < af or ah - N.LastReloadTick < ag then return end
        local ai, aj, ak, al = aa:GetAttribute'Bullets' or 1,
            (t['Rage/AntiAim/FakeDuck'] and t['Rage/AntiAim/FakeDuck/Bind'].Toggled) and o.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0) or o.Character.Head.Position,
            false,
            {}
        for am, an in next, ab do
            if not an or not r.Game.IsAlive(an) then continue end
            local ao = RaycastParams.new()
            ao.FilterType = Enum.RaycastFilterType.Exclude
            table.clear(al)
            if r.Client.HasRequire and r.Game.Variables and r.Game.Variables.Params then
                for ap, aq in next, r.Game.Variables.Params.FilterDescendantsInstances do
                    table.insert(al, aq)
                end
            else
                al = {workspace.Destroyable, workspace.Debris, workspace.Map.Clips}
            end
            ao.FilterDescendantsInstances = al
            ao.IgnoreWater = true
            ao:AddToFilter(o.Character)
            ao:AddToFilter(q)
            if ac then
                if not t['Rage/Knifebot'] then return end
                local ap = (an.Character.HumanoidRootPart.Position - aj).Unit * t['Rage/Knifebot/Radius']
                if not t['Rage/Knifebot/WallCheck'] then
                    ao:AddToFilter(workspace.Map)
                else
                    if table.find(ao.FilterDescendantsInstances, workspace.Map) then
                        for aq, ar in ao.FilterDescendantsInstances do
                            if ar ~= workspace.Map then continue end
                            table.remove(ao.FilterDescendantsInstances, aq)
                        end
                    end
                end
                local aq = workspace:Raycast(aj, ap, ao)
                if aq and aq.Instance and aq.Instance:IsDescendantOf(an.Character) then
                    task.spawn(N.FakeShoot, aa, ac)
                    task.spawn(N.FireEvent, aa, an.Character.HumanoidRootPart, 1, false, ai, t['Rage/Noscope'], t['Rage/Backstab'])
                    ak = true
                    break
                end
            else
                local ap = N.GetHitboxes(an, t['Rage/Hitscan'] or {'Head'})
                if #ap == 0 then continue end
                for aq, ar in next, an.Character:GetChildren() do
                    if not table.find(ap, ar) then
                        ao:AddToFilter(ar)
                    end
                end
                for aq, ar in next, ap do
                    if t['Rage/Fov'] then
                        local as, at = d:GetMouseLocation(), q.ViewportSize
                        local au, av, aw = (at.X * ((t['Rage/Fov/Value'] / 2) / q.FieldOfView)) / 2, q:WorldToViewportPoint(ar.Position)
                        local ax = (Vector2.new(av.X, av.Y) - as).Magnitude
                        if ax > au or not aw then continue end
                    end
                    local as = ar.Position - aj
                    local at = workspace:Raycast(aj, as, ao)
                    if at and at.Instance == ar then
                        if N.ShootTarget(aa, ac, aj, an, ar, true, 1, false) then
                            ak = true
                            break
                        end
                    end
                    if t['Rage/AutoWall'] then
                        local au, av, aw, ax = N.AutoWall(aa, aj, ar, al), false, 1, false
                        for ay, az in au do
                            if az.Hit and az.Hit.Parent == an.Character then
                                av = true
                                aw = t['Rage/ForceDamage'] and 1 or (az.Ratio or 1)
                                ax = az.Wallbang or false
                                break
                            end
                        end
                        if av then
                            if N.ShootTarget(aa, ac, aj, an, ar, false, aw, ax) then
                                ak = true
                                break
                            end
                        end
                    end
                end
            end
            if ak then
                N.LastShotTick = ah
                break
            end
        end
    end
    N.Start = function(aa)
        if not t['Rage/Ragebot'] or not r.Game.IsAlive(o) then return end
        if not r.Game.EquippedWeapon or r.Game.EquippedWeapon == 'C4' then return end
        if not r.Game.EquippedWeaponFolder or (r.Game.EquippedWeaponFolder:GetAttribute'WeaponType' == 'Throwable' and not t['Rage/Throwables']) then return end
        local ab = {}
        for ac, ad in next, j:GetPlayers() do
            if ad == o or not r.Game.IsAlive(ad) or (not b:GetAttribute'NoTKPenalty' and ad:GetAttribute'Team' == o:GetAttribute'Team') or ad.Character:FindFirstChildWhichIsA'ForceField' or table.find(ab, ad) then continue end
            table.insert(ab, ad)
        end
        if #ab > 0 then
            N.Init(r.Game.EquippedWeaponFolder, ab, r.Game.EquippedWeaponFolder:GetAttribute'WeaponType' == 'Melee')
        end
    end
    h.Stepped:Connect(function(aa)
        task.spawn(N.Start, aa)
    end)
end

local aa = {Storage = {}}

do
    function aa.Init(ab)
        if not t['Visuals/ThrowableEsp'] then return end
        if not ab:GetAttribute'Weapon' then return end
        if not ab:FindFirstChildOfClass'MeshPart' then return end
        if ab:GetAttribute'Team' == o:GetAttribute'Team' then return end
        aa.Storage[ab] = {}
        aa.Storage[ab].ThrowableName = Drawing.new'Text'
        aa.Storage[ab].ThrowableName.Font = 2
        aa.Storage[ab].ThrowableName.Position = Vector2.new(0, 0)
        aa.Storage[ab].ThrowableName.Visible = false
        aa.Storage[ab].ThrowableName.Text = ab:GetAttribute'Weapon'
        aa.Storage[ab].ThrowableName.Size = 13
        aa.Storage[ab].ThrowableName.Color = Color3.new(1, 1, 1)
        aa.Storage[ab].ThrowableName.Center = true
        aa.Storage[ab].ThrowableName.Outline = true
        local ac = aa.Storage[ab].ThrowableName
        aa.Storage[ab].Loop = h.PreRender:Connect(function()
            if not ab or not ab.Parent then
                aa.Remove(ab)
                return
            end
            local ad = ab:GetAttribute'Weapon' == 'Jump Pad' and ab:FindFirstChildOfClass'MeshPart':FindFirstChildOfClass'MeshPart' or ab:FindFirstChildOfClass'MeshPart'
            if not ad then return end
            if t['Visuals/ThrowableEsp/Chams'] then
                if not ad:FindFirstChild'yaico999' then
                    local ae = Instance.new('Highlight', ad)
                    ae.Name = 'yaico999'
                    ae.FillColor = t['Visuals/ThrowableEsp/Chams/Fill'].Color
                    ae.FillTransparency = t['Visuals/ThrowableEsp/Chams/Fill'].Alpha
                    ae.OutlineColor = t['Visuals/ThrowableEsp/Chams/Outline'].Color
                    ae.OutlineTransparency = t['Visuals/ThrowableEsp/Chams/Outline'].Alpha
                else
                    local ae = ad.yaico999
                    ae.FillColor = t['Visuals/ThrowableEsp/Chams/Fill'].Color
                    ae.FillTransparency = t['Visuals/ThrowableEsp/Chams/Fill'].Alpha
                    ae.OutlineColor = t['Visuals/ThrowableEsp/Chams/Outline'].Color
                    ae.OutlineTransparency = t['Visuals/ThrowableEsp/Chams/Outline'].Alpha
                end
            else
                if ad:FindFirstChild'yaico999' then ad.yaico999:Destroy() end
            end
            if t['Visuals/ThrowableEsp/Name'] then
                local ae = (ab.Position - q.CFrame.Position).Magnitude
                if ae <= 400 then
                    local af, ag = q:WorldToViewportPoint(ab.Position)
                    local ah = 1
                    if ae >= 370 then
                        ah = math.max(ah - ((ae - 370) / 30), 0)
                    end
                    if ag then
                        ac.Font = t['Visuals/Esp/TextFont'] == 'Plex' and 1 or val == 'System' and 2 or val == 'Monospace' and 3 or 4
                        ac.Position = Vector2.new(af.X, af.Y - 20)
                        ac.Transparency = ah
                        ac.Visible = true
                        ac.Text = ab:GetAttribute'Weapon'
                        ac.Size = t['Visuals/Esp/TextSize'] or 13
                        ac.Color = t['Visuals/ThrowableEsp/Name/Color'] and t['Visuals/ThrowableEsp/Name/Color'].Color or Color3.new(1, 1, 1)
                    else
                        ac.Visible = false
                    end
                else
                    ac.Visible = false
                end
            else
                ac.Visible = false
            end
        end)
    end
    function aa.Remove(ab)
        if aa.Storage[ab] then
            if aa.Storage[ab].Loop then aa.Storage[ab].Loop:Disconnect() end
            if aa.Storage[ab].ThrowableName then aa.Storage[ab].ThrowableName:Remove() end
            if ab and ab.Parent then
                if not ab:FindFirstChildOfClass'MeshPart' then return end
                local ac = ab:GetAttribute'Weapon' == 'Jump Pad' and ab:FindFirstChildOfClass'MeshPart':FindFirstChildOfClass'MeshPart' or ab:FindFirstChildOfClass'MeshPart'
                if not ac then return end
                if ac and ac:FindFirstChild'yaico999' then ac.yaico999:Destroy() end
            end
            aa.Storage[ab] = nil
        end
    end
    for ab, ac in next, workspace.Debris:GetChildren() do aa.Init(ac) end
    for ab, ac in next, workspace.Destroyable:GetChildren() do aa.Init(ac) end
    workspace.Debris.ChildAdded:Connect(function(ab)
        task.wait(0.1)
        aa.Init(ab)
    end)
    workspace.Destroyable.ChildAdded:Connect(function(ab)
        task.wait(0.1)
        aa.Init(ab)
    end)
    workspace.Debris.ChildRemoved:Connect(aa.Remove)
    workspace.Destroyable.ChildRemoved:Connect(aa.Remove)
end

do
    SkyboxInit = function(ab)
        if i:FindFirstChild'Skyboxzz' == nil then
            local ac = Instance.new('Sky', i)
            ac.Name = 'Skyboxzz'
        end
        local ac = i:FindFirstChild'Skyboxzz'
        ac.SkyboxBk = r.Skyboxes[ab].SkyboxBk
        ac.SkyboxDn = r.Skyboxes[ab].SkyboxDn
        ac.SkyboxFt = r.Skyboxes[ab].SkyboxFt
        ac.SkyboxLf = r.Skyboxes[ab].SkyboxLf
        ac.SkyboxRt = r.Skyboxes[ab].SkyboxRt
        ac.SkyboxUp = r.Skyboxes[ab].SkyboxUp
    end
    SkyboxUpdate = function(ab)
        local ac = t['Visuals/Skybox/Type']
        if ab and ac ~= '--' then
            SkyboxInit(ac)
            if Skybox.Connection == nil then
                Skybox.Connection = i.ChildAdded:Connect(function(ad)
                    if ad:IsA'Sky' and ad.Name ~= 'Skyboxzz' then
                        task.wait(2)
                        SkyboxInit(ac)
                    end
                end)
            end
        else
            if Skybox.Connection ~= nil then
                Skybox.Connection:Disconnect()
                Skybox.Connection = nil
            end
            if i:FindFirstChild'Skyboxzz' then i.Skyboxzz:Destroy() end
        end
    end
end

local ab, ac, ad = q.ViewportSize.X / 2, 160, Drawing.new'Text'
ad.Font = 2
ad.Position = Vector2.new(ab - 35, ac)
ad.Visible = false
ad.Text = 'Bomb Status'
ad.Size = 13
ad.Color = Color3.new(1, 1, 1)
ad.Outline = true
local ae = Drawing.new'Text'
ae.Font = 2
ae.Position = Vector2.new(ab - 70, ac + 25)
ae.Visible = false
ae.Size = 13
ae.Color = Color3.new(1, 1, 1)
ae.Outline = true
local af = Drawing.new'Square'
af.Color = Color3.new(0, 0, 0)
af.Position = Vector2.new(ab - 250, ac + 15)
af.Visible = false
af.Size = Vector2.new(502, 5)
af.Filled = true
local ag = Drawing.new'Square'
ag.Color = t['Visuals/BombStatus/Color'].Color
ag.Position = Vector2.new(ab - 249, ac + 16)
ag.Visible = false
ag.Size = Vector2.new(502, 5)
ag.Filled = true
local ah = {BombTimer = 40, BombInfo = 'Site: - | Timer: 40/40'}

do
    workspace.Debris.ChildAdded:Connect(function(ai)
        if not t['Visuals/BombStatus'] then return end
        if ai.Name == 'PlantedC4' then
            local aj = Instance.new'Part'
            aj.Parent = ai
            aj.Size = Vector3.new(0, 0, 0)
            aj.Anchored = false
            ai.PrimaryPart = aj
            task.spawn(function()
                local ak = b:GetAttribute'PlantedAt' ~= nil and ((b:GetAttribute'PlantedAt' == 'BombB' and 'B') or 'A')
                if t['Visuals/BombChams'] then
                    local al = Instance.new('Highlight', ai)
                    al.FillColor = t['Visuals/BombChams/FillColor'].Color
                    al.FillTransparency = t['Visuals/BombChams/FillColor'].Alpha / 100
                    al.OutlineColor = t['Visuals/BombChams/OutlineColor'].Color
                    al.OutlineTransparency = t['Visuals/BombChams/OutlineColor'].Alpha / 100
                    al.Adornee = ai
                    al.DepthMode = 'AlwaysOnTop'
                end
                af.Visible = true
                ag.Visible = true
                ad.Visible = true
                ae.Visible = true
                ag.Color = t['Visuals/BombStatus/Color'].Color
                af.Size = Vector2.new(502, 5)
                ag.Size = Vector2.new(ah.BombTimer * 12.5, 3)
                repeat
                    task.wait(1)
                    ah.BombTimer = ah.BombTimer - 1
                    ah.BombInfo = `Site: {ak} | Timer: {tostring(ah.BombTimer)}/40`
                    af.Size = Vector2.new(502, 5)
                    ag.Size = Vector2.new(ah.BombTimer * 12.5, 3)
                until ah.BombTimer == 0 or b:GetAttribute'RoundOver' or b:GetAttribute'Preparation'
                ah.BombInfo = 'Site: - | Timer: 40/40'
                ae.Visible = false
                af.Visible = false
                ag.Visible = false
                ad.Visible = false
                ah.BombTimer = 40
            end)
        end
    end)
end

local ai = {}

do
    ai.CreateTemporaryPart = function(aj)
        local ak = Instance.new'Part'
        ak.Name = 'Bullet Tracer'
        ak.Size = Vector3.new(0.2, 0.2, 0.2)
        ak.Position = aj
        ak.Transparency = 1
        ak.CanCollide = false
        ak.Anchored = true
        ak.Parent = workspace.Debris
        return ak
    end
    ai.CreateTracer = function(aj, ak, al, am, an)
        if not o.Character:FindFirstChild'Gun' or not o.Character.Gun:FindFirstChild'Flash' then return end
        if not q:FindFirstChild'Arms' or not q.Arms:FindFirstChild'Flash' then return end
        local ao = (t['Visuals/ThirdPerson'] and t['Visuals/ThirdPerson/Bind'].Toggled) and o.Character.Gun.Flash.WorldPosition or q.Arms.Flash.CFrame.Position
        local ap, aq, ar = ai.CreateTemporaryPart(ao), ai.CreateTemporaryPart(aj), Instance.new'Beam'
        ar.Texture = r.BulletTracersTextures[an]
        local as = Instance.new'Attachment'
        as.Parent = ap
        local at = Instance.new'Attachment'
        at.Parent = aq
        ar.Attachment0 = as
        ar.Attachment1 = at
        ar.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, al), ColorSequenceKeypoint.new(1, ak)}
        ar.Width0 = 0.2
        ar.Width1 = 0.2
        ar.FaceCamera = true
        ar.Transparency = NumberSequence.new(0)
        ar.Parent = workspace.Debris
        task.spawn(function()
            task.wait(am)
            for au = 1, 10 do
                ar.Transparency = NumberSequence.new(au / 10)
                task.wait(0.05)
            end
            ar:Destroy()
            as:Destroy()
            at:Destroy()
        end)
        return ar
    end
end

local aj = {}

do
    aj.CreateImpact = function(ak, al, am)
        if not r.Game.EquippedWeapon or not r.Game.EquippedWeaponFolder then return end
        if r.Game.EquippedWeaponFolder:GetAttribute'WeaponType' == 'Melee' then return end
        local an = Instance.new'Part'
        an.Transparency = 1
        an.Anchored = true
        an.CanCollide = false
        an.Size = Vector3.new(0.3, 0.3, 0.3)
        an.Position = ak
        local ao = Instance.new('SelectionBox', an)
        ao.LineThickness = 0
        ao.SurfaceTransparency = 0.5
        ao.Color3 = al
        ao.SurfaceColor3 = al
        ao.Adornee = an
        an.Parent = workspace.Debris
        task.spawn(function()
            task.wait(am)
            ao:Destroy()
            an:Destroy()
        end)
        return ao
    end
end

do
    ViewmodelInit = function()
        if r.Client.HasHookmetamethod then return end
        local ak = q:FindFirstChild'Arms'
        if not ak then return end
        if not t['Visuals/Viewmodel'] then
            if r.Game.IsAlive(o) and ak:GetAttribute'COfsset' ~= nil then
                ak:SetAttribute('COfsset', nil)
            end
            return
        end
        if (t['Visuals/ThirdPerson'] and t['Visuals/ThirdPerson/Bind'].Toggled) or not r.Game.IsAlive(o) then return end
        ak:SetAttribute('COffset', CFrame.new(t['Visuals/Viewmodel/X'] / 300, t['Visuals/Viewmodel/Y'] / 300, t['Visuals/Viewmodel/Z'] / 300))
    end
end

do
    WeaponVisualsInit = function()
        if not r.Game.IsAlive(o) then return end
        if not r.Game.EquippedWeapon or not r.Game.EquippedWeaponFolder then return end
        local ak = q:FindFirstChild'Arms'
        if not ak then return end
        local al = ak:GetAttribute'Scale'
        if t['Visuals/Arms/NoJumpBob'] then
            ak:SetAttribute('Scale', 0)
        else
            ak:SetAttribute('Scale', al)
        end
        if not (t['Visuals/Weapon/Chams'] or t['Visuals/Weapon/TextureChanger']) then return end
        local am, an = function(am)
            if am:IsA'MeshPart' then
                am.Color = t['Visuals/Weapon/Chams/Color'].Color
                am.Material = Enum.Material.ForceField
                am.Transparency = t['Visuals/Weapon/Chams/Color'].Alpha / 100
            elseif am:IsA'UnionOperation' then
                am.UsePartColor = true
                am.Color = t['Visuals/Weapon/Chams/Color'].Color
                am.Material = Enum.Material.ForceField
                am.Transparency = t['Visuals/Weapon/Chams/Color'].Alpha / 100
            end
        end, function(am)
            if am:IsA'MeshPart' then
                am.TextureID = r.WeaponTextures[t['Visuals/Weapon/TextureChanger/Texture']]
            end
        end
        for ao, ap in next, r.Game.EquippedWeaponFolder:GetChildren() do
            if not ap.Name == 'Viewmodel' then continue end
            for aq, ar in next, ak:GetChildren() do
                if not ap:FindFirstChild(ar.Name) then continue end
                for as, at in next, ar:GetDescendants() do
                    if at:IsA'MeshPart' and at.Transparency == 1 then continue end
                    if ar:IsA'MeshPart' and ar.Name == 'Stock' then continue end
                    if t['Visuals/Weapon/Chams'] then
                        task.spawn(am, ar)
                        task.spawn(am, at)
                    elseif t['Visuals/Weapon/TextureChanger'] then
                        task.spawn(an, ar)
                        task.spawn(an, at)
                    end
                    if (at:IsA'Weld' or at:IsA'Motor6D') and at.Name:find'Bullet' then
                        at.Enabled = false
                    elseif at:IsA'SurfaceAppearance' then
                        at.Parent = nil
                    end
                end
            end
        end
    end
end

do
    SoundsInit = function()
        if t['Visuals/HitSound'] then
            if r.Sounds[t['Visuals/HitSound/Sound']] then
                b.Sounds.HitSound.Value = r.Sounds[t['Visuals/HitSound/Sound']]
                b.Sounds.HitSound.Volume.Value = t['Visuals/HitSound/Volume']
            end
        else
            b.Sounds.HitSound.Value = r.Sounds['Default Hit Sound']
            b.Sounds.HitSound.Volume.Value = 1.5
        end
        if t['Visuals/KillSound'] then
            if r.Sounds[t['Visuals/KillSound/Sound']] then
                b.Sounds.KillSound.Value = r.Sounds[t['Visuals/KillSound/Sound']]
                b.Sounds.KillSound.Volume.Value = t['Visuals/KillSound/Volume']
            end
        else
            b.Sounds.KillSound.Value = r.Sounds['Default Kill Sound']
            b.Sounds.KillSound.Volume.Value = 1.5
        end
    end
end

do
    local ak
    ThirdPersonInit = function()
        if not r.Game.IsAlive(o) then
            if ak then
                ak:Disconnect()
                ak = nil
            end
            o.CameraMode = 'Classic'
            o.CameraMaxZoomDistance = 18
            o.CameraMinZoomDistance = 3
            return
        else
            local al = q:FindFirstChild'Arms'
            if not al then return end
            if not (t['Visuals/ThirdPerson'] and t['Visuals/ThirdPerson/Bind'].Toggled) then
                o.CameraMode = 'LockFirstPerson'
                o.CameraMaxZoomDistance = 0.5
                o.CameraMinZoomDistance = 0.5
                if t['Visuals/Viewmodel'] and not r.Client.HasHookmetamethod then
                    al:SetAttribute('COffset', CFrame.new(t['Visuals/Viewmodel/X'] / 300, t['Visuals/Viewmodel/Y'] / 300, t['Visuals/Viewmodel/Z'] / 300))
                else
                    al:SetAttribute('COffset', CFrame.new(0, 0, 0))
                end
                if ak then
                    ak:Disconnect()
                    ak = nil
                end
            else
                o.CameraMode = 'Classic'
                o.CameraMaxZoomDistance = t['Visuals/ThirdPerson/Distance']
                o.CameraMinZoomDistance = t['Visuals/ThirdPerson/Distance']
                al:SetAttribute('COffset', CFrame.new(99, 99, 99))
                if not ak then
                    ak = o.Character:GetAttributeChangedSignal'WhatGun':Connect(function()
                        al:SetAttribute('COffset', CFrame.new(99, 99, 99))
                    end)
                end
            end
        end
    end
end

do
    local ak = {CFrame.new(1, 0, 0), CFrame.new(-1, 0, 0)}
    IsTouchingWall = function()
        for al, am in next, ak do
            local an = (o.Character.HumanoidRootPart.CFrame * am).Position
            local ao = Ray.new(o.Character.HumanoidRootPart.CFrame.Position, (an - o.Character.HumanoidRootPart.CFrame.Position).unit * 2)
            local ap = workspace:FindPartOnRayWithIgnoreList(ao, {q, o.Character, workspace.Destroyable, workspace.Debris})
            if ap then return true end
        end
        return false
    end
end

do
    KillAllInit = function()
        if not t['Misc/KillAll'] or not r.Game.IsAlive(o) then return end
        if not r.Game.EquippedWeaponFolder then return end
        for ak, al in next, j:GetPlayers() do
            if al == o or not r.Game.IsAlive(al) or al.Character:FindFirstChildWhichIsA'ForceField' then continue end
            local am = t['Misc/KillAll/HPS'] > 1 and t['Misc/KillAll/HPS'] or 1
            for an = 1, am do
                r.Game.FireEvent:FireServer({
                    Normal = Vector3.zero,
                    Position = al.Character.Head.Position + Vector3.one,
                    Hit = al.Character,
                    cCF = q.CFrame,
                    hS = al.Character.Head.Size and al.Character.Head.Size.Magnitude,
                    hP = al.Character.Head.Position,
                    PartName = 'Head',
                    Wallbang = true
                }, r.Game.EquippedWeaponFolder, nil, true, q.CFrame, al.Character.Head.Position, nil, nil)
            end
        end
    end
    KillPriorityInit = function()
        if not t['Players/Priority/Kill'] or not r.Game.IsAlive(o) or #s.Lists.Priority < 1 then return end
        if not r.Game.EquippedWeaponFolder then return end
        for ak, al in next, s.Lists.Priority do
            if al == o or not r.Game.IsAlive(al) or al.Character:FindFirstChildWhichIsA'ForceField' then continue end
            local am = t['Players/Priority/Kill/HPS'] > 1 and t['Players/Priority/Kill/HPS'] or 1
            for an = 1, am do
                r.Game.FireEvent:FireServer({
                    Normal = Vector3.zero,
                    Position = al.Character.Head.Position + Vector3.one,
                    Hit = al.Character,
                    cCF = q.CFrame,
                    hS = al.Character.Head.Size and al.Character.Head.Size.Magnitude,
                    hP = al.Character.Head.Position,
                    PartName = 'Head',
                    Wallbang = true
                }, r.Game.EquippedWeaponFolder, nil, true, q.CFrame, al.Character.Head.Position, nil, nil)
            end
        end
    end
end

local ak = {}

do
    for al, am in next, b.Weapons:GetChildren() do
        if am:IsA'Folder' then
            ak[am.Name] = {
                RecoilX = am:GetAttribute'RecoilX',
                RecoilY = am:GetAttribute'RecoilY',
                Auto = am:GetAttribute'Auto',
                ScopedFireRate = am:GetAttribute'ScopedFireRate',
                FireRate = am:GetAttribute'FireRate',
                Penetration = am:GetAttribute'Penetration',
                Range = am:GetAttribute'Range',
                Ammo = am:GetAttribute'Ammo',
                StoredAmmo = am:GetAttribute'StoredAmmo',
                Spread = am:GetAttribute'Spread',
                CrouchSpread = am:GetAttribute'CrouchSpread',
                FireSpread = am:GetAttribute'FireSpread',
                LadderSpread = am:GetAttribute'LadderSpread',
                LandSpread = am:GetAttribute'LandSpread',
                MoveSpread = am:GetAttribute'MoveSpread',
                StandSpread = am:GetAttribute'StandSpread',
                JumpSpread = am:GetAttribute'JumpSpread',
                RunSpread = am:GetAttribute'RunSpread'
            }
        end
    end
    WeaponModsInit = function()
        for al, am in next, b.Weapons:GetChildren() do
            if am:IsA'Folder' then
                local an = ak[am.Name]
                if not an then return end
                if t['Misc/GunMods/NoRecoil'] then
                    am:SetAttribute('RecoilX', 0)
                    am:SetAttribute('RecoilY', 0)
                else
                    am:SetAttribute('RecoilX', an.RecoilX)
                    am:SetAttribute('RecoilY', an.RecoilY)
                end
                if t['Misc/GunMods/NoSpread'] then
                    am:SetAttribute('Spread', 0)
                    am:SetAttribute('CrouchSpread', 0)
                    am:SetAttribute('FireSpread', 0)
                    am:SetAttribute('LadderSpread', 0)
                    am:SetAttribute('LandSpread', 0)
                    am:SetAttribute('MoveSpread', 0)
                    am:SetAttribute('StandSpread', 0)
                    am:SetAttribute('JumpSpread', 0)
                    am:SetAttribute('RunSpread', 0)
                else
                    am:SetAttribute('Spread', an.Spread)
                    am:SetAttribute('CrouchSpread', an.CrouchSpread)
                    am:SetAttribute('FireSpread', an.FireSpread)
                    am:SetAttribute('LadderSpread', an.LadderSpread)
                    am:SetAttribute('LandSpread', an.LandSpread)
                    am:SetAttribute('MoveSpread', an.MoveSpread)
                    am:SetAttribute('StandSpread', an.StandSpread)
                    am:SetAttribute('JumpSpread', an.JumpSpread)
                    am:SetAttribute('RunSpread', an.RunSpread)
                end
                if t['Misc/GunMods/FullAuto'] then
                    am:SetAttribute('Auto', true)
                else
                    am:SetAttribute('Auto', an.Auto)
                end
                if t['Misc/GunMods/RapidFire'] then
                    am:SetAttribute('FireRate', 0.01)
                    am:SetAttribute('ScopedFireRate', 0.01)
                else
                    am:SetAttribute('FireRate', an.FireRate)
                    am:SetAttribute('ScopedFireRate', an.ScopedFireRate)
                end
                if t['Misc/GunMods/ConvertAmmo'] then
                    am:SetAttribute('Ammo', 9e9)
                    am:SetAttribute('StoredAmmo', 9e9)
                else
                    am:SetAttribute('Ammo', an.Ammo)
                    am:SetAttribute('StoredAmmo', an.StoredAmmo)
                end
                if t['Misc/GunMods/InfAmmo'] then
                    am:SetAttribute('UseAmmo', 0)
                else
                    if am:GetAttribute'UseAmmo' ~= nil then
                        am:SetAttribute('UseAmmo', nil)
                    end
                end
            end
        end
    end
end

do
    local al = 0
    ThrowablesInit = function()
        if not r.Game.IsAlive(o) then return end
        local am = game.QueryDescendants(workspace.Destroyable, '[$Weapon] >> TouchTransmitter')
        if #am < 0 then return end
        for an, ao in next, am do
            if not ao.Parent or not ao.Parent.Parent or not ao.Parent.Parent:GetAttribute'Weapon' == 'Laser Mine' then return end
            if ao.Parent.Parent:GetAttribute'Owner' ~= o.Name and (ao.Parent.Parent:GetAttribute'Team' == o:GetAttribute'Team') then return end
            if not t['Misc/Throwables/AllowSelf'] and ao.Parent.Parent:GetAttribute'Owner' == o.Name then return end
            if t['Misc/Throwables/RemoveLaser'] then
                local ap = Instance.new('BoolValue', ao.Parent)
                ap.Name = 'yaica005'
                ao:Destroy()
            end
            if not ao:FindFirstChild'yaica005' then
                if t['Misc/Throwables/Activate'] then
                    if t['Misc/Throwables/Activate/Type'] == 'Touch' then
                        firetouchinterest(o.Character.HumanoidRootPart, ao.Parent, 0)
                    else
                        local ap = r.Game.EquippedWeaponFolder
                        if not ap or ap:GetAttribute'WeaponType' == 'Throwable' then
                            ap = b.Weapons.Knife
                        end
                        local aq, ar = ap:GetAttribute'FireRate' or 0.5, tick()
                        if ar - al < aq then return end
                        r.Game.FireEvent:FireServer({
                            Normal = -Vector3.one,
                            Position = ao.Parent.Parent:GetPivot().Position,
                            Hit = ao.Parent.Parent,
                            hS = ao.Parent.Parent.Size and ao.Parent.Parent.Size.Magnitude,
                            Wallbang = true,
                            Endnormal = Vector3.one
                        }, r.Game.EquippedWeaponFolder, nil, true, nil, nil, nil, nil)
                        al = ar
                    end
                end
            end
        end
    end
end

do
    local al = 0
    h.PreRender:Connect(function()
        if r.Game.IsAlive(o) then
            do
                local am = q.ViewportSize
                local an = (am.X * ((t['Legit/Fov/Value'] / 2) / q.FieldOfView)) / 2
                if t['Legit/SilentAim'] then
                    H = L.GetTarget(t['Legit/Fov'], an)
                    if H ~= nil then
                        I = H.Character[L.Hitboxes[t['Legit/Hitscan']]]
                    end
                end
                if t['Legit/Aimbot'] and (t['Legit/Aimbot/Activate'] == 'Mouse 1' and d:IsMouseButtonPressed(0) or t['Legit/Aimbot/Activate'] == 'Mouse 2' and d:IsMouseButtonPressed(1)) then
                    H = L.GetTarget(t['Legit/Fov'], an)
                    if H ~= nil then
                        local ao, ap = H.Character[L.Hitboxes[t['Legit/Hitscan']]], t['Legit/Aimbot/Speed']
                        if t['Legit/Aimbot/Type'] == 'Mouse Movement' and r.Client.HasMousemoverel then
                            ap = ap / 9
                            local aq = q:WorldToViewportPoint(ao.Position)
                            local ar, as = (aq.X - (q.ViewportSize.X / 2)) * ap / 20.5, (aq.Y - (q.ViewportSize.Y / 2)) * ap / 20.5
                            mousemoverel(ar, as)
                        elseif t['Legit/Aimbot/Type'] == 'Lerp' then
                            local aq, ar = CFrame.new(q.CFrame.Position, ao.Position), (math.abs(math.deg(math.acos((q.CFrame.LookVector):Dot(CFrame.new(q.CFrame.p, ao.Position).LookVector))))) * 2
                            if t['Legit/Aimbot/SpeedType'] == 'Exponential' then
                                ap = ap / 500
                            else
                                ap = (ap / ar) / 100
                            end
                            q.CFrame = q.CFrame:Lerp(aq, ap)
                        else
                            q.CFrame = CFrame.new(q.CFrame.Position, ao.Position)
                        end
                    end
                end
                if t['Legit/Triggerbot'] and t['Legit/Triggerbot/Bind'].Toggled and not F then
                    local ao, ap = {}, RaycastParams.new()
                    ap.FilterType = Enum.RaycastFilterType.Exclude
                    table.clear(ao)
                    if r.Client.HasRequire and r.Game.Variables and r.Game.Variables.Params then
                        for aq, ar in next, r.Game.Variables.Params.FilterDescendantsInstances do
                            table.insert(ao, ar)
                        end
                    else
                        ao = {workspace.Destroyable, workspace.Debris, workspace.Map.Clips}
                    end
                    ap.FilterDescendantsInstances = ao
                    ap.IgnoreWater = true
                    ap:AddToFilter(o.Character)
                    ap:AddToFilter(q)
                    local aq = workspace:Raycast(q.CFrame.Position, q.CFrame.LookVector * 365, ap)
                    if aq and aq.Instance and aq.Instance:IsA'BasePart' then
                        local ar = j:GetPlayerFromCharacter(aq.Instance.Parent)
                        if ar and r.Game.IsAlive(ar) and (b:GetAttribute'NoTKPenalty' or ar:GetAttribute'Team' ~= o:GetAttribute'Team') and not ar.Character:FindFirstChildWhichIsA'ForceField' then
                            F = true
                            if t['Legit/Triggerbot/Delay'] ~= 0 then
                                task.wait(t['Legit/Triggerbot/Delay'] / 1000)
                            end
                            if r.Client.HasGetsenv and r.Client.FullGetsenv then
                                r.Game.BaseWeapon.firebullet()
                            elseif mouse1press and mouse1release then
                                mouse1press()
                                task.wait()
                                mouse1release()
                            end
                            F = false
                        end
                    end
                end
                if t['Misc/Throwables/Teleport'] then
                    J = L.GetTarget(false, math.huge)
                    if J ~= nil then
                        K = J.Character.Head
                    end
                end
            end
            do
                if t['Visuals/Ambient'] then
                    i.Ambient = t['Visuals/Ambient/AmbientColor'].Color
                    i.OutdoorAmbient = t['Visuals/Ambient/OutdoorAmbientColor'].Color
                end
                if t['Visuals/NoSmoke'] then
                    for am, an in next, c:GetTagged'Smoke' do
                        an:Destroy()
                    end
                end
                if t['Visuals/TimeChanger'] then
                    if i.ClockTime ~= t['Visuals/TimeChanger/Time'] then
                        i.ClockTime = t['Visuals/TimeChanger/Time']
                    end
                end
                if not r.Client.HasHookmetamethod then
                    task.spawn(ViewmodelInit)
                end
                task.spawn(WeaponVisualsInit)
                task.spawn(SoundsInit)
                task.spawn(ThirdPersonInit)
            end
            do
                if t['Misc/JoinTeam'] then
                    local am = t['Misc/JoinTeam/Team'] == ('CT')
                    b.RE_Deploy:FireServer(am)
                end
                if t['Misc/ChatSpam'] and r.Client.HasRequire and r.Game.Network and tick() - al > 3 then
                    local am = t['Misc/ChatSpam/Type'] == 'Neyrone' and string.rep('\n', 15) .. 'neyrone on top ' .. tostring(math.random(1, 5)) or t['Misc/ChatSpam/Type'] == 'Advertise' and string.rep('\n', 15) .. 'tg - neyrone_tech ' .. tostring(math.random(1, 5)) or t['Misc/ChatSpam/Type'] == 'Japanese' and string.rep('\u{7684}\u{662f}\u{4e0d}\n', 16) .. tostring(math.random(1, 5)) or t['Misc/ChatSpam/Type'] == 'Custom' and t['Misc/ChatSpam/Custom'] or t['Misc/ChatSpam/Type']
                    Network.FireServer('Chat', am, false)
                    al = tick()
                end
                task.spawn(WeaponModsInit)
                if t['Misc/Throwables/RemoveLaser'] or t['Misc/Throwables/Activate'] then
                    task.spawn(ThrowablesInit)
                end
            end
        end
    end)
end

local am, an, ao, ap, aq = function(am)
        local an, ao = am:ToOrientation()
        return CFrame.new(am.Position) * CFrame.Angles(0, ao, 0)
    end, 0, Enum.HumanoidStateType.None, false
h.Heartbeat:Connect(function()
    do
        if r.Game.IsAlive(o) then
            if t['Rage/AntiAim'] and not t['Rage/AntiAim/Disable'].Toggled then
                o.Character.Humanoid.AutoRotate = false
                local ar, as = -math.atan2(q.CFrame.LookVector.Z, q.CFrame.LookVector.X) + math.rad(-90), math.rad(t['Rage/AntiAim/CustomYaw'])
                an = math.clamp(an + t['Rage/AntiAim/SpinSpeed'], 0, 360)
                if an == 360 then an = 0 end
                if t['Rage/AntiAim/Yaw'] == 'Spin' then
                    ar = ar + math.rad(an)
                elseif t['Rage/AntiAim/Yaw'] == 'Random' then
                    ar = ar + math.rad(math.random(0, 360))
                end
                local at = CFrame.new(o.Character.HumanoidRootPart.Position) * CFrame.Angles(0, ar + as, 0)
                o.Character.HumanoidRootPart.CFrame = am(at)
                local au = t['Rage/AntiAim/Pitch'] == 'Custom' and (t['Rage/AntiAim/CustomPitch'] / 100) or t['Rage/AntiAim/Pitch'] == 'Random' and math.random(-1, 1)
                if r.Client.HasRequire and r.Game.Network and r.Game.Network.FireServer then
                    r.Game.Network.FireServer('0R5lsPxqfSH3', au, true)
                end
            else
                o.Character.Humanoid.AutoRotate = true
            end
            if (t['Rage/AntiAim/FakeDuck'] and t['Rage/AntiAim/FakeDuck/Bind'].Toggled) and r.Client.HasRequire and r.Game.Ambassador and r.Game.Ambassador.Fire then
                r.Game.Ambassador.Fire('WPlay', 'CrouchIdle', nil, 0)
            end
        end
    end
    if t['Visuals/BombStatus'] then
        ae.Text = ah.BombInfo
    end
    do
        local ar = q.ViewportSize
        G.Radius = (ar.X * ((t['Legit/Fov/Value'] / 2) / q.FieldOfView)) / 2
        G.Visible = t['Legit/Fov/Visible'] == true
        G.Color = t['Legit/Fov/Color'].Color
        G.NumSides = t['Legit/Fov/NumSides']
        G.Transparency = 1
        G.Position = Vector2.new(math.floor(q.ViewportSize.X / 2), math.floor(q.ViewportSize.Y / 2))
        M.Radius = (ar.X * ((t['Rage/Fov/Value'] / 2) / q.FieldOfView)) / 2
        M.Visible = t['Rage/Fov/Visible'] == true
        M.Color = t['Rage/Fov/Color'].Color
        M.NumSides = t['Rage/Fov/NumSides']
        M.Transparency = 1
        M.Position = Vector2.new(math.floor(q.ViewportSize.X / 2), math.floor(q.ViewportSize.Y / 2))
    end
    do
        if r.Game.IsAlive(o) then
            local ar = o.Character.Humanoid
            local as = ar:GetState()
            if t['Misc/BypassSpeed'] and r.Game.Variables then
                if r.Game.Variables.crouch or r.Game.Variables.fullycrouched then
                    r.Game.Variables.jumping = true
                else
                    r.Game.Variables.jumping = false
                end
            end
            if t['Misc/AutoJump'] and d:IsKeyDown'Space' and ar.FloorMaterial ~= Enum.Material.Air and as ~= Enum.HumanoidStateType.Jumping and not ap then
                ar.Jump = true
            end
            if t['Misc/Noclip'] then
                for at, au in next, o.Character:GetChildren() do
                    if au:IsA'BasePart' and au.CanCollide == true then
                        au.CanCollide = false
                    end
                end
            else
                o.Character.HumanoidRootPart.CanCollide = true
            end
            if t['Misc/SpeedHack'] then
                local at, au = Vector3.new(), t['Misc/SpeedHack/Speed'] / 10
                if d:IsKeyDown'W' then at = at + q.CFrame.LookVector end
                if d:IsKeyDown'S' then at = at - q.CFrame.LookVector end
                if d:IsKeyDown'A' then at = at - q.CFrame.RightVector end
                if d:IsKeyDown'D' then at = at + q.CFrame.RightVector end
                if at.Magnitude > 0 then
                    at = at.Unit * au * 1.5
                    at = Vector3.new(at.X, 0, at.Z)
                    o.Character.HumanoidRootPart.CFrame = o.Character.HumanoidRootPart.CFrame + (Vector3.new(at.X, 0, at.Z) / 100 * 2)
                end
            end
            if t['Misc/Airstuck'] and t['Misc/Airstuck/Bind'].Toggled then
                o.Character.HumanoidRootPart.Anchored = true
            else
                o.Character.HumanoidRootPart.Anchored = false
            end
            if t['Misc/Pixelsurf'] and t['Misc/Pixelsurf/Bind'].Toggled then
                if aq == nil then aq = Instance.new'BodyVelocity' end
                if IsTouchingWall() then
                    aq.MaxForce = Vector3.new(1500, 1500, 1500)
                    aq.Velocity = Vector3.new()
                    aq.Parent = o.Character.HumanoidRootPart
                else
                    aq.MaxForce = Vector3.new(0, 0, 0)
                    aq.Parent = nil
                end
            else
                if aq ~= nil then
                    aq.MaxForce = Vector3.new(0, 0, 0)
                    aq.Parent = nil
                end
            end
            if t['Misc/Edgebug'] and t['Misc/Edgebug/Bind'].Toggled and not ap then
                if ao == Enum.HumanoidStateType.Freefall and as == Enum.HumanoidStateType.Landed then
                    ap = true
                    local at = o.Character.HumanoidRootPart.Velocity
                    for au = 1, 5 do
                        task.wait()
                        o.Character.HumanoidRootPart.Velocity = (Vector3.new(1.2, 0, 1.2) * at) - Vector3.new(0, 15, 0)
                    end
                    task.wait()
                    o.Character.HumanoidRootPart.Velocity *= Vector3.new(1.8, 1, 1.8)
                    if t['Misc/Edgebug/Notification'] then
                        s:Notification('Edgebugged', 2, Color3.fromRGB(149, 255, 139), {'91814125975782', Color3.new(1, 1, 1)})
                    end
                    task.spawn(function()
                        task.wait(t['Misc/Edgebug/Debounce'])
                        ap = false
                    end)
                end
            end
            ao = as
        else
            if aq ~= nil then
                aq.MaxForce = Vector3.new(0, 0, 0)
                aq.Parent = nil
            end
        end
    end
    do
        task.spawn(KillAllInit)
        task.spawn(KillPriorityInit)
        if r.Game.IsAlive(o) and t['Misc/AntiSpectate'] then
            local ar = t['Misc/AntiSpectate/Type']
            local as = ar == 'Freeze' and Vector3.new(9e9, 9e9, 9e9) or q.CFrame.Position
            local at, au = (q.CFrame * CFrame.new(0, 0, -1)).Position - as, buffer.create(36)
            buffer.writef32(au, 0, as.X)
            buffer.writef32(au, 4, as.Y)
            buffer.writef32(au, 8, as.Z)
            buffer.writeu8(au, 12, (at.X + 1) * 0.5 * 255 // 1)
            buffer.writeu8(au, 13, (at.Y + 1) * 0.5 * 255 // 1)
            buffer.writeu8(au, 14, (at.Z + 1) * 0.5 * 255 // 1)
            buffer.writeu8(au, 15, (bit32.bor(0, 0, 0, 8)))
            buffer.writef32(au, 16, 0)
            buffer.writef32(au, 20, ar == 'Low Fov' and 0 or 70)
            buffer.writef32(au, 24, 0)
            buffer.writef32(au, 28, 0)
            buffer.writef32(au, 32, 0)
            b.UpdateSpectate:FireServer(au)
        end
    end
    do
        if r.Client.HasRequire and r.Game.Appearance and r.Game.Appearance.MapGunSkin then
            task.spawn(ApplyCurrentWeaponSkin)
        end
        task.spawn(ApplyKnifeSkin)
        task.spawn(ApplyGloves)
    end
end)

do
    if r.Client.HasHookfunction and r.Game.Appearance and r.Game.Appearance.MapGunSkin then
        local al = r.Game.Appearance.MapGunSkin
        r.Game.Appearance.MapGunSkin = newcclosure(function(am, an, ...)
            local ao = q:FindFirstChild'Arms'
            if ao and r.Game.IsAlive(o) and an and type(an) == 'string' and am == ao then
                local ap = unpack(an:split'_')
                if ap == 'Knife' and t['Skins/Knife'] and t['Skins/Knife/Type'] ~= 'Knife' then
                    local aq = r.Game.SkinsData.Knives.Replacements and r.Game.SkinsData.Knives.Replacements[t['Skins/Knife/Type']]
                    if aq then an = aq end
                elseif r.Game.SkinsData.Weapons.Replacements and r.Game.SkinsData.Weapons.Replacements[ap] and t[`Skins/{ap}`] then
                    local aq = r.Game.SkinsData.Weapons.Replacements[ap]
                    if aq then an = aq end
                end
            end
            return al(am, an, ...)
        end)
    end
    if r.Client.HasHookmetamethod and r.Client.HasHookfunction then
        local al
        al = hookmetamethod(game, '__namecall', newcclosure(function(am, ...)
            local an, ao = getnamecallmethod(), {...}
            if an == 'Raycast' and am == workspace then
                if t['Legit/SilentAim'] and H ~= nil and t['Legit/SilentAim/HitChance'] >= math.random(1, 100) then
                    ao[2] = (I.Position - ao[1]).Unit * ao[2].Magnitude
                    return al(am, unpack(ao))
                end
            elseif an == 'PivotTo' and am.Parent == q and am.Name == 'Arms' then
                if t['Visuals/Arms/NoSway'] and not (t['Visuals/ThirdPerson'] and t['Visuals/ThirdPerson/Bind'].Toggled) then
                    ao[1] = q.CFrame
                    return al(am, unpack(ao))
                end
                if t['Visuals/Viewmodel'] then
                    ao[1] *= CFrame.new(t['Visuals/Viewmodel/X'] / 300, t['Visuals/Viewmodel/Y'] / 300, t['Visuals/Viewmodel/Z'] / 300)
                    return al(am, unpack(ao))
                end
            elseif an == 'FireServer' then
                if am == r.Game.FireEvent and ao[1].Position ~= nil then
                    local ap = ao[1].Position
                    if t['Visuals/BulletTracers'] then
                        task.spawn(ai.CreateTracer, ap, t['Visuals/BulletTracers/StartColor'].Color, t['Visuals/BulletTracers/EndColor'].Color, t['Visuals/BulletTracers/Lifetime'], t['Visuals/BulletTracers/Texture'])
                    end
                    if t['Visuals/HitImpacts'] then
                        task.spawn(aj.CreateImpact, ap, t['Visuals/HitImpacts/Color'].Color, t['Visuals/HitImpacts/Lifetime'])
                    end
                elseif am.Name == 'Throwable' then
                    if t['Misc/Throwables/Teleport'] and J then
                        ao[2] = K.CFrame
                        ao[3] = -100
                        return al(am, unpack(ao))
                    end
                end
            end
            return al(am, ...)
        end))
        local am
        am = hookmetamethod(game, '__index', function(an, ao)
            if not checkcaller() then
                if ao == 'Velocity' and an.Parent == o.Character and t['Visuals/Arms/NoBob'] and r.Game.IsAlive(o) then
                    return Vector3.zero
                end
            end
            return am(an, ao)
        end)
    end
end

s:Notification(`Loaded in {string.format('%.4f', os.clock() - a)} seconds`, 5, Color3.fromRGB(149, 255, 139), {'135757045959142', Color3.new(1, 1, 1)})

do
    local al = {}
    if not r.Client.HasHookmetamethod then table.insert(al, 'hookmetamethod') end
    if not r.Client.HasMousemoverel then table.insert(al, 'mousemoverel') end
    if not r.Client.HasRequire then table.insert(al, 'require') end
    if not r.Client.FullRequire then table.insert(al, 'require (not fully supported)') end
    if not r.Client.HasGetsenv then table.insert(al, 'getsenv') end
    if not r.Client.FullGetsenv then table.insert(al, 'getsenv (not fully supported)') end
    if #al > 0 then
        local am = `Your exploit doesn't support: {table.concat(al, ', ')}`
        s:Notification(am, 12, Color3.fromRGB(149, 255, 139), {'18209598048', Color3.new(1, 1, 1)})
    end
end
