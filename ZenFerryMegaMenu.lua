-- [ROBLOX LUA SCRIPT: Zen/Ferry - V30 EXTENDED SKELETON WITH FLY PANEL TOGGLE]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "ZenFerry_V30"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [PARENT SAFE]
local targetParent
local success = pcall(function()
    targetParent = (gethui and gethui()) or CoreGui
    local _ = targetParent.Name
end)
if not success or not targetParent then
    targetParent = player:WaitForChild("PlayerGui")
end

for _, v in ipairs(targetParent:GetChildren()) do
    if v.Name == "ZenFerry_V30" then v:Destroy() end
end
gui.Parent = targetParent

-- =========================================================
-- [MAIN WINDOW (MENU UTAMA)]
-- =========================================================
local frame = Instance.new("Frame", gui)
frame.Size, frame.Position = UDim2.new(0, 260, 0, 400), UDim2.new(0.5, -130, 0.5, -200)
frame.BackgroundColor3, frame.BorderSizePixel = Color3.fromRGB(15, 15, 20), 2
frame.Active, frame.Draggable = true, true

local title = Instance.new("TextLabel", frame)
title.Size, title.BackgroundColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(25, 20, 35)
title.Text, title.Font, title.TextSize = "🔮 Zen/Ferry v30", Enum.Font.SourceSansBold, 15

local btnMin = Instance.new("TextButton", title)
btnMin.Size, btnMin.Position = UDim2.new(0, 30, 0, 30), UDim2.new(1, -30, 0, 0)
btnMin.BackgroundColor3, btnMin.TextColor3 = Color3.fromRGB(40, 30, 60), Color3.fromRGB(255, 255, 255)
btnMin.Text, btnMin.Font, btnMin.TextSize, btnMin.BorderSizePixel = "-", Enum.Font.SourceSansBold, 16, 0

-- SCROLLING CONTAINER (Wadah Tombol Fitur)
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, -30)
scroll.Position = UDim2.new(0, 0, 0, 30)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 6
scroll.CanvasSize = UDim2.new(0, 0, 0, 1000) -- Area scroll diperluas

local allBtns = {}
local function mkBtn(text, pos, size)
    local b = Instance.new("TextButton", scroll)
    b.Size, b.Position = size, pos
    b.BackgroundColor3, b.BorderSizePixel = Color3.fromRGB(25, 30, 20), 1
    b.Text, b.Font, b.TextSize = text, Enum.Font.SourceSansBold, 14
    b.AutoButtonColor = true
    table.insert(allBtns, b)
    return b
end

-- ---------------------------------------------------------
-- 1. FITUR PILIH PLAYER
-- ---------------------------------------------------------
local btnPrev = mkBtn("<", UDim2.new(0, 10, 0, 10), UDim2.new(0, 30, 0, 30))
local textBox = Instance.new("TextBox", scroll)
textBox.Size, textBox.Position = UDim2.new(0, 160, 0, 30), UDim2.new(0, 50, 0, 10)
textBox.BackgroundColor3, textBox.TextColor3 = Color3.fromRGB(25, 20, 35), Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText, textBox.Text, textBox.Font, textBox.TextSize = "Display Name...", "", Enum.Font.SourceSans, 14
local btnNext = mkBtn(">", UDim2.new(0, 220, 0, 10), UDim2.new(0, 30, 0, 30))

-- ---------------------------------------------------------
-- 2. TOMBOL UTAMA FITUR (V29.4)
-- ---------------------------------------------------------
local btnPantau  = mkBtn("👀 Spectate", UDim2.new(0, 10, 0, 50), UDim2.new(0, 240, 0, 30))
local btnRefresh = mkBtn("🔄 Auto-Refresh", UDim2.new(0, 10, 0, 90), UDim2.new(0, 240, 0, 30))
local btnTP      = mkBtn("🚀 Teleport!", UDim2.new(0, 10, 0, 130), UDim2.new(0, 240, 0, 30))
local btnNoClip  = mkBtn("👻 Noclip: OFF", UDim2.new(0, 10, 0, 170), UDim2.new(0, 240, 0, 30))

