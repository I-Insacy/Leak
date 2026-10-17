
if not LPH_OBFUSCATED then
    LPH_JIT = function(f) return f end
    LPH_JIT_MAX = function(f) return f end
    LPH_NO_VIRTUALIZE = function(f) return f end
    LPH_ENCFUNC = function(f) return f end
    LPH_ENCSTR = function(s) return s end
    LPH_ENCNUM = function(n) return n end
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local MainESP, CullingSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotWhyLclc/Main/refs/heads/main/Utils/esp.luau"))()
local Options = Library.Options
local Toggles = Library.Toggles

local ExecutorName = (identifyexecutor or getexecutorname or function() return "Unknown" end)():lower()

if ExecutorName == "solara" or ExecutorName == "xeno" then
    Library:Notify(ExecutorName .. " your executor is shit and never will be supported.", 5)
    return
end

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
  Font = 0,
  FontSize = 15,
  TeamCheck = false,
  BoxThickness = 0,
  TracerThickness = 0,
  DirectionThickness = 0,
  SkeletonThickness = 0,
  Bounties = false,
}
MainESP.ObjectOptions = {
  Enabled = false,
  Tracer = false,
  TextOutline = false,
  Distance = false,
  Name = false,
  Font = 0,
  FontSize = 20,
  Rainbow = false,
  Color = Color3.fromRGB(148, 96, 69),
  TracerOrigin = "Bottom",
  TracerThickness = 0,
  BoxThickness = 1,
}

CullingSystem.maxRenderDistance = 20000
CullingSystem.nearDistance = 10000
CullingSystem.farDistance = 15000

local setclipboard = setclipboard or toclipboard or set_clipboard or nil
local setthreadcontext = setthreadidentity or set_thread_identity or setthreadcontext or set_thread_context or function() Library:Notify("missing setthreadidentity/sethreadcontext") end

local workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local replicatedstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local localplayer = game:GetService("Players").LocalPlayer
local collectionservice = game:GetService("CollectionService")
local runservice = game:GetService("RunService")
local userinputservice = game:GetService("UserInputService")
local teleportservice = game:GetService("TeleportService")
local httpservice = game:GetService("HttpService")

configs = {
  player = {
    fspeed = 10,
    ftog = false,
    arrestaura = {
      enabled = false,
      showtargeted = false,
    },
    ejectaura = {
        enabled = false,
    },
    pickpocketaura = {
      enabled = false,
    },
    crimsearchaura = {
      enabled = false,
    },
    breakoutaura = {
      enabled = false,
    },
    autocollectcash = false,
    cashcollectrange = 20,
    nofall = false,
    norag = false,
    noislow = false,
    nosky = false,
    nostun = false,
    nocslow = false,
    nocircwait = false,
    circleclip = false,
    nopwait = false,
    noclip = false,
    infjump = false,
    alwayssp = false,
    juiced = false,
    enableroll = false,
    norwait = false,
    nopunchcd = false,
    antilocked = false,
    infjetpack = false,
    fasterjetpack = false,
    bypassnofly = false,
    crawlequip = false,
    flyequip = false,
    instantdonut = false,
    minimap = {
        antiminimapflash = false,
        antiplayermarkerflash = false,
    },
  },
  vehicle = {
    garage = {
        bodycolor = "None",
        secondbodycolor = "None",
        texture = "None",
        interiormain = "None",
        interiordetail = "None",
        wheelcolor = "None",
        rim = "None",
        spoiler = "None",
        spoilercolor = "None",
        tiremesh = "None",
        horn = "None",
        drifts = "None",
        autoapply = false,
    },
    fspeed = 10,
    ftog = false,
    engine = false,
    enginesp = 0,
    brake = false,
    brakesp = 0,
    suspension = false,
    suspensionhe = 0,
    turnsp = 0,
    turn = false,
    inftrac = false,
    tirepop = false,
    nopop = false,
    infnitro = false,
    nojumpcd = false,
    autoloadslot = false,
    autoloadlast = false,
    showfavorited = false,
    autoflip = false,
    destroydestructibles = false,
    destructrange = 50,
    pitaura = false,
    pitaurarange = 30,
    alwaysdrift = false,
    helibreak = false,
    helienginesp = 0,
    heliverticalsp = 0,
    heliturnsp = 0,
    heliengine = false,
    helipick = false,
    heliheight = false,
    instanttow = false,
    driveonwater = false,
    tanksus = false,
    tanksushe = 5.3,
    tankengine = false,
    tankenginesp = 0,
    voltenginesp = 0,
    voltnopop = false,
    boatengine = false,
    boatenginesp = 1,
    boatland = false,
    boatturn = false, 
    boatturnsp = 1,
    boatantitakedown = false,
    planeengine = false,
    planeenginesp = 1,
    planeheight = false,
    jetinstanttakeoff = false,
    jetnoroll = false,
  },
  robbery = {
    guardnodmg = false,
    bank = {
      disablelasers = false,
      autodynamite = false,
    },
    jewelry = {
      disablelasers = false,
      autograb = false,
      antidoorlock = false,
    },
    casino = {
      autodoor = false,
      doorcooldown = 0.5,
      autocrackvault = false,
      autonotifycode = false,
      disablelasers = false,
      fixcomputer = false,
      autocollect = false,
      elevatorfloor = "Ground",
    },
    museum = {
      disablelasers = false,
      autodynamite = false,
      autosolvepuzzle = false,
    },
    powerplant = {
      disablelasers = false,
      disablepistons = false,
      autosolve = false,
    },
    tomb = {
      disableplanks = false,
      disablespikes = false,
      disablesdarts = false,
      bridgebreak = false,
      disablelava = false,
      autosit = false,
      autoduck = false,
    },
    oilrig = {
      disablelasers = false,
      autotnt = false,
      autokeycard = false,
      disableselfdestruct = false,
      disableturret = false,
    },
    cargoship = {
      disableturret = false,
    },
    cargotrain = {
      autobreach = false,
    },
    passengertrain = {
      autograb = false,
    },
    mansion = {
      disablelasers = false,
      disabletraps = false,
      bandittargetboss = false,
      antibossattack = false,
      autoelevator = false,
    },
    robberystatus = {
        notifyonopen = false,
        hideclosed = false,
        width = 180,
    },
  },
  combat = {
    autokillbandit = false,
    instantkillbandit = false,
    antiequipt = false,
    antispread = false,
    antirecoil = false,
    nobulletg = false,
    alwaysauto = false,
    pistolswat = false,
    antisniperblur = false,
    antiscopeui = false,
    explosives = {
        nogrenadesmoke = false,
        nogrenadesmokelimit = false,
        smokethrowspeed = 100,
        grenadethrowspeed = 100,
        grenadefuse = 3,
        grenadethrowcd = false,
    },
    tasermodz = false,
    instantreload = false,
    instantrocketseek = false,
    forcefieldnomiss = false,
    forcefieldreload = false,
    shootthroughforce = false,
    instantbullethit = false,
    silentaim = {
      enabled = false,
      includecarturret = false,
      includebandits = false,
      friendlyfire = false,
      radius = 50,
      wallcheck = false,
      fovcirc = false,
      fovthick = 5,
      fovtransp = 0,
    },
    loadout = {
        enabled = false,
        dropUnselected = false,
        autograb = false,
        slots = {
            [1] = "None", [2] = "None", [3] = "None", [4] = "None", [5] = "None",
            [6] = "None", [7] = "None", [8] = "None", [9] = "None", [10] = "None"
        }
    },
    carturret = {
      antioverheat = false,
      fastbullet = false,
      followmouse = false,
    },
    batonsword = {
      noreloadtime = false,
      spamlunge = false,
      spamswoosh = false,
    },
  },
  others = {
    disablehometurret = false,
    disablemilitaryturret = false,
    disablemilitaryforcefield = false,
    prisonelevator = false,
    breakelevator = false,
    spectateTarget = nil,
    serverhopuntilbounty = false,
    serverhopcooldown = 1,
  },
  settings = {
    serverhop = false,
  },
} 

local client = {
  bettertablefind = function(tbl, n)
    for i, v in next, tbl do
        if tostring(v) == tostring(n) then return i end
    end
    return nil
  end,
  gc = {},
  debugmode = false,
  noflyzones = {},
  noflyadded = nil,
  autofavorite = nil,
  airdropEnabled = false,
  airdropMarkers = {},
  airdropConns = {},
  minimapmarker = {},
  playermarker = nil,
  extraMarkerGroup = nil,
  extraMarkers = {},
  iconsDetected = false,
  copicon = 7028057307,
  crimicon = 7028057307,
  antilocked = nil,
  instantreload = nil,
  instantreloadprocess = false,
  alwaysjuiced = nil,
  lastcode = "",
  autonotify = false,
  solvedelay = 0.1,
  disabletombdarts = false,
  spectateTarget = nil,
  spectateMaid = nil,
  lastvehiclestats = {
    GarageEngineSpeed = nil,
    GarageBrakes = nil,
    Height = nil,
    TurnSpeed = nil,
  },
  lastvehiclemodel = nil,
  vehicleEntered = false,
  activeaction = {},
  stdraycast = require(replicatedstorage.Std.Raycast),
  puzzleflow = require(replicatedstorage.Game.Robbery.PuzzleFlow),
  guardnpcbinder = require(replicatedstorage.GuardNPC.GuardNPCBinder)._constructor,
  combatconst = require(replicatedstorage.Combat.CombatConsts),
  militaryturretconst = require(replicatedstorage.Game.MilitaryTurret.MilitaryTurretConsts),
  characterutil = require(replicatedstorage.Game.CharacterUtil),
  donut = require(replicatedstorage.Game.Item.Donut),
  actionbuttonservice = require(replicatedstorage.ActionButton.ActionButtonService),
  settings = require(replicatedstorage.Resource.Settings),
  stdcharacterutils = require(replicatedstorage.Std.CharacterUtils),
  paraglide = require(replicatedstorage.Game.Paraglide),
  alexchassis = require(replicatedstorage.Module.AlexChassis),
  alexchassis2 = require(replicatedstorage.Module.AlexChassis2),
  boat = require(replicatedstorage.Game.Boat.Boat),
  jetski = require(replicatedstorage.Game.VehicleSystem.JetSki),
  jet = require(replicatedstorage.Game.Plane.Jet),
  stunt = require(replicatedstorage.Game.Plane.Stunt),
  gamepasssystem = require(replicatedstorage.Gamepass.GamepassSystem),
  pistolitem = require(replicatedstorage.Game.Item.Pistol),
  tase = require(replicatedstorage.Game.Item.Taser),
  plasmagun = require(replicatedstorage.Game.Item.PlasmaGun),
  itemgun = require(replicatedstorage.Game.Item.Gun),
  itemsys = require(replicatedstorage.Game.ItemSystem.ItemSystem),
  gunutil = require(replicatedstorage.Game.GunShop.GunUtils),
  hotbarsystem = require(replicatedstorage.Hotbar.HotbarItemSystem),
  hotbarutils = require(replicatedstorage.Hotbar.HotbarItemUtils),
  smokegrenadeitem = require(replicatedstorage.Game.SmokeGrenade.SmokeGrenade),
  grenade = require(replicatedstorage.Game.Item.Grenade),
  jetpack = require(replicatedstorage.Game.JetPack.JetPack),
  movementrollservice = require(replicatedstorage.MovementRoll.MovementRollService),
  circleac = require(replicatedstorage.Module.UI).CircleAction,
  geomUtils = require(replicatedstorage.Std.GeomUtils),
  vehiclelinkbinder = require(replicatedstorage.VehicleLink.VehicleLinkBinder),
  controlmodule = require(players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule),
  duck = require(replicatedstorage.Game.Robbery.TombRobbery.TombRobberySystem).duck,
  vehicleutils = require(replicatedstorage.Vehicle.VehicleUtils),
  onvehicleentered = require(replicatedstorage.Vehicle.VehicleUtils).OnVehicleEntered,
  onvehicleexited = require(replicatedstorage.Vehicle.VehicleUtils).OnVehicleExited,
  onlocalitemequipped = require(replicatedstorage.Game.ItemSystem.ItemSystem).OnLocalItemEquipped,
  onlocalitemunequipped = require(replicatedstorage.Game.ItemSystem.ItemSystem).OnLocalItemUnequipped,
  raycast = require(replicatedstorage.Module.RayCast),
  bulletemitter = require(replicatedstorage.Game.ItemSystem.BulletEmitter),
  simulatedphysicsprojectile = require(replicatedstorage.Module.SimulatedPhysicsProjectile),
  c4 = require(replicatedstorage.Game.Item.C4),
  rocketconsts = require(replicatedstorage.RocketLauncher.RocketLauncherConsts),
  dartdispenser = require(replicatedstorage.Game.DartDispenser.DartDispenser),
  rocketworld = require(replicatedstorage.Game.RocketWorld),
  turret = require(replicatedstorage.Turret2.Turret),
  itemturret = require(replicatedstorage.Game.Item.Turret),
  turretconfig = require(replicatedstorage.Game.ItemConfig.Turret),
  carturret = require(replicatedstorage.Game.Item.CarTurret),
  carturretconfig = require(replicatedstorage.Game.ItemConfig.CarTurret),
  oilrigbinder = require(replicatedstorage.OilRig.OilRigBinder)._constructor,
  gunshopui = require(replicatedstorage.Game.GunShop.GunShopUI),
  inventoryitemsystem = require(replicatedstorage.Inventory.InventoryItemSystem),
  inventoryitemutils = require(replicatedstorage.Inventory.InventoryItemUtils),
  inventoryitemconsts = require(replicatedstorage.Inventory.InventoryItemConsts),
  tankbinder = require(replicatedstorage.Tank.TankBinder)._constructor,
  forcefieldservice = require(replicatedstorage.Forcefield.ForcefieldService),
  roact = require(replicatedstorage.Roact),
  store = require(replicatedstorage.App.store),
  worldmarker = require(replicatedstorage.Game.WorldMarker.WorldMarker),
  minimapservice = require(replicatedstorage.App.MinimapService),
  worldmarkergroup = require(replicatedstorage.Game.WorldMarker.WorldMarkerGroup),
  worldmarkersystem = require(replicatedstorage.Game.WorldMarker.WorldMarkerSystem),
  playermarkersystem = require(replicatedstorage.Game.PlayerMarkerSystem)
}

client.ori = {
  collidable = clonefunction(client.stdraycast.collidable),
  hookNearest = clonefunction(client.vehiclelinkbinder._constructor._hookNearest),
  turretshoot = clonefunction(client.itemturret.Shoot),
  bulletemitteronlocalhitplayer = clonefunction(client.itemgun.BulletEmitterOnLocalHitPlayer),
  hittargetwithspeed = clonefunction(client.simulatedphysicsprojectile.HitTargetWithSpeed),
  calculatevelocity = clonefunction(client.simulatedphysicsprojectile.CalculateVelocityToHitTargetWithSpeed),
  grenadecalcprojvel = clonefunction(getupvalue(client.grenade.GrenadeThrow, 3)),
  isflying = clonefunction(client.paraglide.IsFlying),
  jetpackIsFlying = clonefunction(client.jetpack.IsFlying),
  tase = clonefunction(client.tase.Tase),
  doesplayerowncached = clonefunction(client.gamepasssystem.doesPlayerOwnCached),
  update = clonefunction(client.circleac.UpdateLogic),
  getequiptime = clonefunction(client.gunutil.getEquipTime),
  rayignorenon = clonefunction(client.raycast.RayIgnoreNonCollide),
  plasmashootother = clonefunction(client.plasmagun.ShootOther),
  pistolsetupmodel = client.pistolitem.SetupModel,
  rayignorenoncollidewithignorelist = clonefunction(client.raycast.RayIgnoreNonCollideWithIgnoreList),
  shoot = clonefunction(client.itemgun.Shoot),
  circleactionpress = clonefunction(client.circleac.Press),
  oillaunchblow = clonefunction(client.oilrigbinder._launchBlowUp),
  getLocked = clonefunction(client.inventoryitemutils.getLocked),
  setLocked = clonefunction(client.inventoryitemutils.setLocked),
  getlocalvehiclepacket = clonefunction(client.vehicleutils.GetLocalVehiclePacket),
  nitroshopvisible = clonefunction(client.vehicleutils.NitroShopVisible),
  boatgetaretirespopped = clonefunction(client.boat.GetAreTiresPopped)
};

local function debugPrint(...)
    if client.debugmode then
        print(...)
    end
end

local function debugWarn(...)
    if client.debugmode then
        warn(...)
    end
end

local cheatcheck = false
local cheatcheck0 = false

for _, v in next, getgc() do
    if type(v) == "function" and islclosure(v) then
        local ok, constants = pcall(getconstants, v)
        if not ok then continue end

        local ok2, info = pcall(getinfo, v)
        local infoname = ""
        local scriptName = ""
        if ok2 and info ~= nil then
            infoname = tostring(info.name or "")
            local ok3, env = pcall(getfenv, v)
            if ok3 and env and env.script then
                scriptName = tostring(env.script)
            end
        end

        if scriptName == "LocalScript" then
            if infoname == "CheatCheck" then
                cheatcheck = true
                debugPrint("cc found:", v)
                hookfunction(v, function() end)
            elseif infoname == "CheatCheck0" then
                cheatcheck0 = true
                debugPrint("cc0 found:", v)
                hookfunction(v, function() end)
            end
            if client.bettertablefind(constants, "StartRagdolling") then client.stunnedragdoll = v end
            if client.bettertablefind(constants, "PlusCash") then client.cashthingy = v end
            if infoname == "attemptPunch" then client.attemptpunch = v end
            if infoname == "UpdatePlayer" then client.updateplayer = v end
            if infoname == "StartNitro" then
                client.startnitro = v
                if not client.nitroTable then
                    local nitroUpval = getupvalue(v, 10)
                    if type(nitroUpval) == "table" and rawget(nitroUpval, "Nitro") and rawget(nitroUpval, "NitroLastMax") then
                        client.nitroTable = nitroUpval
                    end
                end
            end
            if infoname == "StopNitro" then client.stopnitro = v end
        end
        if not client.gc.vehicleactionstart and client.bettertablefind(constants, "_lastUsed") then
            local ok4, upvals = pcall(getupvalues, v)
            if ok4 and #upvals > 10 then
                client.gc.vehicleactionstart = v
            end
        end
        if not client.gc.circleaction then
            local idx05, idx2
            for i, c in next, constants do
                if c == 0.5 then idx05 = i end
                if c == 2 then idx2 = i end
            end
            if idx05 and idx2 then
                client.gc.circleaction = v
                client.gc.circleactionidx05 = idx05
                client.gc.circleactionidx2 = idx2
            end
        end
        if not client.jetpackHeartbeat then
            local _, cam = pcall(getupvalue, v, 2)
            local _, accelTween = pcall(getupvalue, v, 3)
            if cam == workspace.CurrentCamera and type(accelTween) == "table" and rawget(accelTween, "_accel") == 80 then
                client.jetpackHeartbeat = v
            end
        end
    end
end

local bossClass = nil
for _, v in next, getgc(true) do
    if type(v) == "table" 
       and rawget(v, "PlayArmGrab")     
       and rawget(v, "PlayLaserSweepVisual") 
       and rawget(v, "PlayAuraBlast")
       and rawget(v, "_setupArmBoneData") then
        bossClass = v
        break
    end 
end

for i, v in next, getconnections(runservice.Heartbeat) do
  if v.Function and islclosure(v.Function) then
    if getconstants(v.Function)[13] == "Time/UI" then
      client.walkspeedfun = getupvalue(v.Function, 6)
    end
  end
end

task.spawn(function()
    hookfunction(getcallbackvalue(game:GetService("ReplicatedStorage").HawkeyeRemoteFunction, "OnClientInvoke"), function() end)
end)

local Ranges = {
    ["Pistol"] = 1000,
    ["Revolver"] = 800,
    ["Flintlock"] = 900,
    ["AK47"] = 1050,
    ["Rifle"] = 1500,
    ["Uzi"] = 1000,
    ["Shotgun"] = 950,
    ["Sniper"] = 3072,
    ["RocketLauncher"] = 9999,
    ["PlasmaPistol"] = 200,
    ["PlasmaShotgun"] = 50,
    ["Taser"] = 85,
    ["CarTurret"] = 200,
}

local loadoutDisplay = {"None", "AK47", "Baton", "Binoculars", "C4", "Crim Key", "Donut", "Flashlight", "Flintlock", "Forcefield Launcher", "Grenade", "Handcuffs", "Juice", "Key", "Nerf Pistol", "Nerf Revolver", "Pistol", "Plasma Pistol", "Plasma Shotgun", "Revolver", "Rifle", "Rocket Launcher", "Road Spikes", "Shotgun", "Smoke Grenade", "Sniper", "Swat Shield", "Sword", "Taser", "Uzi"}

local loadoutMap = {
    ["None"] = "None",
    ["AK47"] = "AK47",
    ["Baton"] = "Baton",
    ["Binoculars"] = "Binoculars",
    ["C4"] = "C4",
    ["Crim Key"] = "CrimeKey",
    ["Donut"] = "Donut",
    ["Flashlight"] = "Flashlight",
    ["Flintlock"] = "Flintlock",
    ["Forcefield Launcher"] = "ForcefieldLauncher",
    ["Grenade"] = "Grenade",
    ["Handcuffs"] = "Handcuffs",
    ["Juice"] = "Juice",
    ["Keycard"] = "Key",
    ["Nerf Pistol"] = "NerfPistol",
    ["Nerf Revolver"] = "NerfRevolver",
    ["Pistol"] = "Pistol",
    ["Plasma Pistol"] = "PlasmaPistol",
    ["Plasma Shotgun"] = "PlasmaShotgun",
    ["Revolver"] = "Revolver",
    ["Rifle"] = "Rifle",
    ["Rocket Launcher"] = "RocketLauncher",
    ["Road Spikes"] = "RoadSpike",
    ["Shotgun"] = "Shotgun",
    ["Smoke Grenade"] = "SmokeGrenade",
    ["Sniper"] = "Sniper",
    ["Swat Shield"] = "ShieldSwat",
    ["Sword"] = "Sword",
    ["Taser"] = "Taser",
    ["Uzi"] = "Uzi",
}

local loadoutReverseMap = {}
for display, internal in pairs(loadoutMap) do
    loadoutReverseMap[internal] = display
end

client._noclipConn = nil
client._noclipCache = {}

for i, v in next, client.ori do
  client.ori[i] = clonefunction(v)
end

local ok, p = pcall(getupvalue, client.alexchassis.VehicleEnter, 17)
client.rayParamsVehicleEnter = ok and p or nil

client.oilexplosion = workspace.OilRig.OpenCloseSignal.Explosion

client.rocketworld.yousuck = (function() end)

client.getnumactivec4 = getupvalue(client.c4.ShootBegin, 4)
client.gethrowablesmokegrenade = getupvalue(require(replicatedstorage.Game.Item.SmokeGrenade).ShootBegin, 1)
client.getnearestplayer = getupvalue(require(replicatedstorage.Home.HomeItem.Fabricate.Turret).setup, 11)
client.motorupdatewheel = getupvalue(client.alexchassis2.UpdateHQ, 15)
client.circleupdateui = getupvalue(client.circleac.UpdateLogic, 1)

client.rollratelimiter = getupvalue(client.movementrollservice.attemptRoll, 6)
client.vclasses = client.vehicleutils.Classes
client.ori.heliupdate = client.vclasses.Heli.Update
client.ori.voltupdate = clonefunction(client.vclasses.Volt.Update)
client.ori.chassisupdate = client.vclasses.Chassis.UpdateEngine

client.ori.collidable = client.stdraycast.collidable

client.jetpackfuel = getupvalue(client.jetpack.Init, 8)

setreadonly(client.combatconst, isreadonly(client.combatconst) and false)
setreadonly(client.militaryturretconst, isreadonly(client.militaryturretconst) and false)
setreadonly(client.rocketconsts, isreadonly(client.rocketconsts) and false)
setconstant(client.motorupdatewheel, 17, "die")

if client.gc.vehicleactionstart then
    client.constindex = client.constindex or {}
    client.constindex.vehicleactionstart = {}
    client.constindex.vehicleactionstart.GarageEngineSpeed = client.bettertablefind(getconstants(client.gc.vehicleactionstart), "CanJump")
    client.constindex.vehicleactionstart.cooldown = client.bettertablefind(getupvalues(client.gc.vehicleactionstart), 15)

    if client.constindex.vehicleactionstart.cooldown == nil then
        Library:Notify("jump action index is nil, initializing shitty backup mode.")
        for i, v in next, getupvalues(client.gc.vehicleactionstart) do
            if type(v) == "number" and v == 15 then
                client.constindex.vehicleactionstart.cooldown = i
                print(i)
            end
        end
    end

    if client.constindex.vehicleactionstart.cooldown == nil then
        Library:Notify("jump action index is still nil, idk what the fuck happened...")
    end
end

client.getBankDynamiteKey = function()
    return "ddvex3uu"
end

for i, v in next, client.actionbuttonservice.active do
  if table.find(v.keyCodes, Enum.KeyCode.V) then
    client.activeaction.flip = v
  end
  if table.find(v.keyCodes, Enum.KeyCode.LeftControl) then
    client.activeaction.roll = v
  end
end

local itemConfigClone = replicatedstorage.Game.ItemConfig:Clone()
itemConfigClone.Name = "ItemConfigBackup"

local Circle = MainESP.CreateCircle()
Circle.Radius = configs.combat.silentaim.radius
Circle.Color = Color3.fromRGB(255, 255, 255)
Circle.Position = MainESP.TracerOrigins.Middle
Circle.NumSides = 500

local CircleOutline = MainESP.CreateCircle()
CircleOutline.Radius = configs.combat.silentaim.radius + 2
CircleOutline.Color = Color3.fromRGB(0, 0, 0)
CircleOutline.Filled = false
CircleOutline.Visible = false
CircleOutline.Position = MainESP.TracerOrigins.Middle
CircleOutline.NumSides = 500

local CircleFilled = MainESP.CreateCircle()
CircleFilled.Radius = configs.combat.silentaim.radius - 1
CircleFilled.Color = Color3.fromRGB(0, 0, 0)
CircleFilled.Filled = true
CircleFilled.Visible = false
CircleFilled.Transparency = 0.5
CircleFilled.Position = MainESP.TracerOrigins.Middle
CircleFilled.NumSides = 500

for _, v in ipairs(collectionservice:GetTagged("JetPackNoFly")) do
    table.insert(client.noflyzones, v)
end

if not client.noflyadded then
    client.noflyadded = collectionservice:GetInstanceAddedSignal("JetPackNoFly"):Connect(function(part)
        if not table.find(client.noflyzones, part) then
            table.insert(client.noflyzones, part)
        end
        if configs.player.bypassnofly then
            collectionservice:RemoveTag(part, "JetPackNoFly")
        end
    end)
end

hookfunction(client.vehicleutils.NitroShopVisible, function(...)
    local gvp = client.vehicleutils.GetLocalVehiclePacket()
    local isNitroActive = type(gvp) == "table" and gvp.Nitro
    
    if configs.vehicle.infnitro and isNitroActive then
        return
    end
    
    return client.ori.nitroshopvisible(...)
end)

