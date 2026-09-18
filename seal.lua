local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

local IMAGE_ID = "rbxassetid://94513154691410"
local IMAGE_TRANSPARENCY = 0.5
local WINDOW_WIDTH = 400
local WINDOW_HEIGHT = 300
local DRAG_SPEED = 0.15

local Settings = {
    FlySpeed = 50,
    AimEnabled = false,
    SilentAim = false,
    AimPart = "Head",
    FOV = 200,
    Smoothness = 0.8,
    TeamCheck = true,
    WallCheck = false,
    MaxDistance = 500,
    ESPEnabled = false,
    ESPColor = Color3.fromRGB(255, 0, 0),
    ESPMaxDistance = 500,
}

-- ==========================================================
-- NOCLIP (ИСПРАВЛЕНО)
-- ==========================================================
local noclipEnabled = false
local noclipConn = nil

local function startNoclip()
    if noclipConn then return end
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        local char = LP.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)
end

local function stopNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    local char = LP.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- ==========================================================
-- GUI
-- ==========================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SealGUI"
screenGui.Parent = PG
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, WINDOW_WIDTH, 0, WINDOW_HEIGHT)
mainFrame.Position = UDim2.new(0.5, -WINDOW_WIDTH/2, 0.5, -WINDOW_HEIGHT/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Visible = true

local whiteOutline = Instance.new("UIStroke")
whiteOutline.Parent = mainFrame
whiteOutline.Color = Color3.fromRGB(255, 255, 255)
whiteOutline.Thickness = 1.5
whiteOutline.Transparency = 0
whiteOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local bgImage = Instance.new("ImageLabel")
bgImage.Parent = mainFrame
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.BackgroundTransparency = 1
bgImage.Image = IMAGE_ID
bgImage.ScaleType = Enum.ScaleType.Crop
bgImage.ImageTransparency = IMAGE_TRANSPARENCY

local overlay = Instance.new("Frame")
overlay.Parent = mainFrame
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.4
overlay.BorderSizePixel = 0

local dragging = false
local dragStart = nil
local startPos = nil

local titleBar = Instance.new("Frame")
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.BackgroundTransparency = 0.2
titleBar.BorderSizePixel = 0

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(mainFrame, TweenInfo.new(DRAG_SPEED, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = titleBar
titleLabel.Size = UDim2.new(1, -20, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Seal Tralalero Tralala Script"
titleLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local tabBar = Instance.new("Frame")
tabBar.Parent = mainFrame
tabBar.Size = UDim2.new(1, 0, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 35)
tabBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tabBar.BackgroundTransparency = 0.4
tabBar.BorderSizePixel = 0

local flyTab = Instance.new("TextButton")
flyTab.Parent = tabBar
flyTab.Size = UDim2.new(0, 100, 1, 0)
flyTab.Position = UDim2.new(0, 5, 0, 0)
flyTab.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
flyTab.BorderSizePixel = 0
flyTab.Text = "Fly"
flyTab.TextColor3 = Color3.fromRGB(255, 255, 255)
flyTab.TextSize = 13
flyTab.Font = Enum.Font.GothamBold

local combatTab = Instance.new("TextButton")
combatTab.Parent = tabBar
combatTab.Size = UDim2.new(0, 120, 1, 0)
combatTab.Position = UDim2.new(0, 110, 0, 0)
combatTab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
combatTab.BorderSizePixel = 0
combatTab.Text = "Aim / ESP"
combatTab.TextColor3 = Color3.fromRGB(255, 255, 255)
combatTab.TextSize = 13
combatTab.Font = Enum.Font.GothamBold

local flyContent = Instance.new("Frame")
flyContent.Parent = mainFrame
flyContent.Size = UDim2.new(1, 0, 1, -65)
flyContent.Position = UDim2.new(0, 0, 0, 65)
flyContent.BackgroundTransparency = 1
flyContent.Visible = true

local combatContent = Instance.new("Frame")
combatContent.Parent = mainFrame
combatContent.Size = UDim2.new(1, 0, 1, -65)
combatContent.Position = UDim2.new(0, 0, 0, 65)
combatContent.BackgroundTransparency = 1
combatContent.Visible = false

-- ==========================================================
-- FLY
-- ==========================================================
local flyEnabled = false
local flyConn = nil
local flyBodyVelocity = nil

local function disableAnimations()
    local char = LP.Character
    if not char then return end
    local animate = char:FindFirstChild("Animate")
    if animate then animate.Enabled = false end
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end
end

local function enableAnimations()
    local char = LP.Character
    if not char then return end
    local animate = char:FindFirstChild("Animate")
    if animate then animate.Enabled = true end
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
    end

    disableAnimations()

    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.Parent = hrp
    flyBodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)

    flyConn = RunService.Heartbeat:Connect(function()
        if not flyEnabled then return end
        local char2 = LP.Character
        if not char2 then return end
        local hrp2 = char2:FindFirstChild("HumanoidRootPart")
        if not hrp2 then return end

        if not flyBodyVelocity or flyBodyVelocity.Parent ~= hrp2 then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Parent = hrp2
            flyBodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        end

        local cam = workspace.CurrentCamera
        local camCF = cam.CFrame
        local camLook = camCF.LookVector.Unit

        hrp2.CFrame = CFrame.new(hrp2.Position, hrp2.Position + camLook)
        hrp2.RotVelocity = Vector3.new(0, 0, 0)
        hrp2.Velocity = Vector3.new(0, 0, 0)

        local animate = char2:FindFirstChild("Animate")
        if animate and animate.Enabled then animate.Enabled = false end

        local humanoid2 = char2:FindFirstChild("Humanoid")
        if humanoid2 then
            humanoid2.PlatformStand = true
            humanoid2.AutoRotate = false
            for _, track in pairs(humanoid2:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        local move = Vector3.new(0, 0, 0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + camLook end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - camLook end
        local right = Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z).Unit
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - right end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + right end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end

        if move.Magnitude > 0 then move = move.Unit * Settings.FlySpeed end
        flyBodyVelocity.Velocity = move
    end)
end

local function stopFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
    enableAnimations()
    local char = LP.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.AutoRotate = true
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end

-- ==========================================================
-- AIMBOT + SILENT AIM + ESP
-- ==========================================================
local isEspActive = false
local isAimbotEnabled = false
local fovRadius = Settings.FOV
local currentAimbotTarget = nil
local currentAimbotTargetPart = "Head"
local espInstances = {}

local function cleanUpEsp(player)
    if espInstances[player.UserId] then
        for _, inst in ipairs(espInstances[player.UserId]) do
            if inst and inst.Parent then
                inst:Destroy()
            end
        end
        espInstances[player.UserId] = nil
    end
end

local function createEspElements(player)
    if player == LP or espInstances[player.UserId] then return end
    local character = player.Character
    if not character then return end
    local rootPart = character:WaitForChild("HumanoidRootPart", 1)
    if not rootPart then return end
    local playerObjects = {}

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = true
    highlight.Parent = character
    table.insert(playerObjects, highlight)

    espInstances[player.UserId] = playerObjects
end

local function updateEspElements(player)
    -- не используется, оставлено для совместимости
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if isEspActive then createEspElements(player) end
    end)
end)

Players.PlayerRemoving:Connect(cleanUpEsp)

local function refreshEsp()
    if not isEspActive then return end
    for _, player in ipairs(Players:GetPlayers()) do
        cleanUpEsp(player)
        if player.Character then createEspElements(player) end
    end
end

spawn(function()
    while true do
        if isEspActive then refreshEsp() end
        wait(5)
    end
end)

local function getClosestEnemyInFOV()
    local myCharacter = LP.Character
    if not myCharacter or not myCharacter:FindFirstChild("Head") then return nil end
    local centerPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local closestPlayer = nil
    local minDistance = fovRadius + 1
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if not humanoid or humanoid.Health <= 0 then continue end
            local targetPart = player.Character:FindFirstChild(currentAimbotTargetPart)
            if not targetPart then continue end
            local screenPoint, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
            local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - centerPoint).Magnitude
            if onScreen and distance <= fovRadius then
                local myPart = myCharacter:FindFirstChild("Head")
                if myPart then
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {myCharacter, player.Character}
                    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                    local raycastResult = Workspace:Raycast(myPart.Position, targetPart.Position - myPart.Position, raycastParams)
                    if not raycastResult or raycastResult.Instance:IsDescendantOf(player.Character) then
                        if distance < minDistance then
                            minDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function aimAtTarget(target, targetPartName)
    local partToAimAt = target.Character:FindFirstChild(targetPartName)
    if not partToAimAt then return end
    local lookAtCFrame = CFrame.new(Camera.CFrame.Position, partToAimAt.Position)
    Camera.CFrame = Camera.CFrame:Lerp(lookAtCFrame, Settings.Smoothness)
end

RunService.Heartbeat:Connect(function()
    if isAimbotEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        if not currentAimbotTarget or not currentAimbotTarget.Character or currentAimbotTarget.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
            currentAimbotTarget = getClosestEnemyInFOV()
        end
        if currentAimbotTarget then
            aimAtTarget(currentAimbotTarget, currentAimbotTargetPart)
        end
    else
        currentAimbotTarget = nil
    end
end)

-- ==========================================================
-- SILENT AIM (хук на Raycast)
-- ==========================================================
local function startSilentAim()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if Settings.SilentAim and method == "Raycast" and self == workspace then
            local target = getClosestEnemyInFOV()
            if target and target.Character then
                local aimPart = target.Character:FindFirstChild(Settings.AimPart) or target.Character:FindFirstChild("Head")
                if aimPart then
                    args[2] = (aimPart.Position - args[1]).Unit * args[2].Magnitude
                end
            end
        end
        return oldNamecall(self, unpack(args))
    end)
    setreadonly(mt, true)
