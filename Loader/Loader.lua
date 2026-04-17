local url = "https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/S-Games"
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ORTAK STİL FONKSİYONU (Köşeler için)
local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = parent
    return corner
end

-- 1. DESTEKLENEN OYUN İÇİN ONAY GUI
local function createConfirmGui(gameName, placeId)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Msg = Instance.new("TextLabel")
    local YesBtn = Instance.new("TextButton")
    local NoBtn = Instance.new("TextButton")

    ScreenGui.Name = "DencoConfirm"
    ScreenGui.Parent = (game:GetService("CoreGui") or player:WaitForChild("PlayerGui"))

    MainFrame.Size = UDim2.new(0, 300, 0, 180)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    MainFrame.Parent = ScreenGui
    addCorner(MainFrame, 15)

    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "SCRIPT FOUND!"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(0, 255, 150)
    Title.TextSize = 20
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    Msg.Size = UDim2.new(1, -20, 0, 60)
    Msg.Position = UDim2.new(0, 10, 0, 45)
    Msg.Text = "We found a script for " .. gameName .. ".\nDo you want to execute it?"
    Msg.Font = Enum.Font.GothamMedium
    Msg.TextColor3 = Color3.new(1, 1, 1)
    Msg.TextSize = 14
    Msg.TextWrapped = true
    Msg.BackgroundTransparency = 1
    Msg.Parent = MainFrame

    -- EVET BUTONU
    YesBtn.Size = UDim2.new(0, 120, 0, 40)
    YesBtn.Position = UDim2.new(0, 20, 0, 120)
    YesBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
    YesBtn.Text = "Execute"
    YesBtn.Font = Enum.Font.GothamBold
    YesBtn.TextColor3 = Color3.new(1, 1, 1)
    YesBtn.Parent = MainFrame
    addCorner(YesBtn, 8)

    -- HAYIR BUTONU
    NoBtn.Size = UDim2.new(0, 120, 0, 40)
    NoBtn.Position = UDim2.new(1, -140, 0, 120)
    NoBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    NoBtn.Text = "Cancel"
    NoBtn.Font = Enum.Font.GothamBold
    NoBtn.TextColor3 = Color3.new(1, 1, 1)
    NoBtn.Parent = MainFrame
    addCorner(NoBtn, 8)

    YesBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/Games/" .. placeId))()
    end)

    NoBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end

-- 2. DESTEKLENMEYEN OYUN İÇİN LİSTE GUI
local function createUnsupportedGui(supportedGames)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local DeltaWarning = Instance.new("TextLabel")
    local CloseBtn = Instance.new("TextButton")
    local DropdownFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")

    ScreenGui.Name = "DencoSupportGui"
    ScreenGui.Parent = (game:GetService("CoreGui") or player:WaitForChild("PlayerGui"))

    MainFrame.Size = UDim2.new(0, 350, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.Parent = ScreenGui
    addCorner(MainFrame, 15)

    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "SORRY! NOT SUPPORTED"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 60, 60)
    Title.TextSize = 22
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    DeltaWarning.Size = UDim2.new(1, 0, 0, 20)
    DeltaWarning.Position = UDim2.new(0, 0, 0, 50)
    DeltaWarning.Text = "⚠️ Delta executor does not allow changing games!"
    DeltaWarning.TextColor3 = Color3.fromRGB(255, 180, 50)
    DeltaWarning.Font = Enum.Font.GothamBold
    DeltaWarning.TextSize = 12
    DeltaWarning.BackgroundTransparency = 1
    DeltaWarning.Parent = MainFrame

    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -35, 0, 15)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.Parent = MainFrame
    addCorner(CloseBtn, 50)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    DropdownFrame.Size = UDim2.new(1, -30, 0, 270)
    DropdownFrame.Position = UDim2.new(0, 15, 0, 85)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.ScrollBarThickness = 2
    DropdownFrame.Parent = MainFrame

    UIListLayout.Parent = DropdownFrame
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    for name, id in pairs(supportedGames) do
        local GameBtn = Instance.new("TextButton")
        local GameIcon = Instance.new("ImageLabel")
        local GameName = Instance.new("TextLabel")

        GameBtn.Size = UDim2.new(0, 300, 0, 55)
        GameBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        GameBtn.Text = ""
        GameBtn.Parent = DropdownFrame
        addCorner(GameBtn, 10)

        GameIcon.Size = UDim2.new(0, 40, 0, 40)
        GameIcon.Position = UDim2.new(0, 10, 0, 7)
        GameIcon.Parent = GameBtn
        addCorner(GameIcon, 8)

        -- Thumbnail Yükleme
        task.spawn(function()
            local s, info = pcall(function() return MarketplaceService:GetProductInfo(id) end)
            if s and info.IconImageAssetId then
                GameIcon.Image = "rbxassetid://" .. info.IconImageAssetId
            else
                GameIcon.Image = "rbxthumb://type=GameIcon&id=" .. id .. "&w=150&h=150"
            end
        end)

        GameName.Size = UDim2.new(1, -70, 1, 0)
        GameName.Position = UDim2.new(0, 60, 0, 0)
        GameName.Text = name
        GameName.TextColor3 = Color3.new(1, 1, 1)
        GameName.Font = Enum.Font.GothamSemibold
        GameName.TextXAlignment = Enum.TextXAlignment.Left
        GameName.BackgroundTransparency = 1
        GameName.Parent = GameBtn

        GameBtn.MouseButton1Click:Connect(function()
            TeleportService:Teleport(id, player)
        end)
        
        DropdownFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end
end

-- ANA SİSTEM
local success, content = pcall(function()
    return game:HttpGet(url)
end)

if success then
    local func = loadstring(content)
    if func then
        func()
        task.wait(0.1)
        if SupportedGameId then
            local currentId = game.PlaceId
            local foundGameName = nil

            for name, id in pairs(SupportedGameId) do
                if tonumber(id) == currentId then
                    foundGameName = name
                    _G.Gname = name
                    break
                end
            end

            if foundGameName then
                -- OYUN DESTEKLENİYORSA ONAY PENCERESİ AÇ
                createConfirmGui(foundGameName, currentId)
            else
                -- OYUN DESTEKLENMİYORSA LİSTE AÇ
                createUnsupportedGui(SupportedGameId)
            end
        end
    end
end
