local url = "https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/S-Games"
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- YARDIMCI GÖRSEL ARAÇLAR
local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = parent
end

local function addStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(60, 60, 65)
    stroke.Thickness = thickness or 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
end

-- SÜRÜKLEME ÖZELLİĞİ
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

-- 1. ONAY EKRANI
local function createConfirmGui(gameName, placeId, lastUpdate)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DencoConfirm"
    ScreenGui.Parent = (game:GetService("CoreGui") or player:WaitForChild("PlayerGui"))

    local MainFrame = Instance.new("CanvasGroup")
    MainFrame.Size = UDim2.new(0, 320, 0, 180)
    MainFrame.Position = UDim2.new(0.5, -160, 0.45, -90)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainFrame.Parent = ScreenGui
    addCorner(MainFrame, 12)
    addStroke(MainFrame, Color3.fromRGB(0, 255, 120))
    makeDraggable(MainFrame)

    -- TweenInfo Düzeltildi: (Zaman, Stil, Yön)
    MainFrame.GroupTransparency = 1
    local openTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        GroupTransparency = 0, 
        Position = UDim2.new(0.5, -160, 0.5, -90)
    })
    openTween:Play()

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Text = "DENCO HUB"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(0, 255, 120)
    Title.TextSize = 18
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    local Msg = Instance.new("TextLabel")
    Msg.Size = UDim2.new(1, -30, 0, 60)
    Msg.Position = UDim2.new(0, 15, 0, 50)
    Msg.Text = "Game: " .. gameName .. "\nLast Update: " .. lastUpdate
    Msg.Font = Enum.Font.GothamMedium
    Msg.TextColor3 = Color3.fromRGB(200, 200, 200)
    Msg.TextSize = 14
    Msg.BackgroundTransparency = 1
    Msg.Parent = MainFrame

    local YesBtn = Instance.new("TextButton")
    YesBtn.Size = UDim2.new(0, 130, 0, 38)
    YesBtn.Position = UDim2.new(0, 20, 1, -55)
    YesBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    YesBtn.Text = "EXECUTE"
    YesBtn.TextColor3 = Color3.new(1, 1, 1)
    YesBtn.Font = Enum.Font.GothamBold
    YesBtn.Parent = MainFrame
    addCorner(YesBtn, 8)

    local NoBtn = Instance.new("TextButton")
    NoBtn.Size = UDim2.new(0, 130, 0, 38)
    NoBtn.Position = UDim2.new(1, -150, 1, -55)
    NoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    NoBtn.Text = "CANCEL"
    NoBtn.TextColor3 = Color3.new(1, 1, 1)
    NoBtn.Font = Enum.Font.GothamBold
    NoBtn.Parent = MainFrame
    addCorner(NoBtn, 8)
    addStroke(NoBtn, Color3.fromRGB(80, 80, 85))

    YesBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/Games/" .. placeId))()
    end)

    NoBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
end

-- 2. DESTEKLENMEYEN OYUN LİSTESİ
local function createUnsupportedGui(supportedGames)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DencoSupportGui"
    ScreenGui.Parent = (game:GetService("CoreGui") or player:WaitForChild("PlayerGui"))

    local MainFrame = Instance.new("CanvasGroup")
    MainFrame.Size = UDim2.new(0, 360, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    MainFrame.Parent = ScreenGui
    addCorner(MainFrame, 15)
    addStroke(MainFrame, Color3.fromRGB(40, 40, 45))
    makeDraggable(MainFrame)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "UNSUPPORTED GAME"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 60, 60)
    Title.TextSize = 20
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -38, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.Text = "×"
    CloseBtn.TextSize = 22
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.Parent = MainFrame
    addCorner(CloseBtn, 50)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, -20, 0, 310)
    Scroll.Position = UDim2.new(0, 10, 0, 85)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 2
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 120)
    Scroll.Parent = MainFrame

    local List = Instance.new("UIListLayout")
    List.Parent = Scroll
    List.Padding = UDim.new(0, 8)
    List.HorizontalAlignment = Enum.HorizontalAlignment.Center

    for name, data in pairs(supportedGames) do
        local gameId = type(data) == "table" and data.id or data
        local gameUpdate = type(data) == "table" and data.lastUpdate or "Unknown"

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0, 320, 0, 65)
        Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        Btn.Text = ""
        Btn.Parent = Scroll
        addCorner(Btn, 10)
        addStroke(Btn)

        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 48, 0, 48)
        Icon.Position = UDim2.new(0, 8, 0, 8)
        Icon.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        Icon.Parent = Btn
        addCorner(Icon, 8)

        task.spawn(function()
            local cleanId = string.format("%.0f", tonumber(gameId))
            Icon.Image = "rbxthumb://type=GameIcon&id=" .. cleanId .. "&w=150&h=150"
        end)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -75, 0, 30)
        Label.Position = UDim2.new(0, 65, 0, 10)
        Label.Text = name
        Label.TextColor3 = Color3.new(1, 1, 1)
        Label.Font = Enum.Font.GothamSemibold
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.BackgroundTransparency = 1
        Label.Parent = Btn

        local UpdateLabel = Instance.new("TextLabel")
        UpdateLabel.Size = UDim2.new(1, -75, 0, 20)
        UpdateLabel.Position = UDim2.new(0, 65, 0, 32)
        UpdateLabel.Text = "Updated: " .. gameUpdate
        UpdateLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        UpdateLabel.Font = Enum.Font.Gotham
        UpdateLabel.TextSize = 11
        UpdateLabel.TextXAlignment = Enum.TextXAlignment.Left
        UpdateLabel.BackgroundTransparency = 1
        UpdateLabel.Parent = Btn

        Btn.MouseButton1Click:Connect(function()
            TeleportService:Teleport(tonumber(gameId), player)
        end)
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 10)
    end
end

-- SİSTEMİ BAŞLAT
local success, content = pcall(function()
    return game:HttpGet(url)
end)

if success then
    local func = loadstring(content)
    if func then
        func()
        task.wait(0.3)
        if SupportedGameId then
            local currentId = tostring(game.PlaceId)
            local foundName = nil
            local foundUpdate = "Unknown"

            for name, data in pairs(SupportedGameId) do
                local checkId = (type(data) == "table") and tostring(data.id) or tostring(data)
                if checkId == currentId then
                    foundName = name
                    if type(data) == "table" then
                        foundUpdate = tostring(data.lastUpdate or "Unknown")
                    end
                    _G.Gname = name
                    _G.Lastup = foundUpdate
                    break
                end
            end

            if foundName then
                createConfirmGui(foundName, game.PlaceId, foundUpdate)
            else
                createUnsupportedGui(SupportedGameId)
            end
        end
    end
end