client.ispc = (function()
  if userinputservice.TouchEnabled and not userinputservice.KeyboardEnabled and not userinputservice.MouseEnabled then
    return false
  elseif not userinputservice.TouchEnabled and userinputservice.KeyboardEnabled and userinputservice.MouseEnabled then
    return true
  end
  return false
end)
client.flipLoop = LPH_JIT(function()
  repeat
    task.wait(.1)
    pcall(function()
      for i, v in next, client.actionbuttonservice.active do
        if table.find(v.keyCodes, Enum.KeyCode.V) then
          v.onPressed(true)
        end
      end
    end)
  until configs.vehicle.autoflip == false
end)
client.driftLoop = LPH_JIT(function()
  repeat
    task.wait(.1)
    pcall(function()
      local gvp = require(replicatedstorage.Vehicle.VehicleUtils).GetLocalVehiclePacket()
      if gvp then
        for i, v in next, client.actionbuttonservice.active do
          if table.find(v.keyCodes, Enum.KeyCode.LeftShift) then
            v.onPressed(true)
          end
        end
      end
    end)
  until configs.vehicle.alwaysdrift == false
end)
client.nitroLoop = LPH_JIT(function()
    repeat
        task.wait()
        if not client.nitroTable then continue end
        
        local gvp = client.vehicleutils.GetLocalVehiclePacket()
        local isNitroActive = gvp and gvp.Nitro
        
        if isNitroActive then
            client.nitroTable.NitroLastMax = 250
            client.nitroTable.Nitro = 249
        end
        
        client.nitroTable.NitroForceUIUpdate = true
    until not configs.vehicle.infnitro
end)
client.destructLoop = LPH_JIT(function()
    repeat
        task.wait(0.1)
        local gvp = require(replicatedstorage.Vehicle.VehicleUtils).GetLocalVehiclePacket()
        if not gvp or not gvp.Model or not gvp.Model:FindFirstChild("Engine") then continue end
        local engine = gvp.Model.Engine
        local hrp = players.LocalPlayer.Character and players.LocalPlayer.Character.PrimaryPart
        if not hrp then continue end
        
        for _, workspaceChild in ipairs(workspace:GetChildren()) do
            if workspaceChild.Name == "Folder" then
                for _, v in ipairs(workspaceChild:GetDescendants()) do
                    if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then
                        if v:IsDescendantOf(players.LocalPlayer.Character) then continue end
                        if gvp.Model and v:IsDescendantOf(gvp.Model) then continue end
                        if workspace:FindFirstChild("Vehicles") and v:IsDescendantOf(workspace.Vehicles) then continue end
                        
                        local dist = (hrp.Position - v.Position).Magnitude
                        if dist <= configs.vehicle.destructrange then
                            firetouchinterest(v, engine, 0)
                            firetouchinterest(v, engine, 1)
                        end
                    end
                end
            end
        end
    until not configs.vehicle.destroydestructibles
end)
client.pitAuraLoop = LPH_JIT(function()
    repeat
        task.wait(0.15)
        if tostring(players.LocalPlayer.Team) ~= "Police" then continue end
        local gvp = require(replicatedstorage.Vehicle.VehicleUtils).GetLocalVehiclePacket()
        if not gvp or not gvp.Model then continue end
        local bumper = gvp.Model:FindFirstChild("BumperCollide")
        if not bumper then continue end
        local hrp = players.LocalPlayer.Character and players.LocalPlayer.Character.PrimaryPart
        if not hrp then continue end
        local closestPlayer, closestDist = nil, configs.vehicle.pitaurarange
        for _, plr in ipairs(players:GetPlayers()) do
            if plr ~= players.LocalPlayer and plr.Character then
                local plrHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if plrHrp then
                    local dist = (hrp.Position - plrHrp.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closestPlayer = plr
                    end
                end
            end
        end
        if closestPlayer then
            local targetVehicle = require(replicatedstorage.Vehicle.VehicleUtils).GetLocalVehiclePacket()
            if closestPlayer.Character then
                local searchContainer = workspace:FindFirstChild("Vehicles") or workspace

                for _, v in ipairs(searchContainer:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name == "BoundingBox" then
                        local dist = (closestPlayer.Character.PrimaryPart.Position - v.Position).Magnitude
                        if dist < 15 then
                            firetouchinterest(v, bumper, 0)
                            firetouchinterest(v, bumper, 1)
                            break
                        end
                    end
                end
            end
        end
    until not configs.vehicle.pitaura
end)
client.smokeGrenadeHook = (function(boolean)
  if boolean then
    hookfunction(client.smokegrenadeitem._playExplosionFx, function() end)
  else
    if isfunctionhooked(client.smokegrenadeitem._playExplosionFx) then
      restorefunction(client.smokegrenadeitem
        ._playExplosionFx)
    end
  end
end)
client.getNearestPlayerHook = (function(boolean)
  if boolean then
    hookfunction(client.getnearestplayer, function() return nil end)
  else
    if isfunctionhooked(client.getnearestplayer) then restorefunction(client.getnearestplayer) end
  end
end)
client.isCrawlingLoop = LPH_JIT(function()
  repeat
    task.wait(.1)
    if client.characterutil.IsCrawling then
      client.characterutil.IsCrawling = false
    end
  until configs.player.crawlequip == false
end)
client.setnpcignorelp = function(a)
    for i, v in next, getupvalue(client.itemsys.GetEquipped, 1) do
        if v.Character then
            local char = v.Character

            local plr = players:GetPlayerFromCharacter(char)
            if plr then continue end

            local isNpc = false

            if collectionservice:HasTag(char, "GuardNPC") then
                isNpc = true
            else
                local mansion = workspace:FindFirstChild("MansionRobbery")
                if mansion and char:IsDescendantOf(mansion) then
                    isNpc = true
                end
                local drop = workspace:FindFirstChild("Drop")
                if drop and char:IsDescendantOf(drop) then
                    isNpc = true
                end
                local oilrig = workspace:FindFirstChild("OilRig")
                if oilrig and char:IsDescendantOf(oilrig) then
                    isNpc = true
                end
            end

            if isNpc and v.BulletEmitter then
                v.BulletEmitter.IgnoreLocalPlayer = a
            end
        end
    end
end
client.npcnodamageloop = LPH_JIT(function()
  repeat
    task.wait(0.1)
    client.setnpcignorelp(true)
  until configs.robbery.guardnodmg == false
end)
if bossClass then
    client.ori.playArmGrab = clonefunction(bossClass.PlayArmGrab)
    client.ori.playLaserSweepVisual = clonefunction(bossClass.PlayLaserSweepVisual)
    client.ori.playAuraBlast = clonefunction(bossClass.PlayAuraBlast)

    bossClass.PlayArmGrab = function(...)
        if configs.robbery.mansion.antibossattack then
            return
        end
        return client.ori.playArmGrab(...)
    end

    bossClass.PlayLaserSweepVisual = function(...)
        if configs.robbery.mansion.antibossattack then
            return
        end
        return client.ori.playLaserSweepVisual(...)
    end

    bossClass.PlayAuraBlast = function(...)
        if configs.robbery.mansion.antibossattack then
            return
        end
        return client.ori.playAuraBlast(...)
    end
end
client.sprintLoop = LPH_JIT(function()
  repeat
    task.wait()
    setupvalue(client.walkspeedfun, 9, true)
  until not configs.player.alwayssp
end)
client.juicedLoop = LPH_JIT(function()
    if configs.player.juiced then
        if not client.alwaysjuiced then
            client.alwaysjuiced = runservice.Heartbeat:Connect(function()
                client.characterutil.IsJuiced = true
            end)
        end
    else
        if client.alwaysjuiced then
            client.alwaysjuiced:Disconnect()
            client.alwaysjuiced = nil
            client.characterutil.IsJuiced = false
        end
    end
end)
client.roll = function(a)
    replicatedstorage:SetAttribute("RollingEnabled", a)
end
client.launchPlayerFlight = LPH_JIT(function()
    local Character = localplayer.Character or localplayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local Humanoid = Character:WaitForChild("Humanoid")
    
    Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
    
    repeat
        task.wait()
        
        if client.vehicleEntered then continue end
        
        local moveDir = Vector3.zero
        local cam = workspace.CurrentCamera
        local direction = client.controlmodule:GetMoveVector()
        
        if cam then
            moveDir += cam.CFrame.RightVector * direction.X
            moveDir -= cam.CFrame.LookVector * direction.Z
            local up = userinputservice:IsKeyDown(Enum.KeyCode.Space) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonA) or userinputservice:IsKeyDown(Enum.KeyCode.DPadUp)
            local down = userinputservice:IsKeyDown(Enum.KeyCode.LeftShift) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonB) or userinputservice:IsKeyDown(Enum.KeyCode.DPadDown)
            moveDir += Vector3.yAxis * (up and 1 or 0)
            moveDir -= Vector3.yAxis * (down and 1 or 0)
        end

        HumanoidRootPart.AssemblyLinearVelocity = moveDir.Magnitude > 0 and moveDir.Unit * configs.player.fspeed or Vector3.zero
    until configs.player.ftog == false
    
    Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end)
client.launchVehicleFlight = LPH_JIT(function()
    local Character = localplayer.Character or localplayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    repeat
        task.wait()
        local moveDir = Vector3.zero
        local cam = workspace.CurrentCamera
        local direction = client.controlmodule:GetMoveVector()
        
        if cam then
            moveDir += cam.CFrame.RightVector * direction.X
            moveDir -= cam.CFrame.LookVector * direction.Z
            local up = userinputservice:IsKeyDown(Enum.KeyCode.Space) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonA) or userinputservice:IsKeyDown(Enum.KeyCode.DPadUp)
            local down = userinputservice:IsKeyDown(Enum.KeyCode.LeftShift) or userinputservice:IsKeyDown(Enum.KeyCode.ButtonB) or userinputservice:IsKeyDown(Enum.KeyCode.DPadDown)
            moveDir += Vector3.yAxis * (up and 1 or 0)
            moveDir -= Vector3.yAxis * (down and 1 or 0)
        end

        HumanoidRootPart.AssemblyLinearVelocity = moveDir.Magnitude > 0 and moveDir.Unit * configs.vehicle.fspeed or Vector3.zero
    until client.vehicleEntered == false or configs.vehicle.ftog == false
end)
client.getOldWeaponData = (function(name, dataname)
    local config = itemConfigClone:FindFirstChild(name)
    if not config then return nil end
    return rawget(require(config), dataname)
end)
client.setBatonSwordTime = (function(bool)
  local baton = require(replicatedstorage.Game.Item.Baton)
  local sword = require(replicatedstorage.Game.Item.Sword)
  getupvalue(baton.new, 2).ReloadTime = bool and 0 or 0.5
  getupvalue(sword.new, 2).ReloadTime = bool and 0 or 0.5
end)
client.spamBatonSwordSwoosh = LPH_JIT(function()
  repeat
    task.wait()
    local a = client.itemsys.GetLocalEquipped()
    if a and (a.__ClassName == "Sword" or a.__ClassName == "Baton") then
      require(replicatedstorage.Game.Item[a.__ClassName]).SwingSwoosh(a)
    end
  until configs.combat.batonsword.spamswoosh == false
end)
client.spamBatonSwordLunge = LPH_JIT(function()
  repeat
    task.wait()
    local a = client.itemsys.GetLocalEquipped()
    if a and (a.__ClassName == "Sword" or a.__ClassName == "Baton") then
      require(replicatedstorage.Game.Item[a.__ClassName]).SwingLunge(a)
    end
  until configs.combat.batonsword.spamlunge == false
end)
client.notInWall = LPH_JIT(function(pos, ilist, wallCheck)
  if not wallCheck then
    return true
  end
  local camera = workspace.CurrentCamera or nil
  if camera == nil then
    return false
  end
  local direction = (pos - camera.CFrame.Position).Unit * (pos - camera.CFrame.Position).Magnitude
  local rayParams = RaycastParams.new()
  rayParams.FilterType = Enum.RaycastFilterType.Blacklist
  rayParams.FilterDescendantsInstances = ilist or {}
  rayParams.IgnoreWater = true
  local result = workspace:Raycast(camera.CFrame.Position, direction, rayParams)
  return result == nil
end)
client.isEnemies = LPH_JIT(function(a, b)
  local a, b = tostring(a), tostring(b)
  if a == "Criminal" and b == "Police" then
    return true
  elseif a == "Criminal" and b == "Prisoner" then
    return false
  elseif a == "Police" and b == "Criminal" then
    return true
  elseif a == "Police" and b == "Prisoner" then
    return false
  elseif a == "Prisoner" and b == "Police" then
    return true
  elseif a == "Prisoner" and b == "Criminal" then
    return false
  end
end)
client.getNearestToCursor = LPH_JIT(function()
    local notInWall = client.notInWall
    local isEnemies = client.isEnemies
    local middlepos = MainESP.TracerOrigins.Middle
    local Camera = workspace.CurrentCamera
    local LocalPlayer = players.LocalPlayer
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local lhrp = LocalPlayer.Character.HumanoidRootPart
    
    local maxRange = 300
    local equipped = client.itemsys.GetLocalEquipped()
    if equipped and equipped.__ClassName then
        maxRange = Ranges[equipped.__ClassName] or 300
    end

    local closestDist = math.huge
    local closestTarget = nil

    for _, v in next, players:GetPlayers() do
        if not configs.combat.silentaim.friendlyfire and not isEnemies(LocalPlayer.Team, v.Team) then continue end
        if v == LocalPlayer then continue end
        local char = v.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum or hum.Health == 0 then continue end
        if (lhrp.Position - hrp.Position).Magnitude > maxRange then continue end
        local targetPart = char:FindFirstChild("Head") or hrp
        local targetPoint, targetOnScreen = Camera:WorldToViewportPoint(targetPart.Position)
        if not targetOnScreen then continue end
        if not notInWall(targetPart.Position, {LocalPlayer.Character, char}, configs.combat.silentaim.wallcheck) then continue end
        
        local dist = (Vector2.new(targetPoint.X, targetPoint.Y) - Vector2.new(middlepos.X, middlepos.Y)).Magnitude
        if dist < configs.combat.silentaim.radius and dist < closestDist then
            closestDist = dist
            closestTarget = {Character = char, TargetPart = targetPart, IsNPC = false}
        end
    end

    if closestTarget then return closestTarget end

    if configs.combat.silentaim.includebandits then
        local npcs = {}
        local mansion = workspace:FindFirstChild("MansionRobbery")
        if mansion then
            local boss = mansion:FindFirstChild("ActiveBoss")
            if boss and boss:FindFirstChild("Head") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                table.insert(npcs, {Character = boss, TargetPart = boss.Head})
            end
            local guardsFolder = mansion:FindFirstChild("GuardsFolder")
            if guardsFolder then
                for _, guard in next, guardsFolder:GetChildren() do
                    if guard:IsA("Model") and guard:FindFirstChild("HumanoidRootPart") and guard:FindFirstChild("Humanoid") and guard.Humanoid.Health > 0 then
                        table.insert(npcs, {Character = guard, TargetPart = guard:FindFirstChild("Head") or guard.HumanoidRootPart})
                    end
                end
            end
        end
        local drop = workspace:FindFirstChild("Drop")
        if drop and drop:FindFirstChild("NPCs") then
            for _, npc in next, drop.NPCs:GetChildren() do
                if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                    table.insert(npcs, {Character = npc, TargetPart = npc:FindFirstChild("Head") or npc.HumanoidRootPart})
                end
            end
        end
        local oilrig = workspace:FindFirstChild("OilRig")
        if oilrig and oilrig:FindFirstChild("GuardsFolder") then
            for _, guard in next, oilrig.GuardsFolder:GetChildren() do
                if guard:IsA("Model") and guard:FindFirstChild("HumanoidRootPart") and guard:FindFirstChild("Humanoid") and guard.Humanoid.Health > 0 then
                    table.insert(npcs, {Character = guard, TargetPart = guard:FindFirstChild("Head") or guard.HumanoidRootPart})
                end
            end
        end
        for _, npc in next, npcs do
            if (lhrp.Position - npc.TargetPart.Position).Magnitude > maxRange then continue end
            local targetPoint, targetOnScreen = Camera:WorldToViewportPoint(npc.TargetPart.Position)
            if not targetOnScreen then continue end
            if not notInWall(npc.TargetPart.Position, {LocalPlayer.Character}, configs.combat.silentaim.wallcheck) then continue end
            
            local dist = (Vector2.new(targetPoint.X, targetPoint.Y) - Vector2.new(middlepos.X, middlepos.Y)).Magnitude
            if dist < configs.combat.silentaim.radius and dist < closestDist then
                closestDist = dist
                closestTarget = {Character = npc.Character, TargetPart = npc.TargetPart, IsNPC = true}
            end
        end
    end

    return closestTarget
end)
client.turretSilentAim = LPH_JIT(function(shootPos, shootDir)
    local nearest = nil
    local closestDist = configs.combat.silentaim.radius
    local middlepos = MainESP.TracerOrigins.Middle
    local Camera = workspace.CurrentCamera

    for _, enemy in pairs(players:GetPlayers()) do
        if enemy ~= players.LocalPlayer and enemy.Character then
            if client.isEnemies(players.LocalPlayer.Team, enemy.Team) then
                local enemyHRP = enemy.Character:FindFirstChild("HumanoidRootPart")
                local enemyHum = enemy.Character:FindFirstChild("Humanoid")
                if enemyHRP and enemyHum and enemyHum.Health > 0 then
                    if client.notInWall(enemyHRP.Position, {players.LocalPlayer.Character}, configs.combat.silentaim.wallcheck) then
                        local targetPoint, targetOnScreen = Camera:WorldToViewportPoint(enemyHRP.Position)
                        if targetOnScreen then
                            local dist = (Vector2.new(targetPoint.X, targetPoint.Y) - Vector2.new(middlepos.X, middlepos.Y)).Magnitude
                            if dist < closestDist then
                                closestDist = dist
                                nearest = enemyHRP
                            end
                        end
                    end
                end
            end
        end
    end

    if nearest then
        return (nearest.Position - shootPos).Unit
    end
    return shootDir
end)
client.itemturret.Shoot = LPH_JIT(function(self)
    if not self.Tips or #self.Tips == 0 then
        return client.ori.turretshoot(self)
    end

    local v1 = self.Tips[self.TipIndex]
    self.Tip = v1

    local shootPos = v1.Position
    local shootDir = v1.CFrame.lookVector

    if configs.combat.silentaim.includecarturret then
        shootDir = client.turretSilentAim(shootPos, shootDir)
    end

    self.BulletEmitter:Emit(shootPos, shootDir, self.Config.BulletSpeed)
    self.TipIndex = self.TipIndex % #self.Tips + 1

    if not self.Local then return end

    self.CrossHair.Spring:Accelerate(200)

    local CurrentCamera = workspace.CurrentCamera
    local v3 = math.clamp(20 / (self.Model.Back.Position - CurrentCamera.CFrame.p).Magnitude, 0.1, 1)
    self.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * v3 * 0.15 * 15)
end)
client.carturret.Shoot = LPH_JIT(function(self)
    self:_updateIgnoreList()
    local v9 = self.Tips[self.TipIndex]

    if not v9 then
        self:_getTips()
        return
    end

    self.Tip = v9

    local shootPos = v9.WorldPosition
    local shootDir = v9.WorldCFrame.LookVector

    if configs.combat.carturret.followmouse and configs.combat.silentaim.includecarturret then
        shootDir = client.turretSilentAim(shootPos, shootDir)
    end

    self.BulletEmitter:Emit(shootPos, shootDir, self.Config.BulletSpeed)
    self.TipIndex = self.TipIndex % #self.Tips + 1

    if not self.Local then return end

    local CurrentCamera = workspace.CurrentCamera
    local v3 = math.clamp(20 / (self.Model.PrimaryPart.Position - CurrentCamera.CFrame.p).Magnitude, 0.1, 1)
    self.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * v3 * 50)
end)
client.getPlayerVehicle = (function(plrname)
  local uh = nil
  for i, v in next, collectionservice:GetTagged("Vehicle") do
    for i2, v2 in next, v:GetChildren() do
      if v2.Name == "Seat" or v2.Name == "Passenger" then
        local whateverSeatName = v2:FindFirstChild("PlayerName")
        if whateverSeatName and whateverSeatName.Value == plrname then
          return uh
        end
      end
    end
  end
  return uh
end)
client.getNearestVehicle = (function()
  local char = players.LocalPlayer.Character
  local target, distance = nil, 100
  for i, v in next, collectionservice:GetTagged("Vehicle") do
    if v:FindFirstChild("Seat") or v:FindFirstChild("Passenger") then
      local targetDistance = (char:FindFirstChild("HumanoidRootPart").Position - v:GetModelCFrame().Position).magnitude
      if targetDistance < distance then
        distance = targetDistance
        target = v
      end
    end
  end
  return target
end)
client.getNearestPlayerNoCuffed = (function() 
    local maxdistance = 18
    local player = nil;
    for i,v in next, players:GetPlayers() do
        if tostring(v.Team) == "Criminal" then
            local character = v.Character or nil
            if character ~= nil and not v.Character:GetAttribute("Handcuffs") then
                local hrp = character:FindFirstChild("Head") or nil
                local hum = character:FindFirstChild("Humanoid") or nil
                if hrp ~= nil and hum ~= nil then
                    local mag = (players.LocalPlayer.Character:GetModelCFrame().Position - hrp.Position).magnitude
                    if mag < maxdistance then
                        player = v
                        if player ~= nil then
                            return player
                        end
                    end
                end
            end
        end
    end
	return false
end)
client.launchArrestAura = LPH_JIT(function()
    local getNearestPlayerNoCuffed = client.getNearestPlayerNoCuffed
    repeat
        task.wait(0.15)
        pcall(function()
            if tostring(players.LocalPlayer.Team) ~= "Police" then return end

            local char = players.LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart
            
            local plr = getNearestPlayerNoCuffed()
            if not plr or not plr.Character then return end
            
            for _, spec in ipairs(client.circleac.Specs) do
                if spec.Name == "Arrest" and spec.Enabled and spec.Part then
                    if spec.ValidRoot == plr.Character or spec.Part:IsDescendantOf(plr.Character) then
                        if (hrp.Position - spec.Part.Position).Magnitude <= (spec.Dist or 12) then
                            spec:Callback(true)
                            break
                        end
                    end
                end
            end
        end)
    until configs.player.arrestaura.enabled == false
end)

client.launchEjectAura = LPH_JIT(function()
    repeat
        task.wait(0.15)
        pcall(function()
            if tostring(players.LocalPlayer.Team) ~= "Police" then return end

            local char = players.LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart
            
            local vehicle = client.getNearestVehicle()
            if not vehicle then return end
            
            for _, spec in ipairs(client.circleac.Specs) do
                if spec.Name == "Eject" and spec.Enabled and spec.Part then
                    if spec.ValidRoot == vehicle or spec.Part:IsDescendantOf(vehicle) then
                        if (hrp.Position - spec.Part.Position).Magnitude <= 15 then
                            spec:Callback(true)
                            break
                        end
                    end
                end
            end
        end)
    until configs.player.ejectaura.enabled == false
end)

client.launchPickPocketAura = LPH_JIT(function()
    repeat
        task.wait(0.2)
        pcall(function()
            local lchar = players.LocalPlayer.Character
            if not lchar or not lchar:FindFirstChild("HumanoidRootPart") then return end
            local hrp = lchar.HumanoidRootPart
            if tostring(players.LocalPlayer.Team) ~= "Prisoner" and tostring(players.LocalPlayer.Team) ~= "Criminal" then return end

            for _, spec in pairs(client.circleac.Specs) do
                if spec.Name == "Pickpocket" and spec.Enabled and spec.Part then
                    if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                        spec:Callback(true)
                    end
                end
            end
        end)
    until not configs.player.pickpocketaura.enabled
end)

client.launchCrimSearchAura = LPH_JIT(function()
    repeat
        task.wait(0.2)
        pcall(function()
            local lchar = players.LocalPlayer.Character
            if not lchar or not lchar:FindFirstChild("HumanoidRootPart") then return end
            if tostring(players.LocalPlayer.Team) ~= "Police" then return end

            for _, spec in pairs(client.circleac.Specs) do
                if spec.Name == "Search" and spec.Enabled and spec.Part then
                    if (lchar.HumanoidRootPart.Position - spec.Part.Position).Magnitude <= 10 then
                        spec:Callback(true)
                    end
                end
            end
        end)
    until not configs.player.crimsearchaura.enabled
end)

client.launchBreakoutAura = LPH_JIT(function()
    repeat
        task.wait(20)
        pcall(function()
            if tostring(players.LocalPlayer.Team) == "Police" then return end

            local lchar = players.LocalPlayer.Character
            if not lchar or not lchar:FindFirstChild("HumanoidRootPart") then return end
            local hrp = lchar.HumanoidRootPart

            for _, spec in pairs(client.circleac.Specs) do
                if spec.Name == "Breakout" and spec.Enabled and spec.Part then
                    if (hrp.Position - spec.Part.Position).Magnitude <= 18 then
                        spec:Callback(true)
                    end
                end
            end
        end)
    until not configs.player.breakoutaura.enabled
end)
client.autoCollectCashLoop = LPH_JIT(function()
    repeat
        task.wait(0.1)
        local char = players.LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        local hrp = char.HumanoidRootPart
        
        for _, spec in ipairs(client.circleac.Specs) do
            if spec.Name and string.sub(spec.Name, 1, 8) == "Collect " and spec.Part and spec.Part.Parent then
                local dist = (hrp.Position - spec.Part.Position).Magnitude
                if dist <= configs.player.cashcollectrange then
                    pcall(function()
                        spec:Callback(true)
                    end)
                end
            end
        end
    until not configs.player.autocollectcash
end)
client.infinitejetpackfuel = LPH_JIT(function()
    repeat
        task.wait()
        if client.jetpackfuel then
            client.jetpackfuel.LocalFuel = client.jetpackfuel.LocalMaxFuel
        end
    until not configs.player.infjetpack
end)
client.fasterJetpack = function(a)
    local NEW_MAX_THRUST = 5000
    local NEW_ACCEL_RATE = 500
    local DRAG_MULTIPLIER = 0.05

    if a then
        if not client.jetpackHeartbeat then return end

        if not client.ori.jetpackIsFlying() then
            local waitCon
            waitCon = runservice.Heartbeat:Connect(function()
                if client.ori.jetpackIsFlying() then
                    waitCon:Disconnect()
                    client.fasterJetpack(true)
                end
            end)
            return
        end

        if not client.jetpackOrig then
            local accelTween = getupvalue(client.jetpackHeartbeat, 3)
            client.jetpackOrig = {
                _accel = accelTween._accel,
                _y1 = accelTween._y1,
                t = accelTween.t
            }

            accelTween._y1 = NEW_MAX_THRUST
            accelTween._accel = NEW_ACCEL_RATE
            accelTween.t = NEW_MAX_THRUST 

            local oldAbs = getupvalue(client.jetpackHeartbeat, 4)
            if type(oldAbs) == "function" then
                client.ori.jetpackAbs = oldAbs
                setupvalue(client.jetpackHeartbeat, 4, function(x)
                    return client.ori.jetpackAbs(x) * DRAG_MULTIPLIER
                end)
            end
        end
    else
        if client.jetpackHeartbeat and client.jetpackOrig then
            local accelTween = getupvalue(client.jetpackHeartbeat, 3)
            accelTween._accel = client.jetpackOrig._accel
            accelTween._y1 = client.jetpackOrig._y1
            accelTween.t = client.jetpackOrig.t
        end

        if client.ori.jetpackAbs and client.jetpackHeartbeat then
            setupvalue(client.jetpackHeartbeat, 4, client.ori.jetpackAbs)
            client.ori.jetpackAbs = nil
        end

        client.jetpackOrig = nil
    end
