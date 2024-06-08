local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LuaName = "KeyAuth Lua Example"

StarterGui:SetCore("SendNotification", {
    Title = LuaName,
    Text = "Initializing Authentication...",
    Duration = 5
})

--* Configuration *--
local initialized = false
local sessionid = ""

local name = "yoo"; -- Application Name
local ownerid = "vNMOjAKUC3"; -- Owner ID
local version = "1.0"; -- Application Version

local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. name .. '&ownerid=' .. ownerid .. '&type=init&ver=' .. version)

if req == "KeyAuth_Invalid" then 
   print("Error: Application not found.")

   StarterGui:SetCore("SendNotification", {
       Title = LuaName,
       Text = "Error: Application not found.",
       Duration = 3
   })

   return false
end

local data = HttpService:JSONDecode(req)

if data.success == true then
   initialized = true
   sessionid = data.sessionid
elseif data.message == "invalidver" then
   print("Error: Wrong application version..")

   StarterGui:SetCore("SendNotification", {
       Title = LuaName,
       Text = "Error: Wrong application version..",
       Duration = 3
   })

   return false
else
   print("Error: " .. data.message)
   return false
end

print("\n\nLicensing...\n")
local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. name .. '&ownerid=' .. ownerid .. '&type=license&key=' .. License .. '&ver=' .. version .. '&sessionid=' .. sessionid)
local data = HttpService:JSONDecode(req)

if data.success == false then 
   if data.message == "Invalid HWID" then
       StarterGui:SetCore("SendNotification", {
           Title = LuaName,
           Text = "Invalid HWID. Please make a ticket for an HWID reset",
           Duration = 5
       })
   else
       StarterGui:SetCore("SendNotification", {
           Title = LuaName,
           Text = "Error: " .. data.message,
           Duration = 5
       })
   end

   -- Kick the player
   local player = Players.LocalPlayer
   if player then
       player:Kick("Error: " .. data.message)
   end

   return false
end
if data.success == false then 
    StarterGui:SetCore("SendNotification", {
        Title = LuaName,
        Text = "Error: " .. data.message,
        Duration = 5
    })

    -- Kick the player if the license is not registered
    local player = Players.LocalPlayer
    if player then
        player:Kick("Error: " .. data.message)
    end

    return false
end

StarterGui:SetCore("SendNotification", {
    Title = LuaName,
    Text = "Successfully Authorized :)",
    Duration = 5
})

local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

local window1 = engine.new({
    text = "Receiving.lol | Tha Bronx Dupe",
    size = UDim2.new(300, 200),
})

window1.open()

_G.Dupe = true 
_G.with = true
_G.Drop = true

