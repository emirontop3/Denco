local url = "https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/S-Games"
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI Oluşturma Fonksiyonu
local function createUnsupportedGui(supportedGames)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local SubTitle = Instance.new("TextLabel")
    local DeltaWarning = Instance.new("TextLabel")
    local CloseBtn = Instance.new("TextButton")
    local DropdownFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")

    -- ScreenGui Ayarları
    ScreenGui.Name = "DencoSupportGui"
    ScreenGui.Parent = (game:GetService("CoreGui") or player:WaitForChild("PlayerGui"))
    ScreenGui.ResetOnSpawn = false

    -- Ana Panel
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -190)
    MainFrame.Size = UDim2.new(0, 350, 0, 380)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true -- Paneli sürüklenebilir yapar

    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = MainFrame

    -- Başlık
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 0, 0, 15)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "SORRY!"
    Title.TextColor3 = Color3.fromRGB(255, 60, 60)
    Title.TextSize = 26

    -- Alt Yazı
    SubTitle.Parent = MainFrame
    SubTitle.BackgroundTransparency = 1
    SubTitle.Position = UDim2.new(0, 15, 0, 45)
    SubTitle.Size = UDim2.new(1, -30, 0, 40)
    SubTitle.Font = Enum.Font.GothamMedium
    SubTitle.Text = "This game is not supported YET.\nTry our supported games below:"
    SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    SubTitle.TextSize = 14
    SubTitle.TextWrapped = true

    -- DELTA UYARISI (Ünlem ile)
    DeltaWarning.Parent = MainFrame
    DeltaWarning.BackgroundTransparency = 1
    DeltaWarning.Position = UDim2.new(0, 15, 0, 85)
    DeltaWarning.Size = UDim2.new(1, -30, 0, 20)
    DeltaWarning.Font = Enum.Font.GothamBold
    DeltaWarning.Text = "⚠️ Delta executor does not allow changing games!"
    DeltaWarning.TextColor3 = Color3.fromRGB(255, 180, 50)
    DeltaWarning.TextSize = 12

    -- Kapatma Butonu
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = MainFrame
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseBtn.Position = UDim2.new(1, -35, 0, 12)
    CloseBtn.Size = UDim2.new(0, 24, 0, 24)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.TextSize = 12
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = CloseBtn
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- Dropdown Frame
    DropdownFrame.Name = "DropdownFrame"
    DropdownFrame.Parent = MainFrame
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Position = UDim2.new(0, 15, 0, 115)
    DropdownFrame.Size = UDim2.new(1, -30, 0, 245)
    DropdownFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    DropdownFrame.ScrollBarThickness = 2
    DropdownFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

    UIListLayout.Parent = DropdownFrame
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    UIPadding.Parent = DropdownFrame
    UIPadding.PaddingTop = UDim.new(0, 5)

    -- Oyunları Listele
    for name, id in pairs(supportedGames) do
        local GameBtn = Instance.new("TextButton")
        local GameIcon = Instance.new("ImageLabel")
        local GameName = Instance.new("TextLabel")
        local gCorner = Instance.new("UICorner")

        GameBtn.Name = name
        GameBtn.Parent = DropdownFrame
        GameBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        GameBtn.Size = UDim2.new(0, 300, 0, 55)
        GameBtn.Text = ""
        GameBtn.AutoButtonColor = true

        gCorner.CornerRadius = UDim.new(0, 10)
        gCorner.Parent = GameBtn

        -- İKON (Daha güvenli yükleme methodu)
        GameIcon.Parent = GameBtn
        GameIcon.Position = UDim2.new(0, 8, 0, 7)
        GameIcon.Size = UDim2.new(0, 40, 0, 40)
        GameIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        GameIcon.Image = "rbxassetid://0" -- Başta boş
        
        local iCorner = Instance.new("UICorner")
        iCorner.CornerRadius = UDim.new(0, 8)
        iCorner.Parent = GameIcon

        -- İkonu Arka Planda Çek (Donmayı önler)
        task.spawn(function()
            local s, info = pcall(function()
                return MarketplaceService:GetProductInfo(id)
            end)
            if s and info.IconImageAssetId then
                GameIcon.Image = "rbxassetid://" .. info.IconImageAssetId
            else
                -- Hata olursa yedek method
                GameIcon.Image = "rbxthumb://type=GameIcon&id=" .. id .. "&w=150&h=150"
            end
        end)

        GameName.Parent = GameBtn
        GameName.BackgroundTransparency = 1
        GameName.Position = UDim2.new(0, 60, 0, 0)
        GameName.Size = UDim2.new(1, -65, 1, 0)
        GameName.Font = Enum.Font.GothamSemibold
        GameName.Text = name
        GameName.TextColor3 = Color3.new(1, 1, 1)
        GameName.TextSize = 14
        GameName.TextXAlignment = Enum.TextXAlignment.Left

        -- Işınlanma
        GameBtn.MouseButton1Click:Connect(function()
            GameBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
            GameName.Text = "Teleporting..."
            TeleportService:Teleport(id, player)
        end)

        DropdownFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end
end

-- ANA KONTROL MEKANİZMASI
local success, content = pcall(function()
    return game:HttpGet(url)
end)

if success then
    local func, err = loadstring(content)
    if func then
        func() 
        task.wait(0.1)
        if SupportedGameId then
            local currentId = game.PlaceId
            local authorized = false

            for name, id in pairs(SupportedGameId) do
                if tonumber(id) == currentId then
                    authorized = true
                    _G.Gname = name 
                    break
                end
            end

            if authorized then
                print("Oyun Dogrulandi: " .. _G.Gname)
                loadstring(game:HttpGet("https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/Games/" .. game.PlaceId))()
            else
                createUnsupportedGui(SupportedGameId)
            end
        end
    end
end
