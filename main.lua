_G.Settings = {
    ["key"] = _G.Key,
    ["site"] = "https://raw.githubusercontent.com/UnstableSolutions/Whitelist-sys/main/Keys.json",
    ["text"] = "You're not whitelisted";
}
local abc = game:HttpGet(_G.Settings.site .. _G.Settings.key)
if abc == "true" then
print("Whitelisted")
elseif abc == "false" then
print(_G.Settings.text)
else
print("Unknown response")
end

--// Script 
local Players = game:GetService("Players")
if game.PlaceId == 1537690962 then
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({Name = "Belgium Hub | Private Build", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
    
    -- Globals
    _G.autoDig = true
    _G.TPHoney = true
    _G.MakeHoney = true
    _G.walkSpeed = true
    
    -- functions 
    function autoDig()
        while _G.autoDig == true do 
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ToolCollect"):FireServer()
               task.wait()
        end
    end
 function TPHoney()
    local Hive = game:GetService("Players").LocalPlayer.SpawnPos.Value.Position
    getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Hive)
 end
 function MakeHoney()    
local args = {
    [1] = "ToggleHoneyMaking"
}

game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer(unpack(args))
end
function walkSpeed()
    while _G.walkSpeed == true do 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
        task.wait()
end
end

      
    -- tabs 
    local FarmTab = Window:MakeTab({
        Name = "Auto Farm",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local MiscTab = Window:MakeTab({
        Name = "Misc",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })


    
   -- Tabs
    FarmTab:AddToggle({
        Name = "Auto Dig",
        Default = false,
        Callback = function(Value)
          _G.autoDig = Value
          autoDig()
        end 
    })

    FarmTab:AddButton({
        Name = "Sell Honey",
        Callback = function()
          TPHoney()
          MakeHoney()
        end    
    })

    MiscTab:AddToggle({
        Name = "Walk Speed",
        Default = false,
        Callback = function(Value)
          _G.walkSpeed = Value
          walkSpeed()
        end    
    })
  
    -- toggles


    -- buttons



    -- dropdowns

end

