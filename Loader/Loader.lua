local url = "https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/S-Games"
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- KÖŞE YUVARLAMA ARACI
local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = parent
    return corner
end

-- 1. ONAY EKRANI (DESTEKLENEN OYUN)
local function createConfirmGui(gameName, placeId, lastUpdate)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DencoConfirm"
    ScreenGui.Parent = (game:GetService("CoreGui") or player:WaitForChild("PlayerGui"))

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 320, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.Parent = ScreenGui
    addCorner(MainFrame, 12)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Text = "✅ SCRIPT FOUND"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(0, 255, 120)
    Title.TextSize = 20
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    local Msg = Instance.new("TextLabel")
    Msg.Size = UDim2.new(1, -30, 0, 60)
    Msg.Position = UDim2.new(0, 15, 0, 50)
    Msg.Text = "Game: " .. gameName .. "\nLast Update: " .. lastUpdate
    Msg.Font = Enum.Font.GothamMedium
    Msg.TextColor3 = Color3.fromRGB(220, 220, 220)
    Msg.TextSize = 14
    Msg.BackgroundTransparency = 1
    Msg.Parent = MainFrame

    local YesBtn = Instance.new("TextButton")
    YesBtn.Size = UDim2.new(0, 130, 0, 40)
    YesBtn.Position = UDim2.new(0, 20, 1, -60)
    YesBtn.BackgroundColor3 = Color3.fromRGB(45, 150, 80)
    YesBtn.Text = "Execute"
    YesBtn.TextColor3 = Color3.new(1, 1, 1)
    YesBtn.Font = Enum.Font.GothamBold
    YesBtn.Parent = MainFrame
    addCorner(YesBtn, 8)

    local NoBtn = Instance.new("TextButton")
    NoBtn.Size = UDim2.new(0, 130, 0, 40)
    NoBtn.Position = UDim2.new(1, -150, 1, -60)
    NoBtn.BackgroundColor3 = Color3.fromRGB(150, 45, 45)
    NoBtn.Text = "Cancel"
    NoBtn.TextColor3 = Color3.new(1, 1, 1)
    NoBtn.Font = Enum.Font.GothamBold
    NoBtn.Parent = MainFrame
    addCorner(NoBtn, 8)

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

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 360, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -180, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainFrame.Parent = ScreenGui
    addCorner(MainFrame, 15)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "NOT SUPPORTED"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 60, 60)
    Title.TextSize = 22
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    local Warning = Instance.new("TextLabel")
    Warning.Size = UDim2.new(1, 0, 0, 25)
    Warning.Position = UDim2.new(0, 0, 0, 45)
    Warning.Text = "⚠️ Delta executor does not allow changing games!"
    Warning.TextColor3 = Color3.fromRGB(255, 180, 50)
    Warning.Font = Enum.Font.GothamBold
    Warning.TextSize = 12
    Warning.BackgroundTransparency = 1
    Warning.Parent = MainFrame

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -35, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.Parent = MainFrame
    addCorner(CloseBtn, 50)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, -30, 0, 290)
    Scroll.Position = UDim2.new(0, 15, 0, 85)
    Scroll.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 2
    Scroll.Parent = MainFrame

    local List = Instance.new("UIListLayout")
    List.Parent = Scroll
    List.Padding = UDim.new(0, 8)
    List.HorizontalAlignment = Enum.HorizontalAlignment.Center

    for name, data in pairs(supportedGames) do
        local gameId = data.id or data
        local gameUpdate = data.lastUpdate or "Unknown"

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0, 310, 0, 65)
        Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Btn.Text = ""
        Btn.Parent = Scroll
        addCorner(Btn, 10)

        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 48, 0, 48)
        Icon.Position = UDim2.new(0, 8, 0, 8)
        Icon.Parent = Btn
        addCorner(Icon, 8)

        task.spawn(function()
            local cleanId = string.format("%.0f", tonumber(gameId))
            Icon.Image = "rbxthumb://type=GameIcon&id=" .. cleanId .. "&w=150&h=150"
        end)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -70, 0, 30)
        Label.Position = UDim2.new(0, 65, 0, 8)
        Label.Text = name
        Label.TextColor3 = Color3.new(1, 1, 1)
        Label.Font = Enum.Font.GothamSemibold
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.BackgroundTransparency = 1
        Label.Parent = Btn

        local UpdateLabel = Instance.new("TextLabel")
        UpdateLabel.Size = UDim2.new(1, -70, 0, 20)
        UpdateLabel.Position = UDim2.new(0, 65, 0, 32)
        UpdateLabel.Text = "Updated: " .. gameUpdate
        UpdateLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
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
        task.wait(0.3) -- Verilerin tam işlenmesi için süre
        if SupportedGameId then
            local currentId = tostring(game.PlaceId)
            local foundName = nil
            local foundUpdate = "Unknown"

            for name, data in pairs(SupportedGameId) do
                local checkId = ""
                if type(data) == "table" then
                    checkId = tostring(data.id)
                else
                    checkId = tostring(data)
                end

                if checkId == currentId then
                    foundName = name
                    if type(data) == "table" then
                        foundUpdate = tostring(data.lastUpdate or "Unknown")
                    end
                    
                    -- GLOBAL DEĞİŞKENLER
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