local btnSpdM = mkBtn("-", UDim2.new(0, 10, 0, 210), UDim2.new(0, 30, 0, 30))
local lblSpd = Instance.new("TextLabel", scroll)
lblSpd.Size, lblSpd.Position = UDim2.new(0, 160, 0, 30), UDim2.new(0, 50, 0, 210)
lblSpd.BackgroundColor3, lblSpd.TextColor3 = Color3.fromRGB(25, 20, 35), Color3.fromRGB(255, 255, 255)
lblSpd.Text, lblSpd.Font, lblSpd.TextSize = "⚡ Speed: 16", Enum.Font.SourceSansBold, 14
local btnSpdP = mkBtn("+", UDim2.new(0, 220, 0, 210), UDim2.new(0, 30, 0, 30))

local btnESP      = mkBtn("👁️ ESP: OFF", UDim2.new(0, 10, 0, 250), UDim2.new(0, 240, 0, 30))
local btnESPColor = mkBtn("🎨 Color: Merah", UDim2.new(0, 10, 0, 290), UDim2.new(0, 240, 0, 30))
local btnFly      = mkBtn("🕊️ Fly Mode: OFF", UDim2.new(0, 10, 0, 330), UDim2.new(0, 240, 0, 30))

-- ---------------------------------------------------------
-- 3. SLOT FITUR PAJANGAN Tambahan (Fitur 1-14)
-- ---------------------------------------------------------
local btnNew1  = mkBtn("🦘 Infinite Jump [PAJANGAN]", UDim2.new(0, 10, 0, 370), UDim2.new(0, 240, 0, 30))
local btnNew2  = mkBtn("💥 Kill Aura [PAJANGAN]", UDim2.new(0, 10, 0, 410), UDim2.new(0, 240, 0, 30))
local btnNew3  = mkBtn("🛡️ God Mode [PAJANGAN]", UDim2.new(0, 10, 0, 450), UDim2.new(0, 240, 0, 30))
local btnNew4  = mkBtn("🌐 Auto Farm [PAJANGAN]", UDim2.new(0, 10, 0, 490), UDim2.new(0, 240, 0, 30))
local btnNew5  = mkBtn("✨ Fitur Kosong 5", UDim2.new(0, 10, 0, 530), UDim2.new(0, 240, 0, 30))
local btnNew6  = mkBtn("✨ Fitur Kosong 6", UDim2.new(0, 10, 0, 570), UDim2.new(0, 240, 0, 30))
local btnNew7  = mkBtn("✨ Fitur Kosong 7", UDim2.new(0, 10, 0, 610), UDim2.new(0, 240, 0, 30))
local btnNew8  = mkBtn("✨ Fitur Kosong 8", UDim2.new(0, 10, 0, 650), UDim2.new(0, 240, 0, 30))
local btnNew9  = mkBtn("✨ Fitur Kosong 9", UDim2.new(0, 10, 0, 690), UDim2.new(0, 240, 0, 30))
local btnNew10 = mkBtn("✨ Fitur Kosong 10", UDim2.new(0, 10, 0, 730), UDim2.new(0, 240, 0, 30))
local btnNew11 = mkBtn("✨ Fitur Kosong 11", UDim2.new(0, 10, 0, 770), UDim2.new(0, 240, 0, 30))
local btnNew12 = mkBtn("✨ Fitur Kosong 12", UDim2.new(0, 10, 0, 810), UDim2.new(0, 240, 0, 30))
local btnNew13 = mkBtn("✨ Fitur Kosong 13", UDim2.new(0, 10, 0, 850), UDim2.new(0, 240, 0, 30))
local btnNew14 = mkBtn("✨ Fitur Kosong 14", UDim2.new(0, 10, 0, 890), UDim2.new(0, 240, 0, 30))

