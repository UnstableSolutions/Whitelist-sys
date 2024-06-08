local function isValidKey(key)
    
    local whitelist = {
        
        "jk21p9vUObsn",
        "valid_key_2",
        
    }
    
    
    for _, whitelistKey in ipairs(whitelist) do
        if whitelistKey == key then
            return true 
        end
    end
    
    return false 
end


if _G.Key and isValidKey(_G.Key) then
    print("Key is valid. Access granted.")
else
    print("Invalid key. Access denied.")
end
