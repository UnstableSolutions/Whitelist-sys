local function isValidKey(key)
    
    local whitelistURL = "https://raw.githubusercontent.com/UnstableSolutions/Whitelist-sys/main/Keys.lua"
    
    
    local success, whitelist = pcall(game.HttpService.GetAsync, game.HttpService, whitelistURL)
    
    
    if success then
        
        whitelist = loadstring(whitelist)()
        
        
        for _, whitelistKey in ipairs(whitelist) do
            if whitelistKey == key then
                return true 
            end
        end
    else
        
        print("Error fetching whitelist:", whitelist)
    end
    
    return false 
end


if _G.Key and isValidKey(_G.Key) then
    print("Key is valid. Access granted.")
else
    print("Invalid key. Access denied.")
end