-- =========================================================
-- [FLY CONTROL PANEL (MENU TERPISAH DI SAMPING)]
-- =========================================================
local flyPanel = Instance.new("Frame", gui)
flyPanel.Size, flyPanel.Position = UDim2.new(0, 220, 0, 280), UDim2.new(0.5, 140, 0.5, -140)
flyPanel.BackgroundColor3, flyPanel.BorderSizePixel = Color3.fromRGB(15, 15, 20), 2
flyPanel.Visible, flyPanel.Active, flyPanel.Draggable = false, true, true -- Default: Tersembunyi (false)

local flyTitle = Instance.new("TextLabel", flyPanel)
flyTitle.Size, flyTitle.BackgroundColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(25, 20, 35)
flyTitle.Text, flyTitle.Font, flyTitle.TextSize = "✈️ Fly Panel", Enum.Font.SourceSansBold, 14

local btnFlyMin = Instance.new("TextButton", flyTitle)
btnFlyMin.Size, btnFlyMin.Position = UDim2.new(0, 30, 0, 30), UDim2.new(1, -30, 0, 0)
btnFlyMin.BackgroundColor3, btnFlyMin.TextColor3 = Color3.fromRGB(40, 30, 60), Color3.fromRGB(255, 255, 255)
btnFlyMin.Text, btnFlyMin.Font, btnFlyMin.TextSize, btnFlyMin.BorderSizePixel = "-", Enum.Font.SourceSansBold, 15, 0

local function mkFlyBtn(text, pos, size)
    local b = Instance.new("TextButton", flyPanel)
    b.Size, b.Position = size, pos
    b.BackgroundColor3, b.BorderSizePixel = Color3.fromRGB(25, 30, 20), 1
    b.Text, b.Font, b.TextSize = text, Enum.Font.SourceSansBold, 13
    b.AutoButtonColor = true
    table.insert(allBtns, b)
    return b
end

-- Tombol-Tombol Pajangan Kontrol Fly
local btnFlyM = mkFlyBtn("-", UDim2.new(0, 10, 0, 40), UDim2.new(0, 30, 0, 30))
local lblFlySpd = Instance.new("TextLabel", flyPanel)
lblFlySpd.Size, lblFlySpd.Position = UDim2.new(0, 120, 0, 30), UDim2.new(0, 50, 0, 40)
lblFlySpd.BackgroundColor3, lblFlySpd.TextColor3 = Color3.fromRGB(25, 20, 35), Color3.fromRGB(255, 255, 255)
lblFlySpd.Text, lblFlySpd.Font, lblFlySpd.TextSize = "Spd: 50", Enum.Font.SourceSansBold, 14
local btnFlyP = mkFlyBtn("+", UDim2.new(0, 180, 0, 40), UDim2.new(0, 30, 0, 30))

local btnUp    = mkFlyBtn("⬆️ Naik", UDim2.new(0, 10, 0, 80), UDim2.new(0, 60, 0, 35))
local btnFwd   = mkFlyBtn("⏫ Maju", UDim2.new(0, 80, 0, 80), UDim2.new(0, 60, 0, 35))
local btnDown  = mkFlyBtn("⬇️ Turun", UDim2.new(0, 150, 0, 80), UDim2.new(0, 60, 0, 35))

local btnLeft  = mkFlyBtn("⬅️ Kiri", UDim2.new(0, 10, 0, 125), UDim2.new(0, 60, 0, 35))
local btnBwd   = mkFlyBtn("⏬ Mundur", UDim2.new(0, 80, 0, 125), UDim2.new(0, 60, 0, 35))
local btnRight = mkFlyBtn("➡️ Kanan", UDim2.new(0, 150, 0, 125), UDim2.new(0, 60, 0, 35))

local btnFlySens = mkFlyBtn("⚙️ Sens: Normal", UDim2.new(0, 10, 0, 175), UDim2.new(0, 200, 0, 35))
local btnFlyOff  = mkFlyBtn("❌ Matikan Fly", UDim2.new(0, 10, 0, 220), UDim2.new(0, 200, 0, 35))

