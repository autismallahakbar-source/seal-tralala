local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

local LOGO = "rbxassetid://131261307870420"
local FIXED_FOV = 200
local DISCORD_LINK = "https://discord.gg/xhn6WaHzs5"

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "SealDevLoading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 999999
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingGui.Parent = PG

local bg = Instance.new("Frame")
bg.Name = "bg"
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 1
bg.BorderSizePixel = 0
bg.ZIndex = 1
bg.Parent = loadingGui

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 10, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
})
bgGradient.Rotation = 45
bgGradient.Parent = bg

local particleLayer = Instance.new("Frame")
particleLayer.Name = "particles"
particleLayer.Size = UDim2.new(1, 0, 1, 0)
particleLayer.BackgroundTransparency = 1
particleLayer.ZIndex = 2
particleLayer.ClipsDescendants = true
particleLayer.Parent = loadingGui

local logoImage = Instance.new("ImageLabel")
logoImage.Name = "logoImage"
logoImage.AnchorPoint = Vector2.new(0.5, 0.5)
logoImage.Position = UDim2.new(0.5, 0, 0.5, -180)
logoImage.Size = UDim2.new(0, 150, 0, 150)
logoImage.BackgroundTransparency = 1
logoImage.Image = LOGO
logoImage.ImageTransparency = 1
logoImage.ScaleType = Enum.ScaleType.Fit
logoImage.ZIndex = 5
logoImage.Parent = loadingGui

local logoFrame = Instance.new("Frame")
logoFrame.Name = "logoFrame"
logoFrame.AnchorPoint = Vector2.new(0.5, 0.5)
logoFrame.Position = UDim2.new(0.5, 0, 0.5, -30)
logoFrame.Size = UDim2.new(0, 900, 0, 200)
logoFrame.BackgroundTransparency = 1
logoFrame.ZIndex = 5
logoFrame.Parent = loadingGui

local TEXT_SIZE = 120
local BOX_PADDING_Y = 8
local BOX_HEIGHT = TEXT_SIZE + BOX_PADDING_Y * 2

local sealText = Instance.new("TextLabel")
sealText.Name = "sealText"
sealText.AnchorPoint = Vector2.new(1, 0.5)
sealText.Position = UDim2.new(0.5, -6, 0.5, 0)
sealText.Size = UDim2.new(0, 320, 0, BOX_HEIGHT)
sealText.BackgroundTransparency = 1
sealText.Text = "Seal"
sealText.TextColor3 = Color3.fromRGB(255, 255, 255)
sealText.Font = Enum.Font.GothamBold
sealText.TextSize = TEXT_SIZE
sealText.TextXAlignment = Enum.TextXAlignment.Right
sealText.TextYAlignment = Enum.TextYAlignment.Center
sealText.TextTransparency = 1
sealText.ZIndex = 5
sealText.Parent = logoFrame

local devBox = Instance.new("Frame")
devBox.Name = "devBox"
devBox.AnchorPoint = Vector2.new(0, 0.5)
devBox.Position = UDim2.new(0.5, 6, 0.5, 0)
devBox.Size = UDim2.new(0, 230, 0, BOX_HEIGHT)
devBox.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
devBox.BorderSizePixel = 0
devBox.BackgroundTransparency = 1
devBox.ZIndex = 5
devBox.Parent = logoFrame

local devBoxCorner = Instance.new("UICorner")
devBoxCorner.CornerRadius = UDim.new(0, 8)
devBoxCorner.Parent = devBox

local devText = Instance.new("TextLabel")
devText.Name = "devText"
devText.Size = UDim2.new(1, 0, 1, 0)
devText.BackgroundTransparency = 1
devText.Text = "Dev"
devText.TextColor3 = Color3.fromRGB(0, 0, 0)
devText.Font = Enum.Font.GothamBold
devText.TextSize = TEXT_SIZE
devText.TextTransparency = 1
devText.ZIndex = 6
devText.Parent = devBox

