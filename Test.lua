
local function isValidKey(key)
    
    local codeURL = "https://raw.githubusercontent.com/UnstableSolutions/Whitelist-sys/main/Test.lua"
    
    
    local success, code = pcall(game.HttpService.GetAsync, game.HttpService, codeURL)
    
   
    if success then
       
        local whitelist = loadstring(code)()
        
        
        for _, whitelistKey in ipairs(whitelist) do
            if whitelistKey == key then
                return true 
            end
        end
    else
     
        print("Error fetching whitelist Lua code:", code)
    end
    
    return false 
end

if _G.Key and isValidKey(_G.Key) then
    print("Key is valid. Access granted.")
else
    print("Invalid key. Access denied.")
end