end
client.updateToOriginalChassisStats = (function()
  local gvp = require(replicatedstorage.Vehicle.VehicleUtils).GetLocalVehiclePacket()
  if gvp ~= nil and client.lastvehiclestats ~= nil and client.lastvehiclemodel ~= nil and gvp.Model ~= gvp.lastvehiclemodel then
    local stats = client.lastvehiclestats
    if configs.vehicle.engine == false then
      gvp.GarageEngineSpeed = stats.GarageEngineSpeed
    end
    if configs.vehicle.brake == false then
      gvp.GarageBrakes = stats.GarageBrakes
    end
    if configs.vehicle.suspension == false then
      gvp.Height = stats.Height
    end
    if configs.vehicle.turn == false then
      gvp.TurnSpeed = stats.TurnSpeed
    end
  end
end)

client.loadoutDropdowns = {}

client.applyLoadout = function()
    local inventoryItems = client.inventoryitemsystem.getInventoryItemsFor(players.LocalPlayer) or {}
    local itemMap = {}
    for _, item in ipairs(inventoryItems) do
        if item.obj then
            itemMap[item.obj.Name] = item
        end
    end
    for i = 1, 10 do
        local displayName = configs.combat.loadout.slots[i]
        local internalName = loadoutMap[displayName] or displayName
        if internalName and internalName ~= "None" and itemMap[internalName] then
            local ok = pcall(client.hotbarutils.setDisplayOrder, itemMap[internalName].obj, i)
            if not ok then
                pcall(client.hotbarutils.setDisplayOrder, itemMap[internalName], i)
            end
        end
    end
end

client.autoGrabLoadout = LPH_JIT(function()
    local EQUIP = "pj2nqo5o"
    local UNEQUIP = "fbyz92ak"
    local localPlayer = players.LocalPlayer

    local function getGunShopEquipFunc()
        for _, v in next, getgc(true) do
            if type(v) == "table" then
                local ok, fs = pcall(rawget, v, "FireServer")
                if ok and type(fs) == "function" then
                    return v, fs
                end
            end
        end
        return nil, nil
    end

    local function installLearner()
        local tbl, fn = getGunShopEquipFunc()
        if not tbl or not fn then return end
        local function has(name)
            local c = localPlayer.Character
            return c and c:FindFirstChild(name) ~= nil
        end
        local wrapped = function(self, ...)
            local a1, a2 = ...
            if type(a1) == "string" and type(a2) == "string" then
                local before = has(a2)
                task.defer(function()
                    task.wait(0.3)
                    local after = has(a2)
                    if not before and after then
                        EQUIP = a1
                    elseif before and not after then
                        UNEQUIP = a1
                    end
                end)
            end
            return fn(self, ...)
        end
        pcall(function() rawset(tbl, "FireServer", wrapped) end)
    end
    installLearner()

    local function getLoadoutGuns()
        local guns = {}
        local seen = {}
        for i = 1, 10 do
            local displayName = configs.combat.loadout.slots[i]
            if displayName and displayName ~= "None" then
                local internal = loadoutMap[displayName]
                if internal and not seen[internal] then
                    seen[internal] = true
                    table.insert(guns, internal)
                end
            end
        end
        return guns
    end

    local function isNearGunShop()
        local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return false end
        for _, part in ipairs(collectionservice:GetTagged("GunShopRegion")) do
            if part:IsA("BasePart") and (root.Position - part.Position).Magnitude <= 30 then
                return true
            end
        end
        return false
    end

    local function ownsGun(name)
        local items = localPlayer:FindFirstChild("Inventory") or localPlayer:FindFirstChild("Items")
        if not items then return false end
        return items:FindFirstChild(name) ~= nil
    end

    while configs.combat.loadout.autograb do
        task.wait(1)
        if not isNearGunShop() then continue end

        local eventTbl, fireServer = getGunShopEquipFunc()
        if not eventTbl or not fireServer then continue end

        for _, gunName in ipairs(getLoadoutGuns()) do
            if not configs.combat.loadout.autograb then break end
            if ownsGun(gunName) then
                pcall(function()
                    fireServer(eventTbl, EQUIP, gunName, nil)
                end)
                task.wait(0.1)
            end
        end
    end
end)

client.autoLoadoutLoop = LPH_JIT(function()
    repeat
        task.wait(0.5)
        client.applyLoadout()
    until not configs.combat.loadout.enabled
end)

client.autoDropUnselectedLoop = LPH_JIT(function()
    repeat
        task.wait(0.5)

        local selected = {}
        for i = 1, 10 do
            local displayName = configs.combat.loadout.slots[i]
            local internalName = loadoutMap[displayName] or displayName

            if internalName and internalName ~= "None" then
                selected[internalName] = true
            end
        end

        local ignoreDrop = {
            Bag = true,
            Crate = true,
            Gem = true,
            Taser = true,
            Handcuffs = true,
            RoadSpike = true,
            MansionInvite = true,
        }

        local inventoryItems = client.inventoryitemsystem.getInventoryItemsFor(players.LocalPlayer) or {}

        for _, item in ipairs(inventoryItems) do
            if item and item.obj then
                local name = item.obj.Name

                if not selected[name] and not ignoreDrop[name] then
                    pcall(function()
                        item:AttemptSetEquipped(true)
                        task.wait(0.1)
                        item:AttemptDrop()
                    end)
                end
            end
        end
    until not configs.combat.loadout.dropunselected
end)

client.getprisonelevator = (function()
  for i, v in next, workspace:GetChildren() do
    if v:IsA("Model") and v.Name == "Elevator" and v:FindFirstChild("Car") and v.Car:FindFirstChild("InnerModel") and v.Car.InnerModel:FindFirstChild("Calls") and v.Car.InnerModel.Calls[1]:FindFirstChild("SurfaceGui").TextLabel.Text == "1*" then
      return v
    end
  end
  return nil
end)

client.callprisonelevator = (function(flor)
  pcall(function()
    if client.getprisonelevator() ~= nil then
      fireclickdetector(client.getprisonelevator().Car.InnerModel.Calls[1].ClickDetector)
    end
  end)
end)

client.prisonelevatorloop = LPH_JIT(function()
  repeat
    task.wait(0.5)
    client.callprisonelevator(1)
  until configs.others.prisonelevator == false
end)

client.showgunstore = (function()
  setthreadcontext(2)
  client.gunshopui.open()
  setthreadcontext(10)
end)

client.grabAllOwnedGuns = function()
    local EQUIP = "pj2nqo5o"
    local localPlayer = players.LocalPlayer

    local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local nearShop = false
    for _, part in ipairs(collectionservice:GetTagged("GunShopRegion")) do
        if part:IsA("BasePart") and (root.Position - part.Position).Magnitude <= 30 then
            nearShop = true
            break
        end
    end
    if not nearShop then
        Library:Notify("Not near a gun shop!", 2)
        return
    end

    local eventTbl, fireServer = nil, nil
    for _, v in next, getgc(true) do
        if type(v) == "table" then
            local ok, fs = pcall(rawget, v, "FireServer")
            if ok and type(fs) == "function" then
                eventTbl, fireServer = v, fs
                break
            end
        end
    end
    if not eventTbl or not fireServer then
        Library:Notify("Equip remote not found!", 2)
        return
    end

    local gunShopConsts = require(replicatedstorage.Game.GunShop.GunShopConsts)
    local gunShopUtils = require(replicatedstorage.Game.GunShop.GunShopUtils)
    local items = localPlayer:FindFirstChild(gunShopConsts.ITEMS_VALUE_NAME)
    if not items then
        Library:Notify("No owned items found!", 2)
        return
    end

    local count = 0
    for _, data in ipairs(gunShopUtils.getAllData()) do
        local name = data.Name or data[1]
        if typeof(name) == "string" and items:FindFirstChild(name) then
            pcall(function()
                fireServer(eventTbl, EQUIP, name, nil)
            end)
            count = count + 1
            task.wait(0.05)
        end
    end

    Library:Notify("Grabbed " .. count .. " guns", 2)
end

local function applyToParts(parts, enable)
    for _, p in ipairs(parts) do
        if p:IsA("BasePart") then
            if enable then
                if p:GetAttribute("trans") == nil then
                    p:SetAttribute("trans", p.Transparency)
                end
                p.Transparency = 0.8
                p.CanTouch = false
            else
                local orig = p:GetAttribute("trans")
                if orig ~= nil then
                    p.Transparency = orig
                    p:SetAttribute("trans", nil)
                end
                p.CanTouch = true
            end
        end
    end
end

local function isLikelyLaser(part)
    if not part:IsA("BasePart") then return false end
    if part:FindFirstChild("TouchInterest") then return true end
    local name = part.Name:lower()
    if name:find("laser") or name:find("barbed") or name:find("wire") then return true end
    return false
end

local function getDescendantsOfClass(inst, class)
    local list = {}
    for _, d in ipairs(inst:GetDescendants()) do
        if d:IsA(class) then table.insert(list, d) end
    end
    return list
end

client.disableBankLasers = LPH_JIT(function(enabled)
    local Banks = workspace:FindFirstChild("Banks")
    if not Banks then return end
    local allLasers = {}
    for _, bank in ipairs(Banks:GetChildren()) do
        if bank:IsA("Model") and bank:FindFirstChild("Layout") then
            for _, layout in ipairs(bank.Layout:GetChildren()) do
                if layout:FindFirstChild("Lasers") then
                    for _, part in ipairs(getDescendantsOfClass(layout.Lasers, "BasePart")) do
                        if isLikelyLaser(part) then
                            table.insert(allLasers, part)
                        end
                    end
                end
            end
        end
    end
    applyToParts(allLasers, enabled)
end)

client.autoDynamiteLoop = LPH_JIT(function()
    local bankinit = getupvalue(require(replicatedstorage.Game.Robbery.RobberyBank.RobberyBank).Init, 1)
    local key = client.getBankDynamiteKey()

    repeat
        task.wait(0.1)
        for _, part in next, collectionservice:GetTagged("BankDoorEscapeRoute") do
            if part:GetAttribute("Open") == nil then
                pcall(function()
                    bankinit:FireServer(key, part)
                end)
            end
        end
    until configs.robbery.bank.autodynamite == false
end)

client.disableJewelryLasers = LPH_JIT(function(enabled)
    local Jewelrys = workspace:FindFirstChild("Jewelrys")
    if not Jewelrys then return end
    local allLasers = {}
    local Jewelry = Jewelrys:FindFirstChild("Jewelry")
    if not Jewelry then return end
    local Floors = Jewelry:FindFirstChild("Floors")
    if Floors and Floors:FindFirstChild("Model") then
        local Model = Floors.Model
        local Lasers = Model:FindFirstChild("Lasers")
        if Lasers then
            for _, laser in ipairs(Lasers:GetChildren()) do
                if laser.Name == "Laser" and laser:FindFirstChild("InnerModel") then
                    for _, part in ipairs(laser.InnerModel:GetChildren()) do
                        if isLikelyLaser(part) then table.insert(allLasers, part) end
                    end
                end
            end
        end
        local InteractiveButtonLasers = Model:FindFirstChild("InteractiveButtonLasers")
        if InteractiveButtonLasers then
            for _, laserFloor in ipairs(InteractiveButtonLasers:GetChildren()) do
                if laserFloor.Name == "LaserFloor" then
                    for _, child in ipairs(laserFloor:GetChildren()) do
                        if isLikelyLaser(child) then table.insert(allLasers, child) end
                    end
                end
            end
        end
        for _, part in ipairs(Model:GetChildren()) do
            if isLikelyLaser(part) then
                local r = math.floor(part.Color.R * 255 + 0.5)
                local g = math.floor(part.Color.G * 255 + 0.5)
                local b = math.floor(part.Color.B * 255 + 0.5)
                if (r == 255 and g == 63 and b == 84) or (r == 171 and g == 89 and b == 72) then
                    table.insert(allLasers, part)
                end
            end
        end
    end

    local TARGET_NAME = "BarbedWire"
    local POSITION_TOLERANCE = 0.5
    local targetCFrames = {
        CFrame.new(123.227493, 16.2156315, 1307.91064, -0.984813809, 8.60951559e-08, -0.173613802, 7.22449727e-08, 1, 8.60951559e-08, 0.173613802, 7.22449727e-08, -0.984813809),
        CFrame.new(125.946198, -2.58436966, 1294.53528, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617),
        CFrame.new(131.763382, -2.58436966, 1327.526, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617),
        CFrame.new(125.573204, 16.2156315, 1331.86755, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617)
    }
    for _, descendant in ipairs(Jewelrys:GetDescendants()) do
        if isLikelyLaser(descendant) and descendant.Name == TARGET_NAME then
            for _, targetCFrame in ipairs(targetCFrames) do
                if (descendant.Position - targetCFrame.Position).Magnitude <= POSITION_TOLERANCE then
                    table.insert(allLasers, descendant)
                    break
                end
            end
        end
    end

    applyToParts(allLasers, enabled)
end)

client.autoJewelryGrabLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.jewelry.autograb do
            task.wait(1)
            pcall(function()
                local char = players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                for _, spec in ipairs(client.circleac.Specs) do
                    if spec.Name == "Grab Jewel" and spec.Enabled and spec.Part then
                        if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                            spec:Callback(true)
                        end
                    end
                end
            end)
        end
    end)
end)

client.doorlocktargets = {
    { name = "SwingDoor1", z = 19, origZ = 1.3000003099441528 },
    { name = "SwingDoor2", z = 10, origZ = 1.3000003099441528 },
    { name = "SwingDoor3", z = 10, origZ = 1.3000001907348633 },
}

client.setdoorlocksizes = LPH_JIT(function(modified)
    local doors = workspace:FindFirstChild("Jewelrys") and workspace.Jewelrys:FindFirstChild("Jewelry") and workspace.Jewelrys.Jewelry:FindFirstChild("Doors")
    if not doors then return end
    for _, data in ipairs(client.doorlocktargets) do
        local door = doors:FindFirstChild(data.name)
        if door then
            local touch = door:FindFirstChild("Touch")
            if touch and touch:IsA("BasePart") then
                touch.Size = Vector3.new(4.099999904632568, 7.299999713897705, modified and data.z or data.origZ)
            end
        end
    end
end)

client.antiJewelryDoorLock = function(enabled)
    if enabled then
        if client.doorlockloop then return end
        client.doorlockloop = true
        task.spawn(function()
            while configs.robbery.jewelry.antidoorlock do
                task.wait(0.1)
                client.setdoorlocksizes(true)
            end
            client.doorlockloop = false
            client.setdoorlocksizes(false)
        end)
    else
        client.setdoorlocksizes(false)
    end
end

client.disableMuseumLasers = LPH_JIT(function(enabled)
    local Museum = workspace:FindFirstChild("Museum")
    if not Museum then return end
    local Lights = Museum:FindFirstChild("Lights")
    if not Lights then return end
    local allLasers = {}
    for _, spotlightModel in ipairs(Lights:GetChildren()) do
        if spotlightModel.Name == "Spotlight" and spotlightModel:IsA("Model") then
            local lightPart = spotlightModel:FindFirstChild("Light")
            if lightPart and isLikelyLaser(lightPart) then table.insert(allLasers, lightPart) end
        end
    end
    applyToParts(allLasers, enabled)
end)

client.disableCasinoLasers = LPH_JIT(function(enabled)
    local Casino = workspace:FindFirstChild("Casino")
    if not Casino then return end
    local allLasers = {}
    local carousel = Casino:FindFirstChild("LaserCarousel")
    if carousel and carousel:FindFirstChild("InnerModel") then
        for _, p in ipairs(getDescendantsOfClass(carousel.InnerModel, "BasePart")) do
            if isLikelyLaser(p) then table.insert(allLasers, p) end
        end
    end
    local lasers = Casino:FindFirstChild("Lasers")
    if lasers then
        for _, p in ipairs(getDescendantsOfClass(lasers, "BasePart")) do
            if isLikelyLaser(p) then table.insert(allLasers, p) end
        end
    end
    for _, folder in ipairs({ Casino:FindFirstChild("CamerasMoving"), Casino:FindFirstChild("LasersMoving") }) do
        if folder then
            for _, child in ipairs(folder:GetChildren()) do
                local im = child:FindFirstChild("InnerModel")
                if im then
                    local part = im:FindFirstChild("Part")
                    if part and isLikelyLaser(part) then table.insert(allLasers, part) end
                end
            end
        end
    end
    local vaultLaserControl = Casino:FindFirstChild("VaultLaserControl")
    if vaultLaserControl then
        for _, laser in ipairs(vaultLaserControl:GetChildren()) do
            if laser.Name == "Laser" and laser:FindFirstChild("InnerModel") then
                for _, part in ipairs(laser.InnerModel:GetChildren()) do
                    if isLikelyLaser(part) then table.insert(allLasers, part) end
                end
            end
        end
        for _, part in ipairs(vaultLaserControl:GetChildren()) do
            if isLikelyLaser(part) and part.Name == "Part" then table.insert(allLasers, part) end
        end
    end
    applyToParts(allLasers, enabled)
end)

client.autoMuseumDynamiteLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.museum.autodynamite do
            task.wait(0.1)
            pcall(function()
                local char = players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                for _, spec in ipairs(client.circleac.Specs) do
                    if spec.Name == "Place Dynamite" and spec.Enabled and spec.Part then
                        if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                            spec:Callback(true)
                            task.wait(1)
                            break
                        end
                    end
                end
            end)
        end
    end)
end)

client.autoMuseumGrabLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.museum.autograb do
            task.wait(0.1)
            pcall(function()
                local char = players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                for _, spec in ipairs(client.circleac.Specs) do
                    if spec.Name and spec.Name:find("Grab ") and spec.Enabled and spec.Part then
                        if collectionservice:HasTag(spec.Part, "Museum_Item") then
                            if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                                spec:Callback(true)
                                task.wait(2)
                                break
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

client.autoSolveMuseumPuzzleLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.museum.autosolvepuzzle do
            task.wait(0.2)
            pcall(function()
                local museum = workspace:FindFirstChild("Museum")
                if not museum then return end

                local puzzle1 = museum:FindFirstChild("Puzzle1")
                if puzzle1 then
                    local spinners = puzzle1:FindFirstChild("Spinners")
                    local connections = puzzle1:FindFirstChild("Connections")
                    if spinners and connections then
                        for _, spinner in ipairs(spinners:GetChildren()) do
                            local conn = connections:FindFirstChild(spinner.Name)
                            if conn and conn.Color == Color3.fromRGB(89, 144, 255) then
                                local cd = spinner:FindFirstChild("ClickDetector")
                                if cd then 
                                    fireclickdetector(cd)
                                end
                            end
                        end
                    end
                end

                local puzzle2 = museum:FindFirstChild("Puzzle2")
                if puzzle2 then
                    local pieces = puzzle2:FindFirstChild("Pieces")
                    if pieces then
                        local targetOrientations = {
                            ["2"] = Vector3.new(0, -38, 0),
                            ["3"] = Vector3.new(0, -38, 0),
                            ["10"] = Vector3.new(0, -38, 180),
                            ["11"] = Vector3.new(0, -38, 180),
                            ["12"] = Vector3.new(0, -38, 0),
                            ["13"] = Vector3.new(0, -38, 90),
                            ["14"] = Vector3.new(0, -38, 0),
                            ["19"] = Vector3.new(0, -38, 180),
                            ["20"] = Vector3.new(0, -38, -90)
                        }
                        
                        for name, targetOri in pairs(targetOrientations) do
                            local piece = pieces:FindFirstChild(name)
                            if piece then
                                local diff = piece.Orientation - targetOri
                                local isAligned = math.abs(diff.X) < 1 and math.abs(diff.Y) < 1 and math.abs(diff.Z) < 1
                                
                                if not isAligned then
                                    local cd = piece:FindFirstChild("ClickDetector")
                                    if cd then 
                                        fireclickdetector(cd)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end)
client.getcasinoelevator = (function()
  local Casino = workspace:FindFirstChild("Casino")
  if not Casino then return nil end
  local Elevator = Casino:FindFirstChild("Elevator")
  if not Elevator or not Elevator:FindFirstChild("Car") then return nil end
  return Elevator
end)
client.callcasinoelevator = (function(floor)
  pcall(function()
    local elevator = client.getcasinoelevator()
    if elevator and elevator.Car and elevator.Car.InnerModel and elevator.Car.InnerModel.Calls then
      local callButton = elevator.Car.InnerModel.Calls[tostring(floor)]
      if callButton and callButton:FindFirstChild("ClickDetector") then
        fireclickdetector(callButton.ClickDetector)
      end
    end
  end)
end)
client.casinoelevatorloop = LPH_JIT(function()
  repeat
    task.wait(0.1)
    local elevator = client.getcasinoelevator()
    if elevator and elevator.Car and elevator.Car.InnerModel and elevator.Car.InnerModel.Calls then
      local callButton = elevator.Car.InnerModel.Calls["4"]
      if callButton and callButton:FindFirstChild("ClickDetector") then
        fireclickdetector(callButton.ClickDetector)
      end
    end
  until configs.others.breakelevator == false
end)

client.fixCasinoComputerLoop = LPH_JIT(function()
    repeat
        task.wait(0.1)
        local char = players.LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        local hrp = char.HumanoidRootPart

        for _, spec in pairs(client.circleac.Specs) do
            if (spec.Name == "Hack" or spec.Name == "Disable Vault Security") and spec.Enabled and spec.Part then
                if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                    spec:Callback(true)
                    break
                end
            end
        end
    until not configs.robbery.casino.fixcomputer
end)

client.autoCollectCasinoCash = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.casino.autocollectcash do
            task.wait(1)
            if tostring(players.LocalPlayer.Team) == "Police" then continue end
            local char = players.LocalPlayer.Character
            if not char or not char.PrimaryPart then continue end
            local hrp = char.PrimaryPart
            local casino = workspace:FindFirstChild("Casino")
            if not casino or not casino.Loots then continue end

            local inRange = false
            for _, loot in ipairs(casino.Loots:GetChildren()) do
                if (hrp.Position - loot.Position).Magnitude <= 20 then
                    inRange = true
                    break
                end
            end

            if inRange then
                for _, spec in ipairs(client.circleac.Specs) do
                    if spec.Name and spec.Name:find("Collect") then
                        spec:Callback(true)
                    end
                end
            end
        end
    end)
end)

client.casinokeycode = function()
    local casino = workspace:FindFirstChild("Casino")
    if not casino then return "Waiting for Casino..." end
    local codes = casino:FindFirstChild("RobberyDoor") and casino.RobberyDoor:FindFirstChild("Codes")
    if not codes then return "Loading codes..." end
    
    local parts = {}
    for _, v in ipairs(codes:GetDescendants()) do
        if v:IsA("TextLabel") and #v.Text > 0 then
            table.insert(parts, { text = v.Text, pos = v.Parent.Parent.Position.Z })
        end
    end
    
    table.sort(parts, function(a, b) return a.pos > b.pos end)
    local code = ""
    for _, v in ipairs(parts) do code = code .. v.text end
    return #code > 0 and code or "Searching..."
end
client.nearcasinodoor = function()
    local char = players.LocalPlayer.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    local casino = workspace:FindFirstChild("Casino")
    if not casino then return false end
    for _, v in next, casino.RobberyDoor:GetDescendants() do
        if v.Name == "Region" and (v.Position - root.Position).Magnitude < 15 then
            return true
        end
    end
    return false
end
client.autocasinodoor = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.casino.autodoor do
            task.wait(configs.robbery.casino.doorcooldown)
            pcall(function()
                if not client.nearcasinodoor() then return end
                local code = client.casinokeycode()
                if code == "" or code:find("Searching") or code:find("Waiting") then return end
                local pad = collectionservice:GetTagged("CasinoKeypadPrompt")[1]
                if not pad then return end
                local submit = pad:FindFirstChild("CasinoKeypadSubmit")
                if not submit then return end
                submit:FireServer(code)
                submit:FireServer(code:reverse())
            end)
        end
    end)
end)
client.autocrackvault = LPH_JIT(function()
    if client.autocrackvaultThread then
        task.cancel(client.autocrackvaultThread)
        client.autocrackvaultThread = nil
    end

    client.autocrackvaultThread = task.spawn(function()
        local localPlayer = players.LocalPlayer
        while configs.robbery.casino.autovault do
            task.wait(0.05)

            if tostring(localPlayer.Team) ~= "Criminal" then continue end

            local char = localPlayer.Character
            local root = char and char.PrimaryPart
            if not root then continue end

            for _, puzzle in ipairs(collectionservice:GetTagged("VaultDoorPuzzle")) do
                local part = puzzle.PrimaryPart or puzzle:FindFirstChild("Part")

                if part and (root.Position - part.Position).Magnitude <= 10 then
                    local spec = nil
                    for _, s in pairs(client.circleac.Specs) do
                        if s.Part == part then
                            spec = s
                            break
                        end
                    end
                    if not spec then continue end

                    local hackerId = puzzle:GetAttribute("VaultHackerId")

                    if hackerId == nil then
                        spec:Callback(true)
                        task.wait(0.3)
                    end

                    if hackerId == localPlayer.UserId then
                        local callback = spec.Callback
                        if callback then
                            local upvalues = getupvalues(callback)
                            local arg2 = upvalues.arg2 or upvalues[2]

                            if type(arg2) == "table" and arg2.requestHackRemote and arg2.updateDirectionRemote then
                                local model = puzzle.Parent and puzzle.Parent:FindFirstChild("Model")
                                local shouldChangeDirection = false

                                if model then
                                    local lightPart = model:FindFirstChild("UnlockedLED")
                                    if lightPart and lightPart.BrickColor.Name == "Sand violet metallic" then
                                        shouldChangeDirection = true
                                    end

                                    if not shouldChangeDirection then
                                        for _, child in ipairs(model:GetChildren()) do
                                            if child:IsA("BasePart") and child.BrickColor.Name == "Sand violet metallic" then
                                                shouldChangeDirection = true
                                                break
                                            end
                                        end
                                    end
                                end

                                if shouldChangeDirection and spec.Name == "Change Direction" then
                                    arg2.updateDirectionRemote:FireServer()
                                    task.wait(0.5)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)
client.disableOilRigLasers = LPH_JIT(function(enabled)
    local oilRig = workspace:FindFirstChild("OilRig")
    if not oilRig then return end
    local allLasers = {}
    local movingLasers = oilRig:FindFirstChild("MovingLasers")
    if movingLasers then
        for _, laser in ipairs(movingLasers:GetChildren()) do
            if laser.Name == "Laser" and laser:FindFirstChild("InnerModel") then
                local part = laser.InnerModel:FindFirstChild("Part")
                if part and isLikelyLaser(part) then table.insert(allLasers, part) end
            end
        end
    end
    applyToParts(allLasers, enabled)
end)

client.autoOilRigKeycardLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.oilrig.autokeycard do
            task.wait(0.1)
            pcall(function()
                local oilRig = workspace:FindFirstChild("OilRig")
                if not oilRig then return end
                local keyCardTable = oilRig:FindFirstChild("KeyCardTable")
                if not keyCardTable then return end
                local keyCardGiver = keyCardTable:FindFirstChild("KeyCardGiver")
                if not keyCardGiver then return end

                local char = players.LocalPlayer.Character
                if not char or not char.PrimaryPart then return end
                local hrp = char.PrimaryPart

                if (hrp.Position - keyCardGiver.Position).Magnitude <= 20 then
                    local localPlayer = players.LocalPlayer
                    local hasKey = localPlayer:FindFirstChild("Folder") and localPlayer.Folder:FindFirstChild("Key")
                    
                    if not hasKey then
                        local remote = keyCardGiver:FindFirstChild("OnPressedRemote")
                        if remote then remote:FireServer(true) end
                    end
                end
            end)
        end
    end)
end)

