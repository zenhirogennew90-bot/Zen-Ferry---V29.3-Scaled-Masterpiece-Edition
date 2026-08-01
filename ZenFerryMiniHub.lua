-- [ROBLOX LUA SCRIPT: Zen/Ferry - V29.4 Ultimate Scaled]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui")
gui.Name = "ZenFerry_V29_Scaled"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local targetParent
pcall(function() targetParent = gethui and gethui() or CoreGui end)
targetParent = targetParent or player:FindFirstChild("PlayerGui") or player.PlayerGui

for _, v in ipairs(targetParent:GetChildren()) do
    if v.Name == "ZenFerry_V29_Scaled" then v:Destroy() end
end
gui.Parent = targetParent

-- MAIN WINDOW (Ukuran tetap untuk menu utama)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 309, 0, 445)
frame.Position = UDim2.new(0.5, -154, 0.5, -222)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 34)
title.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
title.Text = "🔮 Zen/Ferry - V29.4 (Display Name)"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 15

local btnMin = Instance.new("TextButton", title)
btnMin.Size = UDim2.new(0, 34, 0, 34)
btnMin.Position = UDim2.new(1, -34, 0, 0)
btnMin.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
btnMin.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMin.Text = "-"
btnMin.Font = Enum.Font.SourceSansBold
btnMin.TextSize = 16
btnMin.BorderSizePixel = 0

local allBtns = {}
local function mkBtn(parent, text, pos, size)
    local b = Instance.new("TextButton", parent)
    b.Size, b.Position = size, pos
    b.BackgroundColor3 = Color3.fromRGB(25, 30, 20)
    b.BorderSizePixel = 1
    b.Text, b.Font, b.TextSize = text, Enum.Font.SourceSansBold, 15
    b.AutoButtonColor = true
    table.insert(allBtns, b)
    return b
end

-- MAIN UI ELEMENTS (Tanpa Fly Sens di Menu Utama)
local btnPrev = mkBtn(frame, "<", UDim2.new(0, 15, 0, 42), UDim2.new(0, 35, 0, 34))
local textBox = Instance.new("TextBox", frame)
textBox.Size, textBox.Position = UDim2.new(0, 175, 0, 34), UDim2.new(0, 54, 0, 42)
textBox.BackgroundColor3, textBox.TextColor3 = Color3.fromRGB(25, 20, 35), Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Display Name..."
textBox.Text = ""
textBox.Font, textBox.TextSize = Enum.Font.SourceSans, 15
textBox.Parent = frame
local btnNext = mkBtn(frame, ">", UDim2.new(0, 233, 0, 42), UDim2.new(0, 35, 0, 34))

local btnPantau = mkBtn(frame, "👀 Pantau (Spectate)", UDim2.new(0, 15, 0, 84), UDim2.new(0, 253, 0, 34))
local btnRefresh = mkBtn(frame, "🔄 Refresh (Auto: 7s)", UDim2.new(0, 15, 0, 126), UDim2.new(0, 253, 0, 34))
local btnTP = mkBtn(frame, "🚀 TELEPORT!", UDim2.new(0, 15, 0, 168), UDim2.new(0, 253, 0, 34))
local btnNoClip = mkBtn(frame, "👻 No-Clip: OFF", UDim2.new(0, 15, 0, 210), UDim2.new(0, 253, 0, 34))

local btnSpdM = mkBtn(frame, "-", UDim2.new(0, 15, 0, 252), UDim2.new(0, 35, 0, 34))
local lblSpd = Instance.new("TextLabel", frame)
lblSpd.Size, lblSpd.Position = UDim2.new(0, 175, 0, 34), UDim2.new(0, 54, 0, 252)
lblSpd.BackgroundColor3, lblSpd.TextColor3 = Color3.fromRGB(25, 20, 35), Color3.fromRGB(255, 255, 255)
lblSpd.Text, lblSpd.Font, lblSpd.TextSize = "⚡ Speed: 16", Enum.Font.SourceSansBold, 15
local btnSpdP = mkBtn(frame, "+", UDim2.new(0, 233, 0, 252), UDim2.new(0, 35, 0, 34))

