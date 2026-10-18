-- v 0.1
-- very bad

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

local hookMetamethod = hookmetamethod
local newClosure = newcclosure or function(f) return f end
local isCallerInternal = checkcaller or function() return false end
local getNamecallMethod = getnamecallmethod or function() return "" end
local importModule = require
local loadChunk = loadstring
local GlobalEnv = (getgenv or function() return _G end)()

local DEFAULTS = {
	Enabled = true,
	Mult = 8,
	Running = true,
	Softside = true,
	Spam = true,
	Silent = true,
	SilentFOV = 160,
	SilentWall = true,
	SilentCircle = true,
	SilentHook = false,
	NoRecoil = true,
	OriginSpoof = false,
	AimRotate = true,
	ESP = true,
	ESPDist = 1200,
	ESPOn = { Hemp = true, Stone = true, Metal = true, Sulfur = true, Wood = false, Crates = true },
	StorOn = { Guns = true, Ammo = true, Explosives = true },
	PlayerESP = true,
	PE_TeamCheck = true,
	PE_Box = true,
	PE_BoxFill = false,
	PE_Tracer = true,
	PE_Skeleton = true,
	PE_HeadDot = true,
	PE_Chams = false,
	PE_Name = true,
	PE_Health = true,
	PE_Distance = true,
	PE_VisFlag = true,
	PE_MaxDist = 1500,
	PE_TextSize = 13,
	WalkSpeedOn = false,
	WalkSpeedVal = 16,
	Fullbright = false,
	NoFog = false,
}

local Config = GlobalEnv.fasttools or DEFAULTS
GlobalEnv.fasttools = Config
GlobalEnv.FTHookGen = (GlobalEnv.FTHookGen or 0) + 1

local PE_Colors = {
	Box = Color3.fromRGB(255, 255, 255),
	BoxFill = Color3.fromRGB(255, 0, 0),
	Tracer = Color3.fromRGB(255, 255, 255),
	Skeleton = Color3.fromRGB(255, 255, 255),
	HeadDot = Color3.fromRGB(255, 80, 80),
	Name = Color3.fromRGB(255, 255, 255),
	HealthTop = Color3.fromRGB(0, 255, 0),
	HealthBottom = Color3.fromRGB(255, 0, 0),
	Distance = Color3.fromRGB(255, 255, 255),
	ChamsFill = Color3.fromRGB(255, 255, 255),
	ChamsOutline = Color3.fromRGB(255, 255, 255),
	VisVisible = Color3.fromRGB(120, 255, 150),
	VisHidden = Color3.fromRGB(255, 90, 90),
}
Config.PE_Colors = PE_Colors

local Connections = {}
local PlayerESPState = {}
local ResourceESPList = {}
local StorageBillboards = {}
local SpoofOrigin = nil
local unload

local Replication = ReplicatedStorage:WaitForChild("Replication", 10)
local ReplicationEvents = Replication and Replication:WaitForChild("Events", 10)
local AttackRemote = ReplicationEvents and ReplicationEvents:WaitForChild("Attack", 10)
local GunSystem = ReplicatedStorage:WaitForChild("GunSystem", 10)
local GunRemotes = GunSystem and GunSystem:WaitForChild("RemoteEvents", 10)
local ShotRemote = GunRemotes and GunRemotes:WaitForChild("Shot", 10)
local BowRemote = GunRemotes and GunRemotes:WaitForChild("BowShoot", 10)
local ToolSystem = ReplicatedStorage:WaitForChild("ToolSystem", 10)
local ToolRemotes = ToolSystem and ToolSystem:WaitForChild("RemoteEvents", 10)
local SwingRemote = ToolRemotes and ToolRemotes:WaitForChild("Swing", 10)
local GetSidesRemote = ToolRemotes and ToolRemotes:WaitForChild("GetSides", 10)

local TOOL_TIMINGS = {
	MP5 = 420,
	["Semi-Automatic Pistol"] = 330,
	["Old Revolver"] = 270,
	["Double Barrel Shotgun"] = 150,
	["Badger Rifle"] = 400,
	["Nomad Rifle"] = 400,
	Thompson = 400,
	["Rocket Launcher"] = 60,
}

local TOOL_SWING = {
	Rock = { 0.34, 0.5, 0.6 },
	["Stone Hatchet"] = { 0.28, 0.5, 0.25 },
	["Metal Hatchet"] = { 0.28, 0.5, 0.25 },
	["Stone Pickaxe"] = { 0.29, 0.47, 0.25 },
	["Metal Pickaxe"] = { 0.29, 0.47, 0.25 },
}

local STORAGE_FILTERS = {
	Guns = {
		Items = {
			MP5 = true, ["Semi-Automatic Pistol"] = true, ["Old Revolver"] = true,
			["Double Barrel Shotgun"] = true, ["Badger Rifle"] = true, ["Nomad Rifle"] = true,
			Thompson = true, ["Rocket Launcher"] = true, Bow = true,
		},
		Color = Color3.fromRGB(255, 140, 0),
		Pri = 2,
	},
	Ammo = {
		Items = { ["Pistol Bullet"] = true, ["Rifle Bullet"] = true, ["Shotgun Shell"] = true, Arrow = true },
		Color = Color3.fromRGB(230, 100, 100),
		Pri = 1,
	},
	Explosives = {
		Items = { C4 = true, Dynamite = true, Gunpowder = true, Rocket = true },
		Color = Color3.fromRGB(180, 0, 255),
		Pri = 3,
	},
}

local ESP_CATEGORIES = {
	Hemp = { Color = Color3.fromRGB(90, 255, 130), Names = { Cloth = true, ClothOld = true, Hemp = true } },
	Stone = { Color = Color3.fromRGB(200, 200, 200), Names = { Stone = true, Rock = true } },
	Metal = { Color = Color3.fromRGB(170, 170, 190), Names = { Metal = true } },
	Sulfur = { Color = Color3.fromRGB(255, 230, 80), Names = { Sulfur = true } },
	Wood = { Color = Color3.fromRGB(150, 100, 60), Names = { Wood = true } },
	Crates = { Color = Color3.fromRGB(190, 120, 255), Names = { Crates = true, Crate = true } },
}

