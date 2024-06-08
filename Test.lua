local function isValidKey(key)
   
    local whitelistURL = "https://raw.githubusercontent.com/UnstableSolutions/Whitelist-sys/main/Keys.lua"
    local success, whitelist = pcall(game:GetService("HttpService").GetAsync, game:GetService("HttpService"), whitelistURL)
    

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

-- Check if the provided key is valid
if _G.Key and isValidKey(_G.Key) then
    print("Key is valid.")
else
    print("Invalid key. Access denied.")
end