local btnESP = mkBtn(frame, "👁️ Chams ESP: OFF", UDim2.new(0, 15, 0, 294), UDim2.new(0, 253, 0, 34))
local btnESPColor = mkBtn(frame, "🎨 Warna ESP: Merah", UDim2.new(0, 15, 0, 336), UDim2.new(0, 253, 0, 34))
local btnFly = mkBtn(frame, "🕊️ Fly Mode: OFF", UDim2.new(0, 15, 0, 378), UDim2.new(0, 253, 0, 34))

-- FLY CONTROL PANEL (Diperpanjang ke bawah untuk tombol Sensitivitas & Off Fly)
local flyPanel = Instance.new("Frame", gui)
flyPanel.Size, flyPanel.Position = UDim2.new(0, 250, 0, 315), UDim2.new(0.5, 165, 0.5, -157)
flyPanel.BackgroundColor3, flyPanel.BorderSizePixel = Color3.fromRGB(15, 15, 20), 2
flyPanel.Visible, flyPanel.Active, flyPanel.Draggable = false, true, true

local flyTitle = Instance.new("TextLabel", flyPanel)
flyTitle.Size, flyTitle.BackgroundColor3 = UDim2.new(1, 0, 0, 34), Color3.fromRGB(25, 20, 35)
flyTitle.Text, flyTitle.Font, flyTitle.TextSize = "✈️ Menu Terbang", Enum.Font.SourceSansBold, 13

local btnFlyMin = Instance.new("TextButton", flyTitle)
btnFlyMin.Size, btnFlyMin.Position = UDim2.new(0, 34, 0, 34), UDim2.new(1, -34, 0, 0)
btnFlyMin.BackgroundColor3, btnFlyMin.TextColor3 = Color3.fromRGB(40, 30, 60), Color3.fromRGB(255, 255, 255)
btnFlyMin.Text, btnFlyMin.Font, btnFlyMin.TextSize, btnFlyMin.BorderSizePixel = "-", Enum.Font.SourceSansBold, 15, 0

local isFlyMin = false
btnFlyMin.Activated:Connect(function()
    isFlyMin = not isFlyMin
    btnFlyMin.Text = isFlyMin and "+" or "-"
    flyPanel.Size = isFlyMin and UDim2.new(0, 250, 0, 34) or UDim2.new(0, 250, 0, 315)
    for _, c in ipairs(flyPanel:GetChildren()) do
        if c ~= flyTitle then c.Visible = not isFlyMin end
    end
end)

local function mkFlyBtn(text, pos, size)
    local b = Instance.new("TextButton", flyPanel)
    b.Size, b.Position = size, pos
    b.BackgroundColor3, b.BorderSizePixel = Color3.fromRGB(25, 30, 20), 1
    b.Text, b.Font, b.TextSize = text, Enum.Font.SourceSansBold, 14
    b.AutoButtonColor = true
    table.insert(allBtns, b)
    return b
end

local btnFlyM = mkFlyBtn("-", UDim2.new(0, 10, 0, 42), UDim2.new(0, 34, 0, 32))
local lblFlySpd = Instance.new("TextLabel", flyPanel)
lblFlySpd.Size, lblFlySpd.Position = UDim2.new(0, 152, 0, 32), UDim2.new(0, 48, 0, 42)
lblFlySpd.BackgroundColor3, lblFlySpd.TextColor3 = Color3.fromRGB(25, 20, 35), Color3.fromRGB(255, 255, 255)
lblFlySpd.Text, lblFlySpd.Font, lblFlySpd.TextSize = "Spd: 50", Enum.Font.SourceSansBold, 14
local btnFlyP = mkFlyBtn("+", UDim2.new(0, 204, 0, 42), UDim2.new(0, 34, 0, 32))