local author = Instance.new("TextLabel")
author.Name = "author"
author.AnchorPoint = Vector2.new(0.5, 0.5)
author.Position = UDim2.new(0.5, 0, 0.5, 100)
author.Size = UDim2.new(0, 400, 0, 30)
author.BackgroundTransparency = 1
author.Text = "Free And Keyless Rivals Script For Everyone"
author.TextColor3 = Color3.fromRGB(160, 160, 200)
author.Font = Enum.Font.Gotham
author.TextSize = 16
author.TextTransparency = 1
author.ZIndex = 5
author.Parent = logoFrame

local loadingActive = true
local function spawnParticle()
    if not loadingActive then return end
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
    p.BackgroundColor3 = Color3.fromRGB(math.random(200, 255), math.random(120, 200), math.random(0, 100))
    p.BorderSizePixel = 0
    p.BackgroundTransparency = 0.3
    p.Position = UDim2.new(math.random(), 0, 1.1, 0)
    p.ZIndex = 2

    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(1, 0)
    pCorner.Parent = p
    p.Parent = particleLayer

    local tween = TweenService:Create(p, TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Linear), {
        Position = UDim2.new(p.Position.X.Scale + (math.random() - 0.5) * 0.15, 0, -0.1, 0),
        BackgroundTransparency = 1,
    })
    tween:Play()
    tween.Completed:Connect(function() p:Destroy() end)
end

task.spawn(function()
    while loadingActive do
        spawnParticle()
        task.wait(0.04)
    end
end)