-- =========================================================
-- [RGB ENGINE & INTERAKSI BASIC SKELETON UI]
-- =========================================================
local p1 = {Color3.fromRGB(0,150,255), Color3.fromRGB(255,50,50), Color3.fromRGB(180,0,255), Color3.fromRGB(0,230,100), Color3.fromRGB(255,220,0)}
local p2 = {Color3.fromRGB(255,220,0), Color3.fromRGB(0,230,100)}
task.spawn(function()
    while gui and gui.Parent do
        local t = tick() * 0.4
        local c1 = p1[math.floor((t % 1) * 5) + 1]
        local c2 = p2[math.floor(((t + 0.5) % 1) * 2) + 1]
        title.TextColor3, flyTitle.TextColor3 = c1, c1
        frame.BorderColor3, flyPanel.BorderColor3 = c2, c2
        for i = 1, #allBtns do
            if allBtns[i] ~= btnFlyOff then
                allBtns[i].TextColor3, allBtns[i].BorderColor3 = c2, c2
            end
        end
        task.wait(0.05)
    end
end)

-- MINIMIZE INTERACTION
local isMin, isFlyMin = false, false
btnMin.Activated:Connect(function()
    isMin = not isMin
    btnMin.Text = isMin and "+" or "-"
    frame.Size = isMin and UDim2.new(0, 260, 0, 30) or UDim2.new(0, 260, 0, 400)
    scroll.Visible = not isMin
end)

btnFlyMin.Activated:Connect(function()
    isFlyMin = not isFlyMin
    btnFlyMin.Text = isFlyMin and "+" or "-"
    flyPanel.Size = isFlyMin and UDim2.new(0, 220, 0, 30) or UDim2.new(0, 220, 0, 280)
    for _, c in ipairs(flyPanel:GetChildren()) do
        if c ~= flyTitle then c.Visible = not isFlyMin end
    end
end)

-- TOGGLE TAMPILAN FLY PANEL DARI TOMBOL FLY MODE
local isFlyDummy = false
local function toggleFlyPanelUI()
    isFlyDummy = not isFlyDummy
    btnFly.Text = isFlyDummy and "🕊️ Fly Mode: ON" or "🕊️ Fly Mode: OFF"
    flyPanel.Visible = isFlyDummy -- Tampilkan/Sembunyikan Fly Panel
end

btnFly.Activated:Connect(toggleFlyPanelUI)
btnFlyOff.Activated:Connect(function()
    if isFlyDummy then toggleFlyPanelUI() end
end)

-- =========================================================
-- [BAGIAN LOGIKA / PERINTAH MANUAL DITARUH DI BAWAH SINI]
-- =========================================================
-- =========================================================
-- LOGIKA LENGKAP: FLY PANEL & SISTEM PENERBANGAN (V30)
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local flySpeed = 50
local isFlying = false
local flyConnection = nil
local bodyVel, bodyGyro = nil, nil

-- Kontrol Gerak
local moveState = {
    forward = 0, backward = 0, left = 0, right = 0, up = 0, down = 0
}

-- Update Tampilan Speed di UI
local function updateSpeedDisplay()
    if btnFlySpeed then
        btnFlySpeed.Text = "Speed: " .. tostring(flySpeed)
    end
end

-- Fungsi Menghentikan Terbang
local function stopFlying()
    isFlying = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if bodyVel then bodyVel:Destroy() bodyVel = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end
    
    if btnFlyToggle then
        btnFlyToggle.Text = "Flight: OFF"
        btnFlyToggle.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    end
end