local btnUp = mkFlyBtn("⬆️ Naik", UDim2.new(0, 10, 0, 84), UDim2.new(0, 65, 0, 38))
local btnFwd = mkFlyBtn("⏫ Maju", UDim2.new(0.5, -37, 0, 84), UDim2.new(0, 75, 0, 38))
local btnDown = mkFlyBtn("⬇️ Turun", UDim2.new(1, -75, 0, 84), UDim2.new(0, 65, 0, 38))

local btnLeft = mkFlyBtn("⬅️ Kiri", UDim2.new(0, 10, 0, 132), UDim2.new(0, 65, 0, 38))
local btnBwd = mkFlyBtn("⏬ Mundur", UDim2.new(0.5, -37, 0, 132), UDim2.new(0, 75, 0, 38))
local btnRight = mkFlyBtn("➡️ Kanan", UDim2.new(1, -75, 0, 132), UDim2.new(0, 65, 0, 38))

-- Tombol Baru di dalam Menu Fly
local btnFlySens = mkFlyBtn("⚙️ Sens: Normal", UDim2.new(0, 10, 0, 180), UDim2.new(0, 230, 0, 38))
local btnFlyOff = mkFlyBtn("❌ Matikan Fly Mode", UDim2.new(0, 10, 0, 224), UDim2.new(0, 230, 0, 38))
btnFlyOff.BackgroundColor3 = Color3.fromRGB(50, 20, 20)

-- RGB ENGINE
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

-- VARIABLES
local isMin, isSpec, isNoClip, isFly, isESP = false, false, false, false, false
local idx, speed, flySpd = 0, 16, 50
local flyConn, noclipConn, specStreamConn = nil, nil, nil
local espHighlights = {}

local flySens = 1
local sensNames = {"Normal", "Slow", "Super Slow"}
local sensMultipliers = {1, 0.4, 0.15}

local espColors = {
    {name = "Merah", color = Color3.fromRGB(255, 0, 0)}, {name = "Hijau", color = Color3.fromRGB(0, 255, 0)},
    {name = "Biru", color = Color3.fromRGB(0, 120, 255)}, {name = "Kuning", color = Color3.fromRGB(255, 255, 0)},
    {name = "Cyan", color = Color3.fromRGB(0, 255, 255)}, {name = "Magenta", color = Color3.fromRGB(255, 0, 255)}
}
local currentESPColorIdx = 1

local successControls, playerModule = false, nil
task.spawn(function()
    while not player:FindFirstChild("PlayerScripts") do task.wait(0.5) end
    local pScripts = player.PlayerScripts
    while not pScripts:FindFirstChild("PlayerModule") do task.wait(0.5) end
    successControls, playerModule = pcall(function() return require(pScripts.PlayerModule):GetControls() end)
end)

-- MULTI-TOUCH ENGINE 
local mUp, mDown, mLeft, mRight, mFwd, mBwd = false, false, false, false, false, false
local function bindH(b, setVar)
    local activeTouches = {} 
    b.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            activeTouches[i] = true; setVar(true)
        end
    end)
    b.InputEnded:Connect(function(i)
        if activeTouches[i] then
            activeTouches[i] = nil
            if next(activeTouches) == nil then setVar(false) end
        end
    end)
end
bindH(btnUp, function(v) mUp = v end); bindH(btnDown, function(v) mDown = v end)
bindH(btnLeft, function(v) mLeft = v end); bindH(btnRight, function(v) mRight = v end)
bindH(btnFwd, function(v) mFwd = v end); bindH(btnBwd, function(v) mBwd = v end)

-- UI Interactions
btnMin.Activated:Connect(function()
    isMin = not isMin
    btnMin.Text = isMin and "+" or "-"
    frame.Size = isMin and UDim2.new(0, 309, 0, 34) or UDim2.new(0, 309, 0, 445)
    for _, c in ipairs(frame:GetChildren()) do
        if c ~= title and c ~= btnMin then c.Visible = not isMin end
    end
end)

