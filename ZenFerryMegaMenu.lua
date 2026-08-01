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

-- =========================================================
-- ZEN/FERRY V30 - AUTO-FINDER & LOGICAL CORE
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- Global State Variables
local isFlying = false
local isESP = false
local isNoclip = false
local currentSpeed = 16
local espColorIndex = 1

local espColors = {
    Color3.fromRGB(255, 0, 0),    -- Merah
    Color3.fromRGB(0, 255, 0),    -- Hijau
    Color3.fromRGB(0, 0, 255),    -- Biru
    Color3.fromRGB(255, 255, 0),  -- Kuning
    Color3.fromRGB(0, 255, 255)   -- Cyan
}
local espColorNames = {"Merah", "Hijau", "Biru", "Kuning", "Cyan"}

-- =========================================================
-- HELPER: UTILITY UNTUK NGAIL TOMBOL BERDASARKAN TEKS
-- =========================================================
local function findButtonByText(partialText)
    for _, gui in pairs(LocalPlayer:WaitForChild("PlayerGui"):GetDescendants()) do
        if (gui:IsA("TextButton") or gui:IsA("TextLabel")) and string.find(gui.Text:lower(), partialText:lower()) then
            return gui
        end
    end
    return nil
end

-- =========================================================
-- 1. LOGIKA SPEED SYSTEM (WALKSPEED)
-- =========================================================
local function applySpeed(speed)
    currentSpeed = math.clamp(speed, 16, 250)
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = currentSpeed
    end
    
    local btnDisplay = findButtonByText("speed:")
    if btnDisplay then
        btnDisplay.Text = "⚡ Speed: " .. currentSpeed
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then hum.WalkSpeed = currentSpeed end
end)

-- =========================================================
-- 2. LOGIKA ESP & COLOR PICKER
-- =========================================================
local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hl = char:FindFirstChild("ZenESP_Highlight")
            
            if isESP then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "ZenESP_Highlight"
                    hl.Parent = char
                end
                hl.FillColor = espColors[espColorIndex]
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            else
                if hl then hl:Destroy() end
            end
        end
    end
end

-- =========================================================
-- 3. BINDING OTOMATIS KE TOMBOL UI
-- =========================================================
task.spawn(function()
    task.wait(1) -- Tunggu UI ter-load sempurna

    -- [A] FLY TOGGLE
    local btnFly = findButtonByText("fly mode")
    if btnFly then
        btnFly.MouseButton1Click:Connect(function()
            isFlying = not isFlying
            btnFly.Text = "🦅 Fly Mode: " .. (isFlying and "ON" or "OFF")
            -- Panggil fungsi Fly Handler kamu di sini
        end)
    end

    -- [B] ESP TOGGLE
    local btnESP = findButtonByText("esp:")
    if btnESP then
        btnESP.MouseButton1Click:Connect(function()
            isESP = not isESP
            btnESP.Text = "👁️ ESP: " .. (isESP and "ON" or "OFF")
            updateESP()
        end)
    end

    -- [C] COLOR PICKER TOGGLE
    local btnColor = findButtonByText("color:")
    if btnColor then
        btnColor.MouseButton1Click:Connect(function()
            espColorIndex = (espColorIndex % #espColors) + 1
            btnColor.Text = "🎨 Color: " .. espColorNames[espColorIndex]
            if isESP then updateESP() end
        end)
    end

    -- [D] SPEED MINUS (-)
    -- Mencari tombol "-" yang posisinya sebaris/dekat dengan Speed
    for _, btn in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if btn:IsA("TextButton") and btn.Text == "-" then
            btn.MouseButton1Click:Connect(function()
                applySpeed(currentSpeed - 5)
            end)
        elseif btn:IsA("TextButton") and btn.Text == "+" then
            btn.MouseButton1Click:Connect(function()
                applySpeed(currentSpeed + 5)
            end)
        end
    end
end)