client.disableTombPlanks = LPH_JIT(function(enabled)
    local tomb = workspace:FindFirstChild("RobberyTomb")
    if not tomb or not tomb:FindFirstChild("Cart") then return end
    local planks = tomb.Cart:FindFirstChild("Planks")
    if not planks then return end
    local allPlanks = {}
    for _, child in ipairs(planks:GetChildren()) do
        if child.Name == "Wood" and child:IsA("BasePart") then table.insert(allPlanks, child) end
    end
    applyToParts(allPlanks, enabled)
end)

client.disableTombSpikes = LPH_JIT(function(enabled)
    local tomb = workspace:FindFirstChild("RobberyTomb")
    if not tomb or not tomb:FindFirstChild("SpikeRoom") then return end
    local spikes = tomb.SpikeRoom:FindFirstChild("Spikes")
    if not spikes then return end
    local spikeParts = {}
    local doorParts = {}
    for i = 1, 11 do
        local spike = spikes:FindFirstChild(tostring(i))
        if spike then
            for _, tile in ipairs(spike:GetChildren()) do
                if tile.Name == "Tile" and tile:IsA("Model") and tile:FindFirstChild("Model") then
                    local innerModel = tile.Model:FindFirstChild("InnerModel")
                    if innerModel then
                        local spikePart = innerModel:FindFirstChild("Spikes")
                        if spikePart and spikePart:IsA("BasePart") then
                            table.insert(spikeParts, spikePart)
                        end
                        local door = innerModel:FindFirstChild("Door")
                        if door and door:IsA("BasePart") then
                            table.insert(doorParts, door)
                        end
                    end
                end
            end
        end
    end
    applyToParts(spikeParts, enabled)
    for _, door in ipairs(doorParts) do
        door.CanTouch = not enabled
    end
end)

client.disabledarts = function(enabled)
    client.disabletombdarts = enabled
    
    if enabled then
        if not client.ori.dartfire then
            client.ori.dartfire = client.dartdispenser._fire
        end
        client.dartdispenser._fire = newcclosure(function(...)
            return task.wait(9e9)
        end)
    else
        if client.ori.dartfire then
            client.dartdispenser._fire = client.ori.dartfire
            client.ori.dartfire = nil
        end
    end
end

client.disableTombBridgeBreak = LPH_JIT(function(enabled)
    local tomb = workspace:FindFirstChild("RobberyTomb")
    if not tomb then return end
    local bridge = tomb:FindFirstChild("Bridge")
    if not bridge then return end
    
    for _, plankModel in ipairs(bridge:GetChildren()) do
        if plankModel.Name == "Plank" and plankModel:IsA("Model") then
            local innerModel = plankModel:FindFirstChild("InnerModel")
            if innerModel then
                local plankPart = innerModel:FindFirstChild("Plank")
                if plankPart and plankPart:IsA("BasePart") then
                    if enabled then
                        if plankPart:GetAttribute("Rendex_OrigCanTouch") == nil then
                            plankPart:SetAttribute("Rendex_OrigCanTouch", plankPart.CanTouch)
                        end
                        plankPart.CanTouch = false
                    else
                        local origTouch = plankPart:GetAttribute("Rendex_OrigCanTouch")
                        if origTouch ~= nil then
                            plankPart.CanTouch = origTouch
                            plankPart:SetAttribute("Rendex_OrigCanTouch", nil)
                        end
                    end
                end
            end
        end
    end
end)

client.disableTombLava = LPH_JIT(function(enabled)
    local parts = {}

    local tomb = workspace:FindFirstChild("RobberyTomb")
    if tomb then
        local killFolder = tomb:FindFirstChild("Kill")
        if killFolder then
            for _, part in ipairs(killFolder:GetChildren()) do
                if part.Name == "LavaKill" and part:IsA("BasePart") then
                    table.insert(parts, part)
                end
            end
        end
    end

    local tombRocks = workspace:FindFirstChild("TombRocks2")
    if tombRocks then
        for _, child in ipairs(tombRocks:GetChildren()) do
            if child.Name == "BarbedWire" and child:IsA("BasePart") then
                table.insert(parts, child)
            end
        end
    end

    for _, part in ipairs(parts) do
        if enabled then
            if part:GetAttribute("Rendex_OrigCanTouch") == nil then
                part:SetAttribute("Rendex_OrigCanTouch", part.CanTouch)
            end
            part.CanTouch = false
        else
            local orig = part:GetAttribute("Rendex_OrigCanTouch")
            if orig ~= nil then
                part.CanTouch = orig
                part:SetAttribute("Rendex_OrigCanTouch", nil)
            end
        end
    end
end)

client.autoTombDuckLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.tomb.autoduck do
            task.wait(0.1)
            pcall(function()
                local char = players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                for _, spec in ipairs(client.circleac.Specs) do
                    if spec.Name == "Duck" and spec.Enabled and spec.Part then
                        if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                            spec:Callback(true)
                        end
                    end
                end
            end)
        end
    end)
end)

client.autoSitTomb = LPH_JIT(function()
    repeat
        task.wait(0.1)
        local char = players.LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        local hrp = char.HumanoidRootPart

        local npc = workspace:FindFirstChild("NPC_Collector")
        if not npc then continue end
        local collector = npc:FindFirstChild("Collector")
        if not collector then continue end
        local npcPart = collector:FindFirstChild("UpperTorso")
        if not npcPart or (hrp.Position - npcPart.Position).Magnitude > 20 then continue end

        for _, spec in pairs(client.circleac.Specs) do
            if spec.Name == "Sit" and spec.Enabled and spec.Part then
                if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                    spec:Callback(true)
                    break
                end
            end
        end
    until not configs.robbery.tomb.autosit
end)

client.disableMansionLasers = LPH_JIT(function(enabled)
    local matchedParts = {}

    local mansionDetails = workspace:FindFirstChild("MansionDetails")
    if mansionDetails then
        local interior = mansionDetails:FindFirstChild("Mansion_Interior")
        if interior then
            for _, part in ipairs(interior:GetChildren()) do
                if part.Name == "BarbedWire" and part:IsA("BasePart") then
                    table.insert(matchedParts, part)
                end
            end
        end
    end

    local MansionRobbery = workspace:FindFirstChild("MansionRobbery")
    if MansionRobbery then
        local lasersParent = MansionRobbery:FindFirstChild("Lasers")
        if lasersParent then
            for i = 1, 7 do
                local doorNumber = lasersParent:FindFirstChild(tostring(i))
                if doorNumber then
                    local innerModel = doorNumber:FindFirstChild("Door") and doorNumber.Door:FindFirstChild("InnerModel")
                    if innerModel then
                        local laserPart = innerModel:FindFirstChild("Laser")
                        if laserPart and laserPart:IsA("BasePart") then
                            table.insert(matchedParts, laserPart)
                        end
                    end
                end
            end
        end
    end

    applyToParts(matchedParts, enabled)
end)

client.disableMansionTraps = LPH_JIT(function(enabled)
    local MansionRobbery = workspace:FindFirstChild("MansionRobbery")
    if not MansionRobbery then return end
    local LaserTraps = MansionRobbery:FindFirstChild("LaserTraps")
    if not LaserTraps then return end
    local allParts = {}
    for _, trapModel in ipairs(LaserTraps:GetChildren()) do
        if trapModel.Name == "Trap" and trapModel:IsA("Model") then
            local trapLasers = trapModel:FindFirstChild("Lasers")
            if trapLasers then
                for _, part in ipairs(trapLasers:GetChildren()) do
                    if part.Name == "Part" and part:IsA("BasePart") then table.insert(allParts, part) end
                end
            end
            local trapButtons = trapModel:FindFirstChild("Buttons")
            if trapButtons then
                for _, btnModel in ipairs(trapButtons:GetChildren()) do
                    if btnModel.Name == "TrapButton" and btnModel:IsA("Model") then
                        local touchPart = btnModel:FindFirstChild("InnerModel") and btnModel.InnerModel:FindFirstChild("Touch")
                        if touchPart and touchPart:IsA("BasePart") then table.insert(allParts, touchPart) end
                    end
                end
            end
        end
    end
    applyToParts(allParts, enabled)
end)

client.mansionBanditTargetBoss = function()
    task.spawn(function()
        while configs.robbery.mansion.bandittargetboss do
            task.wait(0.5)
            local mansion = workspace:FindFirstChild("MansionRobbery")
            if not mansion then continue end
            local boss = mansion:FindFirstChild("ActiveBoss")
            if not boss then continue end
            local bossHead = boss:FindFirstChild("Head")
            if not bossHead then continue end
            local guardsFolder = mansion:FindFirstChild("GuardsFolder")
            if not guardsFolder then continue end
            for _, guard in next, guardsFolder:GetChildren() do
                if guard:IsA("Model") then
                    local destObj = guard:FindFirstChild("NPCDestObj")
                    if destObj and destObj:IsA("ObjectValue") then
                        destObj.Value = bossHead
                    end
                end
            end
        end
    end)
end

client.autoEnterElevator = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.mansion.autoelevator do
            task.wait(0.1)
            pcall(function()
                local mansion = workspace:FindFirstChild("MansionRobbery")
                if not mansion then return end
                local elevatorTouch = mansion:FindFirstChild("Lobby") and mansion.Lobby:FindFirstChild("EntranceElevator") and mansion.Lobby.EntranceElevator:FindFirstChild("TouchToEnter")
                if not elevatorTouch then return end

                local char = players.LocalPlayer.Character
                if not char or not char.PrimaryPart then return end
                local hrp = char.PrimaryPart
                
                local dist = (hrp.Position - Vector3.new(1274, 67, -4826)).Magnitude
                if dist < 15 then
                    firetouchinterest(elevatorTouch, hrp, 0)
                    firetouchinterest(elevatorTouch, hrp, 1)
                end
            end)
        end
    end)
end)

client.getinvites = function()
    local ok, count = pcall(function()
        return tonumber(string.match(workspace.MansionRobbery.InviteCount.SurfaceGui.TextLabel.Text, "%d+")) or 0
    end)
    return ok and count or 0
end

client.disablePowerPlantLasers = LPH_JIT(function(enabled)
    local powerPlant = workspace:FindFirstChild("PowerPlant")
    if not powerPlant then return end
    
    local matchedParts = {}
    
    local interior = powerPlant:FindFirstChild("Cosmetic") and powerPlant.Cosmetic:FindFirstChild("Interior")
    if interior then
        for _, part in ipairs(interior:GetDescendants()) do
            if part.Name == "BarbedWire" and part:IsA("BasePart") then
                table.insert(matchedParts, part)
            end
        end
    end
    
    local core = powerPlant:FindFirstChild("Core")
    if core then
        for _, part in ipairs(core:GetDescendants()) do
            if part.Name == "BarbedWire" and part:IsA("BasePart") then
                table.insert(matchedParts, part)
            end
        end
    end
    
    local TARGET_NAME = "BarbedWire"
    local POSITION_TOLERANCE = 0.05
    local QUERY_SIZE = Vector3.new(30, 30, 30)
    
    local targetCFrames = {
        CFrame.new(480.421936, -38.7353859, 2534.55933, -0.707068563, 0, -0.707145572, 0, 1, 0, 0.707145572, 0, -0.707068563),
        CFrame.new(559.355469, -0.356123805, 2504.10498, -0.777842402, 0.491372347, -0.391809136, -0.100149617, -0.712393165, -0.694597721, -0.620428324, -0.501047969, 0.603340387),
        CFrame.new(565.086975, -20.8353748, 2471.89624, 0.469555795, -0, -0.88290292, 0, 1, -0, 0.88290292, 0, 0.469555795),
        CFrame.new(604.553284, -30.2353745, 2450.90845, 0.469555795, -0, -0.88290292, 0, 1, -0, 0.88290292, 0, 0.469555795)
    }
    
    local queryParams = OverlapParams.new()
    queryParams.MaxParts = 500
    
    for _, targetCFrame in ipairs(targetCFrames) do
        local partsInBox = workspace:GetPartBoundsInBox(targetCFrame, QUERY_SIZE, queryParams)
        for _, part in ipairs(partsInBox) do
            if part.Name == TARGET_NAME and part:IsA("BasePart") then
                if (part.Position - targetCFrame.Position).Magnitude <= POSITION_TOLERANCE then
                    table.insert(matchedParts, part)
                    break
                end
            end
        end
    end
    
    applyToParts(matchedParts, enabled)
end)

client.disablePowerPlantPistons = LPH_JIT(function(enabled)
    local powerPlant = workspace:FindFirstChild("PowerPlant")
    if not powerPlant then return end
    for _, child in ipairs(powerPlant:GetChildren()) do
        if child.Name == "Piston" and child:IsA("Model") then
            for _, p in ipairs(child:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "PistonOrigin" then
                    if enabled then
                        if p:GetAttribute("trans") == nil then
                            p:SetAttribute("trans", p.Transparency)
                        end
                        p.Transparency = 0.8
                        p.CanTouch = false
                    else
                        local orig = p:GetAttribute("trans")
                        if orig ~= nil then
                            p.Transparency = orig
                            p:SetAttribute("trans", nil)
                        end
                        p.CanTouch = true
                    end
                end
            end
        end
    end
end)

client.autosolvepuzzle = function()
    local ui = getupvalue(client.puzzleflow.Init, 3)

    if not ui.IsOpen or not ui.Grid then
        return
    end

    local inputGrid = {}
    for i, row in ipairs(ui.Grid) do
        inputGrid[i] = {}
        for j, val in ipairs(row) do
            inputGrid[i][j] = val + 1
        end
    end

    for i, row in ipairs(solved) do
        for j, val in ipairs(row) do
            ui.Grid[i][j] = val - 1
        end
    end

    ui.OnConnection()
end

client.autoCargoTrainBreachLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.cargotrain.autobreach do
            task.wait(0.1)
            pcall(function()
                local char = players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                for _, spec in ipairs(client.circleac.Specs) do
                    if spec.Name == "Breach Vault" and spec.Enabled and spec.Part then
                        if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                            spec:Callback(true)
                        end
                    end
                end
            end)
        end
    end)
end)
client.autoPassengerGrabLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.robbery.passengertrain.autograb do
            task.wait(0.1)
            pcall(function()
                local char = players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                for _, spec in ipairs(client.circleac.Specs) do
                    if spec.Name and spec.Name:lower():find("grab") and spec.Enabled and spec.Part then
                        if (hrp.Position - spec.Part.Position).Magnitude <= 10 then
                            spec:Callback(true)
                            task.wait(0.7)
                            break
                        end
                    end
                end
            end)
        end
    end)
end)
client.disablemilitaryturret = function(a)
  if a then
    client.militaryturretconst.FIRE_RATE = math.huge
  else
    client.militaryturretconst.FIRE_RATE = 1
  end
end
client.disablemilitaryforcefield = function(a)    
    for _, part in ipairs(collectionservice:GetTagged("MilitaryForcefield")) do
        part:SetAttribute("Disabled", a)
    end
    
    if a and not client.militaryforcefieldcon then
        client.militaryforcefieldcon = collectionservice:GetInstanceAddedSignal("MilitaryForcefield"):Connect(function(part)
            if configs.others.disablemilitaryforcefield then
                part:SetAttribute("Disabled", true)
            end
        end)
    elseif not a and client.militaryforcefieldcon then
        client.militaryforcefieldcon:Disconnect()
        client.militaryforcefieldcon = nil
    end
end
client.dropall = (function()
  for i, v in next, client.inventoryitemsystem.getInventoryItemsFor(players.LocalPlayer) do
    local ignore = { "Bag", "Crate", "Gem", "Taser", "Handcuffs", "RoadSpike", "MansionInvite" }
    if not table.find(ignore, v.obj.Name) then
      v:AttemptSetEquipped(true)
      v:AttemptDrop()
    end
  end
end)

client.antilockeditems = function(a)
    if a then
        client.inventoryitemutils.getLocked = function() return false end
        client.inventoryitemutils.setLocked = function() end
        
        if not client.antilocked then
            client.antilocked = runservice.Heartbeat:Connect(function()
                if not configs.player.antilocked then
                    client.antilocked:Disconnect()
                    client.antilocked = nil
                    return
                end
                for _, item in ipairs(collectionservice:GetTagged(client.inventoryitemconsts.TAG_NAME)) do
                    if item:IsDescendantOf(players.LocalPlayer) and item:GetAttribute(client.inventoryitemconsts.LOCKED_ATTR_NAME) then
                        item:SetAttribute(client.inventoryitemconsts.LOCKED_ATTR_NAME, false)
                    end
                end
            end)
        end
    else
        client.inventoryitemutils.getLocked = client.ori.getLocked
        client.inventoryitemutils.setLocked = client.ori.setLocked
        
        if client.antilocked then
            client.antilocked:Disconnect()
            client.antilocked = nil
        end
    end
end

client.stdraycast.collidable = LPH_JIT(function(pos, dir, len, params, collidablefunc)
    if configs.vehicle.heliheight and debug.traceback():find("Heli") then
        return CFrame.new(pos)
    end

    return client.ori.collidable(pos, dir, len, params, collidablefunc)
end)
client.simulatedphysicsprojectile.HitTargetWithSpeed = LPH_JIT(function(...)
    local args = { ... }
    if configs.combat.forcefieldnomiss and args[3] == 75 then
        args[3] = 1
    end
    return client.ori.hittargetwithspeed(unpack(args))
end)
client.simulatedphysicsprojectile.CalculateVelocityToHitTargetWithSpeed = LPH_JIT(function(startPos, targetPos, speed, gravity, useMaxSpeed)
    if speed == 100 then
        local newSpeed = configs.combat.smokethrowspeed
        if type(newSpeed) == "number" and newSpeed > 0 then
            speed = newSpeed
        else
            speed = 100
        end
    end
    return client.ori.calculatevelocity(startPos, targetPos, speed, gravity, useMaxSpeed)
end)
setupvalue(client.grenade.GrenadeThrow, 3, function(p1, p2, p3)
    if p3 == 100 then
        p3 = configs.combat.explosives.grenadethrowspeed
    end
    return client.ori.grenadecalcprojvel(p1, p2, p3)
end)
local originalGrenadeShootBegin = client.grenade.ShootBegin
client.grenade.ShootBegin = function(self, ...)
    if self.Config then
        self.Config.FuseTime = configs.combat.explosives.grenadefuse
    end
    return originalGrenadeShootBegin(self, ...)
end
client.autoKillBanditLoop = LPH_JIT(function()
    task.spawn(function()
        while configs.combat.autokillbandit do
            task.wait(0.1)
            pcall(function()
                local char = players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then
                    return
                end
                local hrp = char.HumanoidRootPart
                local npcs = {}

                local mansion = workspace:FindFirstChild("MansionRobbery")
                if mansion then
                    local guardsFolder = mansion:FindFirstChild("GuardsFolder")
                    if guardsFolder then
                        for _, guard in next, guardsFolder:GetChildren() do
                            if guard:IsA("Model") and guard:FindFirstChild("HumanoidRootPart") and guard:FindFirstChild("Humanoid") and guard.Humanoid.Health > 0 then
                                table.insert(npcs, guard)
                            end
                        end
                    end
                end

                local drop = workspace:FindFirstChild("Drop")
                if drop and drop:FindFirstChild("NPCs") then
                    for _, npc in next, drop.NPCs:GetChildren() do
                        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                            table.insert(npcs, npc)
                        end
                    end
                end

                local oilrig = workspace:FindFirstChild("OilRig")
                if oilrig and oilrig:FindFirstChild("GuardsFolder") then
                    for _, guard in next, oilrig.GuardsFolder:GetChildren() do
                        if guard:IsA("Model") and guard:FindFirstChild("HumanoidRootPart") and guard:FindFirstChild("Humanoid") and guard.Humanoid.Health > 0 then
                            table.insert(npcs, guard)
                        end
                    end
                end

                for _, npc in next, npcs do
                    if (hrp.Position - npc.HumanoidRootPart.Position).Magnitude <= 100 then
                        npc.Humanoid.Health = 0
                        npc:BreakJoints()
                    end
                end
            end)
        end
    end)
end)
client.itemgun.BulletEmitterOnLocalHitPlayer = LPH_JIT(function(...)
    local args = { ... }
    local humanoid = args[2]
    local character = humanoid and humanoid.Parent
    local ok, result = pcall(client.ori.bulletemitteronlocalhitplayer, unpack(args))
    if configs.combat.instantkillbandit and humanoid and humanoid.Health > 0 and character then
        local teamValue = character:FindFirstChild("TeamValue")
        if teamValue and teamValue.Value == "Guard" then
            humanoid.Health = 0
            character:BreakJoints()
        end
    end
    return ok and result or nil
end)
client.itemgun.Shoot = LPH_JIT(function(self, a)
    if configs.combat.silentaim.enabled then
        local targetData = client.getNearestToCursor()
        local character = targetData and targetData.Character
        local targetPart = targetData and targetData.TargetPart
        local aimPart = character and (targetPart or character:FindFirstChild("HumanoidRootPart"))
        if aimPart then
            self.TipDirection = (aimPart.Position - self.Tip.Position).Unit
        end
    end
    local oldLastUpdate = self.BulletEmitter.LastUpdate
    self.BulletEmitter.LastUpdate = configs.combat.instantbullethit and -9e9 or oldLastUpdate
    client.ori.shoot(self, a)
end)
client.plasmagun.ShootOther = LPH_JIT(function(self, a)
    if configs.combat.silentaim.enabled and configs.combat.silentaim.includeplasma then
        local targetData = client.getNearestToCursor()
        local character = targetData and targetData.Character
        local targetPart = targetData and targetData.TargetPart
        local aimPart = character and (targetPart or character:FindFirstChild("HumanoidRootPart"))
        if aimPart then
            self.TipDirection = (aimPart.Position - self.Tip.Position).Unit
        end
    end
    client.ori.plasmashootother(self, a)
end)
client.tase.Tase = LPH_JIT(function(self, ...)
    if configs.combat.tasermodz then
        self._lastDraw = 0
    end
    return client.ori.tase(self, ...)
end)
client.raycast.RayIgnoreNonCollideWithIgnoreList = LPH_JIT(function(...)
    if debug.traceback():find("Taser") and configs.combat.silentaim.enabled and configs.combat.silentaim.includetaser then
        local targetData = client.getNearestToCursor()
        local character = targetData and targetData.Character
        local targetPart = targetData and targetData.TargetPart
        local aimPart = character and (targetPart or character:FindFirstChild("HumanoidRootPart"))
        if aimPart then
            return aimPart, aimPart.Position, aimPart.Position, ...
        end
    end
    return client.ori.rayignorenoncollidewithignorelist(...)
end)
client.gamepasssystem.doesPlayerOwnCached = LPH_JIT(function(...)
    local args = { ... }
    
    if configs.combat.pistolswat and tostring(args[1]) == players.LocalPlayer.Name and debug.traceback():find("tem.Pistol") then
        return true
    end
    
    return client.ori.doesplayerowncached(...)
end)
client.gunutil.getEquipTime = LPH_JIT(function(...)
    return configs.combat.antiequipt and 0 or client.ori.getequiptime(...)
end)
client.paraglide.IsFlying = LPH_JIT(function(...)
    return configs.player.nosky and debug.traceback():find("Falling") and true or client.ori.isflying(...)
end)
client.jetpack.IsFlying = LPH_JIT(function(...)
    if configs.player.flyequip and debug.traceback():find("ItemSystem") then
        return false
    end
    return client.ori.jetpackIsFlying(...)
end)
client.createAirdropMarker = function(part)
    for _, data in ipairs(client.airdropMarkers) do
        if data.part == part then return end
    end

    local marker = client.worldmarker.new()
    marker:SetAdornee(part)
    marker:SetScreenGui(client.worldmarkersystem.gui)
    marker:SetSizes({8, {24, 0}, {math.huge, 8}})

    marker.Frame.ImageColor3 = Color3.new(1, 1, 1)
    marker.FrameInner.ImageColor3 = Color3.new(1, 1, 1)

    if marker.SetIcon then
        pcall(function() marker:SetIcon(105300455594641) end)
    end

    if client.extraMarkerGroup and type(client.extraMarkerGroup.Add) == "function" then
        pcall(function() client.extraMarkerGroup:Add(marker) end)
    end

    local posBinding, updatePos = client.roact.createBinding(part.Position)
    pcall(function()
        client.store:dispatch({
            type = "addMinimapLabel",
            title = "Airdrop_" .. tostring(part),
            imageId = 105300455594641,
            position = posBinding,
            updatePosition = updatePos,
            markerColor = Color3.new(1, 1, 1),
            updateMarkerColor = function() end
        })
    end)

    local ancestryConn = part.AncestryChanged:Connect(function()
        if not part:IsDescendantOf(workspace) then
            client.removeAirdropMarker(part)
        end
    end)

    table.insert(client.airdropMarkers, {
        part = part,
        marker = marker,
        conn = ancestryConn,
        updatePos = updatePos,
        minimapTitle = "Airdrop_" .. tostring(part)
    })
end
client.removeAirdropMarker = function(part)
    for i = #client.airdropMarkers, 1, -1 do
        local data = client.airdropMarkers[i]
        if data.part == part or not data.part:IsDescendantOf(workspace) then
            if data.conn then
                data.conn:Disconnect()
            end
            if client.extraMarkerGroup and type(client.extraMarkerGroup.Remove) == "function" then
                pcall(function() client.extraMarkerGroup:Remove(data.marker) end)
            end
            pcall(function()
                if type(data.marker.Destroy) == "function" then
                    data.marker:Destroy()
                end
            end)
            pcall(function()
                client.store:dispatch({
                    type = "removeMinimapLabel",
                    title = data.minimapTitle
                })
            end)
            table.remove(client.airdropMarkers, i)
        end
    end
end
client.launchAirdropMarkers = function()
    client.airdropEnabled = true

    if not client.extraMarkerGroup then
        client.extraMarkerGroup = client.worldmarkergroup.new()
        client.worldmarkersystem.addGroup(client.extraMarkerGroup)
    end

    for _, conn in ipairs(client.airdropConns) do
        conn:Disconnect()
    end
    table.clear(client.airdropConns)
    for _, v in ipairs(workspace:GetChildren()) do
        if v.Name == "Drop" then
            local root = v:FindFirstChild("Root")
            if root then
                client.createAirdropMarker(root)
            end
        end
    end
    table.insert(client.airdropConns, workspace.ChildAdded:Connect(function(part)
        if part.Name == "Drop" then
            task.wait(0.1)
            if not client.airdropEnabled then return end
            local root = part:FindFirstChild("Root")
            if root then
                client.createAirdropMarker(root)
            end
        end
    end))
    table.insert(client.airdropConns, runservice.Heartbeat:Connect(function()
        for _, data in ipairs(client.airdropMarkers) do
            if data.part and data.part:IsDescendantOf(workspace) and data.updatePos then
                data.updatePos(data.part.Position)
            end
        end
    end))
    table.insert(client.airdropConns, workspace.ChildRemoved:Connect(function(part)
        if part.Name == "Drop" then
            local root = part:FindFirstChild("Root")
            if root then
                client.removeAirdropMarker(root)
            end
        end
    end))
end
client.clearAirdropMarkers = function()
    client.airdropEnabled = false
    for _, conn in ipairs(client.airdropConns) do
        conn:Disconnect()
    end
    table.clear(client.airdropConns)
    for i = #client.airdropMarkers, 1, -1 do
        local data = client.airdropMarkers[i]
        if data.conn then
            data.conn:Disconnect()
        end
        if client.extraMarkerGroup and type(client.extraMarkerGroup.Remove) == "function" then
            pcall(function() client.extraMarkerGroup:Remove(data.marker) end)
        end
        pcall(function()
            if type(data.marker.Destroy) == "function" then
                data.marker:Destroy()
            end
        end)
        pcall(function()
            client.store:dispatch({
                type = "removeMinimapLabel",
                title = data.minimapTitle
            })
        end)
        table.remove(client.airdropMarkers, i)
    end