end

-- ==========================================================
-- КНОПКИ FLY
-- ==========================================================
local flyBtn = Instance.new("TextButton")
flyBtn.Parent = flyContent
flyBtn.Size = UDim2.new(0, 120, 0, 30)
flyBtn.Position = UDim2.new(0, 10, 0, 10)
flyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
flyBtn.BorderSizePixel = 0
flyBtn.Text = "FLY: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextSize = 12
flyBtn.Font = Enum.Font.GothamBold
flyBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    if flyEnabled then
        flyBtn.Text = "FLY: ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        startFly()
    else
        flyBtn.Text = "FLY: OFF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        stopFly()
    end
end)

local noclipBtn = Instance.new("TextButton")
noclipBtn.Parent = flyContent
noclipBtn.Size = UDim2.new(0, 120, 0, 30)
noclipBtn.Position = UDim2.new(0, 10, 0, 50)
noclipBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
noclipBtn.BorderSizePixel = 0
noclipBtn.Text = "NOCLIP: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextSize = 12
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipBtn.Text = "NOCLIP: ON"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        startNoclip()
    else
        noclipBtn.Text = "NOCLIP: OFF"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        stopNoclip()
    end
end)

local sliderBg = Instance.new("Frame")
sliderBg.Parent = flyContent
sliderBg.Size = UDim2.new(0, 150, 0, 8)
sliderBg.Position = UDim2.new(0, 150, 0, 21)
sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sliderBg.BorderSizePixel = 0

