local Rg
do
	local NLL, KH, Y7fg
	local Hn, F5z = pcall(function()

		if type(typeof) ~= "function"
			or type(Instance) ~= "table"
			or type(Instance.new) ~= "function"
		then
			return false
		end

		if type(game) ~= "userdata"
			or typeof(game) ~= "Instance"
			or game.ClassName ~= "DataModel"
			or not game:IsA("DataModel")
		then
			return false
		end

		local hweZ = game:GetService("RunService")
		if typeof(hweZ) ~= "Instance"
			or not hweZ:IsA("RunService")
			or hweZ.Parent ~= game
			or hweZ ~= game:GetService("RunService")
			or type(hweZ:IsStudio()) ~= "boolean"
		then
			return false
		end

		if typeof(hweZ.Heartbeat) ~= "RBXScriptSignal" then
			return false
		end

		local vF = game:GetService("Players")
		if typeof(vF) ~= "Instance"
			or not vF:IsA("Players")
			or vF.Parent ~= game
			or vF ~= game:GetService("Players")
		then
			return false
		end

		local DCM = game:GetService("Workspace")
		if typeof(DCM) ~= "Instance"
			or not DCM:IsA("Workspace")
			or DCM.Parent ~= game
			or DCM ~= workspace
		then
			return false
		end

		if type(Vector3) ~= "table"
			or type(CFrame) ~= "table"
			or type(Enum) ~= "userdata"
		then
			return false
		end

		local xTy = Vector3.new(21, 100, 92)
		if typeof(xTy) ~= "Vector3"
			or xTy.X ~= 21
			or xTy.Y ~= 100
			or xTy.Z ~= 92
		then
			return false
		end

		local ypm = xTy + Vector3.new(1, 2, 3)
		if ypm.X ~= 22 or ypm.Y ~= 102 or ypm.Z ~= 95 then
			return false
		end

		local FFu = CFrame.new(xTy)
		if typeof(FFu) ~= "CFrame" or FFu.Position ~= xTy then
			return false
		end

		if typeof(Enum.KeyCode.Unknown) ~= "EnumItem"
			or Enum.KeyCode.Unknown.EnumType ~= Enum.KeyCode
		then
			return false
		end

		NLL = Instance.new("Folder")
		KH  = Instance.new("Folder")
		if type(NLL) ~= "userdata"
			or typeof(NLL) ~= "Instance"
			or not NLL:IsA("Folder")
		then
			return false
		end

		KH.Name = "v4865379b06553580"
		KH.Parent = NLL
		KH:SetAttribute("aeaf8e1628f647d0f", 485542)

		if NLL:FindFirstChild("v4865379b06553580") ~= KH
			or not KH:IsDescendantOf(NLL)
		then
			return false
		end

		if KH:GetAttribute("aeaf8e1628f647d0f") ~= 485542 then
			return false
		end

		local Efg = KH:GetAttributeChangedSignal("aeaf8e1628f647d0f")
		if typeof(Efg) ~= "RBXScriptSignal" then
			return false
		end

		Y7fg = Efg:Connect(function() end)
		if typeof(Y7fg) ~= "RBXScriptConnection" or not Y7fg.Connected then
			return false
		end

		Y7fg:Disconnect()
		if Y7fg.Connected then
			return false
		end

		local BsKA = {
			xTy.X,                        
			ypm.Y,                        
			FFu.Position.Z,                
			KH:GetAttribute("aeaf8e1628f647d0f")
		}

		NLL:Destroy()
		if KH.Parent ~= nil then
			return false
		end

		return {
			(BsKA[1] * 35074 + BsKA[2] * 39962 + BsKA[3] * 29455 + BsKA[4] * 28873) % 4294967296,
			(BsKA[1] * 18388 + BsKA[2] * 36542 + BsKA[3] * 60456 + BsKA[4] * 44494) % 4294967296,
			(BsKA[1] * 38975 + BsKA[2] * 53412 + BsKA[3] * 34687 + BsKA[4] * 2132)  % 4294967296,
			(BsKA[1] * 53044 + BsKA[2] * 24508 + BsKA[3] * 28101 + BsKA[4] * 19215) % 4294967296,
			(BsKA[1] * 51551 + BsKA[2] * 34978 + BsKA[3] * 18418 + BsKA[4] * 65496) % 4294967296,
			(BsKA[1] * 29202 + BsKA[2] * 59160 + BsKA[3] * 37730 + BsKA[4] * 35758) % 4294967296,
			(BsKA[1] * 2635  + BsKA[2] * 2928  + BsKA[3] * 60379 + BsKA[4] * 25237) % 4294967296,
			(BsKA[1] * 9022  + BsKA[2] * 61257 + BsKA[3] * 25473 + BsKA[4] * 12314) % 4294967296
		}
	end)

	if Y7fg then pcall(function() Y7fg:Disconnect() end) end
	if KH  then pcall(function() KH:Destroy() end) end
	if NLL then pcall(function() NLL:Destroy() end) end

	if not Hn or type(F5z) ~= "table" or #F5z ~= 8 then
		error("Roblox environment verification failed", 0)
	end

	Rg = F5z
end