end
client.getMarkerColor = function(player)
    return tostring(player.Team) == "Police" and Color3.fromRGB(84, 215, 253) or Color3.fromRGB(253, 148, 81)
end
client.forceWorldMarkerVisible = function(marker)
    if not marker then return end
    pcall(function()
        if type(marker.SetVisible) == "function" then marker:SetVisible(true) end
        if marker.Frame then marker.Frame.BackgroundTransparency = 1 end
        if marker.FrameInner then
            marker.FrameInner.Visible = true
            marker.FrameInner.ImageTransparency = 0
            marker.FrameInner.BackgroundTransparency = 1
        end
        if marker.FrameOuter then
            marker.FrameOuter.ImageTransparency = 1
            marker.FrameOuter.BackgroundTransparency = 1
        end
    end)
  end

  client.createExtraMarker = function(player)
    if player == players.LocalPlayer or client.extraMarkers[player.UserId] or not client.isEnemies(players.LocalPlayer.Team, player.Team) then return end
    local marker = client.worldmarker.new()
    marker:SetScreenGui(client.worldmarkersystem.gui)
    marker:SetSizes({4, {24, 0}, {math.huge, 8}})
    pcall(function() marker:SetIcon(tostring(player.Team) == "Police" and client.copicon or client.crimicon) end)
    client.extraMarkerGroup:Add(marker)
    pcall(function()
        marker.FrameInner.ImageColor3 = client.getMarkerColor(player)
        marker.FrameInner.BackgroundTransparency = 1
    end)
    client.forceWorldMarkerVisible(marker)
    client.extraMarkers[player.UserId] = { worldMarker = marker, player = player }
  end

  client.removeExtraMarker = function(player)
    local data = client.extraMarkers[player.UserId]
    if data then
        pcall(function()
            client.extraMarkerGroup:Remove(data.worldMarker)
            data.worldMarker:Destroy()
        end)
        client.extraMarkers[player.UserId] = nil
    end
  end

  client.detectIcons = function()
    if client.iconsDetected then return end
    local gui = client.worldmarkersystem.gui
    if not gui then return end
    local foundCop, foundCrim = false, false
    for _, frame in pairs(gui:GetDescendants()) do
        if frame:IsA("ImageLabel") and frame.Name == "FrameInner" then
            local color = frame.ImageColor3
            if color then
                local idString = string.match(frame.Image, "%d+")
                if idString then
                    local id = tonumber(idString)
                    if color.R * 255 < 150 and color.B * 255 > 150 and not foundCop then
                        client.copicon = id; foundCop = true
                    elseif color.R * 255 > 200 and color.B * 255 < 150 and not foundCrim then
                        client.crimicon = id; foundCrim = true
                    end
                end
            end
        end
    end
    if foundCop and foundCrim then client.iconsDetected = true end
  end

client.toggleAntiMinimapFlash = function(enabled)
    if client.minimapFlashConn then
        client.minimapFlashConn:Disconnect()
        client.minimapFlashConn = nil
    end

    if not enabled then
        for marker, connections in pairs(client.minimapmarker) do
            for _, conn in pairs(connections) do
                pcall(function() conn:Disconnect() end)
            end
        end
        client.minimapmarker = {}

        pcall(function()
            local state = client.store:getState()
            if state.minimapPoints then
                for _, point in ipairs(state.minimapPoints) do
                    local plr = players:FindFirstChild(point.name)
                    if not plr then
                        for _, p in ipairs(players:GetPlayers()) do
                            if p.DisplayName == point.name then plr = p break end
                        end
                    end
                    if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                        point.flash = true
                        if point._updateVisible then
                            point._updateVisible(false)
                        end
                    end
                end
            end
        end)

        pcall(function()
            local pointsFrame = players.LocalPlayer.PlayerGui.AppUI.Buttons.Minimap.Map.Container.Points
            for _, child in pairs(pointsFrame:GetChildren()) do
                if child:IsA("ImageLabel") and child.Name ~= "_you" then
                    local plr = players:FindFirstChild(child.Name)
                    if not plr then
                        for _, p in ipairs(players:GetPlayers()) do
                            if p.DisplayName == child.Name then plr = p break end
                        end
                    end
                    if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                        child.Visible = false
                    end
                end
            end
        end)
        return
    end

    pcall(function()
        local state = client.store:getState()
        if state.minimapPoints then
            for _, point in ipairs(state.minimapPoints) do
                local plr = players:FindFirstChild(point.name)
                if not plr then
                    for _, p in ipairs(players:GetPlayers()) do
                        if p.DisplayName == point.name then plr = p break end
                    end
                end
                if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                    point.flash = false
                    if point._visible and point._updateVisible then
                        point._updateVisible(true)
                    end
                end
            end
        end
    end)

    local function hookPointsFrame()
        local ok, pointsFrame = pcall(function()
            return players.LocalPlayer.PlayerGui.AppUI.Buttons.Minimap.Map.Container.Points
        end)
        if not ok or not pointsFrame then return false end

        local function forceChild(child)
            if child:IsA("ImageLabel") and child.Name ~= "_you" then
                local plr = players:FindFirstChild(child.Name)
                if not plr then
                    for _, p in ipairs(players:GetPlayers()) do
                        if p.DisplayName == child.Name then plr = p break end
                    end
                end
                
                if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                    child.BackgroundTransparency = 1
                    child.Visible = true
                    
                    if not client.minimapmarker[child] then
                        local connections = {}
                        local conn1 = child:GetPropertyChangedSignal("Visible"):Connect(function()
                            if configs.others.antiminimapflash and not child.Visible then
                                child.Visible = true
                            end
                        end)
                        table.insert(connections, conn1)
                        client.minimapmarker[child] = connections
                    end
                end
            end
        end

        for _, child in pairs(pointsFrame:GetChildren()) do
            forceChild(child)
        end

        pointsFrame.ChildAdded:Connect(function(child)
            task.wait()
            forceChild(child)
        end)

        return true
    end

    hookPointsFrame()

    client.minimapFlashConn = runservice.Heartbeat:Connect(function()
        pcall(function()
            local state = client.store:getState()
            if state.minimapPoints then
                for _, point in ipairs(state.minimapPoints) do
                    local plr = players:FindFirstChild(point.name)
                    if not plr then
                        for _, p in ipairs(players:GetPlayers()) do
                            if p.DisplayName == point.name then plr = p break end
                        end
                    end
                    if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                        point.flash = false
                        if point._visible and not point._visible:getValue() then
                            if point._updateVisible then
                                point._updateVisible(true)
                            end
                        end
                    end
                end
            end
        end)

        pcall(function()
            local pointsFrame = players.LocalPlayer.PlayerGui.AppUI.Buttons.Minimap.Map.Container.Points
            for _, child in pairs(pointsFrame:GetChildren()) do
                if child:IsA("ImageLabel") and child.Name ~= "_you" then
                    local plr = players:FindFirstChild(child.Name)
                    if not plr then
                        for _, p in ipairs(players:GetPlayers()) do
                            if p.DisplayName == child.Name then plr = p break end
                        end
                    end
                    if plr and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                        child.Visible = true
                        child.BackgroundTransparency = 1
                    end
                end
            end
        end)
    end)
end

client.antiplayermarkerflash = function(enabled)
    if client.playermarker then
      client.playermarker:Disconnect()
      client.playermarker = nil
  end
    
  if not enabled then
      if client.originalPlayerMarkerDraw then
          client.playermarkersystem._draw = client.originalPlayerMarkerDraw
          client.originalPlayerMarkerDraw = nil
        end
        for userId, data in pairs(client.extraMarkers) do
            pcall(function()
                client.extraMarkerGroup:Remove(data.worldMarker)
                data.worldMarker:Destroy()
            end)
        end
        table.clear(client.extraMarkers)
        
        pcall(function()
            for _, data in pairs(client.playermarkersystem._mapPlayerIdPlayerMarker) do
                if data._worldMarker then
                    if data._worldMarker.Frame then data._worldMarker.Frame.Visible = true end
                    if data._worldMarker.FrameInner then
                      data._worldMarker.FrameInner.Visible = true
                      data._worldMarker.FrameInner.ImageTransparency = 0
                  end
              end
          end
      end)
      return
  end

    if not client.extraMarkerGroup then
        client.extraMarkerGroup = client.worldmarkergroup.new()
        client.worldmarkersystem.addGroup(client.extraMarkerGroup)
    end
    
    if not client.originalPlayerMarkerDraw then
        client.originalPlayerMarkerDraw = client.playermarkersystem._draw
    end

    client.playermarkersystem._draw = function()
        for _, data in pairs(client.playermarkersystem._mapPlayerIdPlayerMarker) do
            local plr = data._player
            if plr then
                local character = plr.Character
                if character and character.PrimaryPart then
                    data._worldMarker:SetPosition(character.PrimaryPart.Position)
                end
                if client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                    pcall(function()
                        if data._worldMarker then
                            if data._worldMarker.Frame then data._worldMarker.Frame.Visible = false end
                            if data._worldMarker.FrameInner then
                                data._worldMarker.FrameInner.Visible = false
                                data._worldMarker.FrameInner.ImageTransparency = 1
                            end
                        end
                    end)
                else
                    client.forceWorldMarkerVisible(data._worldMarker)
                end
            end
        end
    end

    client.detectIcons()
    for _, plr in pairs(players:GetPlayers()) do client.createExtraMarker(plr) end

    client.playermarker = runservice.Heartbeat:Connect(function()
        if not client.iconsDetected then
            client.detectIcons()
            if client.iconsDetected then
                for _, data in pairs(client.extraMarkers) do
                    pcall(function() data.worldMarker:SetIcon(tostring(data.player.Team) == "Police" and client.copicon or client.crimicon) end)
                end
            end
        end

        pcall(function()
            for _, data in pairs(client.playermarkersystem._mapPlayerIdPlayerMarker) do
                if data._worldMarker then
                    if data._worldMarker.Frame then data._worldMarker.Frame.BackgroundTransparency = 1 end
                    if data._worldMarker.FrameInner then data._worldMarker.FrameInner.BackgroundTransparency = 1 end
                    if data._worldMarker.FrameOuter then data._worldMarker.FrameOuter.BackgroundTransparency = 1 end
                end
            end
        end)

        local toRemove = {}
        for userId, data in pairs(client.extraMarkers) do
            local plr = data.player
            if plr and plr.Parent and client.isEnemies(players.LocalPlayer.Team, plr.Team) then
                local char = plr.Character
                if char and char.PrimaryPart then
                    data.worldMarker:SetPosition(char.PrimaryPart.Position)
                    pcall(function()
                        data.worldMarker.FrameInner.ImageColor3 = client.getMarkerColor(plr)
                        data.worldMarker.FrameInner.BackgroundTransparency = 1
                        data.worldMarker.FrameOuter.BackgroundTransparency = 1
                    end)
                end
            else
                table.insert(toRemove, plr)
            end
        end
        for _, plr in pairs(toRemove) do client.removeExtraMarker(plr) end
        for _, plr in pairs(players:GetPlayers()) do
            if client.isEnemies(players.LocalPlayer.Team, plr.Team) and not client.extraMarkers[plr.UserId] then
                client.createExtraMarker(plr)
            end
        end
    end)
end

client.vehiclelinkbinder._constructor._hookNearest = LPH_JIT(function(...)
    local args = { ... }
    local rope = args[1].obj
    local obj = args[1].nearestObj
    local requestLink = args[1].manifest.reqLinkRemote
    if configs.vehicle.helipick and rope.Name == "RopePull" then
      local cf = obj.PrimaryPart.CFrame:PointToObjectSpace(
        client.geomUtils.closestPointInPart(obj.PrimaryPart, rope.Position), rope.Position)
      requestLink:FireServer(obj, cf)
      return
    elseif configs.vehicle.instanttow and rope.Name == "MetalHook" then
      local cf = obj.PrimaryPart.CFrame:PointToObjectSpace(
        client.geomUtils.closestPointInPart(obj.PrimaryPart, rope.Position), rope.Position)
      requestLink:FireServer(obj, cf)
      return
    end
    return client.ori.hookNearest(...)
end)

client.vclasses.Heli.Update = LPH_JIT(function(self, ...)
    client.ori.heliupdate(self, ...)
    if configs.vehicle.heliengine then
      self.Velocity.Velocity *= Vector3.new(configs.vehicle.helienginesp, configs.vehicle.heliverticalsp,
        configs.vehicle.helienginesp)
    end
end)

client.boat.GetAreTiresPopped = LPH_JIT(function(self)
    if configs.vehicle.boatantitakedown then return false end
    return client.ori.boatgetaretirespopped(self)
end)

client.boatModify = function()
    local boat = client.boat
    if not boat then return end
    local mountPlayer = boat.MountPlayer
    local unmountSeat = boat.UnmountSeat
    local destroy = boat.Destroy
    local boats = {}

    local function onBoatMountPlayer(x, y, ...)
        if y == players.LocalPlayer and not boats[x.Meta.Id] then
            boats[x.Meta.Id] = {
                MEMORY = { 
                    SPEED_FORWARD = x.Config.SpeedForward,
                    MAX_TURN_ANGLE = x.Config.MaximumTurnAngle or 1 
                },
                LIFE = runservice.Heartbeat:Connect(function()
                    if configs.vehicle.boatengine then
                        x.Config.SpeedForward = boats[x.Meta.Id].MEMORY.SPEED_FORWARD * configs.vehicle.boatenginesp
                        if configs.vehicle.boatland then x.WaterHeight = 20 end
                    else
                        x.Config.SpeedForward = boats[x.Meta.Id].MEMORY.SPEED_FORWARD
                        x.WaterHeight = 0
                    end
                    
                    if configs.vehicle.boatturn then
                        x.Config.MaximumTurnAngle = boats[x.Meta.Id].MEMORY.MAX_TURN_ANGLE * configs.vehicle.boatturnsp
                    else
                        x.Config.MaximumTurnAngle = boats[x.Meta.Id].MEMORY.MAX_TURN_ANGLE
                    end
                end)
            }
        end
        return mountPlayer(x, y, ...)
    end

    local function onBoatUnmountSeat(x, y)
        if boats[x.Meta.Id] and y == players.LocalPlayer then
            boats[x.Meta.Id].LIFE:Disconnect()
            boats[x.Meta.Id] = nil
        end
        return unmountSeat(x, y)
    end

    local function onBoatDestroy(x)
        if boats[x.Meta.Id] then
            boats[x.Meta.Id].LIFE:Disconnect()
            boats[x.Meta.Id] = nil
        end
        return destroy(x)
    end

    boat.MountPlayer = onBoatMountPlayer
    boat.UnmountSeat = onBoatUnmountSeat
    boat.Destroy = onBoatDestroy
end

client.jetskiModify = function()
    local jetski = client.jetski
    if not jetski then return end
    
    local originalMountPlayer = jetski.MountPlayer
    jetski.MountPlayer = function(p1, p2, p3)
        originalMountPlayer(p1, p2, p3)
        
        if p2 == players.LocalPlayer and p3.Driver then
            p3.Maid:GiveTask(runservice.Heartbeat:Connect(function()
                if configs.vehicle.boatland then
                    if not p1.BuoyancySensor or typeof(p1.BuoyancySensor) == "Instance" then
                        if typeof(p1.BuoyancySensor) == "Instance" then
                            p1.BuoyancySensor:Destroy()
                        end
                        p1.BuoyancySensor = { TouchingSurface = true }
                    end
                else
                    if p1.BuoyancySensor and typeof(p1.BuoyancySensor) ~= "Instance" then
                        p1.BuoyancySensor = nil
                    end
                end

                if configs.vehicle.boatengine and p1.VectorForce then
                    local currentForce = p1.VectorForce.Force
                    p1.VectorForce.Force = Vector3.new(
                        currentForce.X,
                        currentForce.Y,
                        currentForce.Z * configs.vehicle.boatenginesp
                    )
                end
            end))
        end
    end
end

client.planeModify = function()
    local jet = client.jet
    local stunt = client.stunt
    if not jet or not stunt then return end
    local planes = {}

    local function setupPlane(x, y)
        if y == players.LocalPlayer and not planes[x.Plane.Id] then
            planes[x.Plane.Id] = {
                MEMORY = {
                    HEIGHT_MAX = x.Plane.CONST.HEIGHT_MAX,
                    MAX_THRUST = x.Plane.CONST.MAX_THRUST
                },
                LIFE = runservice.Heartbeat:Connect(function()
                    if configs.vehicle.planeengine then
                        if configs.vehicle.planeheight then
                            x.Plane.CONST.HEIGHT_MAX = math.huge
                        else
                            x.Plane.CONST.HEIGHT_MAX = planes[x.Plane.Id].MEMORY.HEIGHT_MAX
                        end
                        x.Plane.CONST.MAX_THRUST = planes[x.Plane.Id].MEMORY.MAX_THRUST * configs.vehicle.planeenginesp
                    else
                        x.Plane.CONST.HEIGHT_MAX = planes[x.Plane.Id].MEMORY.HEIGHT_MAX
                        x.Plane.CONST.MAX_THRUST = planes[x.Plane.Id].MEMORY.MAX_THRUST
                    end
                end)
            }
        end
    end

    local jetMount = jet.MountPlayer
    local jetUnmount = jet.UnmountSeat
    local jetDestroy = jet.Destroy

    jet.MountPlayer = function(x, y, ...) setupPlane(x, y) return jetMount(x, y, ...) end
    jet.UnmountSeat = function(x, y)
        if planes[x.Plane.Id] and y == players.LocalPlayer then planes[x.Plane.Id].LIFE:Disconnect() planes[x.Plane.Id] = nil end
        return jetUnmount(x, y)
    end
    jet.Destroy = function(x)
        if planes[x.Plane.Id] then planes[x.Plane.Id].LIFE:Disconnect() planes[x.Plane.Id] = nil end
        return jetDestroy(x)
    end

    local stuntMount = stunt.MountPlayer
    local stuntUnmount = stunt.UnmountSeat
    local stuntDestroy = stunt.Destroy

    stunt.MountPlayer = function(x, y, ...) setupPlane(x, y) return stuntMount(x, y, ...) end
    stunt.UnmountSeat = function(x, y)
        if planes[x.Plane.Id] and y == players.LocalPlayer then planes[x.Plane.Id].LIFE:Disconnect() planes[x.Plane.Id] = nil end
        return stuntUnmount(x, y)
    end
    stunt.Destroy = function(x)
        if planes[x.Plane.Id] then planes[x.Plane.Id].LIFE:Disconnect() planes[x.Plane.Id] = nil end
        return stuntDestroy(x)
    end
end

client.vclasses.Volt.Update = LPH_JIT(function(volt)
    client.ori.voltupdate(volt)
    if configs.vehicle.voltnopop then
        volt.AreTiresPopped = false
        if volt.WheelWorld and volt.WheelWorld.Wheels then
            for _, wheel in ipairs(volt.WheelWorld.Wheels) do
                wheel:SetForwardFriction(volt._defaultForwardFriction or 0.01)
            end
        end
    end
    volt.Force.Force = volt.Force.Force * (1 + configs.vehicle.voltenginesp)
end)

client.vclasses.Chassis.UpdateEngine = LPH_JIT(function(self, p2, p3)
    local drifting = self.Model and self.Model:GetAttribute("VehicleIsDrifting") == true
    if configs.vehicle.inftrac and not drifting then
        self.Traction = 1
        self.Drift = false
    end
    client.ori.chassisupdate(self, p2, p3)
    if configs.vehicle.inftrac and not drifting then
        self.Traction = 1
        self.Drift = false
    end
end)

  local blacklistedaction = {
    "Rob",
    "Hack",
    "Open Crate",
    "Break In",
    "Pull Lever",
    "Place TNT",
    "Switch",
    "Crack",
    "Change Direction",
    "Open"
  }
  client.circleac.Press = LPH_JIT(function()
    local spec = getupvalue(client.ori.circleactionpress, 1).Spec
    if configs.player.nocircwait and spec and not table.find(blacklistedaction, spec.Name) then
      spec:Callback(true)
    end
    return client.ori.circleactionpress()
  end)

players.LocalPlayer:GetMouse().Move:Connect(function()
    if client.ispc() then
        local Mouse = userinputservice:GetMouseLocation()
        Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
        CircleFilled.Position = Vector2.new(Mouse.X, Mouse.Y)
        CircleOutline.Position = Vector2.new(Mouse.X, Mouse.Y)
    end
end)

players.LocalPlayer.CharacterAdded:Connect(function(a)
    local hrp = players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    if hrp then
        if configs.player.nofall then
            hrp:AddTag("NoFallDamage")
        end
        if configs.player.norag then
            hrp:AddTag("NoRagdoll")
        end
    end
    
    for part, state in pairs(client._noclipCache) do
        if part and part.Parent then
            part.CanCollide = state
        end
    end
    client._noclipCache = {}
end)

client.noclipLoop = LPH_JIT(function()
    repeat
        task.wait()
        local char = players.LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    if configs.player.noclip then
                        if client._noclipCache[part] == nil then
                            client._noclipCache[part] = part.CanCollide
                        end
                        part.CanCollide = false
                    else
                        if client._noclipCache[part] ~= nil then
                            part.CanCollide = client._noclipCache[part]
                            client._noclipCache[part] = nil
                        end
                    end
                end
            end
        end
    until not configs.player.noclip
end)
	game:GetService("UserInputService").JumpRequest:Connect(function()
		if configs.player.infjump then
			game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
		end
	end)
  game.Lighting.ChildAdded:connect(function(marlow)
    if configs.combat.antisniperblur and marlow.Name == "Blur" then
      marlow:GetPropertyChangedSignal("Size"):connect(function()
        marlow.Enabled = false
      end)
    end
  end)
client.antiscopeui = LPH_JIT(function()
    task.spawn(function()
        while configs.combat.antiscopeui do
            task.wait(0.1)
            local playerGui = players.LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                local scopeGui = playerGui:FindFirstChild("ScopeGui")
                if scopeGui and scopeGui:IsA("ScreenGui") then
                    scopeGui.Enabled = false
                end
            end
        end
    end)
end)
client.alwaysfavorited = LPH_JIT(function(enabled)
    if client.autofavorite then
        client.autofavorite = false
    end
    
    if not enabled then return end
    
    client.autofavorite = true
    
    task.spawn(function()
        while client.autofavorite do
            task.wait(0.1)
            local ok, star = pcall(function()
                return players.LocalPlayer.PlayerGui.AppUI.Garage.Center.Portal.Top.FavoritedCheckbox.Star
            end)
            if ok and star then
                local garageVis = false
                pcall(function() garageVis = players.LocalPlayer.PlayerGui.AppUI.Garage.Visible end)
                if garageVis then
                    if star.ImageColor3.R < 0.9 then
                        local conns = getconnections(star.Activated)
                        if conns[1] then
                            conns[1].Function()
                        end
                    end
                end
            end
        end
    end)
end)
client.onvehicleentered:Connect(function(arg1)
    client.vehicleEntered = true
    if arg1.Model ~= client.lastvehiclemodel and arg1.Type == "Chassis" then
        client.lastvehiclemodel = arg1.Model
        client.lastvehiclestats.GarageEngineSpeed = arg1.GarageEngineSpeed
        client.lastvehiclestats.GarageBrakes = arg1.GarageBrakes
        client.lastvehiclestats.TurnSpeed = arg1.TurnSpeed
        client.lastvehiclestats.Height = arg1.Height
    end
    if configs.vehicle.ftog then
        client.launchVehicleFlight()
    end
    if arg1.Type == "Heli" then
        arg1.MaxHeight = configs.vehicle.heliheight and 9e9 or 400
        arg1.FallOutOfSkyDuration = configs.vehicle.helibreak and 0 or 10
        arg1.DisableDuration = configs.vehicle.helibreak and 0 or 10
    elseif arg1.Type == "Chassis" then
        arg1.TirePopDuration = configs.vehicle.nopop and 0 or 7.5
        arg1.DisableDuration = configs.vehicle.nopop and 0 or 7.5
        arg1.TirePopProportion = configs.vehicle.nopop and 0 or 0.5
    elseif arg1.Type == "Volt" or arg1.Type == "Custom" then
        arg1.DisableDuration = configs.vehicle.voltnopop and 0 or 7.5
    end
    if configs.vehicle.driveonwater and client.rayParamsVehicleEnter then
        client.rayParamsVehicleEnter.IgnoreWater = false
    end
    if configs.vehicle.autoloadslot then
        local remote = replicatedstorage:FindFirstChild("GarageSlotLoad")
        if remote then
            remote:FireServer("s" .. slotDrop.Value)
        end
    end
    if configs.vehicle.autoloadlast then
        local Event = replicatedstorage.GarageLoadLastSelection
        if Event then
            Event:FireServer()
        end
    end
    if configs.vehicle.garage.autoapply then
        task.delay(0.5, function()
            client.applyGarageItems()
        end)
    end
end)
client.onvehicleexited:Connect(function()
    client.vehicleEntered = false
end)
client.garageItems = {
    BodyColor = {"Hyper Blue Lvl5", "Hyper Diamond Lvl5", "Hyper Pink Lvl5", "Hyper Shift", "None", "Radiant Orange", "Radiant Pink", "Radiant Polar Blue", "Radiant Purple", "Radiant Red", "Radiant Sun", "Radiant White", "Radiant Yellow", "Radient Green"},
    SecondBodyColor = {"Hyper Blue Lvl5", "Hyper Diamond Lvl5", "Hyper Pink Lvl5", "Hyper Shift", "None", "Radiant Orange", "Radiant Pink", "Radiant Polar Blue", "Radiant Purple", "Radiant Red", "Radiant Sun", "Radiant White", "Radiant Yellow", "Radient Green"},
    Texture = {"Checker", "Drip", "None"},
    InteriorMain = {"Hyper Blue Lvl5", "Hyper Diamond Lvl5", "Hyper Pink Lvl5", "Hyper Shift", "None", "Radiant Orange", "Radiant Pink", "Radiant Polar Blue", "Radiant Purple", "Radiant Red", "Radiant Sun", "Radiant White", "Radiant Yellow", "Radient Green"},
    InteriorDetail = {"Hyper Blue Lvl5", "Hyper Diamond Lvl5", "Hyper Pink Lvl5", "Hyper Shift", "None", "Radiant Orange", "Radiant Pink", "Radiant Polar Blue", "Radiant Purple", "Radiant Red", "Radiant Sun", "Radiant White", "Radiant Yellow", "Radient Green"},
    WheelColor = {"Hyper Blue Lvl5", "Hyper Diamond Lvl5", "Hyper Pink Lvl5", "Hyper Shift", "None", "Radiant Orange", "Radiant Pink", "Radiant Polar Blue", "Radiant Purple", "Radiant Red", "Radiant Sun", "Radiant White", "Radiant Yellow", "Radient Green"},
    Rim = {"Domino Crown", "INF1N1TY", "Laser Cannon", "Live 2026", "None", "RTX", "Void"},
    Spoiler = {"Bamboo Shooters", "Bicycle Rack", "Cash Spitter", "Guest 417", "None", "OG Rocket Thrusters", "Thrusters"},
    SpoilerColor = {"Hyper Blue Lvl5", "Hyper Diamond Lvl5", "Hyper Pink Lvl5", "Hyper Shift", "None", "Radiant Orange", "Radiant Pink", "Radiant Polar Blue", "Radiant Purple", "Radiant Red", "Radiant Sun", "Radiant White", "Radiant Yellow", "Radient Green"},
    TireMesh = {"Brickset", "None", "Radial Red", "Radial Yellow", "Spiked"},
    Horn = {"Airhorn", "Cruiseliner", "None", "Sendoff", "Train"},
    Drifts = {"Blue Fire", "Gradient Pixel", "OG Fuel", "Rainboom", "Spark"},
}