local sliderFill = Instance.new("Frame")
sliderFill.Parent = sliderBg
sliderFill.Size = UDim2.new((Settings.FlySpeed - 10) / 140, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
sliderFill.BorderSizePixel = 0

local sliderKnob = Instance.new("TextButton")
sliderKnob.Parent = sliderBg
sliderKnob.Size = UDim2.new(0, 16, 0, 16)
sliderKnob.Position = UDim2.new((Settings.FlySpeed - 10) / 140, -8, 0.5, -8)
sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderKnob.BorderSizePixel = 0
sliderKnob.Text = ""

local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = flyContent
speedLabel.Size = UDim2.new(0, 150, 0, 20)
speedLabel.Position = UDim2.new(0, 150, 0, 35)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: " .. Settings.FlySpeed
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextSize = 12
speedLabel.Font = Enum.Font.Gotham

local draggingSlider = false

sliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
    end
end)

UIS.InputChanged:Connect(function(input)
    if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mouseX = input.Position.X
        local sliderStart = sliderBg.AbsolutePosition.X
        local sliderWidth = sliderBg.AbsoluteSize.X
        local relativeX = math.clamp((mouseX - sliderStart) / sliderWidth, 0, 1)
        local value = math.floor(10 + relativeX * 140)
        Settings.FlySpeed = value
        sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        sliderKnob.Position = UDim2.new(relativeX, -8, 0.5, -8)
        speedLabel.Text = "Speed: " .. Settings.FlySpeed
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false
    end
end)

