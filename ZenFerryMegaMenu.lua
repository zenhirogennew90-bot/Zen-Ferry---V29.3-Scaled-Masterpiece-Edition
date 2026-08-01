-- =========================================================
-- ZEN / FERRY V30 - MASTERPIECE EDITION
-- BAGIAN 1: UI BUILDER (TAMPILAN VISUAL DI ATAS)
-- =========================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Clean Up Old GUI
if CoreGui:FindFirstChild("ZenFerryGui") then
    CoreGui.ZenFerryGui:Destroy()
end
if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("ZenFerryGui") then
    LocalPlayer.PlayerGui.ZenFerryGui:Destroy()
end

-- ScreenGui Container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZenFerryGui"
screenGui.ResetOnSpawn = false

pcall(function()
    screenGui.Parent = CoreGui
end)
if not screenGui.Parent then
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Window Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 420)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(138, 43, 226) -- Neon Purple
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Header
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🔮 Zen/Ferry v30"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

-- Scroll Container
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -50)
scrollFrame.Position = UDim2.new(0, 10, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 480)
scrollFrame.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 8)
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.Parent = scrollFrame

-- Function Bikin TextButton Standar (UI Only)
local function createButtonUI(name, btnText)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -10, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    button.Text = btnText
    button.TextColor3 = Color3.fromRGB(240, 240, 240)
    button.TextSize = 15
    button.Font = Enum.Font.SourceSansSemibold
    button.AutoButtonColor = true
    button.Active = true
    button.Parent = scrollFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(50, 50, 70)
    btnStroke.Thickness = 1
    btnStroke.Parent = button

    return button
end

-- INI SEMUA TOMBOL UI DIBUAT DULU DI ATAS
local btnSpectate  = createButtonUI("BtnSpectate", "👁️ Spectate")
local btnRefresh   = createButtonUI("BtnRefresh", "🔄 Auto-Refresh")
local btnTeleport  = createButtonUI("BtnTeleport", "🌀 Teleport!")
local btnNoclip    = createButtonUI("BtnNoclip", "👻 Noclip: OFF")