client.garageMap = {
    ["Airhorn"] = "Airhorn",
    ["Bamboo Shooters"] = "Bamboo Shooters",
    ["Bicycle Rack"] = "BicycleRack",
    ["Blue Fire"] = "BlueFire",
    ["Brickset"] = "Brickset",
    ["Cash Spitter"] = "CashSpitter",
    ["Checker"] = "Checker",
    ["Cruiseliner"] = "Cruiseliner",
    ["Domino Crown"] = "DominoCrown",
    ["Drip"] = "Drip",
    ["Gradient Pixel"] = "GradientPixel",
    ["Guest 417"] = "Guest417",
    ["Hyper Blue Lvl5"] = "HyperBlueLvl5",
    ["Hyper Diamond Lvl5"] = "HyperDiamondLvl5",
    ["Hyper Pink Lvl5"] = "HyperPinkLvl5",
    ["Hyper Shift"] = "HyperShift",
    ["INF1N1TY"] = "INF1N1TY",
    ["Laser Cannon"] = "LaserCannon",
    ["Live 2026"] = "Live2026",
    ["None"] = "None",
    ["OG Fuel"] = "OGFuel",
    ["OG Rocket Thrusters"] = "OG Rocket Thrusters",
    ["Radial Red"] = "RadialRed",
    ["Radial Yellow"] = "RadialYellow",
    ["Radiant Orange"] = "RadiantOrange",
    ["Radiant Pink"] = "RadiantPink",
    ["Radiant Polar Blue"] = "RadiantPolarBlue",
    ["Radiant Purple"] = "RadiantPurple",
    ["Radiant Red"] = "RadiantRed",
    ["Radiant Sun"] = "RadiantSun",
    ["Radiant White"] = "RadiantWhite",
    ["Radiant Yellow"] = "RadiantYellow",
    ["Radient Green"] = "RadientGreen",
    ["Rainboom"] = "Rainboom",
    ["RTX"] = "RTX",
    ["Sendoff"] = "Sendoff",
    ["Spark"] = "Spark",
    ["Spiked"] = "Spiked",
    ["Thrusters"] = "Thrusters",
    ["Train"] = "Train",
    ["Void"] = "Void",
}
client.applyGarageItems = LPH_JIT(function()
    local remote = replicatedstorage:FindFirstChild("GarageEquipItem")
    if not remote then return end
    local cfg = configs.vehicle.garage
    local map = client.garageMap

    task.spawn(function()
        local function fire(category, displayValue)
            if displayValue ~= "None" then
                local internal = map[displayValue] or displayValue
                remote:FireServer(category, internal)
                task.wait(0.3)
            end
        end
        fire("BodyColor", cfg.bodycolor)
        fire("SecondBodyColor", cfg.secondbodycolor)
        fire("Texture", cfg.texture)
        fire("InteriorMainColor", cfg.interiormain)
        fire("InteriorDetailColor", cfg.interiordetail)
        fire("TireMesh", cfg.tiremesh)
        fire("Rim", cfg.rim)
        fire("WheelColor", cfg.wheelcolor)
        fire("Spoiler", cfg.spoiler)
        fire("SpoilerColor", cfg.spoilercolor)
        fire("Horn", cfg.horn)
        fire("Drift", cfg.drifts)
        Library:Notify("Done!")
    end)
end)
players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "Garage" then
        task.defer(function()
            if configs.vehicle.showfavorited then
                client.toggleFavoritedFilter(true)
            end
        end)
    end
end)
client.instantreload = function()
    if client.instantreloadcon then
        client.instantreloadcon:Disconnect()
        client.instantreloadcon = nil
    end

    if not configs.combat.instantreload then return end

    client.instantreloadcon = runservice.Heartbeat:Connect(function()
        if client.instantreloadprocess then return end
        if not configs.combat.instantreload then
            client.instantreloadcon:Disconnect()
            client.instantreloadcon = nil
            return
        end

        local gun = client.itemsys.GetLocalEquipped()
        if not gun then return end

        local isReloading = false
        if gun.BulletEmitter and (gun.IsReloading or (gun.AmmoGui and gun.AmmoGui.FlagOutOfAmmo)) then
            isReloading = true
            
        elseif gun.__ClassName == "ForcefieldLauncher" then
            local nextShoot = client.inventoryitemutils.getAttr(gun.inventoryItemValue, "NextShootPossible") or 0
            if os.clock() < nextShoot then
                isReloading = true
            end
        end

        if isReloading then
            local name = gun.__ClassName
            if not name or table.find({"C4", "RocketLauncher", "Grenade", "SmokeGrenade", "unknown"}, name) then return end

            local oldSlot
            for i, v in ipairs(client.hotbarsystem.getSortedHotbarItemsFor(players.LocalPlayer) or {}) do
                if v.obj and tostring(v.obj) == name then
                    oldSlot = i
                    break
                end
            end

            client.instantreloadprocess = true
            task.spawn(function()
                for _, v in ipairs(client.inventoryitemsystem.getInventoryItemsFor(players.LocalPlayer) or {}) do
                    if v.obj and v.obj.Name == name and v.AttemptDrop then 
                        v:AttemptDrop() 
                        break 
                    end
                end
                
                task.wait(0.15)
                
                while configs.combat.instantreload and not client.itemsys.GetLocalEquipped() do
                    local root = players.LocalPlayer.Character and players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root and client.circleac.Specs then
                        for _, v in ipairs(client.circleac.Specs) do
                            if v.Part and v.Enabled and v.Name and string.find(v.Name:lower(), "pick") and (root.Position - v.Part.Position).Magnitude < 25 then
                                v:Callback(true)
                            end
                        end
                    end
                    task.wait()
                end

                if oldSlot and configs.combat.instantreload then
                    for i, v in ipairs(client.hotbarsystem.getSortedHotbarItemsFor(players.LocalPlayer) or {}) do
                        if v.obj and tostring(v.obj) == name then
                            pcall(function()
                                client.hotbarutils.setDisplayOrder(v.obj, oldSlot)
                            end)
                            break
                        end
                    end
                end

                client.instantreloadprocess = false
            end)
        end
    end)
end
client.onlocalitemequipped:Connect(function(equippeddata)
    local getdata = client.getOldWeaponData
    local a = client.itemsys.GetLocalEquipped()
        if getdata(a.__ClassName, "FireAuto") ~= nil then
        a.Config.FireAuto = configs.combat.alwaysauto and true or getdata(a.__ClassName, "FireAuto")
        end
        if getdata(a.__ClassName, "BulletSpread") ~= nil then
        a.Config.BulletSpread = configs.combat.antispread and 0 or getdata(a.__ClassName, "BulletSpread")
        end
        if getdata(a.__ClassName, "CamShakeMagnitude") ~= nil then
        a.Config.CamShakeMagnitude = configs.combat.antirecoil and 0 or getdata(a.__ClassName, "CamShakeMagnitude")
        end
        if a.__ClassName == "Taser" and getdata(a.__ClassName, "ReloadTimeHit") ~= nil and getdata(a.__ClassName, "ReloadTime") ~= nil then
        a.Config.ReloadTimeHit = configs.combat.tasermodz and 0 or getdata(a.__ClassName, "ReloadTimeHit")
        a.Config.ReloadTime = configs.combat.tasermodz and 0 or getdata(a.__ClassName, "ReloadTime")
        end
        if a and a.BulletEmitter and a.BulletEmitter.GravityVector then
        a.BulletEmitter.GravityVector = configs.combat.nobulletg and nil or Vector3.new(0, -workspace.Gravity / 10, 0)
        end
        if a.__ClassName == "ForcefieldLauncher" then
        a.Config.Reload = configs.combat.forcefieldreload and 0 or 4
        end
        if a.__ClassName == "CarTurret" then
        if configs.combat.carturret.antioverheat then
            client.carturretconfig.MaxHeat = math.huge
        else
            client.carturretconfig.MaxHeat = 2
        end
        if configs.combat.carturret.fastbullet then
            client.carturretconfig.BulletSpeed = 5000
        else
            client.carturretconfig.BulletSpeed = 1200
        end
        if a.__ClassName == "Grenade" then
            if configs.combat.explosives.grenadethrowcd then
                a.Config.ReloadTime = 0.01
            else
                a.Config.ReloadTime = getdata("Grenade", "ReloadTime") or 0.5
            end
        end
        if a.__ClassName == "SmokeGrenade" then
            if configs.combat.explosives.grenadethrowcd then
                a.Config.ReloadTime = 0.01
            else
                a.Config.ReloadTime = getdata("SmokeGrenade", "ReloadTime") or 0.5
            end
        end
    end
end)
client.followMouseTurret = function(enabled)
    if client.followMouseTurretConn then
        client.followMouseTurretConn:Disconnect()
        client.followMouseTurretConn = nil
    end
    if not enabled then return end

    client.followMouseTurretConn = runservice.RenderStepped:Connect(function()
        local gvp = client.vehicleutils.GetLocalVehiclePacket()
        if not gvp or not gvp.Model then return end

        local turretTips = gvp.Model:FindFirstChild("TurretTips", true)
        if not turretTips or not turretTips:IsA("BasePart") then return end

        local cam = workspace.CurrentCamera
        if not cam then return end

        local mouseLoc = userinputservice:GetMouseLocation()
        local ray = cam:ViewportPointToRay(mouseLoc.X, mouseLoc.Y)

        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        rayParams.IgnoreWater = true
        local char = players.LocalPlayer.Character
        if char then
            rayParams.FilterDescendantsInstances = {char, gvp.Model}
        end

        local hit = workspace:Raycast(ray.Origin, ray.Direction * 5000, rayParams)
        local targetPos = hit and hit.Position or (ray.Origin + ray.Direction * 5000)

        for _, att in ipairs(turretTips:GetChildren()) do
            if att:IsA("Attachment") then
                local origin = att.WorldPosition
                local dir = targetPos - origin
                if dir.Magnitude > 0.01 then
                    att.WorldCFrame = CFrame.lookAt(origin, targetPos)
                end
            end
        end
    end)
end
client.spectate = function()
    local dropdownValue = configs.player.spectatetarget
    if not dropdownValue then
        Library:Notify("Select a player first", 3)
        return
    end
    local target = players:FindFirstChild(dropdownValue)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        Library:Notify("Player not found", 3)
        return
    end

    client.unspectate()

    client.spectateTarget = target
    workspace.CurrentCamera.CameraSubject = target.Character

    local function onCharAdded(char)
        repeat task.wait() until char:FindFirstChild("HumanoidRootPart")
        if client.spectateTarget == target then
            workspace.CurrentCamera.CameraSubject = char
        end
    end

    local charAddedConn = target.CharacterAdded:Connect(onCharAdded)

    local camChangedConn = workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
        if client.spectateTarget == target then
            if target.Character then
                workspace.CurrentCamera.CameraSubject = target.Character
            end
        end
    end)

    client.spectateMaid = {charAddedConn, camChangedConn}
    Library:Notify("Spectating " .. target.Name, 3)
end
client.unspectate = function()
    if client.spectateMaid then
        for _, conn in ipairs(client.spectateMaid) do
            conn:Disconnect()
        end
        client.spectateMaid = nil
    end
    client.spectateTarget = nil
    local char = players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        workspace.CurrentCamera.CameraSubject = char
    end
end
client.parseMoneyInput = function(input)
    local str = tostring(input):gsub(",", ""):gsub("%$", ""):gsub("%s", ""):lower()
    local multiplier = 1
    local suffix = str:match("[a-z]+$")
    local numStr = str:match("^[%d%.]+")
    
    if not numStr then return nil end
    
    local num = tonumber(numStr)
    if not num then return nil end
    
    if suffix == "k" then
        multiplier = 1000
    elseif suffix == "m" then
        multiplier = 1000000
    elseif suffix == "b" then
        multiplier = 1000000000
    elseif suffix == "t" then
        multiplier = 1000000000000
    end
    
    return math.floor(num * multiplier)
end

client.formatMoney = function(amount)
    local formatted = tostring(amount)
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return "$" .. formatted
end

client.moneySpooferEnabled = false
client.moneySpooferAmount = 0

client.moneySpooferLoop = LPH_JIT(function()
    while client.moneySpooferEnabled do
        task.wait(0.1)
        local formatted = client.formatMoney(client.moneySpooferAmount)
        pcall(function()
            players.LocalPlayer.PlayerGui.AppUI.Buttons.Cash.Content.AmountWrap.Label.Text = formatted
        end)
        pcall(function()
            players.LocalPlayer.PlayerGui.CashGui.Container.Content.ContainerTop.ContainerRight.ContainerCash.TextLabel.Text = formatted
        end)
        pcall(function()
            players.LocalPlayer.leaderstats.Money.Value = client.moneySpooferAmount
        end)
    end
end)
client.robstatus = {}
task.spawn(function()
    while true do
        task.wait(.1)
        pcall(function()
            local humanoid = players.LocalPlayer.Character.Humanoid or nil
            local gvp = require(replicatedstorage.Vehicle.VehicleUtils).GetLocalVehiclePacket() or nil
            if humanoid ~= nil and gvp ~= nil and client.vehicleEntered then
                if gvp.Type == "Chassis" then
                    if configs.vehicle.engine then
                        gvp.GarageEngineSpeed = configs.vehicle.enginesp
                    end
                    if configs.vehicle.brake then
                        gvp.GarageBrakes = configs.vehicle.brakesp
                    end
                    if configs.vehicle.suspension then
                        gvp.Height = configs.vehicle.suspensionhe
                    end
                    if configs.vehicle.turn then
                        gvp.TurnSpeed = configs.vehicle.turnsp
                    end
                end
            end
            if configs.player.norwait then
                table.clear(client.movementrollservice.mapLastRollTime)
            end
        end)
    end
end)

  local function disableAllFeatures()
    for category, tbl in pairs(configs) do
        if type(tbl) == "table" then
            for key, value in pairs(tbl) do
                if type(value) == "boolean" then
                    tbl[key] = false
                end
            end
        end
    end

    for funcName, originalFunc in pairs(client.ori) do
    if isfunctionhooked(originalFunc) then
        restorefunction(originalFunc)
    end
  end

  if client.alwaysjuiced then
      client.alwaysjuiced:Disconnect()
      client.alwaysjuiced = nil
      client.characterutil.IsJuiced = false
    end

    if client.antilocked then
      client.antilocked:Disconnect()
      client.antilocked = nil
    end

    if client.minimapFlashConn then
      client.minimapFlashConn:Disconnect()
      client.minimapFlashConn = nil
    end

    if client.playermarker then
        client.playermarker:Disconnect()
        client.playermarker = nil
    end

    for part, state in pairs(client._noclipCache) do
        if part and part.Parent then
            part.CanCollide = state
        end
    end
    client._noclipCache = {}

    configs.player.ftog = false
    configs.vehicle.ftog = false
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

local BOUNTY_STATE_FILE = "Rendex/serverhop_bounty_state.txt"

client.serverhopUntilBountyRunning = false
client.serverhopBountyValue = ""

client.parseBountyK = function(input)
    local str = tostring(input or ""):gsub(",", ""):gsub("%$", ""):gsub("%s", ""):lower()
    local numStr, suffix = str:match("^([%d%.]+)([a-z]*)$")
    if not numStr then return nil end
    local num = tonumber(numStr)
    if not num then return nil end
    if suffix == "k" then num = num * 1000 end
    return math.floor(num)
end

client.saveServerhopState = function()
    pcall(function()
        if not isfolder("Rendex") then makefolder("Rendex") end
        writefile(BOUNTY_STATE_FILE, "true|" .. tostring(client.serverhopBountyValue or ""))
    end)
end

client.clearServerhopState = function()
    pcall(function()
        if isfolder("Rendex") then
            writefile(BOUNTY_STATE_FILE, "false|")
        end
    end)
end

client.loadServerhopState = function()
    local ok, data = pcall(function()
        if isfile(BOUNTY_STATE_FILE) then
            return readfile(BOUNTY_STATE_FILE)
        end
    end)
    if ok and type(data) == "string" and data ~= "" then
        local enabledStr, target = data:match("^([^|]*)|(.*)$")
        return enabledStr == "true", target or ""
    end
    return false, ""
end

client.stopServerhopUntilBounty = function()
    client.serverhopUntilBountyRunning = false
    client.clearServerhopState()
end

client.startServerhopUntilBounty = LPH_JIT(function()
    if client.serverhopUntilBountyRunning then return end
    client.serverhopUntilBountyRunning = true

    task.spawn(function()
        while client.serverhopUntilBountyRunning and configs.others.serverhopuntilbounty do
            local cooldown = tonumber(configs.others.serverhopcooldown) or 1

            local target = client.parseBountyK(client.serverhopBountyValue)
            if not target then
                Library:Notify("Invalid bounty. Use 30k, 100k, etc.", 3)
                client.stopServerhopUntilBounty()
                break
            end

            local total = 0
            pcall(function() total = client.getTotalServerBounty() end)

            if total >= target then
                Library:Notify("Bounty reached: " .. client.formatMoney(total), 5)
                configs.others.serverhopuntilbounty = false
                client.stopServerhopUntilBounty()
                break
            end

            Library:Notify("Hopping... " .. client.formatMoney(total) .. " / " .. client.formatMoney(target), 2)

            task.wait(cooldown)

            if not client.serverhopUntilBountyRunning then break end

            client.saveServerhopState()
            pcall(function()
                queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotWhyLclc/Rendex/refs/heads/main/Loader.luau"))()')
            end)

            ServerHop()
        end
    end)
end)

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

AddToggle = function(groupboxes, txt, clbck, default, tootip, customId, risky, disabled)
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
    if risky ~= nil then
        tbl.Risky = risky
    end
    if disabled ~= nil then
        tbl.Disabled = disabled
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
  Footer = "Rendex | Jailbreak | 1.0.2 | Total Server Bounty: $0",
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

local tab = Window:AddTab("Home", "house")

local group = tab:AddLeftGroupbox("User Info")
tab:UpdateWarningBox({
    Title = "Warning",
    Text = "Features labeled as red arent recommended to use! and is likely detected.",
    IsNormal = false,
    Visible = true,
    LockSize = true,
})
local lp = players.LocalPlayer

local camera = Instance.new("Camera")
local avatar
local connection

local viewport = group:AddViewport("UserAvatar", {
    Object = Instance.new("Model"),
    Camera = camera,
    Interactive = false,
    AutoFocus = false,
    Height = 180,
})

local function createAvatar(character)
    if avatar then
        avatar:Destroy()
        avatar = nil
    end

    character.Archivable = true
    avatar = character:Clone()
    avatar.Name = "ViewportCharacter"

    for _, v in ipairs(avatar:GetDescendants()) do
        if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") then
            v:Destroy()
        elseif v:IsA("BasePart") then
            v.Anchored = true
            v.CanCollide = false
            v.CanTouch = false
            v.CanQuery = false
        end
    end

    viewport:SetObject(avatar)
end

local function update()
    if not avatar or not lp.Character then
        return
    end

    for _, part in ipairs(lp.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            local clonePart = avatar:FindFirstChild(part.Name, true)
            if clonePart and clonePart:IsA("BasePart") then
                clonePart.CFrame = part.CFrame
            end
        end
    end

    local root = avatar:FindFirstChild("HumanoidRootPart")
    if root then
        local realCamera = workspace.CurrentCamera
        if realCamera then
            local look = realCamera.CFrame.LookVector
            local flatLook = Vector3.new(look.X, 0, look.Z)
            if flatLook.Magnitude > 0 then
                flatLook = flatLook.Unit
                local target = root.Position + Vector3.new(0, 1.5, 0)
                local position = target - flatLook * 7 + Vector3.new(0, 0.5, 0)
                camera.CFrame = CFrame.lookAt(position, target)
            end
        end
    end
end

if lp.Character then
    createAvatar(lp.Character)
end

lp.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart")
    task.wait(0.2)
    createAvatar(character)
end)

connection = runservice.RenderStepped:Connect(update)

local EXECUTION_FILE = "Rendex/execution_count.txt"

local function getExecutionCount()
    if not isfile(EXECUTION_FILE) then
        writefile(EXECUTION_FILE, "0")
    end
    local count = tonumber(readfile(EXECUTION_FILE)) or 0
    count += 1
    writefile(EXECUTION_FILE, tostring(count))
    return count
end

local executionCount = getExecutionCount()

local function formatNumber(n)
    return tostring(n):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

local usernameVisible = true
local usernameLabel = group:AddLabel("User: " .. lp.Name)
group:AddLabel("Executions: " .. formatNumber(executionCount))

group:AddButton("Hide Username", function()
    usernameVisible = not usernameVisible
    if usernameVisible then
        usernameLabel:SetText("User: " .. lp.Name)
    else
        usernameLabel:SetText("User: [Hidden]")
    end
end)

local group = tab:AddRightGroupbox("Script Info")
group:AddLabel([[Previous Update 1.0.1

Previous update features:

• Removed Anti Robbery Marker Delay
• Removed Increase Takedown Damage

Newest Update 1.0.2

New update features:

• Auto Apply Customizations
• Apply Customizations
• Execution Count
• Loadout System
• Loadout Slots 1–10
• Auto Loadout
• Auto Drop Unselected
• Fixed some bugs and issues

Join our Discord for the full changelogs.]], true)
group:AddButton({
    Text = "Copy Discord Invite Link",
    Func = function()
        if setclipboard then
            setclipboard("https://discord.gg/X4GW8N5GdW")
            Library:Notify("Copied Discord invite!", 2)
        else
            Library:Notify("Missing setclipboard function", 2)
        end
    end
})

local tab = Window:AddTab("Player", "user", "Modifications for yourself")

local group = tab:AddLeftGroupbox("Movement")
local PlayerFlightToggle = AddToggle(group, "Player Flight", function(a)
    configs.player.ftog = a
    if a then
        client.launchPlayerFlight()
    end
end, false, "Allows you to fly wow crazy")
AddSlider(group, "Flight Speed", function(a)
    configs.player.fspeed = a
end, 0, 0, 145, 0, nil, "PlayerFlightSpeed")
AddToggle(group, "Always Sprinting", function(a)
  configs.player.alwayssp = a
  if a then
    client.sprintLoop()
  end
end, false, "Makes you always sprint")
local AlwaysJuicedToggle = AddToggle(group, "Always Juiced", function(a)
    configs.player.juiced = a
    client.juicedLoop()
end, false, "Makes you always juiced to be faster.")
local NoclipToggle = AddToggle(group, "Noclip", function(a)
    configs.player.juiced = a
    if a then
        client.noclipLoop()
    else
        for part, state in pairs(client._noclipCache) do
            if part and part.Parent then
                part.CanCollide = state
            end
        end
        client._noclipCache = {}
    end
end, false, "Allows you to noclip certain areas.", nil, true, nil)
AddToggle(group, "Infinite Jump", function(a)
	configs.player.infjump = a
end, false, nil, nil, true, nil)

local group = tab:AddLeftGroupbox("Interactions")
AddToggle(group, "Anti Circle Hold", function(a)
    configs.player.nocircwait = a
    if client.gc.circleaction then
        setconstant(client.gc.circleaction, client.gc.circleactionidx05, a and 0 or 0.5)
        setconstant(client.gc.circleaction, client.gc.circleactionidx2, a and 0 or 2)
    end
end)
AddToggle(group, "Circle Anti Clipping", function(a)
    setconstant(client.circleupdateui, 45, a and "Duration" or "NoRay")
end)

group:AddDivider()

AddToggle(group, "Arrest Aura", function(a)
    configs.player.arrestaura.enabled = a
    if a then client.launchArrestAura()
  end
end)
AddToggle(group, "Eject Aura", function(a)
    configs.player.ejectaura.enabled = a
    if a then client.launchEjectAura() 
  end
end)
AddToggle(group, "Search Criminal Aura", function(a)
    configs.player.crimsearchaura.enabled = a
    if a then client.launchCrimSearchAura() end
end)

group:AddDivider()

AddToggle(group, "Pickpocket Aura", function(a)
    configs.player.pickpocketaura.enabled = a
    if a then client.launchPickPocketAura() 
  end
end)
AddToggle(group, "Breakout Aura", function(a)
    configs.player.breakoutaura.enabled = a
    if a then client.launchBreakoutAura()
  end
end)
AddToggle(group, "Auto Collect Cash", function(a)
    configs.player.autocollectcash = a
    if a then
        task.spawn(client.autoCollectCashLoop)
    end
end, false, nil, "AutoCollectCash")
AddSlider(group, "Cash Collect Range", function(a)
    configs.player.cashcollectrange = a
end, 5, 0, 20, 0)

local group = tab:AddRightGroupbox("Mechanics")
AddToggle(group, "Anti Punch Cooldown", function(a)
    if client.attemptpunch then
        for i, const in next, getconstants(client.attemptpunch) do
            if a and const == 0.5 then
                setconstant(client.attemptpunch, i, 0)
                break
            elseif not a and const == 0 then
                setconstant(client.attemptpunch, i, 0.5)
                break
            end
        end
    end
end, false, "Removes the 0.5s delay between punches")
AddToggle(group, "Anti Ragdoll", function(a)
  configs.player.norag = a
  local hrp = players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") or nil
  if configs.player.norag == false and hrp ~= nil then
    hrp:RemoveTag("NoRagdoll")
  elseif configs.player.norag == true and hrp ~= nil then
    hrp:AddTag("NoRagdoll")
  end
end, false, "Prevents you from ragdolling")
AddToggle(group, "Anti Fall Injury", function(a)
  configs.player.nofall = a
  local hrp = players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") or nil
  if configs.player.nofall == false and hrp ~= nil then
    hrp:RemoveTag("NoFallDamage")
  elseif configs.player.nofall == true and hrp ~= nil then
    hrp:AddTag("NoFallDamage")
  end
end, false, "Prevents from taking fall damage")
AddToggle(group, "Anti Skydiving", function(a)
  configs.player.nosky = a
end, false, "Prevents you from skydiving")
AddToggle(group, "Anti Ragdoll Stun", function(a)
    configs.player.nostun = a
    client.settings.Time.Stunned = configs.player.nostun and 0 or 5
    
    if client.stunnedragdoll then
        if not client.ori.stunnedragdoll then
            client.ori.stunnedragdoll = hookfunction(client.stunnedragdoll, function(...)
                if configs.player.nostun then 
                    return
                end
                return client.ori.stunnedragdoll(...)
            end)
        end
    end
end, false, "Prevents you from being stunned from tasers, etc")
AddToggle(group, "Anti Injury Slow", function(a)
  configs.player.noislow = a
  setconstant(client.walkspeedfun, 8, configs.player.noislow and 1 or 0.5)
end, false, "Prevents you from being slow while damaged")
AddToggle(group, "Anti Crawling Slow", function(a)
  configs.player.nocslow = a
  setconstant(client.walkspeedfun, 16, configs.player.nocslow and 1 or 0.4)
end, false, "Prevents you from being slow while crawling")
AddToggle(group, "Anti Spotlight Slow", function(a)
    configs.player.antispotlightslow = a
    setconstant(client.walkspeedfun, 35, a and 1 or 0.8)
end, false, "Prevents spotlights from slowing you down")
AddToggle(group, "Allow Equip When Crawling", function(a)
  configs.player.crawlequip = a
  if configs.player.crawlequip then
    client.isCrawlingLoop()
  end
end, false, "Allow you to equip items while crawling")
AddToggle(group, "Anti Locked Items", function(a)
    configs.player.antilocked = a
    client.antilockeditems(a)
end, false, "Allows you to unequip any item")