-- ==========================================================
-- КНОПКИ COMBAT
-- ==========================================================
local silentAimBtn = Instance.new("TextButton")
silentAimBtn.Parent = combatContent
silentAimBtn.Size = UDim2.new(0, 120, 0, 30)
silentAimBtn.Position = UDim2.new(0, 10, 0, 10)
silentAimBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
silentAimBtn.BorderSizePixel = 0
silentAimBtn.Text = "SILENT AIM: OFF"
silentAimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
silentAimBtn.TextSize = 11
silentAimBtn.Font = Enum.Font.GothamBold
silentAimBtn.MouseButton1Click:Connect(function()
    Settings.SilentAim = not Settings.SilentAim
    if Settings.SilentAim then
        silentAimBtn.Text = "SILENT AIM: ON"
        silentAimBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        startSilentAim()
    else
        silentAimBtn.Text = "SILENT AIM: OFF"
        silentAimBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    end
end)

local aimBtn = Instance.new("TextButton")
aimBtn.Parent = combatContent
aimBtn.Size = UDim2.new(0, 120, 0, 30)
aimBtn.Position = UDim2.new(0, 10, 0, 50)
aimBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
aimBtn.BorderSizePixel = 0
aimBtn.Text = "AIMBOT: OFF"
aimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aimBtn.TextSize = 12
aimBtn.Font = Enum.Font.GothamBold
aimBtn.MouseButton1Click:Connect(function()
    isAimbotEnabled = not isAimbotEnabled
    Settings.AimEnabled = isAimbotEnabled
    if isAimbotEnabled then
        aimBtn.Text = "AIMBOT: ON"
        aimBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        aimBtn.Text = "AIMBOT: OFF"
        aimBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    end
end)

local espBtn = Instance.new("TextButton")
espBtn.Parent = combatContent
espBtn.Size = UDim2.new(0, 120, 0, 30)
espBtn.Position = UDim2.new(0, 10, 0, 90)
espBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
espBtn.BorderSizePixel = 0
espBtn.Text = "ESP: OFF"
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.TextSize = 12
espBtn.Font = Enum.Font.GothamBold
espBtn.MouseButton1Click:Connect(function()
    isEspActive = not isEspActive
    Settings.ESPEnabled = isEspActive
    if isEspActive then
        espBtn.Text = "ESP: ON"
        espBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then createEspElements(player) end
        end
    else
        espBtn.Text = "ESP: OFF"
        espBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        for _, player in ipairs(Players:GetPlayers()) do
            cleanUpEsp(player)
        end
    end
end)

local teamCheckBtn = Instance.new("TextButton")
teamCheckBtn.Parent = combatContent
teamCheckBtn.Size = UDim2.new(0, 120, 0, 30)
teamCheckBtn.Position = UDim2.new(0, 10, 0, 130)
teamCheckBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
teamCheckBtn.BorderSizePixel = 0
teamCheckBtn.Text = "TEAM CHECK: ON"
teamCheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teamCheckBtn.TextSize = 11
teamCheckBtn.Font = Enum.Font.GothamBold
teamCheckBtn.MouseButton1Click:Connect(function()
    Settings.TeamCheck = not Settings.TeamCheck
    if Settings.TeamCheck then
        teamCheckBtn.Text = "TEAM CHECK: ON"
        teamCheckBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        teamCheckBtn.Text = "TEAM CHECK: OFF"
        teamCheckBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    end
end)

local wallCheckBtn = Instance.new("TextButton")
wallCheckBtn.Parent = combatContent
wallCheckBtn.Size = UDim2.new(0, 120, 0, 30)
wallCheckBtn.Position = UDim2.new(0, 140, 0, 10)
wallCheckBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
wallCheckBtn.BorderSizePixel = 0
wallCheckBtn.Text = "WALL CHECK: OFF"
wallCheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
wallCheckBtn.TextSize = 11
wallCheckBtn.Font = Enum.Font.GothamBold
wallCheckBtn.MouseButton1Click:Connect(function()
    Settings.WallCheck = not Settings.WallCheck
    if Settings.WallCheck then
        wallCheckBtn.Text = "WALL CHECK: ON"
        wallCheckBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        wallCheckBtn.Text = "WALL CHECK: OFF"
        wallCheckBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    end
end)

-- ==========================================================
-- ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК
-- ==========================================================
flyTab.MouseButton1Click:Connect(function()
    flyContent.Visible = true
    combatContent.Visible = false
    flyTab.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
    combatTab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
end)

combatTab.MouseButton1Click:Connect(function()
    flyContent.Visible = false
    combatContent.Visible = true
    combatTab.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
    flyTab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.L then
        mainFrame.Visible = not mainFrame.Visible
    end
end)