-- Fungsi Toggle Fly dipisah agar bisa dipanggil dari tombol OFF di panel
local function toggleFly(state)
    isFly = state
    btnFly.Text = isFly and "🕊️ Fly Mode: ON" or "🕊️ Fly Mode: OFF"
    flyPanel.Visible = isFly
    if isFly then
        if player.Character then startFlyLogic(player.Character) end
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        if player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Anchored = false end
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = false end
        end
    end
end

btnFly.Activated:Connect(function()
    toggleFly(not isFly)
end)

btnFlyOff.Activated:Connect(function()
    toggleFly(false)
end)

btnFlySens.Activated:Connect(function()
    flySens = (flySens % 3) + 1
    btnFlySens.Text = "⚙️ Sens: " .. sensNames[flySens]
end)

btnSpdM.Activated:Connect(function() speed = math.clamp(speed - 5, 16, 250) lblSpd.Text = "⚡ Speed: "..speed if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed end end)
btnSpdP.Activated:Connect(function() speed = math.clamp(speed + 5, 16, 250) lblSpd.Text = "⚡ Speed: "..speed if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed end end)
btnFlyM.Activated:Connect(function() flySpd = math.clamp(flySpd - 10, 10, 300) lblFlySpd.Text = "Spd: "..flySpd end)
btnFlyP.Activated:Connect(function() flySpd = math.clamp(flySpd + 10, 10, 300) lblFlySpd.Text = "Spd: "..flySpd end)