local FADE_FAST = TweenInfo.new(0.27, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
TweenService:Create(bg, FADE_FAST, { BackgroundTransparency = 0 }):Play()
task.wait(0.33)
TweenService:Create(logoImage, FADE_FAST, { ImageTransparency = 0 }):Play()
task.wait(0.33)
TweenService:Create(sealText, FADE_FAST, { TextTransparency = 0 }):Play()
TweenService:Create(devBox, FADE_FAST, { BackgroundTransparency = 0 }):Play()
TweenService:Create(devText, FADE_FAST, { TextTransparency = 0 }):Play()
TweenService:Create(author, FADE_FAST, { TextTransparency = 0.2 }):Play()

local pulseConn
pulseConn = RunService.Heartbeat:Connect(function()
    if not loadingActive then pulseConn:Disconnect() return end
    local scale = 1 + math.sin(tick() * 2) * 0.03
    logoImage.Size = UDim2.new(0, 150 * scale, 0, 150 * scale)
end)

local function finishLoading()
    if not loadingActive then return end
    loadingActive = false
    if pulseConn then pulseConn:Disconnect() end

    local fadeOutInfo = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    TweenService:Create(bg, fadeOutInfo, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(logoImage, fadeOutInfo, { ImageTransparency = 1 }):Play()
    TweenService:Create(sealText, fadeOutInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(author, fadeOutInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(devText, fadeOutInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(devBox, fadeOutInfo, { BackgroundTransparency = 1 }):Play()

    task.delay(0.4, function()
        if loadingGui then loadingGui:Destroy() end
    end)
end

local notifyGui = Instance.new("ScreenGui")
notifyGui.Name = "SealNotify"
notifyGui.ResetOnSpawn = false
notifyGui.IgnoreGuiInset = true
notifyGui.DisplayOrder = 99999
notifyGui.Parent = PG

local notifyFrame = Instance.new("Frame")
notifyFrame.AnchorPoint = Vector2.new(0, 1)
notifyFrame.Position = UDim2.new(0, 20, 1, -20)
notifyFrame.Size = UDim2.new(0, 250, 0, 45)
notifyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
notifyFrame.BackgroundTransparency = 1
notifyFrame.BorderSizePixel = 0
notifyFrame.ClipsDescendants = true
notifyFrame.Parent = notifyGui

local notifyCorner = Instance.new("UICorner")
notifyCorner.CornerRadius = UDim.new(0, 6)
notifyCorner.Parent = notifyFrame

local notifyStroke = Instance.new("UIStroke")
notifyStroke.Color = Color3.fromHex("#8a63ff")
notifyStroke.Thickness = 1
notifyStroke.Transparency = 1
notifyStroke.Parent = notifyFrame

local notifyText = Instance.new("TextLabel")
notifyText.Size = UDim2.new(1, -20, 1, 0)
notifyText.Position = UDim2.new(0, 10, 0, 0)
notifyText.BackgroundTransparency = 1
notifyText.Text = ""
notifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
notifyText.Font = Enum.Font.GothamBold
notifyText.TextSize = 13
notifyText.TextXAlignment = Enum.TextXAlignment.Left
notifyText.TextTransparency = 1
notifyText.Parent = notifyFrame

local notifyThread = false
local function NotifyCustom(text)
    if notifyThread then return end
    notifyThread = true
    
    notifyText.Text = text
    notifyFrame.Position = UDim2.new(0, -300, 1, -20)
    notifyFrame.BackgroundTransparency = 1
    notifyText.TextTransparency = 1
    notifyStroke.Transparency = 1

    TweenService:Create(notifyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 20, 1, -20), BackgroundTransparency = 0.2}):Play()
    TweenService:Create(notifyText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(notifyStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()

    task.delay(2.5, function()
        TweenService:Create(notifyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0, -300, 1, -20), BackgroundTransparency = 1}):Play()
        TweenService:Create(notifyText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(notifyStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
        task.wait(0.35)
        notifyThread = false
    end)
end

local Settings = {
    FlySpeed = 50,
    SilentAim = false,
    AimPart = "Head",
    Smoothness = 0.8,
    MaxDistance = 500,
    ESPColor = Color3.fromRGB(138, 99, 255),
}

local isEspActive = false
local isAimbotEnabled = false
local currentAimbotTarget = nil
local espInstances = {}
local flyEnabled, noclipEnabled = false, false
local flyConn, flyBodyVelocity, noclipConn = nil, nil, nil
local aimbotConn = nil

local CoreGui = game:GetService("CoreGui")
local espFolder = CoreGui:FindFirstChild("SealESP") or Instance.new("Folder")
espFolder.Name = "SealESP"
espFolder.Parent = CoreGui

local ok, UI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)
if not ok or not UI then
    finishLoading()
    return
end

local Hub = UI:CreateWindow({
    Title = "Seal Rivals", Icon = LOGO, Author = "SealDev",
    Folder = "SealRivalsConfigs", Size = UDim2.fromOffset(500, 400),
    ToggleKey = nil, Theme = "Dark",
    Transparent = false, Resizable = true, SideBarWidth = 160,
    User = { Enabled = true, Anonymous = true },
})

pcall(function()
    UI:AddTheme({
        Name = "seal_dark",
        Accent = Color3.fromHex("#8a63ff"),
        Background = Color3.fromHex("#000000"),
        Text = Color3.fromHex("#ffffff"),
        Button = Color3.fromHex("#1a1a1a"),
        Icon = Color3.fromHex("#ffffff"),
        Hover = Color3.fromHex("#2a2a2a"),
        Toggle = Color3.fromHex("#1a1a1a"),
        ToggleBar = Color3.fromHex("#8a63ff"),
        Slider = Color3.fromHex("#1a1a1a"),
        SliderThumb = Color3.fromHex("#8a63ff"),
    })
    Hub:SetTheme("seal_dark")
end)

pcall(function() Hub:EditOpenButton({ Enabled = false }) end)
Hub:Tag({ Title = "Rivals", Icon = "sword", Color = Color3.fromHex("#8a63ff"), Radius = 4 })

finishLoading()

local uiVisible = true
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        uiVisible = not uiVisible
        if uiVisible then
            Hub:Open()
            NotifyCustom("UI is opened")
        else
            Hub:Close()
            NotifyCustom("UI is closed")
        end
    end
end)

local function getClosestEnemyInFOV()
    local cam = Workspace.CurrentCamera
    local myChar = LP.Character
    if not myChar then return nil end
    
    local myHead = myChar:FindFirstChild("Head")
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myHead or not myRoot then return nil end
    
    local centerPoint = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local closestPlayer = nil
    local minDistance = FIXED_FOV + 1
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local targetPart
                if Settings.AimPart == "body" then
                    targetPart = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("body")
                else
                    targetPart = player.Character:FindFirstChild(Settings.AimPart) or player.Character:FindFirstChild("Head")
                end
                
                if targetPart then
                    local dist3D = (myRoot.Position - targetPart.Position).Magnitude
                    if dist3D <= Settings.MaxDistance then
                        local screenPoint, onScreen = cam:WorldToScreenPoint(targetPart.Position)
                        if onScreen then
                            local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - centerPoint).Magnitude
                            if distance <= FIXED_FOV and distance < minDistance then
                                minDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function aimAtTarget(target)
    if not target or not target.Character then return end
    local aimPart
    if Settings.AimPart == "body" then
        aimPart = target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("body")
    else
        aimPart = target.Character:FindFirstChild(Settings.AimPart)
    end
    if not aimPart then return end
    local cam = Workspace.CurrentCamera
    cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, aimPart.Position), Settings.Smoothness)