group:AddDivider()

AddToggle(group, "Enable Roll Action", function(a)
    configs.player.enableroll = a
    client.roll(a)
end, false, "Enables rolling")
AddToggle(group, "Anti Roll Cooldown", function(a)
  configs.player.norwait = a
  client.activeaction.roll.useEvery = configs.player.norwait and 0 or 5
  client.rollratelimiter._budgetPerWindow = configs.player.norwait and 9e9 or 10
  client.rollratelimiter._budgetWindowDuration = configs.player.norwait and 9e9 or 10
end)

local group = tab:AddRightGroupbox("Jetpack")
AddToggle(group, "Infinite Jetpack Fuel", function(a)
    configs.player.infjetpack = a
    if a then 
        task.spawn(client.infinitejetpackfuel) 
    end
end)
AddToggle(group, "Faster Jetpack", function(a)
    configs.player.fasterjetpack = a
    client.fasterJetpack(a)
end)
AddToggle(group, "Allow Equip While Flying", function(a)
    configs.player.flyequip = a
end)
AddToggle(group, "Bypass Fly Zones", function(a)
    configs.player.bypassnofly = a
    for _, v in ipairs(client.noflyzones) do
        if v and v.Parent then
            if a then
                collectionservice:RemoveTag(v, "JetPackNoFly")
            else
                collectionservice:AddTag(v, "JetPackNoFly")
            end
        end
    end
end)

local group = tab:AddRightGroupbox("Consumables")
AddToggle(group, "Instant Donut Consume", function(a)
    configs.player.instantdonut = a
    local idx = client.bettertablefind(getconstants(client.donut.InputBegan), 0.3) or client.bettertablefind(getconstants(client.donut.InputBegan), 0)
    if idx then
        setconstant(client.donut.InputBegan, idx, a and 0 or 0.3)
    end
end)

local group = tab:AddLeftGroupbox("Minimap")
AddToggle(group, "Anti Minimap Flash", function(a)
    configs.player.minimap.antiminimapflash = a
    client.toggleAntiMinimapFlash(a)
end)
AddToggle(group, "Anti Player Marker Flash", function(a)
    configs.player.minimap.antiplayermarkerflash = a
    client.antiplayermarkerflash(a)
end)
AddToggle(group, "Airdrop Marker", function(a)
    if a then
        client.launchAirdropMarkers()
    else
        client.clearAirdropMarkers()
    end
end)

local tab = Window:AddTab("Vehicle", "car", "Modifications for your vehicle!!!!")

local group = tab:AddLeftGroupbox("General")
local VehicleFlightToggle = AddToggle(group, "Vehicle Flight", function(a)
    configs.vehicle.ftog = a
    if a and client.vehicleEntered == true then
        client.launchVehicleFlight()
    end
end, false, "Allows you to fly in a car wow crazy")
AddSlider(group, "Flight Speed", function(a)
    configs.vehicle.fspeed = a
end, 0, 0, 1000, 0, nil, "VehicleFlightSpeed")

group:AddDivider()

AddToggle(group, "Add Jump Action", function(a)
    setconstant(client.gc.vehicleactionstart, client.constindex.vehicleactionstart.GarageEngineSpeed, a and "GarageEngineSpeed" or "CanJump")
end)
AddToggle(group, "Anti Jump Action Wait", function(a)
    setupvalue(client.gc.vehicleactionstart, client.constindex.vehicleactionstart.cooldown, a and 0.1 or 15)
end)
AddToggle(group, "Infinite Nitro", function(a)
  configs.vehicle.infnitro = a
  if configs.vehicle.infnitro then
    client.nitroLoop()
  end
end)

group:AddDivider()

AddToggle(group, "Destructibles Aura", function(a)
    configs.vehicle.destroydestructibles = a
    if a then task.spawn(client.destructLoop) end
end)
AddSlider(group, "Destructibles Range", function(a)
    configs.vehicle.destructrange = a
end, 0, 0, 200)

AddToggle(group, "Pit Aura", function(a)
    configs.vehicle.pitaura = a
    if a then task.spawn(client.pitAuraLoop) end
end)
AddSlider(group, "Pit Aura Range", function(a)
    configs.vehicle.pitaurarange = a
end, 0, 0, 150)

local group = tab:AddLeftGroupbox("Car")
AddSlider(group, "Engine Speed", function(a)
  configs.vehicle.enginesp = a
end, configs.vehicle.enginesp, 0, 200, 0)
AddToggle(group, "Apply Engine Speed", function(a)
  configs.vehicle.engine = a
  if configs.vehicle.engine == false then
    client.updateToOriginalChassisStats()
  end
end)
AddSlider(group, "Brakes", function(a)
  configs.vehicle.brakesp = a
end, configs.vehicle.brakesp, 0, 30, 0)
AddToggle(group, "Apply Breaks", function(a)
  configs.vehicle.brake = a
  if configs.vehicle.brake == false then
    client.updateToOriginalChassisStats()
  end
end)
AddSlider(group, "Suspension Height", function(a)
  configs.vehicle.suspensionhe = a
end, configs.vehicle.suspensionhe, 0, 200, 0)
local SuspensionToggle = AddToggle(group, "Apply Suspension Height", function(a)
  configs.vehicle.suspension = a
    client.updateToOriginalChassisStats()
end)
AddSlider(group, "Turn Speed", function(a)
  configs.vehicle.turnsp = a
end, configs.vehicle.turnsp, 0, 10, 0)
AddToggle(group, "Apply Turn Speed", function(a)
  configs.vehicle.turn = a
  if configs.vehicle.turn == false then
    client.updateToOriginalChassisStats()
  end
end)
AddToggle(group, "Anti Tire Pop", function(a)
  configs.vehicle.nopop = a
end, false, "Makes your tires immune to being popped")
AddToggle(group, "Drive On Water", function(a)
  configs.vehicle.driveonwater = a
  if client.rayParamsVehicleEnter then
    client.rayParamsVehicleEnter.IgnoreWater = not a
  end
end, false, "Be able to drive on water")
AddToggle(group, "Always Flip", function(a)
  configs.vehicle.autoflip = a
  client.flipLoop()
end)
AddToggle(group, "Always Drift", function(a)
  configs.vehicle.alwaysdrift = a
  if a then
    client.driftLoop()
  end
end)
AddToggle(group, "Infinite Traction", function(a)
    configs.vehicle.inftrac = a
end)
AddToggle(group, "Instant Tow", function(a)
  configs.vehicle.instanttow = a
end)

local group = tab:AddLeftGroupbox("Helicopter")
AddSlider(group, "Engine Forward Speed", function(a)
  configs.vehicle.helienginesp = a / 10
end, 0, 0, 500, 0)
AddSlider(group, "Engine Vertical Speed", function(a)
  configs.vehicle.heliverticalsp = a / 10
end, 0, 0, 300, 0)
AddToggle(group, "Apply Modification", function(a)
  configs.vehicle.heliengine = a
end)
AddToggle(group, "Instant Heli Pickup", function(a)
  configs.vehicle.helipick = a
end)
AddToggle(group, "Anti Heli Takedown", function(a)
  configs.vehicle.helibreak = a
end)
AddToggle(group, "Infinite Heli Height", function(a)
  configs.vehicle.heliheight = a
end)

local group = tab:AddRightGroupbox("Garage")
local slotDrop = group:AddDropdown("Slot", {
    Text = "Choose Save Slot",
    Values = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" },
    Default = 1,
})
group:AddButton("Load Save Slot", function()
    local remote = replicatedstorage:FindFirstChild("GarageSlotLoad")
    if remote then
        remote:FireServer("s" .. slotDrop.Value)
        Library:Notify("Loaded slot " .. slotDrop.Value .. "!", 2)
    else
        Library:Notify("Remote not ready!", 2)
    end
end)
AddToggle(group, "Auto Load Save Slot", function(a)
    configs.vehicle.autoloadslot = a
    if a and client.vehicleEntered then
        local remote = replicatedstorage:FindFirstChild("GarageSlotLoad")
        if remote then
            remote:FireServer("s" .. slotDrop.Value)
        end
    end
end)
AddToggle(group, "Auto Load Last Selection", function(a)
    configs.vehicle.autoloadlast = a
    if a and client.vehicleEntered then
        local remote = replicatedstorage.GarageLoadLastSelection
        remote:FireServer()
    end
end)
AddToggle(group, "Always Show Favorited", function(a)
    configs.vehicle.showfavorited = a
    client.alwaysfavorited(a)
end, false, "Only show favorited vehicles in garage")

local group = tab:AddRightGroupbox("Garage Customization")
group:AddLabel("Pro garage is recommended for these otherwise go in a garage and close the garage menu.", true)
group:AddDropdown("GarageBodyColor", {
    Text = "Body Color",
    Values = client.garageItems.BodyColor,
    Default = configs.vehicle.garage.bodycolor,
    Callback = function(value)
        configs.vehicle.garage.bodycolor = value
    end
})
group:AddDropdown("GarageSecondBodyColor", {
    Text = "Second Body Color",
    Values = client.garageItems.SecondBodyColor,
    Default = configs.vehicle.garage.secondbodycolor,
    Callback = function(value)
        configs.vehicle.garage.secondbodycolor = value
    end
})
group:AddDropdown("GarageTexture", {
    Text = "Texture",
    Values = client.garageItems.Texture,
    Default = configs.vehicle.garage.texture,
    Callback = function(value)
        configs.vehicle.garage.texture = value
    end
})
group:AddDropdown("GarageInteriorDetail", {
    Text = "Interior Detail",
    Values = client.garageItems.InteriorDetail,
    Default = configs.vehicle.garage.interiordetail,
    Callback = function(value)
        configs.vehicle.garage.interiordetail = value
    end
})
group:AddDropdown("GarageInteriorMain", {
    Text = "Interior Main",
    Values = client.garageItems.InteriorMain,
    Default = configs.vehicle.garage.interiormain,
    Callback = function(value)
        configs.vehicle.garage.interiormain = value
    end
})
group:AddDropdown("GarageWheelColor", {
    Text = "Wheel Color",
    Values = client.garageItems.WheelColor,
    Default = configs.vehicle.garage.wheelcolor,
    Callback = function(value)
        configs.vehicle.garage.wheelcolor = value
    end
})
group:AddDropdown("GarageRim", {
    Text = "Rim",
    Values = client.garageItems.Rim,
    Default = configs.vehicle.garage.rim,
    Callback = function(value)
        configs.vehicle.garage.rim = value
    end
})
group:AddDropdown("GarageSpoiler", {
    Text = "Spoiler",
    Values = client.garageItems.Spoiler,
    Default = configs.vehicle.garage.spoiler,
    Callback = function(value)
        configs.vehicle.garage.spoiler = value
    end
})
group:AddDropdown("GarageSpoilerColor", {
    Text = "Spoiler Color",
    Values = client.garageItems.SpoilerColor,
    Default = configs.vehicle.garage.spoilercolor,
    Callback = function(value)
        configs.vehicle.garage.spoilercolor = value
    end
})
group:AddDropdown("GarageTireMesh", {
    Text = "Tire Style",
    Values = client.garageItems.TireMesh,
    Default = configs.vehicle.garage.tiremesh,
    Callback = function(value)
        configs.vehicle.garage.tiremesh = value
    end
})
group:AddDropdown("GarageHorn", {
    Text = "Horn",
    Values = client.garageItems.Horn,
    Default = configs.vehicle.garage.horn,
    Callback = function(value)
        configs.vehicle.garage.horn = value
    end
})
group:AddDropdown("GarageDrifts", {
    Text = "Drifts",
    Values = client.garageItems.Drifts,
    Default = configs.vehicle.garage.drifts,
    Callback = function(value)
        configs.vehicle.garage.drifts = value
    end
})

group:AddDivider()

AddToggle(group, "Auto Apply", function(a)
    configs.vehicle.garage.autoapply = a
end, false, "Applies selections when entering a vehicle")
group:AddButton("Apply", function()
    client.applyGarageItems()
end)

local group = tab:AddRightGroupbox("Plane")
AddSlider(group, "Speed Multiplier", function(a)
  configs.vehicle.planeenginesp = a
end, 0, 0, 10, 0, nil, "PlaneSpeedMultiplier")
AddToggle(group, "Apply Speed", function(a)
  configs.vehicle.planeengine = a
end, false, nil, "PlaneApplySpeed")
AddToggle(group, "Infinite Plane Height", function(a)
  configs.vehicle.planeheight = a
end)
AddToggle(group, "Instant Takeoff", function(a)
  configs.vehicle.jetinstanttakeoff = a
end)
AddToggle(group, "Anti Roll Correction", function(a)
  configs.vehicle.jetnoroll = a
end)

local group = tab:AddRightGroupbox("Boat")
AddSlider(group, "Speed Multiplier", function(a)
  configs.vehicle.boatenginesp = a
end, 0, 0, 10, 0, nil, "BoatSpeedMultiplier")
AddSlider(group, "Turn Speed", function(a)
  configs.vehicle.boatturnsp = a
end, 0, 0, 10, 0, nil, "BoatTurnSpeed")
AddToggle(group, "Apply Speed", function(a)
  configs.vehicle.boatengine = a
end, false, nil, "BoatApplySpeed")  
AddToggle(group, "Apply Turn Speed", function(a)
  configs.vehicle.boatturn = a
end, false, nil, "BoatApplyTurnSpeed")
AddToggle(group, "Anti Boat Takedown", function(a)
  configs.vehicle.boatantitakedown = a
end)
AddToggle(group, "Drive on Land", function(a)
  configs.vehicle.boatland = a
end, false, "Allows boats to drive on land")

local group = tab:AddRightGroupbox("Motorbike")
AddSlider(group, "Speed Multiplier", function(a)
  setconstant(client.alexchassis2.UpdateHQ, 76, 1.2 + a)
end, 0, 0, 100, 0, nil, "MotorbikeSpeedMultiplier")
AddSlider(group, "Suspension Height Multiplier", function(a)
  setconstant(client.motorupdatewheel, 16, a)
end, 0, 0, 50, 0)

local group = tab:AddRightGroupbox("Tank")
--[[ AddSlider(group, "Engine Speed Multiplier", function(a)
 	configs.vehicle.tankenginesp = a
 end, 0, 0, 500, 0)
 AddToggle(group, "Apply Engine Speed", function(a)
	print(configs.vehicle.tankenginesp)
	setconstant(getproto(client.tankbinder._handleSeatedDriver, 4), 20, tonumber(configs.vehicle.tankenginesp))
 	print(getconstant(getproto(client.tankbinder._handleSeatedDriver, 4), 20))
 end) ]]
AddSlider(group, "Tracks Height", function(a)
  setconstant(client.tankbinder._buildWheelWorld, 28, 5.3 + a)
end, 0, 0, 50, 0)

local group = tab:AddRightGroupbox("Volt")
AddSlider(group, "Speed Multiplier", function(a)
  configs.vehicle.voltenginesp = a
end, 0, 0, 25, 0, nil, "VoltSpeedMultiplier")
AddSlider(group, "Wheel Height", function(a)
  setconstant(client.vclasses.Volt.VehicleEnter, 30, 6.5 + a)
end, 0, 0, 19, 0)
AddToggle(group, "Anti Pop Tire", function(a)
    configs.vehicle.voltnopop = a
end)

local tab = Window:AddTab("Robberies", "landmark", "Modifications for robberies yipee")

local group = tab:AddLeftGroupbox("General")
AddToggle(group, "Disable Bandit Damage", function(a)
  configs.robbery.guardnodmg = a
  setconstant(client.guardnpcbinder._onItemEquipped, 8, a and "yeafuckyou" or "IgnoreLocalPlayer")
  if a then
    client.setnpcignorelp(true)
    task.spawn(client.npcnodamageloop)
  else
    client.setnpcignorelp(false)
  end
end)
AddToggle(group, "Auto Solve Puzzle", function(a)
    configs.robbery.powerplant.autosolve = a
    if a then
        client.autosolve = task.spawn(function()
            while configs.robbery.powerplant.autosolve do
                task.wait(client.solvedelay)
                client.autosolvepuzzle()
            end
        end)
    else
        if client.autosolve then
            task.cancel(client.autosolve)
            client.autosolve = nil
        end
    end
end, false, "Literally just solves the numberlink puzzle for you", "PowerPlantPuzzle")
AddSlider(group, "Solve Delay", function(a)
    client.solvedelay = a
end, 1, 0.1, 5, 1)

local group = tab:AddLeftGroupbox("Bank")
AddToggle(group, "Disable Lasers", function(a)
    configs.robbery.bank.disablelasers = a
    client.disableBankLasers(a)
end, false, nil, "BankLasers")
AddToggle(group, "Auto Place Dynamite", function(a)
    configs.robbery.bank.autodynamite = a
    if a then task.spawn(client.autoDynamiteLoop) end
end, false, nil, "BankDynamite")

local group = tab:AddLeftGroupbox("Jewelry Store")
AddToggle(group, "Disable Lasers", function(a)
    configs.robbery.jewelry.disablelasers = a
    client.disableJewelryLasers(a)
end, false, nil, "JewelryLasers")
AddToggle(group, "Auto Grab Jewel", function(a)
    configs.robbery.jewelry.autograb = a
    if a then client.autoJewelryGrabLoop() end
end)
AddToggle(group, "Anti Door Lock", function(a)
    configs.robbery.jewelry.antidoorlock = a
    client.antiJewelryDoorLock(a)
end)

local group = tab:AddLeftGroupbox("Museum")
AddToggle(group, "Disable Lasers", function(a)
    configs.robbery.museum.disablelasers = a
    client.disableMuseumLasers(a)
end, false, nil, "MuseumLasers")
AddToggle(group, "Auto Grab", function(a)
    configs.robbery.museum.autograb = a
    if a then client.autoMuseumGrabLoop() end
end, false, nil, "MuseumGrab")
AddToggle(group, "Auto Place Dynamite", function(a)
    configs.robbery.museum.autodynamite = a
    if a then client.autoMuseumDynamiteLoop() end
end, false, nil, "MuseumDynamite")
AddToggle(group, "Auto Solve Puzzle", function(a)
    configs.robbery.museum.autosolvepuzzle = a
    if a then client.autoSolveMuseumPuzzleLoop() end
end, false, nil, "MuseumPuzzle")

local group = tab:AddLeftGroupbox("Power Plant")
AddToggle(group, "Disable Lasers", function(a)
    configs.robbery.powerplant.disablelasers = a
    client.disablePowerPlantLasers(a)
end, false, nil, "PowerPlantLasers")
AddToggle(group, "Disable Pistons", function(a)
  configs.robbery.powerplant.disablepistons = a
  client.disablePowerPlantPistons(a)
end)

local group = tab:AddLeftGroupbox("Tomb")
AddToggle(group, "Disable Planks", function(a)
  configs.robbery.tomb.disableplanks = a
  client.disableTombPlanks(a)
end)
AddToggle(group, "Disable Spikes", function(a)
  configs.robbery.tomb.disablespikes = a
  client.disableTombSpikes(a)
end)
AddToggle(group, "Disable Darts", function(a)
  configs.robbery.tomb.disabledarts = a
  client.disabledarts(a)
end)
AddToggle(group, "Disable Bridge Break", function(a)
  configs.robbery.tomb.bridgebreak = a
  client.disableTombBridgeBreak(a)
end)
AddToggle(group, "Disable Lava", function(a)
  configs.robbery.tomb.disablelava = a
  client.disableTombLava(a)
end)
AddToggle(group, "Auto Duck", function(a)
    configs.robbery.tomb.autoduck = a
    if a then task.spawn(client.autoTombDuckLoop) end
end)

AddToggle(group, "Auto Sit Cart", function(a)
    configs.robbery.tomb.autosit = a
    if a then task.spawn(client.autoSitTomb) end
end)

local group = tab:AddLeftGroupbox("Casino")
local casinocode = group:AddLabel("Code: Searching...", false)

group:AddButton("Copy Code", function()
    local code = client.casinokeycode()
    if setclipboard and code ~= "" and not code:find("Searching") and not code:find("Waiting") then
        setclipboard(code)
        Library:Notify("Copied: " .. code, 2)
    else
        Library:Notify("No code found", 2)
    end
end)

AddToggle(group, "Auto Notify Code", function(a)
    configs.robbery.casino.autonotifycode = a
    client.autonotify = a
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        local code = client.casinokeycode()
        
        if casinocode then
            casinocode:SetText("Code: " .. code)
        end
        
        if client.autonotify and code ~= client.lastcode and code ~= "" and not code:find("Searching") and not code:find("Waiting") then
            client.lastcode = code
            Library:Notify("Code: " .. code, 3)
        end
    end
end)
AddToggle(group, "Disable Lasers", function(a)
    configs.robbery.casino.disablelasers = a
    client.disableCasinoLasers(a)
end, false, nil, "CasinoLasers")
AddToggle(group, "Hack Computer", function(a)
    configs.robbery.casino.fixcomputer = a
    if a then task.spawn(client.fixCasinoComputerLoop)
    end
end)
AddToggle(group, "Auto Collect Cash", function(a)
    configs.robbery.casino.autocollectcash = a
    if a then client.autoCollectCasinoCash() end
end, false, nil, "AutoCollectCashCasino")
AddToggle(group, "Auto Crack Vault", function(a)
    configs.robbery.casino.autovault = a
    if a then
        client.autocrackvault()
    else
        if client.autocrackvaultThread then
            task.cancel(client.autocrackvaultThread)
            client.autocrackvaultThread = nil
        end
    end
end)
AddToggle(group, "Auto Open Door", function(a)
    configs.robbery.casino.autodoor = a
    if a then client.autocasinodoor() end
end)
AddSlider(group, "Auto Open Door Cooldown", function(a)
    configs.robbery.casino.doorcooldown = a
end, configs.robbery.casino.doorcooldown, 0.1, 5, 1)
local elevatorFloorDropdown = group:AddDropdown("CasinoElevatorFloor", {
  Text = "Choose Elevator Floor",
  Values = { "Vaults", "Ground", "Security", "Roof" },
  Default = 2,
  Callback = function(value)
    local floorMap = { ["Vaults"] = 1, ["Ground"] = 2, ["Security"] = 3, ["Roof"] = 4 }
    configs.robbery.casino.elevatorfloor = floorMap[value] or 2
  end
})
group:AddButton("Call Elevator", function()
  local floorNumber = configs.robbery.casino.elevatorfloor or 2
  client.callcasinoelevator(floorNumber)
end)

local group = tab:AddLeftGroupbox("Oil Rig")
AddToggle(group, "Disable Lasers", function(a)
    configs.robbery.oilrig.disablelasers = a
    client.disableOilRigLasers(a)
end, false, nil, "OilRigLasers")
AddToggle(group, "Auto Grab Keycard", function(a)
    configs.robbery.oilrig.autokeycard = a
    if a then client.autoOilRigKeycardLoop() end
end)
AddToggle(group, "Disable Turret", function(a)
    configs.robbery.oilrig.disableturret = a
    setconstant(client.turret.ShootLaser, 31, a and 9e9 or 0.5)
end, false, nil, "OilRigTurret")
AddToggle(group, "Disable Self Destruct", function(a)
    configs.robbery.oilrig.disableselfdestruct = a
    client.oilexplosion.Name = a and "rendexontop123" or "Explosion"
end, false, "Prevents the oil rig from blowing up")

local group = tab:AddLeftGroupbox("Cargo Ship")
AddToggle(group, "Disable Turret", function(a)
    configs.robbery.cargoship.disableturret = a
    setconstant(client.turret.ShootRocket, 16, a and "yousuck" or "Launch")
end, false, nil, "CargoShipTurret")

local group = tab:AddLeftGroupbox("Cargo Train")
AddToggle(group, "Auto Breach Vault", function(a)
    configs.robbery.cargotrain.autobreach = a
    if a then
        client.autoCargoTrainBreachLoop()
    end
end)

local group = tab:AddLeftGroupbox("Passenger Train")
AddToggle(group, "Auto Grab", function(a)
    configs.robbery.passengertrain.autograb = a
    if a then 
        client.autoPassengerGrabLoop() 
    end
end, false, nil, "PassengerGrab")

local group = tab:AddLeftGroupbox("Mansion")
AddToggle(group, "Disable Lasers", function(a)
    configs.robbery.mansion.disablelasers = a
    client.disableMansionLasers(a)
end, false, nil, "MansionLasers")
AddToggle(group, "Disable Traps", function(a)
  configs.robbery.mansion.disabletraps = a
  client.disableMansionTraps(a)
end)
AddToggle(group, "Bandit Target Boss", function(a)
    configs.robbery.mansion.bandittargetboss = a
    if a then
        client.mansionBanditTargetBoss()
    end
end)
AddToggle(group, "Anti Boss Attack", function(a)
    configs.robbery.mansion.antibossattack = a
end)
AddToggle(group, "Auto Enter Elevator", function(a)
    configs.robbery.mansion.autoelevator = a
    if a then client.autoEnterElevator() end
end)
local InviteLabel = group:AddLabel("Invites: 0", false)

task.spawn(function()
    while true do
        local invites = client.getinvites()
        InviteLabel:SetText(invites > 0 and ("Invites: " .. invites) or "Invites: Not Found")
        task.wait(0.5)
    end
end)

local robberyStatusGroup = tab:AddRightGroupbox("Robbery Statuses")

client.robstatus.labels = {}
client.robstatus.enumList = {}
client.robstatus.last = {}
client.robstatus.running = false

client.robstatus.colors = {
    OPENED = "rgb(73, 230, 133)",
    STARTED = "rgb(255, 170, 60)",
    CLOSED = "rgb(234, 36, 36)",
    UNKNOWN = "rgb(180, 180, 180)",
}

client.robstatus.entries = {
    {label = "Bank", search = {"rising_city_bank", "city_bank", "bank"}},
    {label = "Jewelry", search = {"jewelry"}},
    {label = "Museum", search = {"museum"}},
    {label = "Power Plant", search = {"power_plant", "powerplant"}},
    {label = "Tomb", search = {"tomb"}},
    {label = "Crown Jewel", search = {"crown_jewel", "crownjewel", "casino"}},
    {label = "Mansion", search = {"mansion"}},
    {label = "Passenger Train", search = {"train_passenger", "passenger_train"}},
    {label = "Cargo Train", search = {"train_cargo", "cargo_train"}},
    {label = "Cargo Plane", search = {"cargo_plane"}},
    {label = "Cargo Ship", search = {"cargo_ship"}},
    {label = "Bank Truck", search = {"money_truck", "bank_truck"}},
    {label = "Donut Store", search = {"donut"}},
    {label = "Gas Station", search = {"gas"}},
    {label = "Epic Grocery", search = {"grocery"}},
    {label = "Oil Rig", search = {"oil_rig", "oilrig"}},
    {label = "Airdrops", airdrop = true},
}

client.robstatus.makeLabel = LPH_JIT(function(entry, status)
    local text, color
    if entry.airdrop then
        local count = status or 0
        text = count
        color = count > 0 and client.robstatus.colors.OPENED or client.robstatus.colors.UNKNOWN
    else
        if status == "OPENED" then
            text = "Open"
            color = client.robstatus.colors.OPENED
        elseif status == "STARTED" then
            text = "In Progress"
            color = client.robstatus.colors.STARTED
        elseif status == "CLOSED" then
            text = "Closed"
            color = client.robstatus.colors.CLOSED
        else
            text = "Unknown"
            color = client.robstatus.colors.UNKNOWN
        end
    end
    return entry.label .. ": <font color=\"" .. color .. "\">" .. text .. "</font>"
end)