local SPAWN_FOLDERS = { "OreSpawns", "TreeSpawns", "Junkpiles", "Airdrops" }

local BONES = {
	{ "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
	{ "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
	{ "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
	{ "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
	{ "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" },
}

local SKYBOXES = {
	City = {
		SkyboxBk = "http://www.roblox.com/asset/?id=9134792889",
		SkyboxDn = "http://www.roblox.com/asset/?id=9134791975",
		SkyboxFt = "http://www.roblox.com/asset/?id=9134793457",
		SkyboxLf = "http://www.roblox.com/asset/?id=9134791234",
		SkyboxRt = "http://www.roblox.com/asset/?id=9134790419",
		SkyboxUp = "http://www.roblox.com/asset/?id=9134791633",
	},
	Spongebob = {
		SkyboxBk = "http://www.roblox.com/asset/?id=159248188",
		SkyboxDn = "http://www.roblox.com/asset/?id=159248183",
		SkyboxFt = "http://www.roblox.com/asset/?id=159248187",
		SkyboxLf = "http://www.roblox.com/asset/?id=159248173",
		SkyboxRt = "http://www.roblox.com/asset/?id=159248188",
		SkyboxUp = "http://www.roblox.com/asset/?id=159248188",
	},
	["Clouded Sky"] = {
		SkyboxBk = "http://www.roblox.com/asset/?id=252760986",
		SkyboxDn = "http://www.roblox.com/asset/?id=252760986",
		SkyboxFt = "http://www.roblox.com/asset/?id=252760986",
		SkyboxLf = "http://www.roblox.com/asset/?id=252760986",
		SkyboxRt = "http://www.roblox.com/asset/?id=252760986",
		SkyboxUp = "http://www.roblox.com/asset/?id=252762652",
	},
	Retro = {
		SkyboxBk = "rbxasset://sky/null_plainsky512_bk.jpg",
		SkyboxDn = "rbxasset://sky/null_plainsky512_dn.jpg",
		SkyboxFt = "rbxasset://sky/null_plainsky512_ft.jpg",
		SkyboxLf = "rbxasset://sky/null_plainsky512_lf.jpg",
		SkyboxRt = "rbxasset://sky/null_plainsky512_rt.jpg",
		SkyboxUp = "rbxasset://sky/null_plainsky512_up.jpg",
	},
	["Pink Sky"] = {
		SkyboxBk = "http://www.roblox.com/asset/?id=7890140060",
		SkyboxDn = "http://www.roblox.com/asset/?id=7890140060",
		SkyboxFt = "http://www.roblox.com/asset/?id=7890140060",
		SkyboxLf = "http://www.roblox.com/asset/?id=7890140060",
		SkyboxRt = "http://www.roblox.com/asset/?id=7890140060",
		SkyboxUp = "http://www.roblox.com/asset/?id=7890140060",
	},
	["My Summer Car"] = {
		SkyboxBk = "rbxassetid://16648617436",
		SkyboxDn = "rbxassetid://16648595424",
		SkyboxFt = "rbxassetid://16648566370",
		SkyboxLf = "rbxassetid://16648577071",
		SkyboxRt = "rbxassetid://16648598180",
		SkyboxUp = "rbxassetid://16648598180",
	},
}

local LightingSnapshot = {
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogStart = Lighting.FogStart,
	FogEnd = Lighting.FogEnd,
	GlobalShadows = Lighting.GlobalShadows,
}

local function makeDrawing(class, props)
	local drawing = Drawing.new(class)
	for key, value in pairs(props or {}) do
		drawing[key] = value
	end
	return drawing
end

local function makePlayerESP()
	local esp = {}
	esp.box = makeDrawing("Square", { Visible = false, Thickness = 1, Filled = false })
	esp.box_out = makeDrawing("Square", { Visible = false, Thickness = 3, Filled = false, Color = Color3.new(0, 0, 0), ZIndex = -1 })
	esp.box_fill = makeDrawing("Square", { Visible = false, Thickness = 1, Filled = true })
	esp.tracer = makeDrawing("Line", { Visible = false, Thickness = 1 })
	esp.tracer_ol = makeDrawing("Line", { Visible = false, Thickness = 3, Color = Color3.new(0, 0, 0) })
	esp.name = makeDrawing("Text", { Visible = false, Center = true, Outline = true, Font = 2 })
	esp.dist = makeDrawing("Text", { Visible = false, Center = true, Outline = true, Font = 2 })
	esp.hp_bg = makeDrawing("Square", { Visible = false, Thickness = 1, Filled = true, Color = Color3.new(0, 0, 0) })
	esp.hp_bar = makeDrawing("Square", { Visible = false, Thickness = 1, Filled = true })
	esp.headdot = makeDrawing("Circle", { Visible = false, Filled = true, Radius = 2 })
	esp.skel = {}
	for index = 1, #BONES do
		esp.skel[index] = makeDrawing("Line", { Visible = false, Thickness = 1.5 })
	end
	esp.chams = Instance.new("Highlight")
	esp.chams.Adornee = nil
	esp.chams.Enabled = false
	return esp
end

local function hidePlayerESP(esp)
	for key, drawing in pairs(esp) do
		if key ~= "skel" and key ~= "chams" and drawing.Remove then
			drawing.Visible = false
		end
	end
	for index = 1, #BONES do
		esp.skel[index].Visible = false
	end
	esp.chams.Enabled = false
end

local function removePlayerESP(esp)
	for key, drawing in pairs(esp) do
		if key ~= "skel" and key ~= "chams" and drawing.Remove then
			drawing:Remove()
		end
	end
	for index = 1, #BONES do
		esp.skel[index]:Remove()
	end
	esp.chams:Destroy()
end

local FOVCircle = makeDrawing("Circle", {
	Visible = false,
	Filled = false,
	Thickness = 1,
	Transparency = 0.7,
	Color = Color3.fromRGB(255, 80, 80),
})

local function worldToScreen(position)
	local camera = workspace.CurrentCamera
	local relative = camera.CFrame:PointToObjectSpace(position)
	if relative.Z >= -0.01 then
		return nil, false
	end
	local scale = (camera.ViewportSize.Y / 2) / math.tan(math.rad(camera.FieldOfView) / 2)
	local x = camera.ViewportSize.X / 2 + (relative.X / -relative.Z) * scale
	local y = camera.ViewportSize.Y / 2 - (relative.Y / -relative.Z) * scale
	return Vector2.new(x, y), true
end

local function wallCheck(origin, target, character)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Blacklist
	params.FilterDescendantsInstances = { LocalPlayer.Character, character, workspace.CurrentCamera }
	local result = workspace:Raycast(origin, (target - origin), params)
	return result == nil
end

local function leadPosition(position, velocity, flight, clampMagnitude)
	local lead = velocity * flight
	if lead.Magnitude > clampMagnitude then
		lead = lead.Unit * clampMagnitude
	end
	return position + lead
end

local function ballisticDirection(origin, target)
	local offset = target - origin
	local speed = 110
	local gravity = workspace.Gravity
	local maxFlight = math.min(offset.Magnitude / speed + 0.35, 2.727272727272727)
	local dirFor = function(flight)
		return (offset + Vector3.new(0, 0.5 * gravity * flight * flight, 0)).Unit
	end
	local err = function(flight)
		return (origin + dirFor(flight) * (speed * flight)).Y - target.Y
	end
	if err(maxFlight) <= 0 then
		return dirFor(maxFlight)
	end
	local low, high = 0, maxFlight
	for _ = 1, 24 do
		local mid = (low + high) / 2
		if err(mid) > 0 then
			high = mid
		else
			low = mid
		end
	end
	return dirFor((low + high) / 2)
end

local function getEquippedName()
	local character = LocalPlayer.Character
	if not character then
		return nil
	end
	local tool = character:FindFirstChildOfClass("Tool")
	return tool and tool.Name or nil
end

local function findTarget()
	local camera = workspace.CurrentCamera
	local center = camera.ViewportSize / 2
	local fov = Config.SilentFOV
	local best, bestDist = nil, fov
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
			local root = player.Character:FindFirstChild("HumanoidRootPart")
			if humanoid and root and humanoid.Health > 0 then
				local screen, onScreen = worldToScreen(root.Position)
				if onScreen then
					local delta = screen - center
					local distance = delta.Magnitude
					if distance <= bestDist then
						best, bestDist = player, distance
					end
				end
			end
		end
	end
	return best
end

local function runSilent()
	if not Config.Silent then
		return
	end
	local target = findTarget()
	if not target then
		return
	end
	local character = target.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not root or not humanoid or humanoid.Health <= 0 then
		return
	end
	local camera = workspace.CurrentCamera
	local origin = camera.CFrame.Position
	local equipped = getEquippedName()
	local isBow = equipped == "Bow"
	local flightBase = TOOL_TIMINGS[equipped] and 0.3 or 0.35
	local velocity = root.AssemblyLinearVelocity or Vector3.zero
	local aimPoint
	if isBow then
		aimPoint = leadPosition(root.Position, velocity, (root.Position - origin).Magnitude / 110 + flightBase, 8)
	else
		aimPoint = leadPosition(root.Position, velocity, flightBase, 5)
	end
	aimPoint = aimPoint + ballisticDirection(origin, aimPoint) * 0
	if Config.SilentWall then
		if not wallCheck(origin, root.Position, character) then
			return
		end
	else
		SpoofOrigin = { Pos = aimPoint, Time = os.clock(), Bow = isBow }
	end
	if Config.AimRotate and LocalPlayer.Character then
		local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if myRoot then
			myRoot.CFrame = CFrame.lookAt(myRoot.Position, aimPoint, Vector3.new(0, 1, 0))
		end
	end
end

local function hasVestFlag(model)
	local armor = model and model:FindFirstChild("CharacterArmor")
	return armor ~= nil and armor:FindFirstChild("VestDetails") ~= nil
end

local function updateFOVCircle()
	local camera = workspace.CurrentCamera
	FOVCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
	FOVCircle.Radius = Config.SilentFOV
	FOVCircle.Visible = (Config.Silent and Config.SilentCircle) == true
end

local function updatePlayerESP()
	for player, esp in pairs(PlayerESPState) do
		if not player.Parent or not player.Character then
			hidePlayerESP(esp)
			continue
		end
		local character = player.Character
		local head = character:FindFirstChild("Head")
		local root = character:FindFirstChild("HumanoidRootPart")
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not head or not root or not humanoid or humanoid.Health <= 0 then
			hidePlayerESP(esp)
			continue
		end
		if Config.PE_TeamCheck and player.Team == LocalPlayer.Team and player.Team ~= nil then
			hidePlayerESP(esp)
			continue
		end
		local camera = workspace.CurrentCamera
		local distance = (root.Position - camera.CFrame.Position).Magnitude
		if distance > Config.PE_MaxDist then
			hidePlayerESP(esp)
			continue
		end
		local top, topOn = worldToScreen(head.Position + Vector3.new(0, head.Size.Y / 2, 0))
		local bottom, bottomOn = worldToScreen(root.Position - Vector3.new(0, root.Size.Y / 2, 0))
		if not topOn or not bottomOn then
			hidePlayerESP(esp)
			continue
		end
		local height = bottom.Y - top.Y
		local width = height / 2
		local visible = not hasVestFlag(character)
		local baseColor = Config.PE_VisFlag and (visible and PE_Colors.VisVisible or PE_Colors.VisHidden) or PE_Colors.Box
		local size = Config.PE_TextSize
		if Config.PE_Box then
			esp.box.Visible = true
			esp.box.Color = baseColor
			esp.box.Position = Vector2.new(top.X - width / 2, top.Y)
			esp.box.Size = Vector2.new(width, height)
			esp.box_out.Visible = true
			esp.box_out.Position = esp.box.Position - Vector2.new(1, 1)
			esp.box_out.Size = esp.box.Size + Vector2.new(2, 2)
		else
			esp.box.Visible = false
			esp.box_out.Visible = false
		end
		if Config.PE_BoxFill then
			esp.box_fill.Visible = true
			esp.box_fill.Color = PE_Colors.BoxFill
			esp.box_fill.Transparency = 0.6
			esp.box_fill.Position = esp.box.Position
			esp.box_fill.Size = esp.box.Size
		else
			esp.box_fill.Visible = false
		end
		if Config.PE_Tracer then
			esp.tracer.Visible = true
			esp.tracer.Color = PE_Colors.Tracer
			esp.tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
			esp.tracer.To = Vector2.new(top.X, bottom.Y)
			esp.tracer_ol.Visible = true
			esp.tracer_ol.From = esp.tracer.From
			esp.tracer_ol.To = esp.tracer.To
		else
			esp.tracer.Visible = false
			esp.tracer_ol.Visible = false
		end
		if Config.PE_Name then
			esp.name.Visible = true
			esp.name.Color = PE_Colors.Name
			esp.name.Size = size
			esp.name.Position = Vector2.new(top.X, top.Y - size - 2)
			esp.name.Text = player.Name
		else
			esp.name.Visible = false
		end
		if Config.PE_Distance then
			esp.dist.Visible = true
			esp.dist.Color = PE_Colors.Distance
			esp.dist.Size = size
			esp.dist.Position = Vector2.new(top.X, bottom.Y + 2)
			esp.dist.Text = tostring(math.floor(distance)) .. "m"
		else
			esp.dist.Visible = false
		end
		if Config.PE_Health then
			local fraction = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
			esp.hp_bg.Visible = true
			esp.hp_bg.Position = Vector2.new(top.X - width / 2 - 4, top.Y)
			esp.hp_bg.Size = Vector2.new(2, height)
			esp.hp_bar.Visible = true
			esp.hp_bar.Color = PE_Colors.HealthBottom:Lerp(PE_Colors.HealthTop, fraction)
			esp.hp_bar.Position = Vector2.new(top.X - width / 2 - 4, top.Y + height * (1 - fraction))
			esp.hp_bar.Size = Vector2.new(2, height * fraction)
		else
			esp.hp_bg.Visible = false
			esp.hp_bar.Visible = false
		end
		if Config.PE_HeadDot then
			local headScreen, on = worldToScreen(head.Position)
			esp.headdot.Visible = on
			esp.headdot.Color = PE_Colors.HeadDot
			if on then
				esp.headdot.Position = headScreen
			end
		else
			esp.headdot.Visible = false
		end
		if Config.PE_Skeleton then
			for index = 1, #BONES do
				local partA = character:FindFirstChild(BONES[index][1])
				local partB = character:FindFirstChild(BONES[index][2])
				local line = esp.skel[index]
				if partA and partB then
					local pointA, onA = worldToScreen(partA.Position)
					local pointB, onB = worldToScreen(partB.Position)
					line.Visible = onA and onB
					line.Color = PE_Colors.Skeleton
					if line.Visible then
						line.From = pointA
						line.To = pointB
					end
				else
					line.Visible = false
				end
			end
		else
			for index = 1, #BONES do
				esp.skel[index].Visible = false
			end
		end
		if Config.PE_Chams then
			esp.chams.Parent = character
			esp.chams.Adornee = character
			esp.chams.Enabled = true
			esp.chams.FillColor = PE_Colors.ChamsFill
			esp.chams.OutlineColor = PE_Colors.ChamsOutline
			esp.chams.FillTransparency = 0.7
			esp.chams.OutlineTransparency = 0
		else
			esp.chams.Enabled = false
		end
	end
end

local function scanResourceNodes()
	for _, folderName in ipairs(SPAWN_FOLDERS) do
		local folder = workspace:FindFirstChild(folderName)
		if folder then
			for _, node in ipairs(folder:GetChildren()) do
				local known = false
				for categoryKey, category in pairs(ESP_CATEGORIES) do
					if category.Names[node.Name] then
						known = true
						local registered = false
						for _, entry in ipairs(ResourceESPList) do
							if entry.m == node then
								registered = true
								entry.cat = categoryKey
								break
							end
						end
						if not registered then
							table.insert(ResourceESPList, { m = node, cat = categoryKey })
						end
						break
					end
				end
				if not known then
					continue
				end
			end
		end
	end
end

local function updateResourceESP()
	local camera = workspace.CurrentCamera
	local origin = camera.CFrame.Position
	for index = #ResourceESPList, 1, -1 do
		local entry = ResourceESPList[index]
		local model = entry.m
		if not model:IsDescendantOf(workspace) then
			table.remove(ResourceESPList, index)
			continue
		end
		if not Config.ESPOn[entry.cat] then
			local highlight = model:FindFirstChild("FT_ESP")
			if highlight then
				highlight.Enabled = false
			end
			continue
		end
		local ok, pivot = pcall(function()
			return model:GetPivot()
		end)
		if not ok then
			continue
		end
		local distance = (pivot.Position - origin).Magnitude
		local highlight = model:FindFirstChild("FT_ESP")
		if distance <= Config.ESPDist then
			if not highlight then
				highlight = Instance.new("Highlight")
				highlight.Name = "FT_ESP"
				highlight.FillTransparency = 1
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlight.Parent = model
			end
			highlight.Enabled = true
			highlight.OutlineColor = ESP_CATEGORIES[entry.cat].Color
		elseif highlight then
			highlight.Enabled = false
		end
	end
end

local function scanStorage(container, output)
	local storage = container:FindFirstChild("Storage")
	if not storage then
		return output
	end
	for _, slot in ipairs(storage:GetChildren()) do
		local itemName = slot:FindFirstChild("ItemName")
		if itemName and itemName.Value ~= "" then
			for categoryKey, category in pairs(STORAGE_FILTERS) do
				if Config.StorOn[categoryKey] and category.Items[itemName.Value] then
					if category.Pri > output.Pri then
						output.Pri = category.Pri
						output.Color = category.Color
					end
					if #output.Lines < 8 then
						local amount = slot:FindFirstChild("Amount")
						table.insert(output.Lines, itemName.Value .. (amount and (" x" .. amount.Value) or ""))
					end
					break
				end
			end
		end
	end
	return output
end

local function updateStorageESP()
	local sources = {}
	local structures = workspace:FindFirstChild("PlayerBuiltStructures")
	local deployables = structures and structures:FindFirstChild("Deployables")
	if deployables then
		for _, child in ipairs(deployables:GetChildren()) do
			table.insert(sources, child)
		end
	end
	local junk = workspace:FindFirstChild("Junkpiles")
	if junk then
		for _, child in ipairs(junk:GetChildren()) do
			table.insert(sources, child)
		end
	end
	local alive = {}
	for _, container in ipairs(sources) do
		local result = scanStorage(container, { Lines = {}, Pri = 0, Color = Color3.fromRGB(255, 255, 255) })
		local signature = table.concat(result.Lines, "|")
		local billboard = StorageBillboards[container]
		if signature == "" then
			if billboard then
				billboard:Destroy()
				StorageBillboards[container] = nil
			end
			continue
		end
		alive[container] = true
		if not billboard then
			billboard = Instance.new("BillboardGui")
			billboard.Name = "FT_STORBB"
			billboard.Adornee = container
			billboard.AlwaysOnTop = true
			billboard.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
			billboard.Size = UDim2.new(0, 220, 0, 100)
			local label = Instance.new("TextLabel")
			label.Name = "FT_T"
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, 0, 1, 0)
			label.TextStrokeTransparency = 0.2
			label.TextSize = 12
			label.Font = Enum.Font.SourceSansBold
			label.TextXAlignment = Enum.TextXAlignment.Center
			label.TextYAlignment = Enum.TextXAlignment.Center
			label.Parent = billboard
			billboard.Parent = container
			StorageBillboards[container] = billboard
		end
		local label = billboard:FindFirstChild("FT_T")
		if label and label.Text ~= signature then
			label.Text = signature
			label.TextColor3 = result.Color
		end
	end
	for container, billboard in pairs(StorageBillboards) do
		if not alive[container] then
			billboard:Destroy()
			StorageBillboards[container] = nil
		end
	end
end

local function applyFullbright(enabled)
	if enabled then
		Lighting.Ambient = Color3.fromRGB(255, 255, 255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		Lighting.Brightness = 3
		Lighting.ClockTime = 12
		Lighting.GlobalShadows = false
	else
		Lighting.Ambient = LightingSnapshot.Ambient
		Lighting.OutdoorAmbient = LightingSnapshot.OutdoorAmbient
		Lighting.Brightness = LightingSnapshot.Brightness
		Lighting.ClockTime = LightingSnapshot.ClockTime
		Lighting.GlobalShadows = LightingSnapshot.GlobalShadows
	end
end

local function applyNoFog(enabled)
	if enabled then
		Lighting.FogEnd = 9000000000
		Lighting.FogStart = 0
		local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
		if atmosphere then
			atmosphere.Density = 0
			atmosphere.Haze = 0
			atmosphere.Glare = 0
		end
	else
		Lighting.FogEnd = LightingSnapshot.FogEnd
		Lighting.FogStart = LightingSnapshot.FogStart
	end
end

local function setWeather(kind)
	local camera = workspace.CurrentCamera
	local existing = camera:FindFirstChild("MD_Weather")
	if existing then
		existing:Destroy()
	end
	if kind == "None" then
		return
	end
	local part = Instance.new("Part")
	part.Name = "MD_Weather"
	part.Size = Vector3.new(100, 1, 100)
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.Parent = camera
	local emitter = Instance.new("ParticleEmitter")
	emitter.Parent = part
	emitter.EmissionDirection = Enum.NormalId.Bottom
	emitter.Enabled = true
	if kind == "Rain" then
		emitter.Texture = "rbxassetid://241868005"
		emitter.Rate = 10000
		emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
		emitter.LightEmission = 0.2
		emitter.Transparency = NumberSequence.new(0)
		emitter.Size = NumberSequence.new(3, 6)
		emitter.Lifetime = NumberRange.new(2, 2.5)
		emitter.Speed = NumberRange.new(80, 100)
		emitter.SpreadAngle = Vector2.new(0, 0)
		emitter.Acceleration = Vector3.new(0, -50, 0)
		emitter.Orientation = Enum.ParticleOrientation.FaceCamera
	elseif kind == "Snow" then
		emitter.Texture = "rbxassetid://162685588"
		emitter.Rate = 400
		emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
		emitter.LightEmission = 0
		emitter.Transparency = NumberSequence.new(0)
		emitter.Size = NumberSequence.new(1, 2)
		emitter.Lifetime = NumberRange.new(4, 6)
		emitter.Speed = NumberRange.new(10, 20)
		emitter.SpreadAngle = Vector2.new(10, 10)
		emitter.Acceleration = Vector3.new(0, -5, 0)
		emitter.Orientation = Enum.ParticleOrientation.FaceCamera
	elseif kind == "Hell Fire" then
		emitter.Texture = "rbxassetid://241868005"
		emitter.Rate = 4000
		emitter.Color = ColorSequence.new(Color3.fromRGB(255, 120, 20))
		emitter.LightEmission = 1
		emitter.Transparency = NumberSequence.new(0)
		emitter.Size = NumberSequence.new(2, 5)
		emitter.Lifetime = NumberRange.new(1, 2)
		emitter.Speed = NumberRange.new(30, 60)
		emitter.SpreadAngle = Vector2.new(20, 20)
		emitter.Acceleration = Vector3.new(0, 40, 0)
		emitter.Orientation = Enum.ParticleOrientation.FaceCamera
	end
end

local function setSkybox(kind)
	local existing = Lighting:FindFirstChild("MD_Sky")
	if existing then
		existing:Destroy()
	end
	if kind == "Default" then
		return
	end
	local faces = SKYBOXES[kind]
	if not faces then
		return
	end
	for _, child in ipairs(Lighting:GetChildren()) do
		if child:IsA("Atmosphere") or child:IsA("Clouds") then
			child:Destroy()
		end
	end
	local sky = Instance.new("Sky")
	sky.Name = "MD_Sky"
	for face, url in pairs(faces) do
		sky[face] = url
	end
	sky.SunTextureId = ""
	sky.MoonTextureId = ""
	sky.StarCount = 0
	sky.Parent = Lighting
end

local function patchRecoil()
	if not Config.NoRecoil then
		return
	end
	local ok, toolModule = pcall(function()
		return importModule(ToolSystem)
	end)
	if not ok or type(toolModule) ~= "table" or type(toolModule.GetRecoil) ~= "function" then
		return
	end
	local count = 0
	local index = nil
	while true do
		index = next(debug.getupvalues(toolModule.GetRecoil), index)
		if index == nil then
			break
		end
		count += 1
	end
	if count == 1 then
		toolModule.GetRecoil = function()
			return 0
		end
	end
end

if GetSidesRemote then
	GetSidesRemote.OnClientInvoke = function(...)
		local ok, target = pcall(function()
			return LocalPlayer:GetMouse().Target
		end)
		if ok and target then
			return target
		end
		return ...
	end
end

local originalNamecall = nil
originalNamecall = hookMetamethod(game, "__namecall", newClosure(function(target, ...)
	if isCallerInternal() then
		return originalNamecall(target, ...)
	end
	local method = getNamecallMethod()
	local args = table.pack(...)
	if method == "FindFirstChild" and args[1] == "Softside" and Config.Softside then
		return target
	end
	if method == "FireServer" and (target == ShotRemote or target == BowRemote) and Config.OriginSpoof and SpoofOrigin then
		if os.clock() - SpoofOrigin.Time < 0.35 then
			if typeof(args[1]) == "Vector3" then
				args[1] = SpoofOrigin.Pos
			end
			return originalNamecall(target, table.unpack(args, 1, args.n))
		end
	end
	return originalNamecall(target, ...)
end))

local function loadLibrary(relativePath, ...)
	local source = game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/" .. relativePath)
	local chunk = loadChunk(source)
	if chunk then
		return chunk(...)
	end
	return nil
end

local Library = loadLibrary("Library.lua")
loadLibrary("addons/ThemeManager.lua")
loadLibrary("addons/SaveManager.lua")

local Window = Library:CreateWindow({
	Title = "Medalware Decay",
	Center = true,
	AutoShow = true,
	TabPadding = 8,
})

local Tabs = {
	Combat = Window:AddTab("Combat"),
	Visuals = Window:AddTab("Visuals"),
	World = Window:AddTab("World"),
	Config = Window:AddTab("Config"),
}

local AimBox = Tabs.Combat:AddLeftGroupbox("Aimbot")

AimBox:AddToggle("Silent", {
	Text = "Silent Aim",
	Default = Config.Silent,
	Callback = function(value) Config.Silent = value end,
}):AddKeyPicker("SilentKey", { 
    Default = "MB2", 
    Mode = "Toggle", 
    SyncToggleState = true, 
    Text = "Silent Aim Key" 
})

AimBox:AddSlider("SilentFOV", {
	Text = "FOV",
	Default = Config.SilentFOV,
	Min = 10,
	Max = 900,
	Rounding = 0,
	Suffix = "",
	Callback = function(value) Config.SilentFOV = value end,
})

AimBox:AddToggle("SilentWall", {
	Text = "Wall Check",
	Default = Config.SilentWall,
	Callback = function(value) Config.SilentWall = value end,
})

AimBox:AddToggle("SilentCircle", {
	Text = "FOV Circle",
	Default = Config.SilentCircle,
	Callback = function(value) Config.SilentCircle = value end,
})

AimBox:AddToggle("NoRecoil", {
	Text = "No Recoil",
	Default = Config.NoRecoil,
	Callback = function(value)
		Config.NoRecoil = value
		if value then
			pcall(patchRecoil)
		end
	end,
})

AimBox:AddToggle("OriginSpoof", {
	Text = "Origin Spoof",
	Default = Config.OriginSpoof,
	Callback = function(value) Config.OriginSpoof = value end,
})

AimBox:AddToggle("AimRotate", {
	Text = "Aim Rotate",
	Default = Config.AimRotate,
	Callback = function(value) Config.AimRotate = value end,
})

AimBox:AddToggle("Spam", {
	Text = "Swing Spam",
	Default = Config.Spam,
	Callback = function(value) Config.Spam = value end,
})

local PlayerBox = Tabs.Visuals:AddLeftGroupbox("Player ESP")

PlayerBox:AddToggle("PlayerESP", {
	Text = "Player ESP",
	Default = Config.PlayerESP,
	Callback = function(value) Config.PlayerESP = value end,
})

PlayerBox:AddToggle("PE_TeamCheck", {
	Text = "Team Check",
	Default = Config.PE_TeamCheck,
	Callback = function(value) Config.PE_TeamCheck = value end,
})

PlayerBox:AddToggle("PE_Box", {
	Text = "Box",
	Default = Config.PE_Box,
	Callback = function(value) Config.PE_Box = value end,
}):AddColorPicker("PE_BoxColor", {
	Default = PE_Colors.Box,
	Title = "Box Color",
	Callback = function(color) PE_Colors.Box = color end,
})

PlayerBox:AddToggle("PE_BoxFill", {
	Text = "Box Fill",
	Default = Config.PE_BoxFill,
	Callback = function(value) Config.PE_BoxFill = value end,
}):AddColorPicker("PE_BoxFillColor", {
	Default = PE_Colors.BoxFill,
	Title = "Box Fill",
	Transparency = 0.6,
	Callback = function(color) PE_Colors.BoxFill = color end,
})

PlayerBox:AddToggle("PE_Tracer", {
	Text = "Tracer",
	Default = Config.PE_Tracer,
	Callback = function(value) Config.PE_Tracer = value end,
}):AddColorPicker("PE_TracerColor", {
	Default = PE_Colors.Tracer,
	Title = "Tracer Color",
	Callback = function(color) PE_Colors.Tracer = color end,
})

PlayerBox:AddToggle("PE_Skeleton", {
	Text = "Skeleton",
	Default = Config.PE_Skeleton,
	Callback = function(value) Config.PE_Skeleton = value end,
}):AddColorPicker("PE_SkeletonColor", {
	Default = PE_Colors.Skeleton,
	Title = "Skeleton Color",
	Callback = function(color) PE_Colors.Skeleton = color end,
})

PlayerBox:AddToggle("PE_HeadDot", {
	Text = "Head Dot",
	Default = Config.PE_HeadDot,
	Callback = function(value) Config.PE_HeadDot = value end,
}):AddColorPicker("PE_HeadDotColor", {
	Default = PE_Colors.HeadDot,
	Title = "Head Dot Color",
	Callback = function(color) PE_Colors.HeadDot = color end,
})

PlayerBox:AddToggle("PE_Chams", {
	Text = "Chams",
	Default = Config.PE_Chams,
	Callback = function(value) Config.PE_Chams = value end,
}):AddColorPicker("PE_ChamsFill", {
	Default = PE_Colors.ChamsFill,
	Title = "Chams Fill",
	Transparency = 0.7,
	Callback = function(color) PE_Colors.ChamsFill = color end,
}):AddColorPicker("PE_ChamsOutline", {
	Default = PE_Colors.ChamsOutline,
	Title = "Chams Outline",
	Callback = function(color) PE_Colors.ChamsOutline = color end,
})

PlayerBox:AddToggle("PE_Name", {
	Text = "Name",
	Default = Config.PE_Name,
	Callback = function(value) Config.PE_Name = value end,
}):AddColorPicker("PE_NameColor", {
	Default = PE_Colors.Name,
	Title = "Name Color",
	Callback = function(color) PE_Colors.Name = color end,
})

PlayerBox:AddToggle("PE_Health", {
	Text = "Health Bar",
	Default = Config.PE_Health,
	Callback = function(value) Config.PE_Health = value end,
}):AddColorPicker("PE_HealthTop", {
	Default = PE_Colors.HealthTop,
	Title = "Health Top",
	Callback = function(color) PE_Colors.HealthTop = color end,
}):AddColorPicker("PE_HealthBottom", {
	Default = PE_Colors.HealthBottom,
	Title = "Health Bottom",
	Callback = function(color) PE_Colors.HealthBottom = color end,
})

PlayerBox:AddToggle("PE_Distance", {
	Text = "Distance",
	Default = Config.PE_Distance,
	Callback = function(value) Config.PE_Distance = value end,
}):AddColorPicker("PE_DistanceColor", {
	Default = PE_Colors.Distance,
	Title = "Distance Color",
	Callback = function(color) PE_Colors.Distance = color end,
})

PlayerBox:AddToggle("PE_VisFlag", {
	Text = "Visible/Hidden Flag",
	Default = Config.PE_VisFlag,
	Callback = function(value) Config.PE_VisFlag = value end,
}):AddColorPicker("PE_VisVisible", {
	Default = PE_Colors.VisVisible,
	Title = "Visible Color",
	Callback = function(color) PE_Colors.VisVisible = color end,
}):AddColorPicker("PE_VisHidden", {
	Default = PE_Colors.VisHidden,
	Title = "Hidden Color",
	Callback = function(color) PE_Colors.VisHidden = color end,
})

PlayerBox:AddSlider("PE_MaxDist", {
	Text = "Max Distance",
	Default = Config.PE_MaxDist,
	Min = 100,
	Max = 5000,
	Rounding = 0,
	Suffix = "m",
	Callback = function(value) Config.PE_MaxDist = value end,
})

PlayerBox:AddSlider("PE_TextSize", {
	Text = "Text Size",
	Default = Config.PE_TextSize,
	Min = 8,
	Max = 24,
	Rounding = 0,
	Suffix = "",
	Callback = function(value) Config.PE_TextSize = value end,
})

local StorageBox = Tabs.Visuals:AddRightGroupbox("Storage ESP")

StorageBox:AddToggle("ESP", {
	Text = "Resource ESP",
	Default = Config.ESP,
	Callback = function(value) Config.ESP = value end,
})

StorageBox:AddSlider("ESPDist", {
	Text = "Resource Distance",
	Default = Config.ESPDist,
	Min = 100,
	Max = 5000,
	Rounding = 0,
	Suffix = "m",
	Callback = function(value) Config.ESPDist = value end,
})

StorageBox:AddToggle("ESP_Hemp", {
	Text = "Hemp",
	Default = Config.ESPOn.Hemp,
	Callback = function(value) Config.ESPOn.Hemp = value end,
})

StorageBox:AddToggle("ESP_Stone", {
	Text = "Stone",
	Default = Config.ESPOn.Stone,
	Callback = function(value) Config.ESPOn.Stone = value end,
})

StorageBox:AddToggle("ESP_Metal", {
	Text = "Metal",
	Default = Config.ESPOn.Metal,
	Callback = function(value) Config.ESPOn.Metal = value end,
})

StorageBox:AddToggle("ESP_Sulfur", {
	Text = "Sulfur",
	Default = Config.ESPOn.Sulfur,
	Callback = function(value) Config.ESPOn.Sulfur = value end,
})

StorageBox:AddToggle("ESP_Wood", {
	Text = "Wood",
	Default = Config.ESPOn.Wood,
	Callback = function(value) Config.ESPOn.Wood = value end,
})

StorageBox:AddToggle("ESP_Crates", {
	Text = "Crates",
	Default = Config.ESPOn.Crates,
	Callback = function(value) Config.ESPOn.Crates = value end,
})

StorageBox:AddToggle("Stor_Guns", {
	Text = "Guns",
	Default = Config.StorOn.Guns,
	Callback = function(value) Config.StorOn.Guns = value end,
})

StorageBox:AddToggle("Stor_Ammo", {
	Text = "Ammo",
	Default = Config.StorOn.Ammo,
	Callback = function(value) Config.StorOn.Ammo = value end,
})

StorageBox:AddToggle("Stor_Explosives", {
	Text = "Explosives",
	Default = Config.StorOn.Explosives,
	Callback = function(value) Config.StorOn.Explosives = value end,
})

local MovementBox = Tabs.World:AddLeftGroupbox("Movement")

MovementBox:AddToggle("WalkSpeedOn", {
	Text = "Walk Speed",
	Default = Config.WalkSpeedOn,
	Callback = function(value)
		Config.WalkSpeedOn = value
		if not value and LocalPlayer.Character then
			local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = 16
			end
		end
	end,
})

MovementBox:AddSlider("WalkSpeedVal", {
	Text = "Speed",
	Default = Config.WalkSpeedVal,
	Min = 16,
	Max = 200,
	Rounding = 0,
	Suffix = "",
	Callback = function(value) Config.WalkSpeedVal = value end,
})

MovementBox:AddToggle("Fullbright", {
	Text = "Fullbright",
	Default = Config.Fullbright,
	Callback = function(value)
		Config.Fullbright = value
		applyFullbright(value)
	end,
})

MovementBox:AddToggle("NoFog", {
	Text = "No Fog",
	Default = Config.NoFog,
	Callback = function(value)
		Config.NoFog = value
		applyNoFog(value)
	end,
})

local WeatherBox = Tabs.World:AddRightGroupbox("Sky & Weather")

local skyNames = { "Default" }
for name in pairs(SKYBOXES) do
	table.insert(skyNames, name)
end

WeatherBox:AddDropdown("Weather", {
	Text = "Weather",
	Values = { "None", "Rain", "Snow", "Hell Fire" },
	Default = "None",
	AllowNull = false,
	Callback = setWeather,
})

WeatherBox:AddDropdown("Skybox", {
	Text = "Skybox",
	Values = skyNames,
	Default = "Default",
	AllowNull = false,
	Callback = setSkybox,
})

local UnloadBox = Tabs.Config:AddLeftGroupbox("Unload")

UnloadBox:AddButton("Unload", function()
	GlobalEnv.fasttools_unload = true
end)

Connections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		if not PlayerESPState[player] then
			PlayerESPState[player] = makePlayerESP()
		end
	end)
end)

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		PlayerESPState[player] = makePlayerESP()
	end
end

Connections.PlayerRemoving = Players.PlayerRemoving:Connect(function(player)
	local esp = PlayerESPState[player]
	if esp then
		removePlayerESP(esp)
		PlayerESPState[player] = nil
	end
end)

Connections.RenderStepped = RunService.RenderStepped:Connect(function()
	updateFOVCircle()
	if Config.PlayerESP then
		updatePlayerESP()
	end
	if Config.ESP then
		scanResourceNodes()
		updateResourceESP()
		updateStorageESP()
	end
end)

Connections.Heartbeat = RunService.Heartbeat:Connect(function()
	if Config.WalkSpeedOn and LocalPlayer.Character then
		local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid and humanoid.WalkSpeed ~= Config.WalkSpeedVal then
			humanoid.WalkSpeed = Config.WalkSpeedVal
		end
	end
end)

Connections.MainLoop = task.spawn(function()
	while task.wait(1 / math.clamp(Config.Mult or 8, 1, 20)) do
		if GlobalEnv.fasttools_unload then
			break
		end
		if not Config.Running then
			continue
		end
		if Config.Spam and SwingRemote then
			pcall(function()
				SwingRemote:FireServer()
			end)
		end
		pcall(runSilent)
	end
end)

unload = function()
	for _, connection in pairs(Connections) do
		if typeof(connection) == "RBXScriptConnection" then
			connection:Disconnect()
		end
	end
	for _, esp in pairs(PlayerESPState) do
		removePlayerESP(esp)
	end
	table.clear(PlayerESPState)
	for _, billboard in pairs(StorageBillboards) do
		billboard:Destroy()
	end
	table.clear(StorageBillboards)
	for _, entry in ipairs(ResourceESPList) do
		local highlight = entry.m:FindFirstChild("FT_ESP")
		if highlight then
			highlight:Destroy()
		end
	end
	table.clear(ResourceESPList)
	FOVCircle:Remove()
	applyFullbright(false)
	applyNoFog(false)
	local sky = Lighting:FindFirstChild("MD_Sky")
	if sky then
		sky:Destroy()
	end
	local camera = workspace.CurrentCamera
	local weather = camera:FindFirstChild("MD_Weather")
	if weather then
		weather:Destroy()
	end
	if type(restorefunction) == "function" then
		restorefunction(game, "__namecall")
	end
	GlobalEnv.fasttools_unload = true
	pcall(function()
		Library:Unload()
	end)
end

Library:OnUnload(unload)
pcall(patchRecoil)