end

aimbotConn = RunService.Heartbeat:Connect(function()
    if isAimbotEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = currentAimbotTarget
        if not target or not target.Character then
            currentAimbotTarget = getClosestEnemyInFOV()
            target = currentAimbotTarget
        end
        if target then aimAtTarget(target) end
    else
        currentAimbotTarget = nil
    end
end)

local function startNoclip()
    if noclipConn then return end
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        local char = LP.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end
    end)
end

local function stopNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    local char = LP.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = true end
    end
end

local function startFly()
    if flyConn then return end
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local humanoid = char:FindFirstChild("Humanoid")
    
    if humanoid then
        humanoid.PlatformStand = true
        humanoid.AutoRotate = false
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do track:Stop() end
    end
    
    local animate = char:FindFirstChild("Animate")
    if animate then animate.Enabled = false end
    
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.Parent = hrp
    flyBodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    
    flyConn = RunService.Heartbeat:Connect(function()
        if not flyEnabled then return end
        local c = LP.Character
        if not c then return end
        local r = c:FindFirstChild("HumanoidRootPart")
        if not r then return end
        
        if not flyBodyVelocity or flyBodyVelocity.Parent ~= r then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Parent = r
            flyBodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        end
        
        local cam = Workspace.CurrentCamera
        local camLook = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector
        
        r.CFrame = CFrame.new(r.Position, r.Position + camLook)
        r.Velocity = Vector3.zero
        
        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move += camLook end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move -= camLook end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move -= right end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move += right end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.yAxis end
        
        if move.Magnitude > 0 then move = move.Unit * Settings.FlySpeed end
        flyBodyVelocity.Velocity = move
    end)
end

local function stopFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
    local char = LP.Character
    if char then
        local animate = char:FindFirstChild("Animate")
        if animate then animate.Enabled = true end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.AutoRotate = true
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end

local function cleanUpEsp(player)
    if espInstances[player.UserId] then
        for _, inst in ipairs(espInstances[player.UserId]) do
            if inst and inst.Parent then inst:Destroy() end
        end
        espInstances[player.UserId] = nil
    end
end

local function createEspElements(player)
    if player == LP or espInstances[player.UserId] then return end
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Settings.ESPColor
    highlight.OutlineColor = Settings.ESPColor
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = character
    highlight.Parent = espFolder
    espInstances[player.UserId] = {highlight}
end

local function refreshEsp()
    if not isEspActive then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
            local char = player.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if root and hum and hum.Health > 0 then
                if not espInstances[player.UserId] or not espInstances[player.UserId][1] or not espInstances[player.UserId][1].Parent then
                    cleanUpEsp(player)
                    createEspElements(player)
                else
                    espInstances[player.UserId][1].Adornee = char
                end
            else
                cleanUpEsp(player)
            end
        end
    end
