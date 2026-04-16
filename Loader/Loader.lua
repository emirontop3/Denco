local url = "https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/S-Games"

-- Executor metodu ile içeriği çekiyoruz
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
                if id == currentId then
                    authorized = true
                    -- Oyun ismini global değişkene kaydediyoruz
                    _G.Gname = name 
                    break
                end
            end

            if authorized then
                print("Oyun Dogrulandi: " .. _G.Gname)
                loadstring(game:HttpGet("https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/Games/" .. game.PlaceId))()
            else
                warn("Bu oyun icin yetkiniz yok. ID: " .. currentId)
            end
        else
            warn("SupportedGameId tablosu bulunamadi. GitHub dosyasini kontrol edin!")
        end
    else
        warn("Kod yuklenirken hata (Syntax Hatasi): " .. tostring(err))
    end
else
    warn("GitHub baglantisi kurulamadi!")
end