-- Fungsi Memulai Terbang
local function startFlying()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if not hrp or not hum then return end
    
    isFlying = true
    hum.PlatformStand = true

    -- Membuat mover objects
    bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyVel.Velocity = Vector3.zero
    bodyVel.Parent = hrp

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bodyGyro.P = 9000
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp

    if btnFlyToggle then
        btnFlyToggle.Text = "Flight: ON"
        btnFlyToggle.BackgroundColor3 = Color3.fromRGB(40, 150, 40)
    end

    -- Loop Pergerakan Terbang
    flyConnection = RunService.RenderStepped:Connect(function()
        if not isFlying or not hrp or not hrp.Parent then
            stopFlying()
            return
        end
        
        local camera = workspace.CurrentCamera
        local moveDir = Vector3.zero
        
        -- Deteksi Input Pergerakan Standard
        local forward = moveState.forward
        local backward = moveState.backward
        local left = moveState.left
        local right = moveState.right
        local up = moveState.up
        local down = moveState.down

        -- Integrasi Keyboard PC
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then forward = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then backward = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then left = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then right = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) or UserInputService:IsKeyDown(Enum.KeyCode.Space) then up = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then down = 1 end

        -- Hitung arah gerakan sesuai arah Kamera
        local camCF = camera.CFrame
        local flyVector = (camCF.LookVector * (forward - backward)) + 
                          (camCF.RightVector * (right - left)) + 
                          (Vector3.new(0, 1, 0) * (up - down))
        
        if flyVector.Magnitude > 0 then
            bodyVel.Velocity = flyVector.Unit * flySpeed
        else
            bodyVel.Velocity = Vector3.zero
        end

        bodyGyro.CFrame = camCF
    end)
end

-- Toggle On/Off Terbang dari Tombol Flight Toggle
if btnFlyToggle then
    btnFlyToggle.Activated:Connect(function()
        if isFlying then
            stopFlying()
        else
            startFlying()
        end
    end)
end

-- Pengatur Speed (+ / -)
if btnFlyUpSpeed then
    btnFlyUpSpeed.Activated:Connect(function()
        flySpeed = math.min(500, flySpeed + 10)
        updateSpeedDisplay()
    end)
end

if btnFlyDownSpeed then
    btnFlyDownSpeed.Activated:Connect(function()
        flySpeed = math.max(10, flySpeed - 10)
        updateSpeedDisplay()
    end)
end

-- Tombol Naik (Up) & Turun (Down) di Fly Panel (Cocok Buat HP/Mobile)
if btnFlyUp then
    btnFlyUp.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            moveState.up = 1
        end
    end)
    btnFlyUp.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            moveState.up = 0
        end
    end)
end

if btnFlyDown then
    btnFlyDown.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            moveState.down = 1
        end
    end)
    btnFlyDown.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            moveState.down = 0
        end
    end)
end

-- Reset state terbang jika karakter respawn/mati
LocalPlayer.CharacterAdded:Connect(function()
    stopFlying()
end)

updateSpeedDisplay()
-- =========================================================
-- LOGIKA LENGKAP: ESP SYSTEM & COLOR CUSTOMIZER
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Status & Warna Default
local espEnabled = false
local espColor = Color3.fromRGB(255, 50, 50) -- Warna default (Merah Vibrant)
local espObjects = {}

-- Fungsi Membuat ESP untuk 1 Player
local function createESP(player)
    if player == LocalPlayer then return end

    local function applyESP(character)
        if not character then return end
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        local hum = character:WaitForChild("Humanoid", 5)
        if not hrp or not hum then return end

        -- 1. Highlight Effect (Tembus Dinding)
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.Adornee = character
        highlight.FillColor = espColor
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0
        highlight.Enabled = espEnabled
        highlight.Parent = character

        -- 2. BillboardGui (Teks Nama & Health)
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESPInfo"
        billboard.Adornee = hrp
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Enabled = espEnabled

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = espColor
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.Font = Enum.Font.SourceSansBold
        label.TextSize = 14
        label.Parent = billboard

        billboard.Parent = character

        -- Simpan referensi objek
        espObjects[player] = {
            highlight = highlight,
            billboard = billboard,
            label = label,
            character = character,
            humanoid = hum,
            hrp = hrp
        }
    end

    if player.Character then
        applyESP(player.Character)
    end
    player.CharacterAdded:Connect(applyESP)
end

-- Fungsi Hapus ESP Player
local function removeESP(player)
    if espObjects[player] then
        if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
        if espObjects[player].billboard then espObjects[player].billboard:Destroy() end
        espObjects[player] = nil
    end