end

task.spawn(function()
    while task.wait(0.5) do
        if isEspActive then
            refreshEsp()
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    cleanUpEsp(player)
end)

local function startSilentAim()
    pcall(function()
        local mt = getrawmetatable(game)
        if not mt then return end
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if Settings.SilentAim and method == "Raycast" and self == Workspace then
                local args = {...}
                local target = getClosestEnemyInFOV()
                if target and target.Character then
                    local aimPart
                    if Settings.AimPart == "body" then
                        aimPart = target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("body")
                    else
                        aimPart = target.Character:FindFirstChild(Settings.AimPart)
                    end
                    if aimPart and args[1] and args[2] then
                        args[2] = (aimPart.Position - args[1]).Unit * args[2].Magnitude
                    end
                end
                return oldNamecall(self, unpack(args))
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end)
end

local FlyTab = Hub:Tab({ Title = "Movement", Icon = "footprints" })
FlyTab:Toggle({ 
    Title = "Fly", Default = false, 
    Callback = function(v) 
        flyEnabled = v; if v then startFly() else stopFly() end 
        NotifyCustom("Join Discord pls") 
    end 
})
FlyTab:Toggle({ 
    Title = "Noclip", Default = false, 
    Callback = function(v) 
        noclipEnabled = v; if v then startNoclip() else stopNoclip() end 
        NotifyCustom("Join Discord pls") 
    end 
})

local CombatTab = Hub:Tab({ Title = "Combat", Icon = "crosshair" })
CombatTab:Toggle({ 
    Title = "Aimbot (Hold RMB)", Default = false, 
    Callback = function(v) 
        isAimbotEnabled = v 
        NotifyCustom("Join Discord pls") 
    end 
})
CombatTab:Dropdown({
    Title = "Aim Part",
    Values = { "Head", "body" },
    Default = "Head",
    Callback = function(v) 
        Settings.AimPart = v 
        NotifyCustom("Join Discord pls") 
    end,
})
CombatTab:Toggle({ 
    Title = "Silent Aim", Default = false, 
    Callback = function(v) 
        Settings.SilentAim = v; if v then startSilentAim() end 
        NotifyCustom("Join Discord pls") 
    end 
})

local EspTab = Hub:Tab({ Title = "ESP", Icon = "eye" })
EspTab:Toggle({
    Title = "ESP", Default = false,
    Callback = function(v)
        isEspActive = v
        if v then refreshEsp() else for _, p in ipairs(Players:GetPlayers()) do cleanUpEsp(p) end end
        NotifyCustom("Join Discord pls")
    end,
})
EspTab:Colorpicker({
    Title = "ESP Color", Default = Settings.ESPColor,
    Callback = function(c)
        Settings.ESPColor = c
        for _, objects in pairs(espInstances) do
            for _, obj in ipairs(objects) do
                if obj:IsA("Highlight") then obj.FillColor = c; obj.OutlineColor = c end
            end
        end
        NotifyCustom("Join Discord pls")
    end,
})

local MiscTab = Hub:Tab({ Title = "Misc", Icon = "wrench" })
MiscTab:Button({ 
    Title = "Join Discord", 
    Callback = function() 
        pcall(setclipboard, DISCORD_LINK)
        NotifyCustom("discord link copied, pase it into ur browser or smth, ty") 
    end 
})

Hub:OnDestroy(function()
    if flyConn then flyConn:Disconnect() end
    if noclipConn then noclipConn:Disconnect() end
    if aimbotConn then aimbotConn:Disconnect() end
    if flyBodyVelocity then flyBodyVelocity:Destroy() end
    for _, p in ipairs(Players:GetPlayers()) do cleanUpEsp(p) end
    stopFly()
    stopNoclip()
    if notifyGui then notifyGui:Destroy() end
    if espFolder then espFolder:Destroy() end
end)

NotifyCustom(" Press K to open/close UI")