-- Speed Panel UI
local speedFrame = Instance.new("Frame")
speedFrame.Name = "SpeedFrame"
speedFrame.Size = UDim2.new(1, -10, 0, 38)
speedFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
speedFrame.Parent = scrollFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 6)
speedCorner.Parent = speedFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(0.6, 0, 1, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ Speed: 16"
speedLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
speedLabel.TextSize = 15
speedLabel.Font = Enum.Font.SourceSansSemibold
speedLabel.Parent = speedFrame

local btnMinus = Instance.new("TextButton")
btnMinus.Name = "BtnMinus"
btnMinus.Size = UDim2.new(0.18, 0, 0.8, 0)
btnMinus.Position = UDim2.new(0.62, 0, 0.1, 0)
btnMinus.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
btnMinus.Text = "-"
btnMinus.TextColor3 = Color3.fromRGB(255, 100, 100)
btnMinus.TextSize = 18
btnMinus.Font = Enum.Font.SourceSansBold
btnMinus.Parent = speedFrame

local btnPlus = Instance.new("TextButton")
btnPlus.Name = "BtnPlus"
btnPlus.Size = UDim2.new(0.18, 0, 0.8, 0)
btnPlus.Position = UDim2.new(0.81, 0, 0.1, 0)
btnPlus.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
btnPlus.Text = "+"
btnPlus.TextColor3 = Color3.fromRGB(100, 255, 100)
btnPlus.TextSize = 18
btnPlus.Font = Enum.Font.SourceSansBold
btnPlus.Parent = speedFrame

local btnESP       = createButtonUI("BtnESP", "👁️ ESP: OFF")
local btnColor     = createButtonUI("BtnColor", "🎨 Color: Merah")
local btnFly       = createButtonUI("BtnFly", "✈️ Fly Mode: OFF")

=========================================================
-- BUILD FLY PANEL (YANG MUNCUL SAAT FLY ON)
-- =========================================================
local flyPanel = Instance.new("Frame")
flyPanel.Name = "FlyPanel"
flyPanel.Size = UDim2.new(0, 240, 0, 220)
flyPanel.Position = UDim2.new(0.2, 0, 0.3, 0)
flyPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
flyPanel.Visible = false -- Sembunyikan dulu sampai Fly dinyalakan
flyPanel.Active = true
flyPanel.Draggable = true
flyPanel.Parent = flyGui
Instance.new("UICorner", flyPanel).CornerRadius = UDim.new(0, 8)
local flyStroke = Instance.new("UIStroke")
flyStroke.Color = Color3.fromRGB(0, 170, 255)
flyStroke.Thickness = 2
flyStroke.Parent = flyPanel

local flyTitle = Instance.new("TextLabel")
flyTitle.Size = UDim2.new(1, 0, 0, 30)
flyTitle.BackgroundTransparency = 1
flyTitle.Text = "✈️ Fly Panel"
flyTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
flyTitle.TextSize = 15
flyTitle.Font = Enum.Font.SourceSansBold
flyTitle.Parent = flyPanel

local btnCloseFly = createButtonUI("BtnCloseFly", "❌ Matikan Fly")
btnCloseFly.Size = UDim2.new(1, -20, 0, 32)
btnCloseFly.Position = UDim2.new(0, 10, 0, 175)
btnCloseFly.Parent = flyPanel

-- =========================================================
-- BAGIAN 2: LOGIC & FUNCTIONALITY (LOGIKANYA DI BAWAH)
-- =========================================================

-- State Variables
local espEnabled = false
local noclipEnabled = false
local flyEnabled = false
local walkSpeed = 16

local colors = {
    Color3.fromRGB(255, 50, 50),   -- Merah
    Color3.fromRGB(50, 255, 50),   -- Hijau
    Color3.fromRGB(50, 150, 255),  -- Biru
    Color3.fromRGB(255, 255, 50)   -- Kuning
}
local colorNames = {"Merah", "Hijau", "Biru", "Kuning"}
local colorIndex = 1

local espFolder = workspace:FindFirstChild("ZenFerryESP") or Instance.new("Folder", workspace)
espFolder.Name = "ZenFerryESP"

-- Functions Logic
local function updateSpeed(newSpeed)
    walkSpeed = math.max(16, newSpeed)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
    end
end

RunService.Stepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if LocalPlayer.Character.Humanoid.WalkSpeed ~= walkSpeed then
            LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
        end
    end
    
    if noclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local function refreshESP()
    espFolder:ClearAllChildren()
    if not espEnabled then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = Instance.new("Highlight")
            highlight.Name = player.Name
            highlight.Adornee = player.Character
            highlight.FillColor = colors[colorIndex]
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.Parent = espFolder
        end
    end
end

local espEnabled = false
local noclipEnabled = false
local flyEnabled = false
local walkSpeed = 16
local flySpeed = 50
local spectatingTarget = nil

local colors = {
    Color3.fromRGB(255, 50, 50),
    Color3.fromRGB(50, 255, 50),
    Color3.fromRGB(50, 150, 255),
    Color3.fromRGB(255, 255, 50)
}
local colorNames = {"Merah", "Hijau", "Biru", "Kuning"}
local colorIndex = 1

local espFolder = workspace:FindFirstChild("ZenFerryESP") or Instance.new("Folder", workspace)
espFolder.Name = "ZenFerryESP"

-- 1. LOGIC SPEED
local function updateSpeed(newSpeed)
    walkSpeed = math.max(16, newSpeed)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
    end
end

-- 2. LOGIC NOCLIP & FLY LOOP
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if char.Humanoid.WalkSpeed ~= walkSpeed and not flyEnabled then
            char.Humanoid.WalkSpeed = walkSpeed
        end
        
        if noclipEnabled then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        
        -- Fly Engine Physics
        if flyEnabled and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            hrp.Velocity = Vector3.new(0, 1, 0) -- Anti gravity sederhana
        end
    end
end)

