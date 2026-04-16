local url = "https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/S-Games"

-- Executor metodu ile içeriği çekiyoruz
local success, content = pcall(function()
    return game:HttpGet(url)
end)

if success then
    -- 'attempt to call a nil value' hatasını önlemek için loadstring'i güvenli çalıştıralım
    local func, err = loadstring(content)
    
    if func then
        func() -- İçeriği çalıştırır ve _G.Sg tablosunu oluşturur
        
        -- Veri geldikten sonra kısa bir bekleme (opsiyonel)
        task.wait(0.1)

        -- Kontrol kısmı
        if SupportedGameId then
            local currentId = game.PlaceId
            local authorized = false

            for name, id in pairs(SupportedGameId) do
                if id == currentId then
                    authorized = true
                    
                    break
                end
            end

            if authorized then
              loadstring(game:HttpGet("https://raw.githubusercontent.com/emirontop3/Denco/refs/heads/main/Games/" .. game.PlaceId))()
            else
                warn("Bu oyun icin yetkiniz yok. ID: " .. currentId)
            end
        else
            warn("_G.Sg tablosu bulunamadi. GitHub dosyasini kontrol edin!")
        end
    else
        warn("Kod yuklenirken hata (Syntax Hatasi): " .. tostring(err))
    end
else
    warn("GitHub baglantisi kurulamadi!")
end
