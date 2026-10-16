
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")

local function makeTextButton()
  local localPlayer = players.LocalPlayer
  local playerGui = localPlayer:WaitForChild("PlayerGui")

  if isfolder and makefolder then
    pcall(function()
      if not isfolder("Scriptfarmer") then
        makefolder("Scriptfarmer")
      end
    end)
  end

  local function f1(p1, p2, imageLabel)
    task.spawn(function()
      local v1 = "Scriptfarmer" .. "/" .. p2
      local v2 = getcustomasset and writefile and isfile
      local v3

      if v2 then
        if not isfile(v1) then
          local v4
          v4, v3 = pcall(function() return game:HttpGet(p1) end)

          if v4 and v3 then
            pcall(function() writefile(v1, v3) end)
          end
        end

        if isfile(v1) then
          pcall(function() imageLabel.Image = getcustomasset(v1) end)
        end
      end
    end)
  end

  if playerGui:FindFirstChild("ScriptfarmerUI") then
    playerGui.ScriptfarmerUI:Destroy()
  end

  local scriptfarmerUI = Instance.new("ScreenGui")
  scriptfarmerUI.Name = "ScriptfarmerUI"
  scriptfarmerUI.ResetOnSpawn = false
  scriptfarmerUI.Parent = playerGui

  local frame = Instance.new("Frame")
  frame.Size = UDim2.new(0, 360, 0, 220)
  frame.Position = UDim2.new(0.5, -180, 0.5, -110)
  frame.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
  frame.BorderSizePixel = 0
  frame.Active = true
  frame.Draggable = true
  frame.ClipsDescendants = true
  frame.Parent = scriptfarmerUI

  Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = Color3.fromRGB(225, 225, 225)
  uiStroke.Thickness = 1.5
  uiStroke.Parent = frame

  local imageLabel2 = Instance.new("ImageLabel")
  imageLabel2.Size = UDim2.new(0, 34, 0, 34)
  imageLabel2.Position = UDim2.new(0, 18, 0, 13)
  imageLabel2.BackgroundTransparency = 1
  imageLabel2.ScaleType = Enum.ScaleType.Fit
  imageLabel2.Parent = frame

  f1("https://i.postimg.cc/Dz19fdsW/images.png", "mainlogo.png", imageLabel2)

  local textLabel = Instance.new("TextLabel")
  textLabel.Size = UDim2.new(0, 200, 0, 30)
  textLabel.Position = UDim2.new(0, 62, 0, 15)
  textLabel.BackgroundTransparency = 1
  textLabel.Text = "SCRIPTFARMER"
  textLabel.TextColor3 = Color3.fromRGB(20, 20, 20)
  textLabel.TextXAlignment = Enum.TextXAlignment.Left
  textLabel.Font = Enum.Font.GothamBlack
  textLabel.TextSize = 20
  textLabel.Parent = frame

  local textBox = Instance.new("TextBox")
  textBox.Size = UDim2.new(0, 320, 0, 42)
  textBox.Position = UDim2.new(0, 20, 0, 55)
  textBox.PlaceholderText = "Paste Key Here..."
  textBox.PlaceholderColor3 = Color3.fromRGB(160, 160, 160)
  textBox.Text = ""
  textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  textBox.TextColor3 = Color3.fromRGB(20, 20, 20)
  textBox.Font = Enum.Font.GothamMedium
  textBox.TextSize = 14
  textBox.ClearTextOnFocus = false
  textBox.Parent = frame

  Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 8)

  local uiStroke2 = Instance.new("UIStroke")
  uiStroke2.Color = Color3.fromRGB(215, 215, 215)
  uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
  uiStroke2.Parent = textBox

  local textButton = Instance.new("TextButton")
  textButton.Size = UDim2.new(0, 320, 0, 42)
  textButton.Position = UDim2.new(0, 20, 0, 105)
  textButton.Text = "CHECK KEY"
  textButton.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
  textButton.TextColor3 = Color3.new(1, 1, 1)
  textButton.Font = Enum.Font.GothamBold
  textButton.TextSize = 15
  textButton.AutoButtonColor = true
  textButton.Parent = frame

  Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 8)

  local function makeTextButton2(name, text, p3, p4, p5, color, color2)
    local textButton2 = Instance.new("TextButton")
    textButton2.Name = name
    textButton2.Size = UDim2.new(0, 106, 0, 40)
    textButton2.Position = UDim2.new(0, p3, 0, 160)
    textButton2.Text = ""
    textButton2.BackgroundColor3 = color
    textButton2.BorderSizePixel = 0
    textButton2.AutoButtonColor = true
    textButton2.Parent = frame

    Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 8)

    local imageLabel3 = Instance.new("ImageLabel")
    imageLabel3.Size = UDim2.new(0, 20, 0, 20)
    imageLabel3.Position = UDim2.new(0, 10, 0, 10)
    imageLabel3.BackgroundTransparency = 1
    imageLabel3.ScaleType = Enum.ScaleType.Fit
    imageLabel3.ZIndex = 5
    imageLabel3.Parent = textButton2

    if p4 and p4 ~= "" then
      f1(p4, p5, imageLabel3)
    end

    local textLabel2 = Instance.new("TextLabel")
    textLabel2.Size = UDim2.new(0, 70, 0, 40)
    textLabel2.Position = UDim2.new(0, 36, 0, 0)
    textLabel2.BackgroundTransparency = 1
    textLabel2.Text = text
    textLabel2.TextColor3 = color2 or Color3.fromRGB(255, 255, 255)
    textLabel2.Font = Enum.Font.GothamBold
    textLabel2.TextSize = 13
    textLabel2.TextXAlignment = Enum.TextXAlignment.Center
    textLabel2.ZIndex = 5
    textLabel2.Parent = textButton2

    return textButton2
  end

  local v5 = makeTextButton2(
    "GetKeyBtn", "Get Key", 11, "https://i.postimg.cc/66DTn2mk/1000222251-Photoroom.png",
    "keylogo.png", Color3.fromRGB(255, 255, 255), Color3.fromRGB(40, 40, 40)
  )

  local uiStroke3 = Instance.new("UIStroke")
  uiStroke3.Color = Color3.fromRGB(215, 215, 215)
  uiStroke3.Parent = v5

  local v6 = makeTextButton2(
    "YoutubeBtn", "YouTube", 127, "https://i.postimg.cc/9QPMkdWX/IMG-20260826-143351.png",
    "youtubelogo.png", Color3.fromRGB(225, 30, 30), Color3.fromRGB(255, 255, 255)
  )

  local v7 = makeTextButton2(
    "DiscordBtn", "Discord", 243, "https://i.postimg.cc/rwGmH18p/1000165184-Photoroom-1-1.png",
    "discordlogo.png", Color3.fromRGB(88, 101, 242), Color3.fromRGB(255, 255, 255)
  )

  local frame2 = Instance.new("Frame")
  frame2.Size = UDim2.new(1, 0, 1, 0)
  frame2.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
  frame2.Visible = false
  frame2.ZIndex = 10
  frame2.Parent = frame

  Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 14)

  local textLabel3 = Instance.new("TextLabel")
  textLabel3.Size = UDim2.new(1, 0, 0.3, 0)
  textLabel3.Text = "Successfully copied to your clipboard!"
  textLabel3.TextColor3 = Color3.fromRGB(34, 197, 94)
  textLabel3.BackgroundTransparency = 1
  textLabel3.Font = Enum.Font.GothamBold
  textLabel3.TextSize = 15
  textLabel3.ZIndex = 11
  textLabel3.Parent = frame2

  local textBox2 = Instance.new("TextBox")
  textBox2.Size = UDim2.new(0.9, 0, 0.3, 0)
  textBox2.Position = UDim2.new(0.05, 0, 0.35, 0)
  textBox2.TextEditable = false
  textBox2.ClearTextOnFocus = false
  textBox2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  textBox2.TextColor3 = Color3.fromRGB(100, 100, 100)
  textBox2.TextSize = 12
  textBox2.ZIndex = 11
  textBox2.Parent = frame2

  Instance.new("UICorner", textBox2).CornerRadius = UDim.new(0, 6)

  local uiStroke4 = Instance.new("UIStroke")
  uiStroke4.Color = Color3.fromRGB(210, 210, 210)
  uiStroke4.Parent = textBox2

  local textButton3 = Instance.new("TextButton")
  textButton3.Size = UDim2.new(0.5, 0, 0.2, 0)
  textButton3.Position = UDim2.new(0.25, 0, 0.75, 0)
  textButton3.Text = "OK"
  textButton3.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
  textButton3.TextColor3 = Color3.new(1, 1, 1)
  textButton3.Font = Enum.Font.GothamBold
  textButton3.ZIndex = 11
  textButton3.Parent = frame2

  Instance.new("UICorner", textButton3).CornerRadius = UDim.new(0, 6)
  textButton3.Activated:Connect(function() frame2.Visible = false end)

  local function f2(text2)
    pcall(function()
      if setclipboard then
        setclipboard(text2)
      elseif toclipboard then
        toclipboard(text2)
      end
    end)

    textBox2.Text = text2
    frame2.Visible = true

    task.delay(3, function()
      if textBox2.Text == text2 then
        frame2.Visible = false
      end
    end)
  end

  local function f3()
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

    local create = tweenService:Create(frame, tweenInfo, {
      Size = UDim2.new(0, 0, 0, 0),
      Position = UDim2.new(0.5, 0, 0.5, 0),
      BackgroundTransparency = 1,
    })

    local create2 = tweenService:Create(uiStroke, tweenInfo, { Transparency = 1 })

    local create3 = tweenService:Create(textButton, tweenInfo, {
      TextTransparency = 1,
      BackgroundTransparency = 1,
    })

    local create4 = tweenService:Create(textBox, tweenInfo, {
      TextTransparency = 1,
      BackgroundTransparency = 1,
    })

    local create5 = tweenService:Create(textLabel, tweenInfo, { TextTransparency = 1 })
    create:Play()
    create2:Play()
    create3:Play()
    create4:Play()
    create5:Play()
    create.Completed:Wait()
    scriptfarmerUI:Destroy()
  end

  local v8 = tostring(localPlayer.UserId)

  local function f4(p6)
    textButton.Text = "ACCESS GRANTED"
    textButton.BackgroundColor3 = Color3.fromRGB(34, 197, 94)

    if writefile then
      pcall(function() writefile("Scriptfarmer/SavedKey.txt", p6) end)
    end

    f3()

    local v9, v10 = pcall(function()
      return game:HttpGet("https://scriptfarmer.dpdns.org/loader/ui")
    end)

    if v9 and not string.match(v10, "404: Not Found") and v10 ~= "" then
      task.spawn(function() pcall(function() loadstring(v10)() end) end)
    else
      warn("Scriptfarmer: Error 404 - The first script link provided is currently dead.")
    end

    local v11, v12 = pcall(function()
      return game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua")
    end)

    if v11 and not string.match(v12, "404: Not Found") and v12 ~= "" then
      task.spawn(function() pcall(function() loadstring(v12)() end) end)
    end
  end

  local function f5(text3, p7)
    if p7 then
      textBox.Text = ""

      if delfile and isfile and isfile("Scriptfarmer/SavedKey.txt") then
        pcall(function() delfile("Scriptfarmer/SavedKey.txt") end)
      end
    end

    textButton.Text = text3
    textButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)

    task.wait(1.5)

    textButton.Text = "CHECK KEY"
    textButton.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
  end

  local function f6(p8, p9)
    if p9 then
      textButton.Text = "AUTO-VERIFYING..."
    else
      textButton.Text = "VERIFYING..."
    end

    textButton.BackgroundColor3 = Color3.fromRGB(245, 158, 11)
    local v13, v14

    if p8 == "" then
      f5("PLEASE ENTER KEY", p9)
      return
    else
      local v15, v16 = pcall(function()
        return game:HttpGet("https://scriptfarmer.dpdns.org/api/key/freshpirosucure")
      end)

      if v15 and v16 then
        local v17 = string.gsub(v16, "%s+", "")
        local v18 = string.gsub(v17, '"', "")

        if p8 == string.gsub(v18, "'", "")
          or string.len(p8) >= 4 and string.find(v16, p8, 1, true) then
          f4(p8)
          return
        end
      end

      local v19, v20 = pcall(function()
        return game:HttpGet("https://scriptfarmer.dpdns.org" .. "/api/premiumkey/check?key="
          .. p8)
      end)

      if v19 and v20 then
        local v21 = string.lower(string.gsub(v20, "%s+", ""))

        if v21 == "valid" then
          v14 = "https://scriptfarmer.dpdns.org" .. "/api/premiumkey/assignuser?key=" .. p8
            .. "&Id=" .. v8

          local v22, v23 = pcall(function() return game:HttpGet(v14) end)

          if v22 and string.find(string.lower(v23), "successfully registered") then
            f4(p8)
            return
          end

          f5("ASSIGN FAILED", p9)
          return
        elseif v21 == "used" then
          v13 = "https://scriptfarmer.dpdns.org" .. "/api/premiumkey/usercheck?key=" .. p8
            .. "&Id=" .. v8

          local v24, v25 = pcall(function() return game:HttpGet(v13) end)

          if v24 and string.find(string.lower(v25), "success") then
            f4(p8)
            return
          end

          f5("KEY IN USE", p9)
          return
        else
          if v21 == "invalid" then
            f5("INVALID KEY", p9)
            return
          end

          f5("INVALID KEY", p9)
          return
        end
      else
        f5("INVALID KEY", p9)
        return
      end
    end
  end

  textButton.Activated:Connect(function() f6(string.gsub(textBox.Text, "%s+", ""), false) end)
  v5.Activated:Connect(function() f2("https://scriptfarmer-getkey.vercel.app") end)

  v6.Activated:Connect(function()
    f2("https://youtube.com/@scriptfarmer2.0?si=c7Nd04r3G2zX72rE")
  end)

  v7.Activated:Connect(function() f2("https://discord.gg/7q2TvZ9GYX") end)

  task.spawn(function()
    if readfile and isfile and isfile("Scriptfarmer/SavedKey.txt") then
      local v26, v27 = pcall(function() return readfile("Scriptfarmer/SavedKey.txt") end)

      if v26 and v27 and v27 ~= "" then
        textBox.Text = v27
        f6(v27, true)
      end
    end
  end)
end

makeTextButton()