-- 3. LOGIC ESP
local function refreshESP()
    espFolder:ClearAllChildren()
    if not espEnabled then return end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hl = Instance.new("Highlight")
            hl.Name = player.Name
            hl.Adornee = player.Character
            hl.FillColor = colors[colorIndex]
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.FillTransparency = 0.5
            hl.Parent = espFolder
        end
    end
end

-- 4. LOGIC SPECTATE (Melihat player lain bergantian)
local function toggleSpectate()
    local playersList = Players:GetPlayers()
    if not spectatingTarget then
        for _, p in pairs(playersList) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                spectatingTarget = p
                workspace.CurrentCamera.CameraSubject = p.Character.Humanoid
                btnSpectate.Text = "👁️ Spectating: " .. p.Name
                btnSpectate.TextColor3 = Color3.fromRGB(0, 255, 120)
                break
            end
        end
    else
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        btnSpectate.Text = "👁️ Spectate"
        btnSpectate.TextColor3 = Color3.fromRGB(240, 240, 240)
        spectatingTarget = nil
    end
end

-- 5. LOGIC TELEPORT TO MOUSE (Teleport instan ke arah kursor/posisi depan)
local function teleportToMouse()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local mouse = LocalPlayer:GetMouse()
        if mouse.Hit then
            char.HumanoidRootPart.CFrame = mouse.Hit + Vector3.new(0, 3, 0)
        end
    end
end

-- =========================================================
-- SAMBUNGAN LOGIC KE TOMBOL UI
-- =========================================================

btnNoclip.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    btnNoclip.Text = "👻 Noclip: " .. (noclipEnabled and "ON" or "OFF")
    btnNoclip.TextColor3 = noclipEnabled and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(240, 240, 240)
end)

btnMinus.MouseButton1Click:Connect(function()
    updateSpeed(walkSpeed - 5)
    speedLabel.Text = "⚡ Speed: " .. walkSpeed
end)

btnPlus.MouseButton1Click:Connect(function()
    updateSpeed(walkSpeed + 5)
    speedLabel.Text = "⚡ Speed: " .. walkSpeed
end)

btnESP.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    btnESP.Text = "👁️ ESP: " .. (espEnabled and "ON" or "OFF")
    btnESP.TextColor3 = espEnabled and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(240, 240, 240)
    refreshESP()
end)

btnColor.MouseButton1Click:Connect(function()
    colorIndex = (colorIndex % #colors) + 1
    btnColor.Text = "🎨 Color: " .. colorNames[colorIndex]
    refreshESP()
end)

btnFly.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    btnFly.Text = "✈️ Fly Mode: " .. (flyEnabled and "ON" or "OFF")
    btnFly.TextColor3 = flyEnabled and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(240, 240, 240)
end)

btnSpectate.MouseButton1Click:Connect(function()
    print("[Zen/Ferry] Spectate Triggered")
end)

btnRefresh.MouseButton1Click:Connect(function()
    print("[Zen/Ferry] Refresh Triggered")
end)

btnTeleport.MouseButton1Click:Connect(function()
    print("[Zen/Ferry] Teleport Triggered")
end)

-- Tombol Fly Mode Utama di Menu
local function triggerFly()
    flyEnabled = not flyEnabled
    btnFly.Text = "✈️ Fly Mode: " .. (flyEnabled and "ON" or "OFF")
    btnFly.TextColor3 = flyEnabled and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(240, 240, 240)
    flyPanel.Visible = flyEnabled -- Memunculkan / Menyembunyikan Fly Panel di layar!
end

btnFly.MouseButton1Click:Connect(triggerFly)
btnCloseFly.MouseButton1Click:Connect(triggerFly)

btnSpectate.MouseButton1Click:Connect(toggleSpectate)
btnTeleport.MouseButton1Click:Connect(teleportToMouse)
btnRefresh.MouseButton1Click:Connect(function()
    refreshESP()
    print("[Zen/Ferry] UI Refreshed!")
end)