function Dupe()
    while _G.Dupe do
    local args = {
        [1] = "Drop",
        [2] = 0/0
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("BankProcessRemote"):InvokeServer(unpack(args))

        local args = {
            [1] = "depo",
            [2] = "30000"
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("BankAction"):FireServer(unpack(args))
         task.wait(5)
    end
end
function with()
    local args = {
        [1] = "with",
        [2] = "30000"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("BankAction"):FireServer(unpack(args))
end
function Drop()
    while _G.Drop do 
    local args = {
        [1] = "Drop",
        [2] = "9999"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("BankProcessRemote"):InvokeServer(unpack(args))
    task.wait(3)
end
end

--// hitboxes
local player = game.Players.LocalPlayer
    local HitboxEnabled4 = false

    local function adjustHitbox(player)
        print("Adjusting hitbox for player:", player.Name)
        if player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if HitboxEnabled3 then
                    pcall(function()
                        head.Size = Vector3.new(1, 1, 1)
                        head.Transparency = 0.9
                        head.BrickColor = BrickColor.new("Dark nougat")
                        head.Material = "Glass"
                        head.CanCollide = false
                    end)
                else
                    pcall(function()
                        head.Size = Vector3.new(0, 0, 0)
                        head.Transparency = 0
                        head.BrickColor = BrickColor.new("Dark nougat")
                        head.Material = "Glass"
                        head.CanCollide = true
                    end)
                end
            end
        end
    end

    local function applyHitboxStateToAllPlayers4()
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player then
                adjustHitbox(otherPlayer)
            end
        end
    end

    local function onPlayerAdded(player)
        print("Player added:", player.Name)
        player.CharacterAdded:Connect(function(character)
            wait(1) 
            adjustHitbox(player)
        end)
    end

    local function onPlayerRespawn(player)
        print("Player respawned:", player.Name)
        player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").Died:Connect(function()
                wait(35) 
                adjustHitbox(player)
            end)
        end)
    end


    applyHitboxStateToAllPlayers4()

    game.Players.PlayerAdded:Connect(onPlayerAdded)
    print("Player added event connected")

    game.Players.PlayerAdded:Connect(function(player)
        onPlayerAdded(player)
        player.CharacterAdded:Connect(function(character)
            wait(1) 
            adjustHitbox(player)
        end)
    end)
    print("Player added and respawn events connected")

    
    local player = game.Players.LocalPlayer
    local HitboxEnabled3 = false

    local function adjustHitbox(player)
        print("Adjusting hitbox for player:", player.Name)
        if player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if HitboxEnabled3 then
                    pcall(function()
                        head.Size = Vector3.new(3, 3, 3)
                        head.Transparency = 0.9
                        head.BrickColor = BrickColor.new("Dark nougat")
                        head.Material = "Glass"
                        head.CanCollide = false
                    end)
                else
                    pcall(function()
                        head.Size = Vector3.new(0, 0, 0)
                        head.Transparency = 0
                        head.BrickColor = BrickColor.new("Dark nougat")
                        head.Material = "Glass"
                        head.CanCollide = true
                    end)
                end
            end
        end
    end

    local function applyHitboxStateToAllPlayers3()
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player then
                adjustHitbox(otherPlayer)
            end
        end
    end

   
    local function onPlayerAdded(player)
        print("Player added:", player.Name)
        player.CharacterAdded:Connect(function(character)
            wait(1) 
            adjustHitbox(player)
        end)
    end

    local function onPlayerRespawn(player)
        print("Player respawned:", player.Name)
        player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").Died:Connect(function()
                wait(35)
                adjustHitbox(player)
            end)
        end)
    end

    
    applyHitboxStateToAllPlayers3()

    
    game.Players.PlayerAdded:Connect(onPlayerAdded)
    print("Player added event connected")

    game.Players.PlayerAdded:Connect(function(player)
        onPlayerAdded(player)
        player.CharacterAdded:Connect(function(character)
            wait(1) 
            adjustHitbox(player)
        end)
    end)
    print("Player added and respawn events connected")

   
    local player = game.Players.LocalPlayer
    local HitboxEnabled = false

    local function adjustHitbox(player)
        print("Adjusting hitbox for player:", player.Name)
        if player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if HitboxEnabled then
                    pcall(function()
                        head.Size = Vector3.new(5, 5, 5)
                        head.Transparency = 0.9
                        head.BrickColor = BrickColor.new("Dark nougat")
                        head.Material = "Glass"
                        head.CanCollide = false
                    end)
                else
                    pcall(function()

                        head.Size = Vector3.new(1, 1, 1)
                        head.Transparency = 0.9
                        head.BrickColor = BrickColor.new("Dark nougat")
                        head.Material = "Glass"
                        head.CanCollide = true
                    end)
                end
            end
        end
    end


    local function applyHitboxStateToAllPlayers()
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player then
                adjustHitbox(otherPlayer)
            end
        end
    end

    local function onPlayerAdded(player)
        print("Player added:", player.Name)
        player.CharacterAdded:Connect(function(character)
            wait(0) 
            adjustHitbox(player)
        end)
    end

    local function onPlayerRespawn(player)
        print("Player respawned:", player.Name)
        player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").Died:Connect(function()
                wait(0) 
                adjustHitbox(player)
            end)
        end)
    end

    
    applyHitboxStateToAllPlayers()

   
    game.Players.PlayerAdded:Connect(onPlayerAdded)
    print("Player added event connected")

    game.Players.PlayerAdded:Connect(function(player)
        onPlayerAdded(player)
        player.CharacterAdded:Connect(function(character)
            wait(0) 
            adjustHitbox(player)
        end)
    end)
    print("Player added and respawn events connected")


    
    local player = game.Players.LocalPlayer
    local HitboxEnabled5 = false

    local function adjustHitbox(targetPlayer)
        print("Adjusting hitbox for player:", targetPlayer.Name)
        if targetPlayer.Character then
            local head = targetPlayer.Character:FindFirstChild("Dark nougat")
            if head then
                if HitboxEnabled5 then
                    pcall(function()
                        head.Size = Vector3.new(5, 5, 5)
                        head.Transparency = 0.9
                        head.BrickColor = BrickColor.new("Dark nougat")
                        head.Material = "Glass"
                        head.CanCollide = false
                    end)
                else
                    pcall(function()
                        head.Size = Vector3.new(1, 1, 1)
                        head.Transparency = 0.9
                        head.BrickColor = BrickColor.new("Dark nougat")
                        head.Material = "Glass"
                        head.CanCollide = true
                    end)
                end
            end
        end
    end


    local function applyHitboxStateToAllPlayers5()
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player then
                adjustHitbox(otherPlayer)
            end
        end
    end


    local function toggleHitbox()
        HitboxEnabled5 = not HitboxEnabled5
        applyHitboxStateToAllPlayers5() 
    end
--// hitboxes

local tab1 = window1.new({
    text = "Cash Dupe",
})
local tab2 = window1.new({
    text = "Hitbox",
})
local tab3 = window1.new({
    text = "Esp",
})

local label1 = tab1.new("label", {
    text = nil,
    color = Color3.new(1, 0, 0),
})

local switch1 = tab1.new("switch", {
    text = "Dupe Cash";
})
switch1.set(false)
switch1.event:Connect(function(bool)
    _G.Dupe = bool
    Dupe()  
end)

local button1 = tab1.new("button", {
    text = "Withdrawl 30k",
})
button1.event:Connect(function(Value)
    _G.with = Value
    with()
    do
        Notification:Notify(
    {Title = "Receiving.lol", Description = "30k has been put in your wallet"},
    {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 3, Type = "default"})
    end
end)

local switch2 = tab1.new("switch", {
    text = "Drop Cash";
})
switch2.set(false)
switch2.event:Connect(function(bool)
    _G.Drop = bool
    Drop()  
end)



local switch1 = tab2.new("switch", {
    text = "Legit Hitbox";
})
switch1.set(false)
switch1.event:Connect(function(Value)
    HitboxEnabled4 = Value 
    applyHitboxStateToAllPlayers4()
end)

local switch2 = tab2.new("switch", {
    text = "Legit Hitbox";
})
switch2.set(false)
switch2.event:Connect(function(Value)
    HitboxEnabled = Value
    applyHitboxStateToAllPlayers()
end)

print("Logged In!" .. Players.LocalPlayer.Name)