end

-- Load ESP untuk Semua Player yang Ada & Baru Masuk
for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
end
Players.PlayerAdded:Connect(createESP)
Players.PlayerRemoving:Connect(removeESP)

-- Update Loop (Distance & Health Realtime)
RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

    for player, data in pairs(espObjects) do
        if data.character and data.character.Parent and data.humanoid.Health > 0 and data.hrp then
            local distance = myHrp and math.floor((myHrp.Position - data.hrp.Position).Magnitude) or 0
            local hp = math.floor(data.humanoid.Health)
            
            data.label.Text = string.format("%s\n[%d HP] - %dm", player.DisplayName, hp, distance)
            data.highlight.Enabled = true
            data.billboard.Enabled = true
        else
            if data.highlight then data.highlight.Enabled = false end
            if data.billboard then data.billboard.Enabled = false end
        end
    end
end)

-- Update Warna ESP Secara Global
local function updateESPColor(newColor)
    espColor = newColor
    for _, data in pairs(espObjects) do
        if data.highlight then data.highlight.FillColor = newColor end
        if data.label then data.label.TextColor3 = newColor end
    end
end

-- =========================================================
-- INTEGRASI TOMBOL UI ESP & COLOR
-- =========================================================

-- Toggle Button ESP
if btnESPToggle then
    btnESPToggle.Activated:Connect(function()
        espEnabled = not espEnabled
        btnESPToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
        btnESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(150, 40, 40)
        
        for _, data in pairs(espObjects) do
            if data.highlight then data.highlight.Enabled = espEnabled end
            if data.billboard then data.billboard.Enabled = espEnabled end
        end
    end)
end

-- Pilihan Warna ESP (Preset Color Buttons)
if btnColorRed then
    btnColorRed.Activated:Connect(function() updateESPColor(Color3.fromRGB(255, 50, 50)) end)
end
if btnColorGreen then
    btnColorGreen.Activated:Connect(function() updateESPColor(Color3.fromRGB(50, 255, 50)) end)
end
if btnColorBlue then
    btnColorBlue.Activated:Connect(function() updateESPColor(Color3.fromRGB(50, 150, 255)) end)
end
if btnColorYellow then
    btnColorYellow.Activated:Connect(function() updateESPColor(Color3.fromRGB(255, 255, 50)) end)
end
if btnColorCyan then
    btnColorCyan.Activated:Connect(function() updateESPColor(Color3.fromRGB(50, 255, 255)) end)
end
-- =========================================================
-- LOGIKA LENGKAP: SPEED SYSTEM (WALKSPEED)
-- =========================================================

local currentSpeed = 16 -- Default WalkSpeed Roblox
local minSpeed, maxSpeed, speedStep = 16, 250, 5

-- Fungsi Terapkan & Update Speed ke Karakter
local function applySpeed(speed)
    currentSpeed = math.clamp(speed, minSpeed, maxSpeed)
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = currentSpeed
        end
    end
end

-- Update Teks Display Speed di UI (Menyesuaikan teks tombol di UI kamu)
local function updateSpeedDisplay()
    if btnSpeedDisplay then -- Sesuaikan nama variabel teks/tombol speed di UI-mu jika beda
        btnSpeedDisplay.Text = "⚡ Speed: " .. currentSpeed
    end
end

-- Event saat karakter mati/respawn, pasang ulang WalkSpeed-nya
LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.WalkSpeed = currentSpeed
    end
end)

-- =========================================================
-- INTEGRASI TOMBOL UI SPEED (+ / -)
-- =========================================================

-- Tombol Kurang (-) Speed
if btnSpeedMinus then
    btnSpeedMinus.Activated:Connect(function()
        applySpeed(currentSpeed - speedStep)
        updateSpeedDisplay()
    end)
end

-- Tombol Tambah (+) Speed
if btnSpeedPlus then
    btnSpeedPlus.Activated:Connect(function()
        applySpeed(currentSpeed + speedStep)
        updateSpeedDisplay()
    end)
end