for i, entry in next, client.robstatus.entries do
    client.robstatus.labels[entry.label] = robberyStatusGroup:AddLabel(client.robstatus.makeLabel(entry))
end

client.robstatus.loadConsts = LPH_JIT(function()
    for i, path in next, {{"Robbery", "RobberyConsts"}, {"Game", "Robbery", "RobberyConsts"}} do
        local cur = replicatedstorage
        for i2, name in next, path do
            cur = cur:FindFirstChild(name)
            if not cur then break end
        end
        if cur then
            local ok, res = pcall(require, cur)
            if ok and type(res) == "table" then return res end
        end
    end
    return nil
end)

client.robstatus.buildEnums = LPH_JIT(function()
    client.robstatus.enumList = {}
    local c = client.robstatus.consts
    if type(c) ~= "table" or type(c.LIST_ROBBERY) ~= "table" then return end
    for i, val in next, c.LIST_ROBBERY do
        local enumName = c.ENUM_ROBBERY and c.ENUM_ROBBERY[val]
        local data = enumName and (c.DATA_ROBBERY[enumName] or c.DATA_ROBBERY[val])
        local key = type(data) == "table" and (data.key or data.name or data.Key or data.Name)
        if enumName and key then
            table.insert(client.robstatus.enumList, {key = tostring(key):lower(), enum = enumName})
        end
    end
end)

client.robstatus.findEnum = LPH_JIT(function(terms)
    for i, term in next, terms do
        for i2, entry in next, client.robstatus.enumList do
            if entry.key == term:lower() then
                return entry.enum
            end
        end
    end
    for i, term in next, terms do
        for i2, entry in next, client.robstatus.enumList do
            if string.find(entry.key, term:lower(), 1, true) then
                return entry.enum
            end
        end
    end
    return nil
end)

client.robstatus.normalize = LPH_JIT(function(raw)
    if raw == nil then return nil end
    if typeof(raw) == "boolean" then return raw and "OPENED" or "CLOSED" end
    if typeof(raw) == "EnumItem" then raw = raw.Name end
    if typeof(raw) == "string" then
        local n = tonumber(raw)
        if n then return client.robstatus.normalize(n) end
        local u = raw:upper()
        if u == "OPEN" then return "OPENED" end
        if u == "START" then return "STARTED" end
        if u == "CLOSE" then return "CLOSED" end
        return u
    end
    if typeof(raw) == "number" then
        local es = client.robstatus.consts and client.robstatus.consts.ENUM_STATE
        if type(es) == "table" then
            for name, v in next, es do
                if v == raw then return client.robstatus.normalize(name) end
            end
        end
        return ({"CLOSED", "OPENED", "STARTED", "CLOSED"})[raw + 1]
    end
    return tostring(raw)
end)

client.robstatus.update = LPH_JIT(function()
    if not client.robstatus.consts then
        client.robstatus.consts = client.robstatus.loadConsts()
        if client.robstatus.consts then
            client.robstatus.buildEnums()
        end
    end

    local state = replicatedstorage:FindFirstChild("RobberyState")

    for i, entry in next, client.robstatus.entries do
        local label = client.robstatus.labels[entry.label]
        if label then
            if entry.airdrop then
                local count = 0
                for i2, v in next, workspace:GetChildren() do
                    if v.Name == "Drop" and v.ClassName == "Model" then
                        count = count + 1
                    end
                end
                label:SetText(client.robstatus.makeLabel(entry, count))
            else
                local status
                if state then
                    local enumName = client.robstatus.findEnum(entry.search)
                    if enumName then
                        local child = state:FindFirstChild(tostring(enumName))
                        if child then
                            local ok, val = pcall(function() return child.Value end)
                            if ok then status = client.robstatus.normalize(val) end
                        end
                    end
                end

                if configs.robbery.robberystatus.notifyonopen and status == "OPENED" and client.robstatus.last[entry.label] ~= "OPENED" then
                    Library:Notify(entry.label .. " is now <font color=\"" .. client.robstatus.colors.OPENED .. "\">open</font>!", 3)
                end
                client.robstatus.last[entry.label] = status

                if configs.robbery.robberystatus.hideclosed and status == "CLOSED" then
                    label:SetText("")
                else
                    label:SetText(client.robstatus.makeLabel(entry, status))
                end
            end
        end
    end
end)

client.robstatus.start = LPH_JIT(function()
    if client.robstatus.running then return end
    client.robstatus.running = true

    local state = replicatedstorage:FindFirstChild("RobberyState") or replicatedstorage:WaitForChild("RobberyState", 15)

    if state then
        local onChange = function()
            client.robstatus.update()
        end

        for i, child in next, state:GetChildren() do
            pcall(function()
                child:GetPropertyChangedSignal("Value"):Connect(onChange)
            end)
        end

        state.ChildAdded:Connect(function(child)
            pcall(function()
                child:GetPropertyChangedSignal("Value"):Connect(onChange)
            end)
            onChange()
        end)

        state.ChildRemoved:Connect(onChange)
    end

    client.robstatus.update()

    task.spawn(function()
        while client.robstatus.running do
            task.wait(1)
            if not client.robstatus.consts then
                client.robstatus.consts = client.robstatus.loadConsts()
                if client.robstatus.consts then
                    client.robstatus.buildEnums()
                end
            end
            client.robstatus.update()
        end
    end)
end)

robberyStatusGroup:AddDivider()

robberyStatusGroup:AddButton("Pop In / Out", function()
    robberyStatusGroup:TogglePoppedOut()
    robberyStatusGroup:SetPopOutWidth(configs.robbery.robberystatus.width)
end)
AddSlider(robberyStatusGroup, "Pop Out Width", function(a)
    configs.robbery.robberystatus.width = a
    robberyStatusGroup:SetPopOutWidth(a)
end, configs.robbery.robberystatus.width, 100, 500, 0, "Adjust the width of the pop-out default is 180")
AddToggle(robberyStatusGroup, "Notify On Open", function(a)
    configs.robbery.robberystatus.notifyonopen = a
end, false, "Notifies when a robbery opens")
AddToggle(robberyStatusGroup, "Hide Closed Robberies", function(a)
    configs.robbery.robberystatus.hideclosed = a
    client.robstatus.update()
end, false, "Hides closed robberies from the list")

local tab = Window:AddTab("Combat", "hand-fist", "Stuff for combat like silent aim & etc.")

local group = tab:AddLeftGroupbox("Projectiles")
AddToggle(group, "Instant Reload", function(a)
    configs.combat.instantreload = a
    client.instantreload()
end, false, "using this with high movement speeds is not recommended (e.g: character flight")
AddToggle(group, "Auto Kill Bandit", function(a)
    configs.combat.autokillbandit = a
    if a then
        client.autoKillBanditLoop()
    end
end)
AddToggle(group, "Bandit Instant Kill", function(a)
    configs.combat.instantkillbandit = a
end)
AddToggle(group, "Always Auto", function(a)
  configs.combat.alwaysauto = a
end)
AddToggle(group, "Anti Recoil", function(a)
  configs.combat.antirecoil = a
end)
AddToggle(group, "Anti Spread", function(a)
  configs.combat.antispread = a
end)
AddToggle(group, "Anti Equip Time", function(a)
  configs.combat.antiequipt = a
end)
AddToggle(group, "Anti Sniper Scope UI", function(a)
    configs.combat.antiscopeui = a
    if a then client.antiscopeui() end
end)
AddToggle(group, "Instant Bullet Hit", function(a)
  configs.combat.instantbullethit = a
end)
AddToggle(group, "Rocket Instant Seek", function(a)
    configs.combat.instantrocketseek = a
    setreadonly(client.rocketconsts, false)
    client.rocketconsts.SEEKING_LOCK_MIN_DURATION = a and 0 or 2
    local equipped = client.itemsys.GetLocalEquipped()
    if equipped and equipped.__ClassName == "RocketLauncher" then
        equipped.targetPartFoundAt = a and 0 or os.clock()
    end
end)
AddToggle(group, "Free Swat Pistol", function(a)
  configs.combat.pistolswat = a
end)
AddToggle(group, "Fast Taser", function(a)
  configs.combat.tasermodz = a
end)
AddToggle(group, "Faster Forcefield Reload", function(a)
  configs.combat.forcefieldreload = a
end)
AddToggle(group, "Anti Forcefield Misses", function(a)
  configs.combat.forcefieldnomiss = a
end)
AddToggle(group, "Shoot Through Forcefield", function(a)
    configs.combat.shootthroughforce = a
    if a then
        client.forcefieldservice.ListShieldsDisabled = {}
        setconstant(client.bulletemitter.Update, 27, "ListShieldsDisabled")
    else
        setconstant(client.bulletemitter.Update, 27, "ListShields")
    end
end)

local group = tab:AddLeftGroupbox("Melee")
AddToggle(group, "Anti Reload Time", function(a)
  configs.combat.batonsword.noreloadtime = a
  if configs.combat.batonsword.noreloadtime then
    client.setBatonSwordTime(configs.combat.batonsword.noreloadtime)
  end
end)
AddToggle(group, "Always Swoosh", function(a)
  configs.combat.batonsword.spamswoosh = a
  if configs.combat.batonsword.spamswoosh then
    client.spamBatonSwordSwoosh()
  end
end)
AddToggle(group, "Always Lunge", function(a)
  configs.combat.batonsword.spamlunge = a
  if configs.combat.batonsword.spamlunge then
    client.spamBatonSwordLunge()
  end
end)

local group = tab:AddRightGroupbox("Silent Aim")

AddToggle(group, "Enabled", function(a)
    configs.combat.silentaim.enabled = a
end, false, nil, "SilentAimEnabled")
AddToggle(group, "Wallcheck", function(a)
  configs.combat.silentaim.wallcheck = a
end)
AddToggle(group, "Include Car Turret", function(a)
  configs.combat.silentaim.includecarturret = a
end)
AddToggle(group, "Include Bandits", function(a)
  configs.combat.silentaim.includebandits = a
end)
AddToggle(group, "Include Taser", function(a)
  configs.combat.silentaim.includetaser = a
end)
AddToggle(group, "Include Plasma", function(a)
  configs.combat.silentaim.includeplasma = a
end)
AddToggle(group, "Friendly Fire", function(a)
  configs.combat.silentaim.friendlyfire = a
end)
AddToggle(group, "FOV Circle", function(a)
  configs.combat.silentaim.fovcirc = a
  Circle.Visible = a
  CircleOutline.Visible = a
end)
AddToggle(group, "FOV Circle Filled", function(a)
  CircleFilled.Visible = a
end)
AddSlider(group, "Radius", function(a)
  configs.combat.silentaim.radius = a
  Circle.Radius = a
  CircleOutline.Radius = a + 2
  CircleFilled.Radius = a - 1
end, 50, 10, 1000, 0)

local group = tab:AddRightGroupbox("Explosives")
AddSlider(group, "Smoke Grenade Throw Speed", function(a)
    configs.combat.smokethrowspeed = a
end, 100, 50, 1000, 0)
AddSlider(group, "Grenade Throw Speed", function(a)
    configs.combat.explosives.grenadethrowspeed = a
end, 100, 50, 1000, 0)
AddSlider(group, "Grenade Fuse Time", function(a)
    configs.combat.explosives.grenadefuse = a
    local eq = client.itemsys.GetLocalEquipped()
    if eq and eq.__ClassName == "Grenade" then
        eq.Config.FuseTime = a
    end
end, 3, 0.1, 10, 1)
AddToggle(group, "Anti Throw Cooldown", function(a)
    configs.combat.explosives.grenadethrowcd = a
    local eq = client.itemsys.GetLocalEquipped()
    if eq and (eq.__ClassName == "Grenade" or eq.__ClassName == "SmokeGrenade") then
        eq.Config.ReloadTime = a and 0.01 or (client.getOldWeaponData(eq.__ClassName, "ReloadTime") or 0.5)
    end
end)
AddToggle(group, "Anti Smoke Effect", function(a)
  configs.combat.nogrenadesmoke = a
  client.smokeGrenadeHook(a)
end)
AddToggle(group, "Anti Smoke Limit", function(a)
  configs.combat.nogrenadesmokelimit = a
  setconstant(client.gethrowablesmokegrenade, 6, a and 0 or 1)
end)

local group = tab:AddRightGroupbox("Gun Store")
group:AddLabel("This only works within 30 studs of a gun store", true)
group:AddButton("Grab All Owned Guns", function()
    client.grabAllOwnedGuns()
end)
group:AddButton("Open Gunstore UI", function()
    client.showgunstore()
end)

local group = tab:AddLeftGroupbox("Car Turret")
AddToggle(group, "Anti Overheat", function(a)
    configs.combat.carturret.antioverheat = a
    client.carturretconfig.MaxHeat = a and math.huge or 2
    client.turretconfig.MaxHeat = a and math.huge or 3
end)
AddToggle(group, "Fast Bullet", function(a)
    configs.combat.carturret.fastbullet = a
    client.carturretconfig.BulletSpeed = a and 5000 or 1200
    client.turretconfig.BulletSpeed = a and 5000 or 600
end)
AddToggle(group, "Follow Mouse", function(a)
    configs.combat.carturret.followmouse = a
    client.followMouseTurret(a)
end)

local group = tab:AddLeftGroupbox("Loadout")
for i = 1, 10 do
    client.loadoutDropdowns[i] = group:AddDropdown("Slot" .. i, {
        Text = "Slot " .. i,
        Searchable = true,
        Values = loadoutDisplay,
        Default = configs.combat.loadout.slots[i],
        Callback = function(value)
            configs.combat.loadout.slots[i] = value
        end 
    })
end
AddToggle(group, "Auto Loadout", function(a)
    configs.combat.loadout.enabled = a
    if a then
        client.applyLoadout()
        client.autoLoadoutLoop()
    end
end)
AddToggle(group, "Auto Grab Loadout", function(a)
    configs.combat.loadout.autograb = a
    if a then
        task.spawn(client.autoGrabLoadout)
    end
end)
AddToggle(group, "Auto Drop Unselected", function(a)
    configs.combat.loadout.dropunselected = a
    if a then
        client.autoDropUnselectedLoop()
    end
end)

local tab = Window:AddTab("Visual", "eye")

local group = tab:AddLeftGroupbox("ESP Options")
AddToggle(group, "Enabled", function(a)
  MainESP.Options.Enabled = a
end, false, nil, "EspEnabled")
AddToggle(group, "Bounties", function(a)
  MainESP.Options.Bounties = a
end)
AddToggle(group, "Box", function(a)
  MainESP.Options.Box = a
end)
AddToggle(group, "Tracer", function(a)
  MainESP.Options.Tracer = a
end)
AddToggle(group, "Name", function(a)
  MainESP.Options.Name = a
end)
AddToggle(group, "Health", function(a)
  MainESP.Options.Health = a
end)
AddToggle(group, "Skeleton", function(a)
  MainESP.Options.Skeleton = a
end)
AddToggle(group, "Distance", function(a)
  MainESP.Options.Distance = a
end)
group:AddDropdown("DistanceUnitDropdown", {
    Values = {"Studs", "Meters", "S", "M"},
    Default = 1,
    Text = "Distance Unit",
    Callback = function(Value)
        MainESP.Options.DistanceUnit = Value
    end
})

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

local group = tab:AddLeftGroupbox("Airdrop ESP Options")
AddToggle(group, "Enabled", function(a)
  MainESP.ObjectOptions.Enabled = a
end, false, nil, "AirdropEnabled")
AddToggle(group, "Tracer", function(a)
  MainESP.ObjectOptions.Tracer = a
end, false, nil, "AirdropTracer")
AddToggle(group, "Name", function(a)
  MainESP.ObjectOptions.Name = a
end, false, nil, "AirdropName")
AddToggle(group, "Distance", function(a)
  MainESP.ObjectOptions.Distance = a
end, false, nil, "AirdropDistance")

local group = tab:AddRightGroupbox("Airdrop ESP Settings")
AddToggle(group, "Rainbow", function(a)
  MainESP.ObjectOptions.Rainbow = a
end, false, nil, "AirdropRainbow")
AddToggle(group, "Text Outline", function(a)
  MainESP.ObjectOptions.TextOutline = a
end, false, nil, "AirdropTextOutline")
AddSlider(group, "Airdrop Text Size", function(a)
  MainESP.ObjectOptions.FontSize = a
end, 15, 1, 50, 0)
group:AddDropdown('AirdropTracerOrigins', {
  Values = { "Top", "Middle", "Bottom" },
  Default = 3,
  Multi = false,
  Text = "Tracer Origins",
  Searchable = false,
  Callback = function(Value)
    MainESP.ObjectOptions.TracerOrigin = Value
  end,
  Visible = true,
})

local tab = Window:AddTab("Miscellaneous", "earth")

local group = tab:AddLeftGroupbox("Money Spoofer")
group:AddLabel("visual of course.", true)
local moneyInput = group:AddInput("MoneyInput", {
    Text = "Amount (e.g. 1b, 1,000,000,000)",
    Default = "",
    Callback = function(value)
        client.moneyInputValue = value
    end
})  
group:AddButton("Apply Money Spoofer", function()
    local amount = client.parseMoneyInput(client.moneyInputValue)
    if amount then
        client.moneySpooferAmount = amount
        if not client.moneySpooferEnabled then
            client.moneySpooferEnabled = true
            task.spawn(client.moneySpooferLoop)
        end
        Library:Notify("Money Spoofer applied: " .. client.formatMoney(amount), 2)
    else
        Library:Notify("Invalid money input", 2)
    end
end)
group:AddButton("Disable Money Spoofer", function()
    client.moneySpooferEnabled = false
    Library:Notify("Will disable fully after earning money.", 2)
end)

local group = tab:AddLeftGroupbox("Servers")
group:AddButton("Server Hop", function()
    ServerHop()
end)
group:AddButton("Rejoin Server", function()
    RejoinServer()
end)
group:AddButton("Voice Chat Server", function()
    ServerHop(17190407811)
end)
group:AddButton("High Roller Server", function()
    ServerHop(108098425719662)
end)
group:AddButton("Trade Server", function()
    ServerHop(9780994092)
end)

local group = tab:AddLeftGroupbox("Military")
AddToggle(group, "Disable Military Turret", function(a)
  configs.others.disablemilitaryturret = a
  client.disablemilitaryturret(a)
end)
AddToggle(group, "Disable Military Forcefield", function(a)
    configs.others.disablemilitaryforcefield = a
    client.disablemilitaryforcefield(a)
end)

local group = tab:AddLeftGroupbox("Protections")
AddToggle(group, "Disable Home Turret", function(a)
  configs.others.disablehometurret = a
  client.getNearestPlayerHook(a)
end)

local group = tab:AddRightGroupbox("Spectate")
local spectateDropdown = group:AddDropdown("SpectateTarget", {
    Text = "Select Player",
    Values = {},
    Default = 1,
    Callback = function(value)
        configs.player.spectatetarget = value
    end
})
local function updateSpectateList()
    local values = {}
    for _, plr in ipairs(players:GetPlayers()) do
        if plr ~= players.LocalPlayer then
            table.insert(values, plr.Name)
        end
    end
    spectateDropdown:SetValues(values)
end
updateSpectateList()
players.PlayerAdded:Connect(updateSpectateList)
players.PlayerRemoving:Connect(function()
    if client.spectateTarget and not players:FindFirstChild(client.spectateTarget.Name) then
        client.unspectate()
    end
    updateSpectateList()
end)
group:AddButton("Spectate", function()
    client.spectate()
end)
group:AddButton("Unspectate", function()
    client.unspectate()
    Library:Notify("Stopped spectating", 3)
end)

local group = tab:AddRightGroupbox("Serverhop Until Bounty")
local bountyInput = group:AddInput("ServerhopBountyInput", {
    Default = "",
    Numeric = false,
    Finished = false,
    ClearTextOnFocus = false,
    Text = "Target Total Bounty (e.g. 100k)",
    Tooltip = "Keeps server hopping until total server bounty reaches the amount.",
    Placeholder = "100k",
    Callback = function(Value)
        client.serverhopBountyValue = Value
    end
})
AddSlider(group, "Serverhop Cooldown", function(a)
    configs.others.serverhopcooldown = a
end, 1, 1, 5, 1, "Seconds between hops")
AddToggle(group, "Serverhop Until Bounty", function(a)
    configs.others.serverhopuntilbounty = a
    if a then
        client.startServerhopUntilBounty()
    else
        client.stopServerhopUntilBounty()
    end
end)

local group = tab:AddRightGroupbox("Fun")
AddToggle(group, "Break Prison Elevator", function(a)
  configs.others.prisonelevator = a
  if a then
    client.prisonelevatorloop()
  else
    client.callprisonelevator(2)
  end
end)
AddToggle(group, "Break Casino Elevator", function(a)
  configs.others.breakelevator = a
  if a then
    client.casinoelevatorloop()
  else
    local elevator = client.getcasinoelevator()
      if elevator and elevator.Car and elevator.Car.InnerModel and elevator.Car.InnerModel.Calls then
        local callButton = elevator.Car.InnerModel.Calls["2"]
        if callButton and callButton:FindFirstChild("ClickDetector") then
          fireclickdetector(callButton.ClickDetector)
        end
      end
  end
end)

local group = tab:AddRightGroupbox("Others")
group:AddButton("Anti Lag", function()
    Window:AddDialog("AntiLagConfirm", {
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
MenuGroup:AddButton({
    Text = "Unload",
    DoubleClick = true,
    Func = function()
        disableAllFeatures()
        Library:Unload()
    end
})

MenuGroup:AddDivider()

MenuGroup:AddButton({
    Text = "Join Our Discord",
    Func = function()
        game:GetService("GuiService"):OpenUrl("https://discord.gg/X4GW8N5GdW")
    end
})
MenuGroup:AddButton({
    Text = "Copy Discord Invite Link",
    Func = function()
        if setclipboard then
            setclipboard("https://discord.gg/X4GW8N5GdW")
            Library:Notify("Copied Discord invite!", 2)
        else
            Library:Notify("Missing setclipboard function", 2)
        end
    end
})
MenuGroup:AddLabel("if you're generous and want to support me:", true)
MenuGroup:AddButton({
    Text = "Copy BTC To Clipboard",
    Func = function()
        if setclipboard then
            setclipboard("bc1qf07mrtsqdwlg9207whprc0pqnkarkeegvqcm2k")
            Library:Notify("Copied BTC address!", 2)
        else
            Library:Notify("Missing setclipboard function", 2)
        end
    end
})
MenuGroup:AddButton({
    Text = "Copy ETH To Clipboard",
    Func = function()
        if setclipboard then
            setclipboard("0xc8855835d25fDa581695aC7F207f2fb03ae0F3B8")
            Library:Notify("Copied ETH address!", 2)
        else
            Library:Notify("Missing setclipboard function", 2)
        end
    end
})
MenuGroup:AddButton({
    Text = "Copy LTC To Clipboard",
    Func = function()
        if setclipboard then
            setclipboard("LVoixxDrAj75WY68ySNQr5KkjZLeKJ4bqZ")
            Library:Notify("Copied LTC address!", 2)
        else
            Library:Notify("Missing setclipboard function", 2)
        end
    end
})
MenuGroup:AddButton({
    Text = "Copy SOL To Clipboard",
    Func = function()
        if setclipboard then
            setclipboard("4Bquk3pvMLSkzSuJ8XQFFZLgepAkXQq9puYwWhGGWtYG")
            Library:Notify("Copied SOL address!", 2)
        else
            Library:Notify("Missing setclipboard function", 2)
        end
    end
})
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder('Rendex')
SaveManager:SetFolder('Rendex/Jailbreak')
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

local group = tab:AddRightGroupbox("Credits")
group:AddLabel("credits to codecoat for the source", true)

PlayerFlightToggle:AddKeyPicker("PlayerFlightKey", {
  Default = "X",
  Text = "Player Flight",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.ftog = a
    if a then
      client.launchPlayerFlight()
    end
  end
})

VehicleFlightToggle:AddKeyPicker("VehicleFlightKey", {
  Default = "Z",
  Text = "Vehicle Flight",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.vehicle.ftog = a
    if a and client.vehicleEntered == true then
      client.launchVehicleFlight()
    end
  end
})

NoclipToggle:AddKeyPicker("NoclipKey", {
  Default = "N",
  Text = "Noclip",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.noclip = a
    if a then
        client.noclipLoop()
    else
        for part, a in pairs(client._noclipCache) do
            if part and part.Parent then
                part.CanCollide = a
            end
        end
        client._noclipCache = {}
    end
  end
})

AlwaysJuicedToggle:AddKeyPicker("AlwaysJuicedKey", {
  Default = "K",
  Text = "Always Juiced",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.player.juiced = a
  end
})

SuspensionToggle:AddKeyPicker("SusHeightKey", {
  Default = "K",
  Text = "Suspension Height",
  SyncToggleState = true,
  Mode = "Toggle",
  Callback = function(a)
    configs.vehicle.suspension = a
    client.updateToOriginalChassisStats()
  end
})

local loadTime = math.floor((tick() - time) * 100) / 100
Library:Notify("Loaded in " .. loadTime .. " seconds!", 3)
if client.ispc() then
  Library:Notify("Right shift to open", 3)
end

debugPrint("cheatcheck:", cheatcheck)
debugPrint("cheatcheck0:", cheatcheck0)

client.planeModify()
client.jetskiModify()
client.boatModify()
if client.robstatus and client.robstatus.start then
    client.robstatus.start()
end

client.getTotalServerBounty = LPH_JIT(function()
    local total = 0
    pcall(function()
        local module = require(replicatedstorage.Bounty.BountyBoardService)
        for i, v in next, module.Bounties do
            if v.Bounty then
                total = total + v.Bounty
            end
        end
    end)
    return total
end)
task.defer(function()
    task.wait(1)
    local wasEnabled, savedTarget = client.loadServerhopState()
    if wasEnabled and savedTarget ~= "" then
        client.serverhopBountyValue = savedTarget
        configs.others.serverhopuntilbounty = true

        pcall(function()
            if Options.ServerhopBountyInput then Options.ServerhopBountyInput:SetValue(savedTarget) end
            if Options.ServerhopUntilBounty then Options.ServerhopUntilBounty:SetValue(true) end
        end)

        client.startServerhopUntilBounty()
    end
end)
task.spawn(LPH_NO_VIRTUALIZE(function()
    while task.wait(5) do
        local total = client.getTotalServerBounty()
        local formatted = client.formatMoney(total)
        Window:SetFooter("Rendex | Jailbreak | Total Server Bounty: " .. formatted)
    end
end))
task.spawn(LPH_NO_VIRTUALIZE(function()
    while task.wait(2) do
        local r = configs.robbery
        if r.bank.disablelasers then client.disableBankLasers(true) end
        if r.museum.disablelasers then client.disableMuseumLasers(true) end
        if r.casino.disablelasers then client.disableCasinoLasers(true) end
        if r.oilrig.disablelasers then client.disableOilRigLasers(true) end
        if r.tomb.disableplanks then client.disableTombPlanks(true) end
        if r.tomb.disablespikes then client.disableTombSpikes(true) end
        if r.tomb.bridgebreak then client.disableTombBridgeBreak(true) end
        if r.tomb.disablelava then client.disableTombLava(true) end
        if r.jewelry.disablelasers then client.disableJewelryLasers(true) end
        if r.mansion.disablelasers then client.disableMansionLasers(true) end
        if r.mansion.disabletraps then client.disableMansionTraps(true) end
        if r.powerplant.disablelasers then client.disablePowerPlantLasers(true) end
        if r.powerplant.disablepistons then client.disablePowerPlantPistons(true) end
    end
end))