-- CHAMS ESP
btnESP.Activated:Connect(function()
    isESP = not isESP
    btnESP.Text = isESP and "👁️ Chams ESP: ON" or "👁️ Chams ESP: OFF"
    if isESP then
        task.spawn(function()
            while isESP and gui and gui.Parent do
                local col = espColors[currentESPColorIdx].color
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= player and p.Character then
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            if not espHighlights[p] or not espHighlights[p].Parent then
                                local hl = Instance.new("Highlight")
                                hl.Name, hl.FillTransparency, hl.OutlineTransparency = "ZenESP", 0.6, 0.1
                                hl.DepthMode, hl.Parent = Enum.HighlightDepthMode.AlwaysOnTop, p.Character
                                espHighlights[p] = hl
                            end
                            espHighlights[p].FillColor, espHighlights[p].OutlineColor = col, col
                        else
                            if espHighlights[p] then espHighlights[p]:Destroy() espHighlights[p] = nil end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        for _, hl in pairs(espHighlights) do if hl and hl.Parent then hl:Destroy() end end
        espHighlights = {}
    end
end)

btnESPColor.Activated:Connect(function()
    currentESPColorIdx = (currentESPColorIdx % #espColors) + 1
    btnESPColor.Text = "🎨 Warna ESP: " .. espColors[currentESPColorIdx].name
end)

-- LOGIC SEARCH BY DISPLAY NAME
local function getTargets()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do if p ~= player then table.insert(list, p) end end
    return list
end

local function getTarget()
    local s = string.lower(textBox.Text:match("^%s*(.-)%s*$"))
    if s == "" then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and string.sub(string.lower(p.DisplayName), 1, #s) == s then return p end
    end
    return nil
end

local function stopSpectateLoop() if specStreamConn then specStreamConn:Disconnect() specStreamConn = nil end end

local function applySpectate(t)
    if not t or not t.Character then return false end
    local sub = t.Character:FindFirstChildOfClass("Humanoid") or t.Character:FindFirstChild("HumanoidRootPart")
    if sub then
        camera.CameraSubject = sub
        stopSpectateLoop()
        specStreamConn = RunService.Heartbeat:Connect(function()
            if isSpec and t and t.Character then
                local cs = t.Character:FindFirstChildOfClass("Humanoid") or t.Character:FindFirstChild("HumanoidRootPart")
                if cs then camera.CameraSubject = cs end
            else
                stopSpectateLoop()
            end
        end)
        return true
    end
    return false
end

local function cycle(step)
    local list = getTargets()
    if #list == 0 then return end
    idx = ((idx + step - 1) % #list) + 1
    local t = list[idx]
    if t then textBox.Text = t.DisplayName if isSpec then applySpectate(t) end end
end

btnPrev.Activated:Connect(function() cycle(-1) end)
btnNext.Activated:Connect(function() cycle(1) end)
btnRefresh.Activated:Connect(function() idx = 0 cycle(1) end)

task.spawn(function()
    while gui and gui.Parent do
        task.wait(7)
        local current = getTarget()
        if not current and textBox.Text ~= "" then idx = 0 cycle(1) end
    end
end)

btnPantau.Activated:Connect(function()
    isSpec = not isSpec
    stopSpectateLoop()
    if isSpec then
        local t = getTarget()
        if t and applySpectate(t) then btnPantau.Text = "❌ Stop Pantau" else isSpec = false end
    else
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then camera.CameraSubject = hum end
        btnPantau.Text = "👀 Pantau (Spectate)"
    end
end)

btnTP.Activated:Connect(function()
    local t = getTarget()
    if t and t.Character then
        local c = t.Character
        local targetHRP = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("Head") or c.PrimaryPart
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP and hrp then
            local pos = targetHRP.Position
            pcall(function() camera.Focus = CFrame.new(pos) player:RequestStreamAroundAsync(pos, 10) end)
            hrp.CFrame = targetHRP.CFrame * CFrame.new(0, 2, 3)
            hrp.Anchored = true
            task.delay(0.5, function() if hrp and hrp.Parent then hrp.Anchored = false end end)
            if isSpec then
                isSpec = false; stopSpectateLoop()
                local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if hum then camera.CameraSubject = hum end
                btnPantau.Text = "👀 Pantau (Spectate)"
            end
        end
    end
end)

-- FLY & NO-CLIP LOGIC
function startFlyLogic(char)
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local hrp = char:WaitForChild("HumanoidRootPart", 3)
    local hum = char:WaitForChild("Humanoid", 3)
    if not hrp or not hum then return end
    
    hum.PlatformStand = true
    local anchored = false
    flyConn = RunService.RenderStepped:Connect(function()
        if not hrp or not hrp.Parent then return end
        local dir = Vector3.zero
        local camCF = camera.CFrame
        if successControls and playerModule then
            local mv = playerModule:GetMoveVector()
            if mv.Magnitude > 0.15 then dir = dir + (camCF.RightVector * mv.X) + (camCF.LookVector * -mv.Z) end
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) or mFwd then dir = dir + camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) or mBwd then dir = dir - camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) or mLeft then dir = dir - camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) or mRight then dir = dir + camCF.RightVector end
        if mUp or UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
        if mDown or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir + Vector3.new(0, -1, 0) end

        if dir.Magnitude > 0 then
            if anchored then hrp.Anchored = false anchored = false end
            hrp.AssemblyLinearVelocity = dir.Unit * (flySpd * sensMultipliers[flySens])
            hrp.AssemblyAngularVelocity = Vector3.zero
            hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + camCF.LookVector)
        else
            if not anchored then
                hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
                hrp.Anchored, anchored = true, true
            end
            hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + camCF.LookVector)
        end
    end)
end

btnNoClip.Activated:Connect(function()
    isNoClip = not isNoClip
    btnNoClip.Text = isNoClip and "👻 No-Clip: ON" or "👻 No-Clip: OFF"
    if isNoClip then
        noclipConn = RunService.Stepped:Connect(function()
            local c = player.Character
            if c then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    else
        if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    end
end)

-- RESPAWN AUTO-FLY FIX
player.CharacterAdded:Connect(function(newC)
    task.spawn(function()
        task.wait(1)
        local h = newC:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = speed end
        
        if isFly then startFlyLogic(newC) end
    end)
end)
