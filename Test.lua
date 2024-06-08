if game.PlaceId == 13643807539 then --13643807539
    local notif = loadstring(game:HttpGet('https://raw.githubusercontent.com/Iratethisname10/Code/main/aztup-ui/notifs.lua'))()
    local ArrayField = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = ArrayField:CreateWindow({
            Name = "Requisition | South Bronx",
            LoadingTitle = "Requisition Script Hub",
            LoadingSubtitle = "discord.gg/8yDaDVQWNC",
            ConfigurationSaving = {
                Enabled = true,
                FolderName = nil, -- Create a custom folder for your hub/game
                FileName = "Requisition"
            },
        })
        
    local c = workspace.CurrentCamera
    local ps = game:GetService("Players")
    local lp = ps.LocalPlayer
    local rs = game:GetService("RunService")

    _G.ESP_ENABLED = false 

    local function ftool(cr)
        for _, b in ipairs(cr:GetChildren()) do 
            if b:IsA("Tool") then
                return tostring(b.Name)
            end
        end
        return 'empty'
    end

    local function esp(p, cr)
        local h = cr:WaitForChild("Humanoid")
        local hrp = cr:WaitForChild("HumanoidRootPart")

        local text = Drawing.new('Text')
        text.Visible = false
        text.Center = true
        text.Outline = true
        text.Color = Color3.new(1, 1, 1)
        text.Font = 2
        text.Size = 13

        local c1 
        local c2
        local c3 

        local function dc()
            text.Visible = false
            text:Remove()
            if c3 then
                c1:Disconnect()
                c2:Disconnect()
                c3:Disconnect()
                c1 = nil 
                c2 = nil
                c3 = nil
            end
        end

        c2 = cr.AncestryChanged:Connect(function(_, parent)
            if not parent then
                dc()
            end
        end)

        c3 = h.HealthChanged:Connect(function(v)
            if (v <= 0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                dc()
            end
        end)

        c1 = rs.Heartbeat:Connect(function()
            local hrp_pos, hrp_os = c:WorldToViewportPoint(hrp.Position)
            if hrp_os and _G.ESP_ENABLED then
                text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y)
                text.Text = '[ '..tostring(ftool(cr))..' ]'
                text.Visible = true
            else
                text.Visible = false
            end
        end)
    end

    local function p_added(p)
        if p.Character then
            esp(p, p.Character)
        end
        p.CharacterAdded:Connect(function(cr)
            esp(p, cr)
        end)
    end


    local function toggleESP()
        _G.ESP_ENABLED = not _G.ESP_ENABLED
    end


    ps.PlayerAdded:Connect(p_added)


    for _, b in ipairs(ps:GetPlayers()) do 
        if b ~= lp then
            p_added(b)
        end
    end



        local MainTab = Window:CreateTab("Combat Tab", nil)
        local FarmTab = Window:CreateTab("Autofarm Tab", nil)
        local VisTab = Window:CreateTab("Visuals Tab", nil)
        local MiscTab = Window:CreateTab("Misc Tab", nil)
        local CreditTab = Window:CreateTab("Credit Tab", nil)

        -- [Main Tab] --
        local AimbotToggle = MainTab:CreateToggle({
            Name = "Toggle Aimbot",
            CurrentValue = false,
            Flag = "AimbotToggle", 
            Callback = function(Value)
                local Camera = workspace.CurrentCamera
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local UserInputService = game:GetService("UserInputService")
                local TweenService = game:GetService("TweenService")
                local LocalPlayer = Players.LocalPlayer
                local Holding = false

                _G.AimbotEnabled = Value
                _G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
                _G.AimPart = "Head" -- Where the aimbot script would lock at.
                _G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

                _G.CircleSides = 64 -- How many sides the FOV circle would have.
                _G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
                _G.CircleTransparency = 0.7 -- Transparency of the circle.
                _G.CircleRadius = 80 -- The radius of the circle / FOV.
                _G.CircleFilled = false -- Determines whether or not the circle is filled.
                _G.CircleVisible = true -- Determines whether or not the circle is visible.
                _G.CircleThickness = 0 -- The thickness of the circle.

                if Value == false then
                    _G.CircleVisible = false
                end

                local FOVCircle = Drawing.new("Circle")
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Filled = _G.CircleFilled
                FOVCircle.Color = _G.CircleColor
                FOVCircle.Visible = _G.CircleVisible
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Transparency = _G.CircleTransparency
                FOVCircle.NumSides = _G.CircleSides
                FOVCircle.Thickness = _G.CircleThickness

                local function GetClosestPlayer()
                    local MaximumDistance = _G.CircleRadius
                    local Target = nil

                    for _, v in next, Players:GetPlayers() do
                        if v.Name ~= LocalPlayer.Name then
                            if _G.TeamCheck == true then
                                if v.Team ~= LocalPlayer.Team then
                                    if v.Character ~= nil then
                                        if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                            if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                                
                                                if VectorDistance < MaximumDistance then
                                                    Target = v
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if v.Character ~= nil then
                                    if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                        if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                            
                                            if VectorDistance < MaximumDistance then
                                                Target = v
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    return Target
                end

                UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Holding = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Holding = false
                    end
                end)

                RunService.RenderStepped:Connect(function()
                    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    FOVCircle.Radius = _G.CircleRadius
                    FOVCircle.Filled = _G.CircleFilled
                    FOVCircle.Color = _G.CircleColor
                    FOVCircle.Visible = _G.CircleVisible
                    FOVCircle.Radius = _G.CircleRadius
                    FOVCircle.Transparency = _G.CircleTransparency
                    FOVCircle.NumSides = _G.CircleSides
                    FOVCircle.Thickness = _G.CircleThickness

                    if Holding == true and _G.AimbotEnabled == true then
                        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
                    end
                end)
            end,
         })

         local AimPart = MainTab:CreateDropdown({
            Name = "Aim Part",
            Options = {"Head","HumanoidRootPart"},
            CurrentOption = {"Head"},
            MultipleOptions = false,
            Flag = "AimPart", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Option)
                local selectedOption
                if type(Option) == "table" then
                    selectedOption = Option[1] -- Extract the first element if it's a table
                else
                    selectedOption = Option -- Use directly if it's already a string
                end
                
                _G.AimPart = selectedOption
            end,
         })

         local FOVSlider = MainTab:CreateSlider({
            Name = "Fov Size",
            Range = {0, 150},
            Increment = 5,
            Suffix = "",
            CurrentValue = 80,
            Flag = "FOVSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleRadius = Value
            end,
         })

         local CircleVisible = MainTab:CreateToggle({
            Name = "Visible FOV",
            CurrentValue = true,
            Flag = "CircleVisible", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleVisible = Value
            end,
         })

         local FilledFOV = MainTab:CreateToggle({
            Name = "Filled FOV",
            CurrentValue = false,
            Flag = "FilledFOV", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleFilled = Value
            end,
         })

         local CircleColor = MainTab:CreateColorPicker({
            Name = "Circle Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "CircleColor", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                print(Value)
                _G.CircleColor = Value
                -- The function that takes place every time the color picker is moved/changed
                -- The variable (Value) is a Color3fromRGB value based on which color is selected
            end
        })

        -- [Farm Tab] --
        local BoxToggle = FarmTab:CreateToggle({
            Name = "Box Job Autofarm",
            CurrentValue = false,
            Flag = "BoxFarm",
            Callback = function(Value)
                local teleport_table = {
                    location1 = Vector3.new(-551.0175170898438, 3.537144184112549, -85.6669692993164), -- start
                    location2 = Vector3.new(-400.960754, 3.41219378, -72.2366257, -0.999820769, -2.88791675e-08, -0.0189329591, -2.808512e-08, 1, -4.22059294e-08, 0.0189329591, -4.1666631e-08, -0.999820769) -- end
                }
                
                local tween_s = game:GetService('TweenService')
                
                local lp = game.Players.LocalPlayer
                
                _G.TELEPORT_ENABLED = Value
                
                function bypass_teleport(v, speed)
                    if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                        local cf = CFrame.new(v)
                        local distance = (lp.Character.HumanoidRootPart.Position - cf.p).magnitude
                        local baseDuration = 1
                        local duration = baseDuration + (distance / speed)
                        
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local tween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                        tween:Play()
                        tween.Completed:Wait() -- Wait for the tween to complete before proceeding
                    end
                end
                
                while _G.TELEPORT_ENABLED do
                    bypass_teleport(teleport_table.location1, 19)
                    wait(1)
                    fireproximityprompt(game:GetService("Workspace").PlaceHere.Attachment.ProximityPrompt)
                    wait(0.5)
                    local crateTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Crate")
                    if crateTool then
                        game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(crateTool)
                    end
                    bypass_teleport(teleport_table.location2, 19)
                    local character = game.Players.LocalPlayer.Character
                    local humanoid = character:WaitForChild("Humanoid")
                    humanoid:Move(Vector3.new(0, 0, -5))
                    wait(1)
                    while game.Players.LocalPlayer.Backpack:FindFirstChild("Crate") or game.Players.LocalPlayer.Character:FindFirstChild("Crate") do
                        fireproximityprompt(game:GetService("Workspace").cratetruck2.Model.ClickBox.ProximityPrompt)
                        wait(1)
                    end
                    wait(1) 
                end                              
            end,
        })
        
        local ATMToggle = FarmTab:CreateToggle({
            Name = "ATM Farm",
            CurrentValue = false,
            Flag = "ATMToggle",
            Callback = function(Value)
                local playerName = game.Players.LocalPlayer.Name
                local lp = game.Players.LocalPlayer
                
                local moneyAmount = game:GetService("Players")[playerName].PlayerGui.Main.Money.Amount
                
                print(moneyAmount.Text)
                
                local moneyValueText = moneyAmount.Text:gsub("%$", "")
                local moneyValue = tonumber(moneyValueText)
                
                local teleport_table = {
                    location1 = Vector3.new(214.934265, 3.73713231, -335.223938),
                    location2 = Vector3.new(-48.807437896728516, 3.735410213470459, -320.9378356933594) 
                }
                
                local hasTeleportedToLocation2 = false
                
                local tween_s = game:GetService('TweenService')
                
                _G.shouldRun = Value -- Toggleable variable
                
                function bypass_teleport(v, speed)
                    if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                        local cf = CFrame.new(v)
                        local distance = (lp.Character.HumanoidRootPart.Position - cf.p).magnitude
                        local baseDuration = 1
                        local duration = baseDuration + (distance / speed)
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local teleportTween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                        teleportTween:Play()
                        teleportTween.Completed:Wait()
                    end
                end
                
                -- Main loop
                while _G.shouldRun do
                    if moneyValue and moneyValue >= 850 then
                        print("Player has more/equal to 850 money")
                        
                        -- Perform teleportation actions
                        bypass_teleport(teleport_table.location1, 19) -- Teleport to location1 with speed 25 studs per second
                        wait(1)  -- Adjust if additional delay is needed after teleporting
                        fireproximityprompt(game:GetService("Workspace").NPCs.FakeIDSeller.UpperTorso.Attachment.ProximityPrompt)
                        wait(1)
                        local fakeID = game.Players.LocalPlayer.Backpack:FindFirstChild("Fake ID")
                        if fakeID then
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(fakeID)
                        end
                        
                        local bankTeller = game:GetService("Workspace").NPCs["Bank Teller"]
                        local proximityPrompt = bankTeller.UpperTorso.Attachment.ProximityPrompt
                        if proximityPrompt then
                            local isActive = false
                            local function CheckPromptActive()
                                isActive = proximityPrompt.Enabled
                                return isActive
                            end
                            repeat
                                wait(0.1)
                            until CheckPromptActive()
                            print("Proximity prompt for Bank Teller is now active")
                            if not hasTeleportedToLocation2 then
                                bypass_teleport(teleport_table.location2, 19) -- Teleport to location2 with speed 25 studs per second
                                hasTeleportedToLocation2 = true 
                            end
                            fireproximityprompt(game:GetService("Workspace").NPCs["Bank Teller"].UpperTorso.Attachment.ProximityPrompt)
                            notif.new({text = 'Requisition | Waiting for card!', duration = 40.2})
                            wait(40.2)
                            print("done")
                            wait(1)
                            bypass_teleport(Vector3.new(-39.2600784, 6.71216249, -330.2117), 19) -- Teleport to another location with speed 25 studs per second
                            fireproximityprompt(game:GetService("Workspace").Blank.Attachment.ProximityPrompt)
                            wait(1)
                            local BlankCard = game.Players.LocalPlayer.Backpack:FindFirstChild("Card")
                            if BlankCard then
                                game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(BlankCard)
                            end
                            local ATMSFolder = game:GetService("Workspace").ATMS
                            local activeATM = nil
                            for _, ATM in pairs(ATMSFolder:GetChildren()) do
                                local proximityPrompt = ATM:FindFirstChild("Attachment") and ATM.Attachment:FindFirstChild("ProximityPrompt")
                                if proximityPrompt and proximityPrompt.Enabled then
                                    activeATM = ATM
                                    break
                                end
                            end
                            if activeATM then
                                local targetPosition = activeATM.Position
                                print("Teleporting to ATM at position:", targetPosition)
                                bypass_teleport(targetPosition, 19) -- Teleport to ATM location with speed 25 studs per second
                                local character = game.Players.LocalPlayer.Character
                                local humanoid = character:WaitForChild("Humanoid")
                                humanoid:Move(Vector3.new(0, 0, -5))
                                wait(1)
                            else
                                print("No active ATM found")
                            end
                        else
                            print("Proximity prompt for Bank Teller not found")
                        end
                    else
                        print("Player does not have enough money")
                    end
                    hasTeleportedToLocation2 = false
                    wait(5) -- Repeat the loop every 5 seconds
                end                 
            end,
        })


        -- [Visuals Tab] --
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Iratethisname10/Code/main/espLibrary.lua"))()
        local espLibrary = getgenv().espLibrary
        espLibrary.Visuals.BoxSettings.Type = 2
        
        local ESPToggle = VisTab:CreateToggle({
            Name = "Toggle ESP",
            CurrentValue = false,
            Flag = "ESPT", 
            Callback = function(Value)
                espLibrary.Settings.Enabled = Value
            end,
         })
        local BoxToggle = VisTab:CreateToggle({
            Name = "Toggle Boxes",
            CurrentValue = false,
            Flag = "BOXT", 
            Callback = function(Value)
                espLibrary.Visuals.BoxSettings.Enabled = Value
            end,
         })
        local VisibilitySlider = VisTab:CreateSlider({
            Name = "Visibility",
            Range = {0, 1},
            Increment = 0.01,
            Suffix = "%",
            CurrentValue = 1,
            Flag = "VisibilityS", 
            Callback = function(Value)
                espLibrary.Visuals.BoxSettings.Transparency = Value
            end,
         })
        local ThicknessSlider = VisTab:CreateSlider({
            Name = "Thickness",
            Range = {1, 5},
            Increment = 1,
            Suffix = "%",
            CurrentValue = 1,
            Flag = "ThicknessyS", 
            Callback = function(Value)
                espLibrary.Visuals.BoxSettings.Thickness = Value
            end,
         })
        local FilledToggle = VisTab:CreateToggle({
            Name = "Filled Boxes",
            CurrentValue = false,
            Flag = "FilledT", 
            Callback = function(Value)
                espLibrary.Visuals.BoxSettings.Filled = Value
            end,
         })
        local HBToggle = VisTab:CreateToggle({
            Name = "Health Bar",
            CurrentValue = false,
            Flag = "HBT", 
            Callback = function(Value)
                espLibrary.Visuals.HealthBarSettings.Enabled = Value
            end,
         })
        local TextSection = VisTab:CreateSection("Text ESP")
        
        local TextToggle = VisTab:CreateToggle({
            Name = "Text ESP",
            CurrentValue = false,
            Flag = "TextT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.Enabled = Value
            end,
         })
        local ColorPicker1 = VisTab:CreateColorPicker({
            Name = "Text Outline Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "TOC", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.OutlineColor = Value
            end,
        })
        local ColorPicker2 = VisTab:CreateColorPicker({
            Name = "Text Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "TC", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.TextColor = Value
            end,
        })
        local TOToggle = VisTab:CreateToggle({
            Name = "Text Outline",
            CurrentValue = true,
            Flag = "TOT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.Outline = Value
            end,
         })
        local SDToggle = VisTab:CreateToggle({
            Name = "Show Distance",
            CurrentValue = true,
            Flag = "SDT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.DisplayDistance = Value
            end,
         })
        local SNToggle = VisTab:CreateToggle({
            Name = "Show Name",
            CurrentValue = true,
            Flag = "SNT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.DisplayName = Value
            end,
         })
        local SHToggle = VisTab:CreateToggle({
            Name = "Show Health",
            CurrentValue = true,
            Flag = "SHT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.DisplayHealth = Value
            end,
         })
        local STToggle = VisTab:CreateToggle({
            Name = "Show Tool",
            CurrentValue = true,
            Flag = "STT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.DisplayTool = Value
            end,
         })
        local VisibilitySlider2 = VisTab:CreateSlider({
            Name = "Text Visibility",
            Range = {0, 1},
            Increment = 0.01,
            Suffix = "%",
            CurrentValue = 1,
            Flag = "VisibilityS2", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.TextTransparency = Value
            end,
         })
        local SizeSlider = VisTab:CreateSlider({
            Name = "Size",
            Range = {10, 25},
            Increment = 1,
            Suffix = "%",
            CurrentValue = 17,
            Flag = "SizeS", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.TextSize = Value
            end,
         })

        local TextSection = VisTab:CreateSection("Other ESP")

        local ATMToggle = VisTab:CreateToggle({
            Name = "Active ATM ESP",
            CurrentValue = false,
            Flag = "ActiveATMESP",
            Callback = function(Value)
                local ATMSFolder = game:GetService("Workspace").ATMS
                local activeATMs = {}
                _G.TextVisible = Value -- Initially not visible

                -- Function to create or update the text drawing object for an ATM
                local function updateTextDrawing(atm)
                    if not _G.TextVisible then return end -- Check if text visibility is disabled

                    if activeATMs[atm] then
                        activeATMs[atm]:Remove()
                    end
                    
                    local text = "ATM Active"
                    local textDrawing = Drawing.new("Text")
                    textDrawing.Text = text
                    textDrawing.Size = 20
                    textDrawing.Color = Color3.fromRGB(255, 255, 255)
                    
                    local viewportPosition = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(atm.Position)
                    textDrawing.Position = Vector2.new(viewportPosition.X, viewportPosition.Y) -- Convert to Vector2
                    textDrawing.Visible = true
                    activeATMs[atm] = textDrawing
                end

                -- Function to check for active ATMs and update text drawings
                local function updateActiveATMs()
                    if not _G.TextVisible then
                        for _, textDrawing in pairs(activeATMs) do
                            textDrawing:Remove() -- Remove all text drawings
                        end
                        activeATMs = {} -- Clear the table
                        return
                    end

                    for _, ATM in pairs(ATMSFolder:GetChildren()) do
                        local proximityPrompt = ATM:FindFirstChild("Attachment") and ATM.Attachment:FindFirstChild("ProximityPrompt")
                        if proximityPrompt and proximityPrompt.Enabled then
                            updateTextDrawing(ATM)
                        elseif activeATMs[ATM] then
                            activeATMs[ATM]:Remove()
                            activeATMs[ATM] = nil
                        end
                    end
                end

                -- Call the function initially and set up a loop to continuously check for active ATMs
                updateActiveATMs()
                game:GetService("RunService").Stepped:Connect(function()
                    updateActiveATMs()
                end)
 
            end,
        })

        -- [Misc Tab] --
        local IPButton = MiscTab:CreateButton({
            Name = "Instant Proximity",
            Callback = function()
                for i,v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.ClassName == "ProximityPrompt" then
                     v.HoldDuration = 0
                    end
                   end                   
            end,
         })

         local SmallButton = MiscTab:CreateButton({
            Name = "Join smallest server",
            Callback = function()
                local Http = game:GetService("HttpService")
                local TPS = game:GetService("TeleportService")
                local Api = "https://games.roblox.com/v1/games/"
                
                local _place = game.PlaceId
                local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
                function ListServers(cursor)
                  local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                  return Http:JSONDecode(Raw)
                end
                
                local Server, Next; repeat
                  local Servers = ListServers(Next)
                  Server = Servers.data[1]
                  Next = Servers.nextPageCursor
                until Server
                
                TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)               
            end,
         })

         
         local RejoinButton = MiscTab:CreateButton({
            Name = "Rejoin server",
            Callback = function()
                local ts = game:GetService("TeleportService")
                local p = game:GetService("Players").LocalPlayer
                ts:Teleport(game.PlaceId, p)        
            end,
         })

         local HopButton = MiscTab:CreateButton({
            Name = "Server Hop",
            Callback = function()
                local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()
                module:Teleport(game.PlaceId)     
            end,
         })

        -- [Credit Tab] --
        local DiscordButton = CreditTab:CreateButton({
            Name = "Join the Discord!",
            Callback = function()
                local HttpService = game:GetService("HttpService")
                local requestFunction = (syn and syn.request) or (http and http.request) or http_request
                
                if requestFunction then
                    local nonce = HttpService:GenerateGUID(false)
                    local requestBody = HttpService:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = nonce,
                        args = {code = "8yDaDVQWNC"}
                    })
                    
                    requestFunction({
                        Url = 'http://127.0.0.1:6463/rpc?v=1',
                        Method = 'POST',
                        Headers = {
                            ['Content-Type'] = 'application/json',
                            Origin = 'https://discord.com'
                        },
                        Body = requestBody
                    })
                else
                    warn("Unable to make HTTP request: requestFunction is not available")
                end                
            end,
         })



elseif game.PlaceId == 14413475235 then
    local notif = loadstring(game:HttpGet('https://raw.githubusercontent.com/Iratethisname10/Code/main/aztup-ui/notifs.lua'))()
    local ArrayField = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = ArrayField:CreateWindow({
            Name = "Requisition | South Bronx",
            LoadingTitle = "Requisition Script Hub",
            LoadingSubtitle = "discord.gg/8yDaDVQWNC",
            ConfigurationSaving = {
                Enabled = true,
                FolderName = nil, -- Create a custom folder for your hub/game
                FileName = "Requisition"
            },
            Discord = {
                Enabled = true,
                Invite = "8yDaDVQWNC", -- The Discord invite code, do not include discord.gg/
                RememberJoins = true -- Set this to false to make them join the discord every time they load it up
            },
            KeySystem = false, -- Set this to true to use our key system
            KeySettings = {
                Title = "Requisition",
                Subtitle = "Key System",
                Note = "Join the discord (discord.gg/8yDaDVQWNC)",
                FileName = "RequisitionKeys",
                SaveKey = false,
                GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
                Key = {"https://raw.githubusercontent.com/ImEzyLol/tester/main/key.txt"},
                Actions = {
                    [1] = {
                        Text = 'Click here to copy the key link',
                        OnPress = function()
                            setclipboard("discord.gg/8yDaDVQWNC")
                        end,
                    }
                },
            }
        })
        
    local c = workspace.CurrentCamera
    local ps = game:GetService("Players")
    local lp = ps.LocalPlayer
    local rs = game:GetService("RunService")

    _G.ESP_ENABLED = false 

    local function ftool(cr)
        for _, b in ipairs(cr:GetChildren()) do 
            if b:IsA("Tool") then
                return tostring(b.Name)
            end
        end
        return 'empty'
    end

    local function esp(p, cr)
        local h = cr:WaitForChild("Humanoid")
        local hrp = cr:WaitForChild("HumanoidRootPart")

        local text = Drawing.new('Text')
        text.Visible = false
        text.Center = true
        text.Outline = true
        text.Color = Color3.new(1, 1, 1)
        text.Font = 2
        text.Size = 13

        local c1 
        local c2
        local c3 

        local function dc()
            text.Visible = false
            text:Remove()
            if c3 then
                c1:Disconnect()
                c2:Disconnect()
                c3:Disconnect()
                c1 = nil 
                c2 = nil
                c3 = nil
            end
        end

        c2 = cr.AncestryChanged:Connect(function(_, parent)
            if not parent then
                dc()
            end
        end)

        c3 = h.HealthChanged:Connect(function(v)
            if (v <= 0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
                dc()
            end
        end)

        c1 = rs.Heartbeat:Connect(function()
            local hrp_pos, hrp_os = c:WorldToViewportPoint(hrp.Position)
            if hrp_os and _G.ESP_ENABLED then
                text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y)
                text.Text = '[ '..tostring(ftool(cr))..' ]'
                text.Visible = true
            else
                text.Visible = false
            end
        end)
    end

    local function p_added(p)
        if p.Character then
            esp(p, p.Character)
        end
        p.CharacterAdded:Connect(function(cr)
            esp(p, cr)
        end)
    end


    local function toggleESP()
        _G.ESP_ENABLED = not _G.ESP_ENABLED
    end


    ps.PlayerAdded:Connect(p_added)


    for _, b in ipairs(ps:GetPlayers()) do 
        if b ~= lp then
            p_added(b)
        end
    end


    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Y then
            toggleESP()
        end
    end)



        local MainTab = Window:CreateTab("Combat Tab", nil)
        local FarmTab = Window:CreateTab("Autofarm Tab", nil)
        local VisTab = Window:CreateTab("Visuals Tab", nil)
        local MiscTab = Window:CreateTab("Misc Tab", nil)
        local CreditTab = Window:CreateTab("Credit Tab", nil)

        -- [Main Tab] --
        local AimbotToggle = MainTab:CreateToggle({
            Name = "Toggle Aimbot",
            CurrentValue = false,
            Flag = "AimbotToggle", 
            Callback = function(Value)
                local Camera = workspace.CurrentCamera
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local UserInputService = game:GetService("UserInputService")
                local TweenService = game:GetService("TweenService")
                local LocalPlayer = Players.LocalPlayer
                local Holding = false

                _G.AimbotEnabled = Value
                _G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
                _G.AimPart = "Head" -- Where the aimbot script would lock at.
                _G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

                _G.CircleSides = 64 -- How many sides the FOV circle would have.
                _G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
                _G.CircleTransparency = 0.7 -- Transparency of the circle.
                _G.CircleRadius = 80 -- The radius of the circle / FOV.
                _G.CircleFilled = false -- Determines whether or not the circle is filled.
                _G.CircleVisible = true -- Determines whether or not the circle is visible.
                _G.CircleThickness = 0 -- The thickness of the circle.

                if Value == false then
                    _G.CircleVisible = false
                end

                local FOVCircle = Drawing.new("Circle")
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Filled = _G.CircleFilled
                FOVCircle.Color = _G.CircleColor
                FOVCircle.Visible = _G.CircleVisible
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Transparency = _G.CircleTransparency
                FOVCircle.NumSides = _G.CircleSides
                FOVCircle.Thickness = _G.CircleThickness

                local function GetClosestPlayer()
                    local MaximumDistance = _G.CircleRadius
                    local Target = nil

                    for _, v in next, Players:GetPlayers() do
                        if v.Name ~= LocalPlayer.Name then
                            if _G.TeamCheck == true then
                                if v.Team ~= LocalPlayer.Team then
                                    if v.Character ~= nil then
                                        if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                            if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                                
                                                if VectorDistance < MaximumDistance then
                                                    Target = v
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if v.Character ~= nil then
                                    if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                        if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                            
                                            if VectorDistance < MaximumDistance then
                                                Target = v
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    return Target
                end

                UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Holding = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Holding = false
                    end
                end)

                RunService.RenderStepped:Connect(function()
                    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    FOVCircle.Radius = _G.CircleRadius
                    FOVCircle.Filled = _G.CircleFilled
                    FOVCircle.Color = _G.CircleColor
                    FOVCircle.Visible = _G.CircleVisible
                    FOVCircle.Radius = _G.CircleRadius
                    FOVCircle.Transparency = _G.CircleTransparency
                    FOVCircle.NumSides = _G.CircleSides
                    FOVCircle.Thickness = _G.CircleThickness

                    if Holding == true and _G.AimbotEnabled == true then
                        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
                    end
                end)
            end,
         })

         local AimPart = MainTab:CreateDropdown({
            Name = "Aim Part",
            Options = {"Head","HumanoidRootPart"},
            CurrentOption = {"Head"},
            MultipleOptions = false,
            Flag = "AimPart", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Option)
                local selectedOption
                if type(Option) == "table" then
                    selectedOption = Option[1] -- Extract the first element if it's a table
                else
                    selectedOption = Option -- Use directly if it's already a string
                end
                
                _G.AimPart = selectedOption
            end,
         })

         local FOVSlider = MainTab:CreateSlider({
            Name = "Fov Size",
            Range = {0, 150},
            Increment = 5,
            Suffix = "",
            CurrentValue = 80,
            Flag = "FOVSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleRadius = Value
            end,
         })

         local CircleVisible = MainTab:CreateToggle({
            Name = "Visible FOV",
            CurrentValue = true,
            Flag = "CircleVisible", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleVisible = Value
            end,
         })

         local FilledFOV = MainTab:CreateToggle({
            Name = "Filled FOV",
            CurrentValue = false,
            Flag = "FilledFOV", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.CircleFilled = Value
            end,
         })

         local CircleColor = MainTab:CreateColorPicker({
            Name = "Circle Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "CircleColor", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                print(Value)
                _G.CircleColor = Value
                -- The function that takes place every time the color picker is moved/changed
                -- The variable (Value) is a Color3fromRGB value based on which color is selected
            end
        })

        -- [Farm Tab] --
        local BoxToggle = FarmTab:CreateToggle({
            Name = "Box Job Autofarm",
            CurrentValue = false,
            Flag = "BoxFarm",
            Callback = function(Value)
                local teleport_table = {
                    location1 = Vector3.new(-551.0175170898438, 3.537144184112549, -85.6669692993164), -- start
                    location2 = Vector3.new(-400.960754, 3.41219378, -72.2366257, -0.999820769, -2.88791675e-08, -0.0189329591, -2.808512e-08, 1, -4.22059294e-08, 0.0189329591, -4.1666631e-08, -0.999820769) -- end
                }
                
                local tween_s = game:GetService('TweenService')
                
                local lp = game.Players.LocalPlayer
                
                _G.TELEPORT_ENABLED = Value
                
                function bypass_teleport(v, speed)
                    if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                        local cf = CFrame.new(v)
                        local distance = (lp.Character.HumanoidRootPart.Position - cf.p).magnitude
                        local baseDuration = 1
                        local duration = baseDuration + (distance / speed)
                        
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local tween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                        tween:Play()
                        tween.Completed:Wait() -- Wait for the tween to complete before proceeding
                    end
                end
                
                while true do
                    if _G.TELEPORT_ENABLED then
                        bypass_teleport(teleport_table.location1, 25)
                        wait(1)
                        fireproximityprompt(game:GetService("Workspace").PlaceHere.Attachment.ProximityPrompt)
                        -- Equip tool "Crate" here
                        
                        wait(0.5)
                        local crateTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Crate")
                        if crateTool then
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(crateTool)
                        end
                        bypass_teleport(teleport_table.location2, 25)
                        local character = game.Players.LocalPlayer.Character
                        local humanoid = character:WaitForChild("Humanoid")
                        humanoid:Move(Vector3.new(0, 0, -5))
                        wait(1)
                        -- Wait until the "Crate" tool is removed from inventory here
                        while game.Players.LocalPlayer.Backpack:FindFirstChild("Crate") or game.Players.LocalPlayer.Character:FindFirstChild("Crate") do
                            fireproximityprompt(game:GetService("Workspace").cratetruck2.Model.ClickBox.ProximityPrompt)
                            wait(1)
                        end        
                    else
                        wait(1) -- Wait if teleport is not enabled
                    end
                end                
            end,
        })
        
        local ATMToggle = FarmTab:CreateToggle({
            Name = "ATM Farm",
            CurrentValue = false,
            Flag = "ATMToggle",
            Callback = function(Value)
                local playerName = game.Players.LocalPlayer.Name
                local lp = game.Players.LocalPlayer
                
                local moneyAmount = game:GetService("Players")[playerName].PlayerGui.Main.Money.Amount
                
                print(moneyAmount.Text)
                
                local moneyValueText = moneyAmount.Text:gsub("%$", "")
                local moneyValue = tonumber(moneyValueText)
                
                local teleport_table = {
                    location1 = Vector3.new(214.934265, 3.73713231, -335.223938),
                    location2 = Vector3.new(-48.807437896728516, 3.735410213470459, -320.9378356933594) 
                }
                
                local hasTeleportedToLocation2 = false
                
                local tween_s = game:GetService('TweenService')
                
                _G.shouldRun = Value -- Toggleable variable
                
                function bypass_teleport(v, speed)
                    if lp.Character and lp.Character:FindFirstChild('HumanoidRootPart') then
                        local cf = CFrame.new(v)
                        local distance = (lp.Character.HumanoidRootPart.Position - cf.p).magnitude
                        local baseDuration = 1
                        local duration = baseDuration + (distance / speed)
                        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                        local teleportTween = tween_s:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = cf})
                        teleportTween:Play()
                        teleportTween.Completed:Wait()
                    end
                end
                
                -- Main loop
                while _G.shouldRun do
                    if moneyValue and moneyValue >= 850 then
                        print("Player has more/equal to 850 money")
                        
                        -- Perform teleportation actions
                        bypass_teleport(teleport_table.location1, 22) -- Teleport to location1 with speed 25 studs per second
                        wait(1.1)  -- Adjust if additional delay is needed after teleporting
                        fireproximityprompt(game:GetService("Workspace").NPCs.FakeIDSeller.UpperTorso.Attachment.ProximityPrompt)
                        wait(1.2)
                        local fakeID = game.Players.LocalPlayer.Backpack:FindFirstChild("Fake ID")
                        if fakeID then
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(fakeID)
                        end
                        
                        local bankTeller = game:GetService("Workspace").NPCs["Bank Teller"]
                        local proximityPrompt = bankTeller.UpperTorso.Attachment.ProximityPrompt
                        if proximityPrompt then
                            local isActive = false
                            local function CheckPromptActive()
                                isActive = proximityPrompt.Enabled
                                return isActive
                            end
                            repeat
                                wait(0.1)
                            until CheckPromptActive()
                            print("Proximity prompt for Bank Teller is now active")
                            if not hasTeleportedToLocation2 then
                                bypass_teleport(teleport_table.location2, 22) -- Teleport to location2 with speed 25 studs per second
                                hasTeleportedToLocation2 = true 
                            end
                            fireproximityprompt(game:GetService("Workspace").NPCs["Bank Teller"].UpperTorso.Attachment.ProximityPrompt)
                            notif.new({text = 'Requisition | Waiting for card!', duration = 40.2})
                            wait(40.2)
                            print("done")
                            wait(1)
                            bypass_teleport(Vector3.new(-39.2600784, 6.71216249, -330.2117), 22) -- Teleport to another location with speed 25 studs per second
                            fireproximityprompt(game:GetService("Workspace").Blank.Attachment.ProximityPrompt)
                            wait(1)
                            local BlankCard = game.Players.LocalPlayer.Backpack:FindFirstChild("Card")
                            if BlankCard then
                                game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(BlankCard)
                            end
                            local ATMSFolder = game:GetService("Workspace").ATMS
                            local activeATM = nil
                            for _, ATM in pairs(ATMSFolder:GetChildren()) do
                                local proximityPrompt = ATM:FindFirstChild("Attachment") and ATM.Attachment:FindFirstChild("ProximityPrompt")
                                if proximityPrompt and proximityPrompt.Enabled then
                                    activeATM = ATM
                                    break
                                end
                            end
                            if activeATM then
                                local targetPosition = activeATM.Position
                                print("Teleporting to ATM at position:", targetPosition)
                                bypass_teleport(targetPosition, 22) -- Teleport to ATM location with speed 25 studs per second
                                local character = game.Players.LocalPlayer.Character
                                local humanoid = character:WaitForChild("Humanoid")
                                humanoid:Move(Vector3.new(0, 0, -5))
                                wait(1)
                            else
                                print("No active ATM found")
                            end
                        else
                            print("Proximity prompt for Bank Teller not found")
                        end
                    else
                        print("Player does not have enough money")
                    end
                    hasTeleportedToLocation2 = false
                    wait(5) -- Repeat the loop every 5 seconds
                end                 
            end,
        })


        -- [Visuals Tab] --
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Iratethisname10/Code/main/espLibrary.lua"))()
        local espLibrary = getgenv().espLibrary
        espLibrary.Visuals.BoxSettings.Type = 2
        
        local ESPToggle = VisTab:CreateToggle({
            Name = "Toggle ESP",
            CurrentValue = false,
            Flag = "ESPT", 
            Callback = function(Value)
                espLibrary.Settings.Enabled = Value
            end,
         })
        local BoxToggle = VisTab:CreateToggle({
            Name = "Toggle Boxes",
            CurrentValue = false,
            Flag = "BOXT", 
            Callback = function(Value)
                espLibrary.Visuals.BoxSettings.Enabled = Value
            end,
         })
        local VisibilitySlider = VisTab:CreateSlider({
            Name = "Visibility",
            Range = {0, 1},
            Increment = 0.01,
            Suffix = "%",
            CurrentValue = 1,
            Flag = "VisibilityS", 
            Callback = function(Value)
                espLibrary.Visuals.BoxSettings.Transparency = Value
            end,
         })
        local ThicknessSlider = VisTab:CreateSlider({
            Name = "Thickness",
            Range = {1, 5},
            Increment = 1,
            Suffix = "%",
            CurrentValue = 1,
            Flag = "ThicknessyS", 
            Callback = function(Value)
                espLibrary.Visuals.BoxSettings.Thickness = Value
            end,
         })
        local FilledToggle = VisTab:CreateToggle({
            Name = "Filled Boxes",
            CurrentValue = false,
            Flag = "FilledT", 
            Callback = function(Value)
                espLibrary.Visuals.BoxSettings.Filled = Value
            end,
         })
        local HBToggle = VisTab:CreateToggle({
            Name = "Health Bar",
            CurrentValue = false,
            Flag = "HBT", 
            Callback = function(Value)
                espLibrary.Visuals.HealthBarSettings.Enabled = Value
            end,
         })
        local TextSection = VisTab:CreateSection("Text ESP")
        
        local TextToggle = VisTab:CreateToggle({
            Name = "Text ESP",
            CurrentValue = false,
            Flag = "TextT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.Enabled = Value
            end,
         })
        local ColorPicker1 = VisTab:CreateColorPicker({
            Name = "Text Outline Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "TOC", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.OutlineColor = Value
            end,
        })
        local ColorPicker2 = VisTab:CreateColorPicker({
            Name = "Text Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "TC", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.TextColor = Value
            end,
        })
        local TOToggle = VisTab:CreateToggle({
            Name = "Text Outline",
            CurrentValue = true,
            Flag = "TOT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.Outline = Value
            end,
         })
        local SDToggle = VisTab:CreateToggle({
            Name = "Show Distance",
            CurrentValue = true,
            Flag = "SDT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.DisplayDistance = Value
            end,
         })
        local SNToggle = VisTab:CreateToggle({
            Name = "Show Name",
            CurrentValue = true,
            Flag = "SNT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.DisplayName = Value
            end,
         })
        local SHToggle = VisTab:CreateToggle({
            Name = "Show Health",
            CurrentValue = true,
            Flag = "SHT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.DisplayHealth = Value
            end,
         })
        local STToggle = VisTab:CreateToggle({
            Name = "Show Tool",
            CurrentValue = true,
            Flag = "STT", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.DisplayTool = Value
            end,
         })
        local VisibilitySlider2 = VisTab:CreateSlider({
            Name = "Text Visibility",
            Range = {0, 1},
            Increment = 0.01,
            Suffix = "%",
            CurrentValue = 1,
            Flag = "VisibilityS2", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.TextTransparency = Value
            end,
         })
        local SizeSlider = VisTab:CreateSlider({
            Name = "Size",
            Range = {10, 25},
            Increment = 1,
            Suffix = "%",
            CurrentValue = 17,
            Flag = "SizeS", 
            Callback = function(Value)
                espLibrary.Visuals.ESPSettings.TextSize = Value
            end,
         })
         
        local TextSection = VisTab:CreateSection("Text ESP")

        local ATMToggle = VisTab:CreateToggle({
            Name = "Active ATM ESP",
            CurrentValue = false,
            Flag = "ActiveATMESP",
            Callback = function(Value)
                local ATMSFolder = game:GetService("Workspace").ATMS
                local activeATMs = {}
                _G.TextVisible = Value -- Initially not visible

                -- Function to create or update the text drawing object for an ATM
                local function updateTextDrawing(atm)
                    if not _G.TextVisible then return end -- Check if text visibility is disabled

                    if activeATMs[atm] then
                        activeATMs[atm]:Remove()
                    end
                    
                    local text = "ATM Active"
                    local textDrawing = Drawing.new("Text")
                    textDrawing.Text = text
                    textDrawing.Size = 20
                    textDrawing.Color = Color3.fromRGB(255, 255, 255)
                    
                    local viewportPosition = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(atm.Position)
                    textDrawing.Position = Vector2.new(viewportPosition.X, viewportPosition.Y) -- Convert to Vector2
                    textDrawing.Visible = true
                    activeATMs[atm] = textDrawing
                end

                -- Function to check for active ATMs and update text drawings
                local function updateActiveATMs()
                    if not _G.TextVisible then
                        for _, textDrawing in pairs(activeATMs) do
                            textDrawing:Remove() -- Remove all text drawings
                        end
                        activeATMs = {} -- Clear the table
                        return
                    end

                    for _, ATM in pairs(ATMSFolder:GetChildren()) do
                        local proximityPrompt = ATM:FindFirstChild("Attachment") and ATM.Attachment:FindFirstChild("ProximityPrompt")
                        if proximityPrompt and proximityPrompt.Enabled then
                            updateTextDrawing(ATM)
                        elseif activeATMs[ATM] then
                            activeATMs[ATM]:Remove()
                            activeATMs[ATM] = nil
                        end
                    end
                end

                -- Call the function initially and set up a loop to continuously check for active ATMs
                updateActiveATMs()
                game:GetService("RunService").Stepped:Connect(function()
                    updateActiveATMs()
                end)
 
            end,
        })


        -- [Misc Tab] --
        local IPButton = MiscTab:CreateButton({
            Name = "Instant Proximity",
            Callback = function()
                for i,v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.ClassName == "ProximityPrompt" then
                     v.HoldDuration = 0
                    end
                   end                   
            end,
         })

        local SmallButton = MiscTab:CreateButton({
            Name = "Join smallest server",
            Callback = function()
                local Http = game:GetService("HttpService")
                local TPS = game:GetService("TeleportService")
                local Api = "https://games.roblox.com/v1/games/"
                
                local _place = game.PlaceId
                local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
                function ListServers(cursor)
                  local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                  return Http:JSONDecode(Raw)
                end
                
                local Server, Next; repeat
                  local Servers = ListServers(Next)
                  Server = Servers.data[1]
                  Next = Servers.nextPageCursor
                until Server
                
                TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)               
            end,
         })

         
         local RejoinButton = MiscTab:CreateButton({
            Name = "Rejoin server",
            Callback = function()
                local ts = game:GetService("TeleportService")
                local p = game:GetService("Players").LocalPlayer
                ts:Teleport(game.PlaceId, p)        
            end,
         })

         local HopButton = MiscTab:CreateButton({
            Name = "Server Hop",
            Callback = function()
                local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()
                module:Teleport(game.PlaceId)     
            end,
         })

        -- [Credit Tab] --
        local DiscordButton = CreditTab:CreateButton({
            Name = "Join the Discord!",
            Callback = function()
                local HttpService = game:GetService("HttpService")
                local requestFunction = (syn and syn.request) or (http and http.request) or http_request
                
                if requestFunction then
                    local nonce = HttpService:GenerateGUID(false)
                    local requestBody = HttpService:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = nonce,
                        args = {code = "8yDaDVQWNC"}
                    })
                    
                    requestFunction({
                        Url = 'http://127.0.0.1:6463/rpc?v=1',
                        Method = 'POST',
                        Headers = {
                            ['Content-Type'] = 'application/json',
                            Origin = 'https://discord.com'
                        },
                        Body = requestBody
                    })
                else
                    warn("Unable to make HTTP request: requestFunction is not available")
                end                
            end,
         })
elseif game.PlaceId == 9874911474 then
------\\Booting//
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Requisition | Tha Bronx 2",
    LoadingTitle = "Requisition Script Hub",
    LoadingSubtitle = "discord.gg/8yDaDVQWNC",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Requisition"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = False, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Quis", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Test"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

------\\Chat Spy//------
enabled = true -- chat "/spy" to toggle!
spyOnMyself = true -- if true will check your messages too
public = false -- if true will chat the logs publicly (fun, risky)
publicItalics = true -- if true will use /me to stand out
privateProperties = { -- customize private logs
    Color = Color3.fromRGB(0,255,255),
    Font = Enum.Font.SourceSansBold,
    TextSize = 18,
}

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance

local function onChatted(p, msg)
    if _G.chatSpyInstance == instance then
        if p == player and msg:lower():sub(1, 4) == "/spy" then
            enabled = not enabled
            wait(0.3)
            privateProperties.Text = "{SPY " .. (enabled and "EN" or "DIS") .. "ABLED}"
            StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
        elseif enabled and (spyOnMyself == true or p ~= player) then
            msg = msg:gsub("[\n\r]", ''):gsub("\t", ' '):gsub("[ ]+", ' ')
            local hidden = true
            local conn = getmsg.OnClientEvent:Connect(function(packet, channel)
                if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(#msg - #packet.Message + 1) and (channel == "All" or (channel == "Team" and public == false and Players[packet.FromSpeaker].Team == player.Team)) then
                    hidden = false
                end
            end)
            wait(1)
            conn:Disconnect()
            if hidden and enabled then
                if public then
                    saymsg:FireServer((publicItalics and "/me " or '') .. "{SPY} [" .. p.Name .. "]: " .. msg, "All")
                else
                    privateProperties.Text = "{SPY} [" .. p.Name .. "]: " .. msg
                    StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                end
            end
        end
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    p.Chatted:Connect(function(msg) onChatted(p, msg) end)
end

Players.PlayerAdded:Connect(function(p)
    p.Chatted:Connect(function(msg) onChatted(p, msg) end)
end)

privateProperties.Text = "{SPY " .. (enabled and "EN" or "DIS") .. "ABLED}"
StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)

if not player.PlayerGui:FindFirstChild("Chat") then wait(3) end

local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)



------\\Spec//------
 local Players = game.Players
 local LocalPlayer = Players.LocalPlayer
  local function teleportToPlayer(playerName)
     local playerToTeleport = Players:FindFirstChild(playerName)
     if playerToTeleport then
         local character = LocalPlayer.Character
         local humanoid = character:FindFirstChildOfClass("Humanoid")
         local rootPart = character:FindFirstChild("HumanoidRootPart")
 
         local targetCharacter = playerToTeleport.Character
         local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
 
         if targetRootPart then
             rootPart.CFrame = targetRootPart.CFrame
         end
     end
 end
 
 ------\\Esp Library//------
 local c = workspace.CurrentCamera
local ps = game:GetService("Players")
local lp = ps.LocalPlayer
local rs = game:GetService("RunService")

_G.ESP_ENABLED = false 

local function ftool(cr)
    for _, b in ipairs(cr:GetChildren()) do 
        if b:IsA("Tool") then
            return tostring(b.Name)
        end
    end
    return 'empty'
end

local function esp(p, cr)
    local h = cr:WaitForChild("Humanoid")
    local hrp = cr:WaitForChild("HumanoidRootPart")

    local text = Drawing.new('Text')
    text.Visible = false
    text.Center = true
    text.Outline = true
    text.Color = Color3.new(1, 1, 1)
    text.Font = 2
    text.Size = 13

    local c1 
    local c2
    local c3 

    local function dc()
        text.Visible = false
        text:Remove()
        if c3 then
            c1:Disconnect()
            c2:Disconnect()
            c3:Disconnect()
            c1 = nil 
            c2 = nil
            c3 = nil
        end
    end

    c2 = cr.AncestryChanged:Connect(function(_, parent)
        if not parent then
            dc()
        end
    end)

    c3 = h.HealthChanged:Connect(function(v)
        if (v <= 0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
            dc()
        end
    end)

    c1 = rs.Heartbeat:Connect(function()
        local hrp_pos, hrp_os = c:WorldToViewportPoint(hrp.Position)
        if hrp_os and _G.ESP_ENABLED then
            text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y)
            text.Text = '[ '..tostring(ftool(cr))..' ]'
            text.Visible = true
        else
            text.Visible = false
        end
    end)
end

local function p_added(p)
    if p.Character then
        esp(p, p.Character)
    end
    p.CharacterAdded:Connect(function(cr)
        esp(p, cr)
    end)
end


local function toggleESP()
    _G.ESP_ENABLED = not _G.ESP_ENABLED
end


ps.PlayerAdded:Connect(p_added)


for _, b in ipairs(ps:GetPlayers()) do 
    if b ~= lp then
        p_added(b)
    end
end


local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local function teleportToPlayer(playerName)
    local playerToTeleport = Players:FindFirstChild(playerName)
    if playerToTeleport then
        local character = LocalPlayer.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")

        local targetCharacter = playerToTeleport.Character
        local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")

        if targetRootPart then
            rootPart.CFrame = targetRootPart.CFrame
        end
    end
end
 
 
 
 
 ------\\SPIN BOT//------
 -- Create a function to handle the spin bot behavior
 local player = game.Players.LocalPlayer
 local spinEnabled = false
 local spinSpeed = 0
 
 local function spinBot(speed)
     while spinEnabled do
         game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(speed), 0)
         wait(0.1)
     end
 end
 
 local function adjustSpin()
     if spinEnabled then
         spinBot(spinSpeed)
     else
         -- You can add code here to stop the spinning effect
     end
 end
 
 ------//Send money\\
 function SendMoneyToPlayer(playerName, amount)
    local args = {
        [1] = "Send",
        [2] = amount,
        [3] = playerName
    }
    game:GetService("ReplicatedStorage").BankProcessRemote:InvokeServer(unpack(args))
end

local toggleLoop
 

 
 ------\\G.functions//
 
 _G.Moneyfarm = true
 
 ------\\button Functions//

 function RemoteSpy()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
   wait(.01)
end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TeleportOptions = {}

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(TeleportOptions, player.Name)
    end
end
 
 ------\\REAL FUNCTIONS//

 local noclipEnabled = false
 local Noclip = nil
 
 local function enableNoclip()
     if not noclipEnabled then
         noclipEnabled = true
 
         if Noclip then
             Noclip:Disconnect()
         end
 
         local character = game.Players.LocalPlayer.Character
         if character then
             for _, part in ipairs(character:GetDescendants()) do
                 if part:IsA('BasePart') then
                     part.CanCollide = false
                 end
             end
         end
 
         Noclip = game:GetService('RunService').Stepped:Connect(noclip)
     end
 end
 
 local function disableNoclip()
     if noclipEnabled then
         noclipEnabled = false
 
         if Noclip then
             Noclip:Disconnect()
         end
 
         local character = game.Players.LocalPlayer.Character
         if character then
             for _, part in ipairs(character:GetDescendants()) do
                 if part:IsA('BasePart') then
                     part.CanCollide = true
                 end
             end
         end
     end
 end
 
------\\Legit-Hitbox Toggle function//------
local player = game.Players.LocalPlayer
local HitboxEnabled4 = false

local function adjustHitbox(player)
    print("Adjusting hitbox for player:", player.Name)
    if player.Character then
        local upperTorso = player.Character:FindFirstChild("UpperTorso")
        local lowerTorso = player.Character:FindFirstChild("LowerTorso")
        if upperTorso and lowerTorso then
            if HitboxEnabled4 then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    upperTorso.Size = Vector3.new(2, 2, 2)
                    upperTorso.Transparency = 0.9
                    upperTorso.BrickColor = BrickColor.new("Glass")
                    upperTorso.Material = "Glass"
                    upperTorso.CanCollide = false
                    
                    lowerTorso.Size = Vector3.new(2, 2, 2)
                    lowerTorso.Transparency = 0.9
                    lowerTorso.BrickColor = BrickColor.new("Glass")
                    lowerTorso.Material = "Glass"
                    lowerTorso.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    upperTorso.Size = Vector3.new(2, 2, 1)
                    upperTorso.Transparency = 0.1
                    upperTorso.BrickColor = BrickColor.new("Glass")
                    upperTorso.Material = "Glass"
                    upperTorso.CanCollide = true
                    
                    lowerTorso.Size = Vector3.new(0, 0, 0)
                    lowerTorso.Transparency = 0.1
                    lowerTorso.BrickColor = BrickColor.new("Glass")
                    lowerTorso.Material = "Glass"
                    lowerTorso.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers4()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Function to handle player added events
local function onPlayerAdded(player)
    print("Player added:", player.Name)
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end

local function onPlayerRespawn(player)
    print("Player respawned:", player.Name)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            wait(35) -- Delay to allow time for respawn
            adjustHitbox(player)
        end)
    end)
end

-- Initialize hitbox state when the script starts
applyHitboxStateToAllPlayers4()

-- Listen for player added events
game.Players.PlayerAdded:Connect(onPlayerAdded)
print("Player added event connected")

game.Players.PlayerAdded:Connect(function(player)
    onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end)
print("Player added and respawn events connected")

------\\Semi-Legit-Hitbox//------
local player = game.Players.LocalPlayer
local HitboxEnabled3 = false

local function adjustHitbox(player)
    print("Adjusting hitbox for player:", player.Name)
    if player.Character then
        local head = player.Character:FindFirstChild("Head")
        if head then
            if HitboxEnabled3 then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    head.Size = Vector3.new(2, 2, 2)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    -- You can adjust these properties as needed when the hitbox is disabled
                    head.Size = Vector3.new(0, 0, 0)
                    head.Transparency = 0
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers3()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Function to handle player added events
local function onPlayerAdded(player)
    print("Player added:", player.Name)
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end

local function onPlayerRespawn(player)
    print("Player respawned:", player.Name)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            wait(35) -- Delay to allow time for respawn
            adjustHitbox(player)
        end)
    end)
end

-- Initialize hitbox state when the script starts
applyHitboxStateToAllPlayers3()

-- Listen for player added events
game.Players.PlayerAdded:Connect(onPlayerAdded)
print("Player added event connected")

game.Players.PlayerAdded:Connect(function(player)
    onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end)
print("Player added and respawn events connected")

------\\Rage-Hitbox V2 Toggle Function//------
local player = game.Players.LocalPlayer
local HitboxEnabled = false

local function adjustHitbox(player)
    print("Adjusting hitbox for player:", player.Name)
    if player.Character then
        local head = player.Character:FindFirstChild("Head")
        if head then
            if HitboxEnabled then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    head.Size = Vector3.new(5, 5, 5)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    -- You can adjust these properties as needed when the hitbox is disabled
                    head.Size = Vector3.new(1, 1, 1)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Function to handle player added events
local function onPlayerAdded(player)
    print("Player added:", player.Name)
    player.CharacterAdded:Connect(function(character)
        wait(0) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end

local function onPlayerRespawn(player)
    print("Player respawned:", player.Name)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            wait(0) -- Delay to allow time for respawn
            adjustHitbox(player)
        end)
    end)
end

-- Initialize hitbox state when the script starts
applyHitboxStateToAllPlayers()

-- Listen for player added events
game.Players.PlayerAdded:Connect(onPlayerAdded)
print("Player added event connected")

game.Players.PlayerAdded:Connect(function(player)
    onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        wait(0) -- Delay to ensure character fully loads
        adjustHitbox(player)
    end)
end)
print("Player added and respawn events connected")


------\\Rage Keybind//------
local player = game.Players.LocalPlayer
local HitboxEnabled5 = false

local function adjustHitbox(targetPlayer)
    print("Adjusting hitbox for player:", targetPlayer.Name)
    if targetPlayer.Character then
        local head = targetPlayer.Character:FindFirstChild("Head")
        if head then
            if HitboxEnabled5 then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    head.Size = Vector3.new(5, 5, 5)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    head.Size = Vector3.new(1, 1, 1)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers5()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Toggle function to be called by the keybind
local function toggleHitbox()
    HitboxEnabled5 = not HitboxEnabled5 -- Toggle the state
    applyHitboxStateToAllPlayers5() -- Apply the new state to all players
end





------\\Money Farm Function//------
 -- Define global variable to control the autofarm state
 _G.autofarmEnabled = false

 local function pickUpMoney()
     for _, moneyInstance in pairs(workspace.Dollas:GetChildren()) do
         if moneyInstance:FindFirstChild("ProximityPrompt") then
             fireproximityprompt(moneyInstance.ProximityPrompt)
         end
     end
 end
 
 local function autofarm()
     while _G.autofarmEnabled do
         -- Step 1: Drop money
         local argsDrop = {
             [1] = "Drop",
             [2] = 0/0 -- NaN
         }
         game:GetService("ReplicatedStorage").BankProcessRemote:InvokeServer(unpack(argsDrop))
 
         -- Short wait to ensure money has been dropped
        
 
         -- Step 2: Attempt to pick up dropped money
         pickUpMoney()
 
         -- Short wait to ensure money has been picked up
         wait(0)
 
         -- Step 3: Deposit picked up money
         local argsDeposit = {
             [1] = "depo",
             [2] = "29000" -- Update this value to the amount you want to deposit
         }
         game:GetService("ReplicatedStorage").BankAction:FireServer(unpack(argsDeposit))
 
         -- Adjust the wait time as needed for your use case
         wait(0)
     end
 end
 

------\\Hitbox keybind//------
local player = game.Players.LocalPlayer
local HitboxEnabled5 = false

local function adjustHitbox(targetPlayer)
    print("Adjusting hitbox for player:", targetPlayer.Name)
    if targetPlayer.Character then
        local head = targetPlayer.Character:FindFirstChild("Head")
        if head then
            if HitboxEnabled5 then
                pcall(function()
                    -- Adjust the hitbox properties when enabled
                    head.Size = Vector3.new(5, 5, 5)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = false
                end)
            else
                pcall(function()
                    -- Reset the hitbox properties when disabled
                    head.Size = Vector3.new(1, 1, 1)
                    head.Transparency = 0.9
                    head.BrickColor = BrickColor.new("Glass")
                    head.Material = "Glass"
                    head.CanCollide = true
                end)
            end
        end
    end
end

-- Function to apply hitbox state to all players
local function applyHitboxStateToAllPlayers5()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            adjustHitbox(otherPlayer)
        end
    end
end

-- Toggle function to be called by the keybind
local function toggleHitbox()
    HitboxEnabled5 = not HitboxEnabled5 -- Toggle the state
    applyHitboxStateToAllPlayers5() -- Apply the new state to all players
end

 ------\\Tab 1//------
 local MainTab = Window:CreateTab("Home🏠", nil) -- Title, Image
 local MainSection = MainTab:CreateSection("Main")

 local VisTab = Window:CreateTab("Visuals", nil) -- Title, Image
 local VisSection = VisTab:CreateSection("Esp")
 
 ------\\Tab 2//------
  local MoneyTab = Window:CreateTab("Money-Farm💲💵", nil) -- Title, Image
  local MoneySection = MoneyTab:CreateSection("Money")
 
 ------\\Tab 3//------
  local PvpTab = Window:CreateTab("Target🎯", nil) -- Title, Image
  local PvpSection = PvpTab:CreateSection("Pvp")

  ------\\Tab 4//------
  local MiscTab = Window:CreateTab("Misc✔", nil) -- Title, Image
  local MiscSection = MiscTab:CreateSection("Misc")

  ------\\Tab 5//------
  local BlatantTab = Window:CreateTab("Blatant😎", nil) -- Title, Image
  local BlatantSection = BlatantTab:CreateSection("Blatant")


  ------\\Tab 6//------
  local LocationTab = Window:CreateTab("Locations📍", nil) -- Title, Image
  local LocationSection = LocationTab:CreateSection("Teleport")

  ------\\Tab 7//------
  local ShopTab = Window:CreateTab("Shop🛒", nil) -- Title, Image
  local ShopSection = ShopTab:CreateSection("Shop")


  ------\\Main Tab//------

 local Slider = MainTab:CreateSlider({
	Name = "[Walk-Speed]",
	Range = {16, 250},
	Increment = 10,
	Suffix = "Walkspeed",
	CurrentValue = 10,
	Flag = "WalkspeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(V)
        _G.WS = (V); -- Enter speed here
        local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
        Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        Humanoid.WalkSpeed = _G.WS;
        end)
        Humanoid.WalkSpeed = _G.WS;
    end,
})

local Slider = MainTab:CreateSlider({
	Name = "[Jump-Power]",
	Range = {16, 250},
	Increment = 10,
	Suffix = "Jump Power",
	CurrentValue = 85,
	Flag = "JumpPowerSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(G)
		game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = G
    		-- The variable (Value) is a number which correlates to the value the slider is currently at
	end,
})

local Slider = MainTab:CreateSlider({
    Name = "[Gravity]",
    Range = {0, 85},
    Increment = 10,
    Suffix = "Gravity Slider",
    CurrentValue = 10,
    Flag = "GravitySlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(V)
        wait()
        game.workspace.Gravity = V
    end,
 })

local Toggle = MainTab:CreateToggle({
	Name = "[Inf Jump]",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(infjmp)
		local infjmp = true
        game:GetService("UserInputService").jumpRequest:Connect(function()
            if infjmp then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass"Humanoid":ChangeState("Jumping")
            end
        end)
        
	end,
})

local Label = MainTab:CreateLabel("Feel Free To Support Us❤")
local Button = MainTab:CreateButton({
    Name = "[Send Tweet]",
    Callback = function()
        local args = {
            [1] = "Tweet",
            [2] = {
                [1] = "CreateTweet",
                [2] = "Want Free Money? join,gg/NhpfQWJJ❤"
            }
        }
        
        game:GetService("ReplicatedStorage").Resources["#Phone"].Main:FireServer(unpack(args))
        
    end,
 })
















------\\Pvp Tab//------
local Label = PvpTab:CreateLabel("[Selected Target]")
local TargetName = ""
local function CheckPlr2(arg)
    for i,v in pairs(game.Players:GetChildren()) do
        if (string.sub(string.lower(v.Name),1,string.len(arg))) == string.lower(arg) then
            TargetName = v.Name
        end
        if (string.sub(string.lower(v.DisplayName),1,string.len(arg))) == string.lower(arg) then
            TargetName = v.Name
        end
    end
    return nil
end
local Input = PvpTab:CreateInput({
    Name = "[Target Name]",
    PlaceholderText = "type here",
    RemoveTextAfterFocusLost = false,
    Callback = function(Target)
    -- The function that takes place when the input is changed
    -- The variable (Text) is a string for the value in the text box
    CheckPlr2(Target)
    Label:Set("Selected target:".. Target)
    for i = 1, 10 do
    print(Target)
    end
    end
 })

 local button = PvpTab:CreateButton({
    Name = "[Teleport to Player📍]",
    Callback = function()
        --game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[TargetName].Character.HumanoidRootPart.CFrame
        teleportToPlayer(TargetName)
      end    
   })
 


local Toggle = PvpTab:CreateToggle({
    Name = "[Spectate👀]",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
if Value == true then
    game.Workspace.Camera.CameraSubject = game.Players[TargetName].Character:FindFirstChild("HumanoidRootPart")
elseif Value ~= true then
    game.Workspace.Camera.CameraSubject = LocalPlayer.Character.HumanoidRootPart 
    end
end,
 })

------\\MONEY TAB//------
local Button = MoneyTab:CreateButton({
	Name = "[Deposit Money]",
	Callback = function()
		local args = {
            [1] = "depo",
            [2] = "29000"
        }
        
        game:GetService("ReplicatedStorage").BankAction:FireServer(unpack(args))
        
	end,
})

local Button = MoneyTab:CreateButton({
	Name = "[Withdraw Money]",
	Callback = function()
		local args = {
            [1] = "with",
            [2] = "90000"
        }
        
        game:GetService("ReplicatedStorage").BankAction:FireServer(unpack(args))
        
	end,
})


-- Create the toggle control in your UI library
local Toggle = MoneyTab:CreateToggle({
    Name = "[Autofarm-Money]",
    CurrentValue = false,
    Flag = "AutofarmMoneyToggle", -- Make sure this flag is unique
    Callback = function(Value)
        _G.autofarmEnabled = Value
        if _G.autofarmEnabled then
            autofarm() -- Start autofarming when toggle is turned on
        end
    end,
})

local Toggle = PvpTab:CreateToggle({
    Name = "[Send Money]",
    CurrentValue = false,
    Flag = "SendMoneyToggle",
    Callback = function(Value)
        -- The function that takes place when the toggle is pressed
        -- The variable (Value) is a boolean on whether the toggle is true or false
        if Value then
            toggleLoop = true
            while toggleLoop do
                local selectedPlayer = TargetName -- Replace this with your method of getting the selected player
                local amountToSend = 9999 -- Change this to the desired amount
                SendMoneyToPlayer(selectedPlayer, amountToSend)
                wait(1) -- Wait for a certain amount of time before sending money again (in seconds)
            end
        else
            toggleLoop = false
        end
    end,
})

------\\ANNOY TOGGLE AND  FUNCTIONS//------
-- Declare the toggle variable at a scope accessible by both the function and the button callback
local toggleAttack = false

local function AttackCheckKnockPickUpAndTeleportFunction()
    local originalCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    while toggleAttack do -- Loop will continue as long as toggleAttack is true
        local playerToAttack = game.Players:FindFirstChild(TargetName)
        if playerToAttack then
            local targetPlayerCFrame = playerToAttack.Character.HumanoidRootPart.CFrame
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayerCFrame

            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Fist") or game.Players.LocalPlayer.Character:FindFirstChild("Fist")
            if tool then
                if not game.Players.LocalPlayer.Character:FindFirstChild(tool.Name) then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                end

                if playerToAttack.Character.Humanoid.Health > 30 then
                    tool.MeleeSystem.AttackEvent:FireServer(playerToAttack)
                end

                wait(0.1)

                if playerToAttack.Character.Humanoid.Health <= 10 then
                    local pickupArgs = {
                        [1] = playerToAttack
                    }
                    game:GetService("ReplicatedStorage").PickUpRemote:InvokeServer(unpack(pickupArgs))

                    wait(0.5)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
                    toggleAttack = false -- Turn off the toggle if the player is knocked
                end
            else
                break
            end
        else
            break
        end
        wait()
    end
end

-- Create a toggle button that turns the attack on or off when pressed
local AttackKnockPickupToggleButton = PvpTab:CreateToggle({
    Name = "[AutoKnock-Annoy👿]",
    Default = false,
    Callback = function(state)
        toggleAttack = state -- Update the toggle variable with the new state
        if toggleAttack then
            AttackCheckKnockPickUpAndTeleportFunction() -- Start the function if toggled on
        end
    end,
})

------\\AutoKill Button//------

-- Define the existing auto-kill functionality as a separate function
local function AutoKillFunction()
    local function CheckPlayerDeath(player)
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            return player.Character.Humanoid.Health <= 0
        end
        return false
    end

    -- Store the original position before teleporting and attacking
    local originalCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    local IsAttacking = true
    while IsAttacking do
        local playerToAttack = game.Players:FindFirstChild(TargetName)
        if playerToAttack then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Fist") or game.Players.LocalPlayer.Backpack:FindFirstChild("Fist"))
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid:TakeDamage(0) -- Reset Humanoid health to avoid crashing
            end
            game:GetService("Players").LocalPlayer.Character.Fist.MeleeSystem.AttackEvent:FireServer(playerToAttack)
            wait(0.1) -- Add a 0.1-second delay between each punch
        end

        local playerToTeleport = game.Players:FindFirstChild(TargetName)
        if playerToTeleport then
            local targetPlayerCFrame = playerToTeleport.Character.HumanoidRootPart.CFrame

            -- Teleport to the target player
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayerCFrame

            -- Check if the target player dies
            if CheckPlayerDeath(playerToTeleport) then
                -- Teleport back to the original position after killing the player
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
                IsAttacking = false -- Stop attacking when the target player dies
            else
                wait(0) -- Add a delay after each teleportation if the player is still alive
            end
        end
        
        wait() -- Rapidly perform both teleportation and auto-attack with adjusted delays
    end
end

-- Create a button that triggers the AutoKillFunction when pressed
local Button = PvpTab:CreateButton({
    Name = "[Kill-Player💀]",
    Callback = function()
        AutoKillFunction()
    end,
})

------\\BLATANT TAB//------
------\\Legit Hitbox//------

local Toggle = BlatantTab:CreateToggle({
    Name = "= [Legit-Hitbox] =",
    CurrentValue = false,
    Flag = "LegitHitbox", -- Unique flag for configuration saving
    Callback = function(Value)
        -- Function to toggle hitbox
        HitboxEnabled4 = Value
        applyHitboxStateToAllPlayers4() -- Apply hitbox state when toggle changes
    end,
})



------\\semi Legit hitbox//------
local Toggle = BlatantTab:CreateToggle({
    Name = "= [Semi-Legit-Hitbox] =",
    CurrentValue = false,
    Flag = "semiLegit", -- Flag to store toggle state
    Callback = function(Value)
        HitboxEnabled3 = Value -- Update HitboxEnabled based on the toggle value
        applyHitboxStateToAllPlayers3() -- Apply the new hitbox state to all players
    end,
})

------\\Rage Hitbox//------
local Toggle = BlatantTab:CreateToggle({
    Name = "= [Rage-Hitbox] =",
    CurrentValue = false,
    Flag = "rage hitbox", -- Flag to store toggle state
    Callback = function(Value)
        HitboxEnabled = Value -- Update HitboxEnabled based on the toggle value
        applyHitboxStateToAllPlayers() -- Apply the new hitbox state to all players
    end,
})


-- Register the keybind with your UI library
local Keybind = BlatantTab:CreateKeybind({
    Name = "Toggle Hitbox",
    CurrentKeybind = "X",
    HoldToInteract = false,
    Flag = "HitboxKeybind", -- Unique flag for the keybind
    Callback = toggleHitbox, -- Set the callback to the toggle function
})








------\\SPIN BOT//------
local Toggle = BlatantTab:CreateToggle({
    Name = "[Spin-Bot]",
    CurrentValue = false,
    Flag = "SpinBotToggle",
    Callback = function(Value)
        spinEnabled = Value
        adjustSpin()
    end,
})

local Slider = BlatantTab:CreateSlider({
    Name = "[Spin-Speed]",
    Range = {40, 500},
    Increment = 10,
    Suffix = "Speed",
    CurrentValue = 0,
    Flag = "SpinSpeedSlider",
    Callback = function(Value)
        spinSpeed = Value
        if spinEnabled then
            adjustSpin()
        end
    end,
})

------\\Visuals//------
loadstring(game:HttpGet("https://raw.githubusercontent.com/Iratethisname10/Code/main/espLibrary.lua"))()
local espLibrary = getgenv().espLibrary
espLibrary.Visuals.BoxSettings.Type = 2

local ESPToggle = VisTab:CreateToggle({
    Name = "Toggle ESP",
    CurrentValue = false,
    Flag = "ESPT", 
    Callback = function(Value)
        espLibrary.Settings.Enabled = Value
    end,
 })
local BoxToggle = VisTab:CreateToggle({
    Name = "Toggle Boxes",
    CurrentValue = false,
    Flag = "BOXT", 
    Callback = function(Value)
        espLibrary.Visuals.BoxSettings.Enabled = Value
    end,
 })
local VisibilitySlider = VisTab:CreateSlider({
    Name = "Visibility",
    Range = {0, 1},
    Increment = 0.01,
    Suffix = "%",
    CurrentValue = 1,
    Flag = "VisibilityS", 
    Callback = function(Value)
        espLibrary.Visuals.BoxSettings.Transparency = Value
    end,
 })
local ThicknessSlider = VisTab:CreateSlider({
    Name = "Thickness",
    Range = {1, 5},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 1,
    Flag = "ThicknessyS", 
    Callback = function(Value)
        espLibrary.Visuals.BoxSettings.Thickness = Value
    end,
 })
local FilledToggle = VisTab:CreateToggle({
    Name = "Filled Boxes",
    CurrentValue = false,
    Flag = "FilledT", 
    Callback = function(Value)
        espLibrary.Visuals.BoxSettings.Filled = Value
    end,
 })
local HBToggle = VisTab:CreateToggle({
    Name = "Health Bar",
    CurrentValue = false,
    Flag = "HBT", 
    Callback = function(Value)
        espLibrary.Visuals.HealthBarSettings.Enabled = Value
    end,
 })
local TextSection = VisTab:CreateSection("Text ESP")

local TextToggle = VisTab:CreateToggle({
    Name = "Text ESP",
    CurrentValue = false,
    Flag = "TextT", 
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.Enabled = Value
    end,
 })
local ColorPicker1 = VisTab:CreateColorPicker({
    Name = "Text Outline Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "TOC", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.OutlineColor = Value
    end,
})
local ColorPicker2 = VisTab:CreateColorPicker({
    Name = "Text Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "TC", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.TextColor = Value
    end,
})
local TOToggle = VisTab:CreateToggle({
    Name = "Text Outline",
    CurrentValue = true,
    Flag = "TOT", 
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.Outline = Value
    end,
 })
local SDToggle = VisTab:CreateToggle({
    Name = "Show Distance",
    CurrentValue = true,
    Flag = "SDT", 
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.DisplayDistance = Value
    end,
 })
local SNToggle = VisTab:CreateToggle({
    Name = "Show Name",
    CurrentValue = true,
    Flag = "SNT", 
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.DisplayName = Value
    end,
 })
local SHToggle = VisTab:CreateToggle({
    Name = "Show Health",
    CurrentValue = true,
    Flag = "SHT", 
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.DisplayHealth = Value
    end,
 })
local STToggle = VisTab:CreateToggle({
    Name = "Show Tool",
    CurrentValue = true,
    Flag = "STT", 
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.DisplayTool = Value
    end,
 })
local VisibilitySlider2 = VisTab:CreateSlider({
    Name = "Text Visibility",
    Range = {0, 1},
    Increment = 0.01,
    Suffix = "%",
    CurrentValue = 1,
    Flag = "VisibilityS2", 
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.TextTransparency = Value
    end,
 })
local SizeSlider = VisTab:CreateSlider({
    Name = "Size",
    Range = {10, 25},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 17,
    Flag = "SizeS", 
    Callback = function(Value)
        espLibrary.Visuals.ESPSettings.TextSize = Value
    end,
 })




------\\Misc//
local Toggle = MiscTab:CreateToggle({
    Name = "[No clip]",
    CurrentValue = false,
    Flag = "NoclipToggle", -- A unique flag identifier
    Callback = function(Value)
        if Value then
            enableNoclip()
        else
            disableNoclip()
        end
    end,
})



local Slider = MiscTab:CreateSlider({
	Name = "[Brightness Changer]",
	Range = {1, 1000},
	Increment = 10,
	Suffix = "Brightness",
	CurrentValue = 10,
	Flag = "Brightness Changer", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(V)
		local Lighting = game:GetService("Lighting")
          Lighting.Brightness = 1
          Lighting.OutdoorAmbient = Color3.fromRGB(V, V, V)

    		-- The variable (Value) is a number which correlates to the value the slider is currently at
	end,
})
















------\\TESTING DUMB STUFF//------


------\\TEST V2//------
local Button = ShopTab:CreateButton({
	Name = "[Buy Shiesty😷]",
	Callback = function()
		local args = {
            [1] = "Shiesty"
        }
         game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Taco🌮]",
	Callback = function()
		local args = {
            [1] = "Taco"
        }
         game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Pizza🍕]",
	Callback = function()
		local args = {
            [1] = "Pizza"
        }
         game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Green Apple Juice🍏]",
	Callback = function()
		local args = {
            [1] = "GreenAppleJuice"
        }
        
        game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Apple Juice🍎]",
	Callback = function()
		local args = {
            [1] = "AppleJuice"
        }
        
        game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Grape Juice🍇]",
	Callback = function()
		local args = {
            [1] = "GrapeJuice"
        }
        
        game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
        
        
	end,
})

local Button = ShopTab:CreateButton({
	Name = "[Buy Water💦]",
	Callback = function()
		local args = {
            [1] = "Water"
        }
        
        game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(unpack(args))
        
        
        
	end,
})





















------\\Locations//

local Button = LocationTab:CreateButton({
	Name = "[GunStore🔫]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1230.27, 262, -814.3)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Mask🎭]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-647.19, 255.03, -708.66)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Melee Shop🗡]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-912.69, 253.54, -1216.32)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Bank💰]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9241.35, 317.55, -1964.76)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Bank Vault💴]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9246.95, 317.57, -2100.68)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Studio🎤]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10886.88, 109.66, -1082.73)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Ice Box💎]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-613.21, 250.91, -1116.86)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Cardealer🚗]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-412.81, 254.03, -1221.86)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Rice Job🍲]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-452.23, 276.55, -356.68)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Job 1⚒]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1002.4, 253.06, -812.17)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Job 2⚒]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1461.54, 253, -594.8)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[New Job 3⚒]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1082.72, 253.61, -952.54)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Clothe Store👚]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-966.18, 253.76, -350.04)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Bed🛏]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1142.67, 259.32, -699.17)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hotel 1🛏]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10331.62, 102.31, -817.35)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hotel 2🛏]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-721.84, 268.64, -726.13)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hotel 3🛏]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-684.73, 253.78, -820.26)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Rent home🛏💰]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-728.14, 296.93, -906.89)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Rent home 2🛏💰]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1531.72, 373.91, -394.23)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hospital First Floor🦺]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1154.44, 253.64, -288.04)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hospital Gear Room🦺]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1209.21, 254.52, -252.8)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Hospital Up Stairs]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1174.97, 402.22, -253.16)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Safe spot 1🚧]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1060.78, 279.99, -768.66)

	end,
})

local Button = LocationTab:CreateButton({
	Name = "[Safe spot 2🚧]",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1112.55, -29.68, 9085)

	end,
})


Rayfield:LoadConfiguration()
elseif game.PlaceId == 12077443856 then
    -- https://www.roblox.com/games/12077443856/Cali-Shootout-PLAYSTATION-SUPPORT

    local scriptLoadAt = tick()
    warn('script started load')

    local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/ImEzyLol/uilib/main/jan.lua'))()
    local notif = loadstring(game:HttpGet('https://raw.githubusercontent.com/Iratethisname10/Code/main/aztup-ui/notifs.lua'))()

    local Maid = loadstring(game:HttpGet('https://raw.githubusercontent.com/Iratethisname10/Code/main/aztup-ui/maid.lua'))()
    local Util = loadstring(game:HttpGet('https://raw.githubusercontent.com/Iratethisname10/Code/main/aztup-ui/util.lua'))()

    local cloneref = cloneref or function(instance) return instance end

    local playersService = cloneref(game:GetService('Players'))
    local runService = cloneref(game:GetService('RunService'))
    local userInputService = cloneref(game:GetService('UserInputService'))
    local teleportService = cloneref(game:GetService('TeleportService'))
    local proximityPromptService = cloneref(game:GetService('ProximityPromptService'))
    local replicatedStorageService = cloneref(game:GetService('ReplicatedStorage'))
    local lightingService = cloneref(game:GetService('Lighting'))

    if not playersService.LocalPlayer then playersService:GetPropertyChangedSignal('LocalPlayer'):Wait() end
    local lplr = playersService.LocalPlayer

    library.gameName = 'cali shootout'
    library.title = string.format('Requisition | %s', library.gameName)

    local mouse = lplr:GetMouse()

    local vector2New = Vector2.new
    local vector3New = Vector3.new
    local vector3Zero = Vector3.zero
    local vector3One = Vector3.one
    local cframeNew = CFrame.new
    local cframeAngles = CFrame.Angles

    local function copyTable(t) -- lua.org
        local k = typeof(t)
        local c = {}

        if k == 'table' then
            for i, v in next, t, nil do
                c[copyTable(i)] = copyTable(v)
            end

            setmetatable(c, copyTable(getmetatable(t)))
        else
            c = t
        end

        return c
    end

    local maid = Maid.new()

    local locations = {
        ['gun shop'] = vector3New(-1633, 7, -92),
        ['bank'] = vector3New(-2369, 4, 115),
        ['night club'] = vector3New(-1195, 3, -75),
        ['car dealership'] = vector3New(-1415, 3, -128),
        ['armour'] = vector3New(-1616, 3, -546),
        ['casino'] = vector3New(-2417, 3, -660),
        ['cash register'] = vector3New(-1793, 4, -71),
        ['cali apartments'] = vector3New(-2442, 6, -292),
        ['mc donald\'s'] = vector3New(-1919, 4, -654),
        ['swipe'] = vector3New(-1539, 3, -322),
        ['weed area'] = vector3New(-2000, 3, 187),
        ['janitor job'] = vector3New(-1675, 4, 49),
        ['crate job'] = vector3New(-1947, 3, -39),
        ['bank dealer'] = vector3New(-1923, 3, 89)
    }

    local safeZones = workspace:WaitForChild('SafeZones', 100)
    local jobSystem = workspace:WaitForChild('Job System', 100)

    local gameRemotes = replicatedStorageService:WaitForChild('Remotes', 100)
    local gameEvents = replicatedStorageService:WaitForChild('Events', 100)
    local gameModules = replicatedStorageService:WaitForChild('Modules', 100)

    local events = {
        killed = gameEvents.Killed,
        changeTeam = replicatedStorageService.TeamChangeRequestEvent,
        ragdollVariableServer = lplr.PlayerGui.ragdoll.events.variableserver,
        codeRedeem = replicatedStorageService.codeEvent
    }

    local modules = {
        blurModule = require(gameModules.CreateBlur),
        cameraShakeModule = require(gameModules.CameraShaker),
        carModule = require(gameModules.Cars),
        smokeTrailModule = require(gameModules.SmokeTrail)
    }

    local gunsList = {}
    local unnecessaryTools = {'Phone', 'Mop', 'Laptop'}

    local comb = library:AddTab('Combat')
    local visu = library:AddTab('Visuals')
    local tele = library:AddTab('Teleports')
    local misc = library:AddTab('Miscellaneous')

    local comb1 = comb:AddColumn()
    local comb2 = comb:AddColumn()

    local visu1 = visu:AddColumn()
    local visu2 = visu:AddColumn()

    local tele1 = tele:AddColumn()
    local tele2 = tele:AddColumn()

    local misc1 = misc:AddColumn()
    local misc2 = misc:AddColumn()

    local aimbotSection = comb1:AddSection('Aim Bot')
    local antiAimSection = comb2:AddSection('Anti Aim')

    local boxEspSection = visu1:AddSection('Player ESP')
    local textEspSection = visu1:AddSection('Text ESP')
    local worldSection = visu2:AddSection('World Effects')
    local localPlayerSection = visu2:AddSection('Local Player')
    local clientSideSection = visu2:AddSection('Client Side')

    local mainTpSection = tele1:AddSection('Main')
    local playerTpSection = tele1:AddSection('Players')
    local locationsTpSection = tele1:AddSection('Locations')
    local settingsTpSection = tele2:AddSection('Settings')
    local utilityTpSection = tele2:AddSection('Utilities')

    local characterSection = misc1:AddSection('Character')
    local extrasSection = misc1:AddSection('Extras')
    local autoFarmSection = misc2:AddSection('Auto Farms')
    local gunModsSection = misc2:AddSection('Gun Modifications')
    local rageSection = misc2:AddSection('Rage')

    do -- combat
        do
            local aimbotFovCircle

            aimbotSection:AddToggle({
                text = 'Enabled',
                flag = 'Aim Bot',
                callback = function(t)
                    if t then
                        maid.aimbot = runService.RenderStepped:Connect(function()
                            local character = Util:getClosestCharacter({
                                useFOV = library.flags.aimBotTargetSelection == 'mouse',
                                aimbotFOV = library.flags.aimBotFieldOfView,
                                visibilityCheck = library.flags.aimBotVisibilityCheck,
                                maxHealth = library.flags.aimBotIgnoreUnAttackable and 200 or math.huge
                            })

                            if aimbotFovCircle then
                                aimbotFovCircle.Visible = library.flags.aimBotFOVCircle
                            end
                
                            character = character and character.Character
                            if not character then return end
                
                            local hit = character:FindFirstChild(library.flags.aimBotAimPart)
                            local hitPos = hit and hit.CFrame.Position
                    
                            local camera = workspace.CurrentCamera
                            if not camera then return end
                
                            local hitPosition2D, visible = camera:WorldToViewportPoint(hitPos)
                            if not visible then return end
                    
                            hitPosition2D = Vector2.new(hitPosition2D.X, hitPosition2D.Y)
                    
                            local mousePosition = userInputService:GetMouseLocation()
                            local final = (hitPosition2D - mousePosition) / library.flags.aimBotSmoothing

                            if library.flags.aimBotRequireMouseDown then
                                if not userInputService:IsMouseButtonPressed(library.flags.aimBotMouseButton == 'Left' and 0 or 1) then return end
                            end

                            if library.flags.aimBotAimMethod == 'mouse emulation' then
                                mousemoverel(final.X, final.Y)
                            else
                                camera.CFrame = camera.CFrame:lerp(cframeNew(camera.CFrame.Position, hitPos), 1 / library.flags.aimBotSmoothing)
                            end
                        end)
                    else
                        maid.aimbot = nil
                        if aimbotFovCircle then
                            aimbotFovCircle.Visible = false
                        end 
                    end
                end
            }):AddBind({
                flag = 'Aimbot Bind',
                callback = function()
                    library.options.aimBot:SetState(not library.flags.aimBot)
                end
            })

            aimbotSection:AddDivider()

            aimbotSection:AddList({
                text = 'Aim Part',
                flag = 'Aim Bot Aim Part',
                values = {'Head', 'HumanoidRootPart'},
                value = 'Head'
            })
            aimbotSection:AddList({
                text = 'Target Selection',
                flag = 'Aim Bot Target Selection',
                values = {'mouse', 'character'},
                value = 'mouse',
                callback = function(val)
                    if aimbotFovCircle then
                        aimbotFovCircle.Visible = val == 'mouse' and library.flags.aimBot
                    end
                end
            })
            aimbotSection:AddList({
                text = 'Aim Method',
                flag = 'Aim Bot Aim Method',
                values = {'game camera', 'mouse emulation'},
                value = 'game camera'
            })
            aimbotSection:AddSlider({
                text = 'Field Of View',
                flag = 'Aim Bot Field Of View',
                min = 10,
                max = 1000,
                callback = function(val)
                    if aimbotFovCircle then
                        aimbotFovCircle.Radius = val
                    end
                end
            })
            aimbotSection:AddSlider({
                text = 'Smoothing',
                flag = 'Aim Bot Smoothing',
                tip = 'setting value under 2 when using mouse emulation aim method might break',
                min = 1,
                max = 20,
                value = 5
            })
            aimbotSection:AddToggle({
                text = 'FOV Circle',
                flag = 'Aim Bot F O V Circle',
                callback = function(t)
                    if t then
                        aimbotFovCircle = library:Create('Circle', {
                            Transparency = 0.45,
                            NumSides = 500,
                            Filled = false,
                            Thickness = 1,
                            Visible = library.flags.aimBot and library.flags.aimBotTargetSelection == 'mouse',
                            Radius = library.flags.aimBotFieldOfView,
                            Position = workspace.CurrentCamera.ViewportSize / 2,
                            Color = library.flags.aimBotCircleColor
                        })
                    else
                        if aimbotFovCircle then
                            aimbotFovCircle:Destroy()
                            aimbotFovCircle = nil
                        end
                    end
                end
            }):AddColor({
                flag = 'Aim Bot Circle Color',
                tip = 'fov circle color'
            })
            aimbotSection:AddToggle({
                text = 'Visibility Check',
                flag = 'Aim Bot Visibility Check'
            })
            aimbotSection:AddToggle({
                text = 'Require Mouse Down',
                flag = 'Aim Bot Require Mouse Down'
            })
            aimbotSection:AddList({
                text = 'Mouse Button',
                values = {'Right', 'Left'},
                value = 'Right',
                flag = 'Aim Bot Mouse Button'
            })
            aimbotSection:AddToggle({
                text = 'Ignore Un Attackable',
                flag = 'Aim Bot Ignore Un Attackable'
            })
        end

        do
            local function toYRotation(cframe)
                local x, y, z = cframe:ToOrientation()
                return cframeNew(cframe.Position) * cframeAngles(0, y, 0)
            end

            local rotationAngle
            local antiAimFunctions = {
                shift = function()
                    rotationAngle = -math.atan2(workspace.CurrentCamera.CFrame.LookVector.Z, workspace.CurrentCamera.CFrame.LookVector.X) + math.rad(library.flags.antiAimAngle)
                end,
                random = function()
                    rotationAngle = -math.atan2(workspace.CurrentCamera.CFrame.LookVector.Z, workspace.CurrentCamera.CFrame.LookVector.X) + math.random(0, 360)
                end
            }

            antiAimSection:AddToggle({
                text = 'Enabled',
                flag = 'Anti Aim',
                callback = function(t)
                    if t then
                        maid.antiAim = runService.RenderStepped:Connect(function()
                            if not lplr.Character then return end
                            if not lplr.Character:FindFirstChild('Humanoid') then return end
                            if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end

                            lplr.Character.Humanoid.AutoRotate = false

                            antiAimFunctions[library.flags.antiAimMode]()

                            if library.flags.antiAimMode == 'shift' then
                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(lplr.Character.HumanoidRootPart.CFrame.Position) * cframeAngles(0, math.rad(library.flags.antiAimAngle) + math.rad((math.random(1, 2) == 1 and library.flags.antiAimSpeed or -library.flags.antiAimSpeed)), 0)
                            else
                                local newAngle = cframeNew(lplr.Character.HumanoidRootPart.CFrame.Position) * cframeAngles(0, rotationAngle + library.flags.antiAimAngle, 0)
                                lplr.Character.HumanoidRootPart.CFrame = toYRotation(newAngle)
                            end
                        end)
                    else
                        maid.antiAim = nil
                        maid.antiAimAnimStop = nil

                        if not lplr.Character then return end
                        if not lplr.Character:FindFirstChild('Humanoid') then return end

                        lplr.Character.Humanoid.AutoRotate = true
                    end
                end
            }):AddBind({
                flag = 'Anti Aim Bind',
                callback = function()
                    library.options.antiAim:SetState(not library.flags.antiAim)
                end
            })
            antiAimSection:AddSlider({
                text = 'Anti Aim Speed',
                min = 1,
                max = 1000,
                value = 130
            })
            antiAimSection:AddSlider({
                text = 'Anti Aim Angle',
                min = 0,
                max = 360
            })
            antiAimSection:AddList({
                text = 'Anti Aim Mode',
                values = {'shift', 'random'}
            })

            antiAimSection:AddDivider()

            local animation

            local animations = {
                ['sleep'] = 4689362868,
                ['Tilt'] = 3360692915,
                ['Salute'] = 3360689775,
                ['Applaud'] = 5915779043,
                ['Hero Landing'] = 5104377791,
                ['HIPMOTION - Amaarae'] = 16572756230,
                ['Mae Stephens - Piano Hands'] = 16553249658,
                ['Mini Kong'] = 17000058939,
                ['ericdoa - dance'] = 15698510244,
                ['Bored'] = 5230661597,
                ['V Pose - Tommy Hilfiger'] = 10214418283,
                ['Uprise - Tommy Hilfiger'] = 10275057230,
                ['Elton John - Piano Jump'] = 11453096488,
                ['Dolphin Dance'] = 5938365243,
                ['Quiet Waves'] = 7466046574,
                ['Frosty Flair - Tommy Hilfiger'] = 10214406616 -- spin
            }

            local anims = {}
            for animationName, animationID in next, animations do
                anims[#anims + 1] = animationName
            end

            local function addAnimation()
                repeat task.wait(); until lplr.Character and lplr.Character:FindFirstChild('Humanoid') or not library.flags.animationPlayer
                if animation then
                    animation:Stop()
                    animation.Animtion:Destroy()
                    animation = nil
                end
                local anim = Instance.new('Animation')
                local suc, id = pcall(function() return string.match(game:GetObjects('rbxassetid://'.. (library.flags.customAnimation and library.flags.customAnimationId or animations[library.flags.animation]))[1].AnimationId, '%?id=(%d+)') end)
                if not suc then id = library.flags.customAnimation and library.flags.customAnimationId or animations[library.flags.animation] end
                anim.AnimationId = 'rbxassetid://'.. id
                local suc, res = pcall(function() animation = lplr.Character.Humanoid.Animator:LoadAnimation(anim) end)
                if suc then
                    animation.Priority = Enum.AnimationPriority.Action4
                    animation.Looped = true
                    animation:AdjustSpeed(library.flags.animationSpeed)
                    animation:Play()
                    maid.antiAimAnimStop = animation.Stopped:Connect(function()
                        if library.flags.animationPlayer then
                            library.options.animationPlayer:SetState(not library.flags.animationPlayer)
                            library.options.animationPlayer:SetState(not library.flags.animationPlayer)
                        end
                    end)
                end
            end

            antiAimSection:AddToggle({
                text = 'Animation Player',
                callback = function(t)
                    if t then
                        addAnimation()
                        maid.antiAimAnimChar = lplr.CharacterAdded:Connect(addAnimation)
                    else
                        maid.antiAimAnimStop = nil
                        maid.antiAimAnimChar = nil
                        if animation then animation:Stop(); animation = nil end
                    end
                end
            }):AddBind({
                flag = 'Animation Player Bind',
                callback = function()
                    library.options.animationPlayer:SetState(not library.flags.animationPlayer)
                end
            })
            antiAimSection:AddList({
                text = 'Animation',
                values = anims,
                value = 'Sleep',
                callback = function()
                    if library.flags.animationPlayer then
                        library.options.animationPlayer:SetState(not library.flags.animationPlayer)
                        library.options.animationPlayer:SetState(not library.flags.animationPlayer)
                    end
                end
            })
            antiAimSection:AddToggle({text = 'Custom Animation'})
            antiAimSection:AddBox({text = 'Custom Animation Id'})
            antiAimSection:AddSlider({
                text = 'Animation Speed',
                min = 1,
                max = 100,
                value = 5
            })
        end
    end

    do -- visuals
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Iratethisname10/Code/main/espLibrary.lua"))()
        local espLibrary = getgenv().espLibrary
        espLibrary.Visuals.BoxSettings.Type = 2

        do
            boxEspSection:AddToggle({
                text = 'Enabled',
                flag = 'Player E S P',
                tip = 'this acts as a lock for all visual options on the left side',
                callback = function(t) espLibrary.Settings.Enabled = t end
            }):AddBind({
                flag = 'Player E S P Bind',
                callback = function()
                    library.options.playerESP:SetState(not library.flags.playerESP)
                end
            })

            boxEspSection:AddDivider()

            boxEspSection:AddToggle({
                text = 'Boxes',
                callback = function(t) espLibrary.Visuals.BoxSettings.Enabled = t end
            }):AddColor({
                flag = 'Boxes Color',
                callback = function(col) espLibrary.Visuals.BoxSettings.Color = col end
            })
            boxEspSection:AddSlider({
                text = 'Visibility',
                value = 1,
                min = 0,
                max = 1,
                float = 0.01,
                callback = function(val) espLibrary.Visuals.BoxSettings.Transparency = val end
            })
            boxEspSection:AddSlider({
                text = 'Thickness',
                min = 1,
                max = 5,
                callback = function(val) espLibrary.Visuals.BoxSettings.Thickness = val end
            })
            boxEspSection:AddToggle({
                text = 'Filled',
                callback = function(t) espLibrary.Visuals.BoxSettings.Filled = t end
            })
            boxEspSection:AddToggle({
                text = 'Health Bar',
                callback = function(t) espLibrary.Visuals.HealthBarSettings.Enabled = t end
            })
        end

        do
            textEspSection:AddToggle({
                text = 'Text',
                callback = function(t) espLibrary.Visuals.ESPSettings.Enabled = t end
            }):AddColor({
                tip = 'text outline color',
                color = Color3.fromRGB(0, 0, 0),
                callback = function(col) espLibrary.Visuals.ESPSettings.OutlineColor = col end
            }):AddColor({
                tip = 'text color',
                callback = function(col) espLibrary.Visuals.ESPSettings.TextColor = col end
            })
            textEspSection:AddToggle({
                text = 'Text Outline',
                state = true,
                callback = function(t) espLibrary.Visuals.ESPSettings.Outline = t end
            })
            textEspSection:AddToggle({
                text = 'Show Distance',
                callback = function(t) espLibrary.Visuals.ESPSettings.DisplayDistance = t end
            })
            textEspSection:AddToggle({
                text = 'Show Name',
                state = true,
                callback = function(t) espLibrary.Visuals.ESPSettings.DisplayName = t end
            })
            textEspSection:AddToggle({
                text = 'Show Health',
                state = true,
                callback = function(t) espLibrary.Visuals.ESPSettings.DisplayHealth = t end
            })
            textEspSection:AddToggle({
                text = 'Show Tool',
                state = true,
                callback = function(t) espLibrary.Visuals.ESPSettings.DisplayTool = t end
            })
            textEspSection:AddSlider({
                text = 'Visibility',
                flag = 'text E S P Visibility',
                value = 1,
                min = 0,
                max = 1,
                float = 0.01,
                callback = function(val) espLibrary.Visuals.ESPSettings.TextTransparency = val end
            })
            textEspSection:AddSlider({
                text = 'Size',
                min = 10,
                max = 25,
                value = 17,
                callback = function(val) espLibrary.Visuals.ESPSettings.TextSize = val end
            })
        end

        do
            do
                local oldBritghtness, oldAmbient

                worldSection:AddToggle({
                    text = 'Full Bright',
                    callback = function(t)
                        if t then
                            oldBritghtness, oldAmbient = lightingService.Brightness, lightingService.Ambient

                            maid.fullBright = lightingService:GetPropertyChangedSignal('Ambient'):Connect(function()
                                lightingService.Ambient = Color3.fromRGB(255, 255, 255)
                                lightingService.Brightness = 3.5
                            end)
                            lightingService.Ambient = Color3.fromRGB(255, 255, 255)
                        else
                            maid.fullBright = nil
                            if oldAmbient and oldBritghtness then
                                lightingService.Brightness, lightingService.Ambient = oldBritghtness, oldAmbient
                            end
                        end
                    end
                })

                local oldTime

                worldSection:AddToggle({
                    text = 'Cutom Time',
                    callback = function(t)
                        if t then
                            oldTime = lightingService.ClockTime

                            maid.customTime = runService.RenderStepped:Connect(function()
                                lightingService.ClockTime = library.flags.customTimeValue
                            end)
                            lightingService.ClockTime = library.flags.customTimeValue
                        else
                            maid.customTime = nil
                            if oldTime then lightingService.ClockTime = oldTime end
                        end
                    end
                })
                worldSection:AddSlider({
                    text = 'Custom Time Value',
                    textpos = 2,
                    min = 0,
                    max = 23.9,
                    value = 12.0,
                    float = 0.1
                })
            end
            worldSection:AddToggle({
                text = 'No Hurt Cam',
                callback = function(t)
                    if t then
                        maid.noHurtCam = runService.Stepped:Connect(function()
                            for i, v in next, lplr.PlayerGui["Damage GUI"]:GetChildren() do
                                if v:IsA('ImageLabel') then
                                    v.Visible = false
                                end
                            end
                        end)
                    else
                        maid.noHurtCam = nil
                    end
                end
            })
            worldSection:AddToggle({
                text = 'Better Hurt Cam',
                callback = function(t) lplr.PlayerGui["Damage GUI"].IgnoreGuiInset = t end
            })
        end

        do
            local materials = {}
            for i, v in next, Enum.Material:GetEnumItems() do
                table.insert(materials, v.Name)
            end

            local oldData = {}
            local processing = false

            local function changeCharacterMaterial()
                repeat task.wait() until not processing
                repeat task.wait() until lplr.Character or not library.flags.materialChams
                for i, v in next, lplr.Character:GetDescendants() do
                    processing = true
                    if v:IsA('BasePart') and v.Name ~= 'HumanoidRootPart' then
                        processing = true
                        oldData[v] = {material = v.Material, color = v.Color, trans = v.Transparency}
                        v.Material = library.flags.materialChamsMaterial
                        v.Color = library.flags.materialChamsColor
                        v.Transparency = library.flags.materialChamsTransparency
                    end
                    processing = false
                end
            end

            localPlayerSection:AddToggle({
                text = 'Material Chams',
                callback = function(t)
                    if t then
                        changeCharacterMaterial()
                        maid.materialChamsChar = lplr.CharacterAdded:Connect(function()
                            task.wait(0.2)
                            changeCharacterMaterial()
                        end)
                    else
                        maid.materialChamsChar = nil
                        if not lplr.Character then return end
                        processing = true
                        for i, v in next, lplr.Character:GetDescendants() do
                            if oldData[v] then v.Transparency = oldData[v].trans end
                            if oldData[v] then v.Color = oldData[v].color end
                            if oldData[v] then v.Material = oldData[v].material end
                        end
                        processing = false
                    end
                end
            }):AddColor({
                flag = 'Material Chams Color'
            })
            localPlayerSection:AddList({
                flag = 'Material Chams Material',
                values = materials,
                value = 'ForceField'
            })
            localPlayerSection:AddSlider({
                text = 'Transparency',
                flag = 'Material Chams Transparency',
                min = 0,
                max = 1,
                float = 0.01
            })
        end
    end

    do -- teleports
        local rayParams = RaycastParams.new()
        rayParams.RespectCanCollide = true
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        rayParams.FilterDescendantsInstances = {workspace.CurrentCamera, lplr.Character}

        local teleporting = false
        local function teleport(position)
            if teleporting then return end
            if not lplr.Character then return end
            if not lplr.Character:FindFirstChild('Humanoid') then return end
            if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end

            teleporting = true

            task.delay(not library.flags.safeLoad and library.flags.timeout or 35, function()
                teleporting = false
                lplr.Character.HumanoidRootPart.Anchored = false
            end)

            if lplr.Character.Humanoid.SeatPart then
                if library.flags.holdWhenSitting then teleporting = false return end
                lplr.Character.Humanoid.Sit = false
                task.wait()
            end

            if library.flags.safeLoad then
                lplr.Character.HumanoidRootPart.Anchored = true
            end

            lplr.Character.HumanoidRootPart.CFrame = cframeNew(position)
            lplr.Character.HumanoidRootPart.AssemblyLinearVelocity = vector3Zero
            lplr.Character.HumanoidRootPart.AssemblyAngularVelocity = vector3Zero

            if library.flags.safeLoad then
                repeat
                    local ray = workspace:Raycast(lplr.Character.HumanoidRootPart.CFrame.Position, Vector3.new(0, -150, 0), rayParams)
                    task.wait()
                until ray and ray.Instance

                lplr.Character.HumanoidRootPart.Anchored = false
            end
            
            teleporting = false
        end

        do
            mainTpSection:AddToggle({
                text = 'Click Teleport',
                callback = function(t)
                    if t then
                        if not mouse then return end
                        maid.clickTP = mouse.Button1Down:Connect(function()
                            local hitPoint = mouse.Hit.Position + vector3New(0, 4, 0)
                            teleport(hitPoint)
                        end)
                    else
                        maid.clickTP = nil
                    end
                end
            }):AddBind({
                flag = 'Click Teleport Bind',
                callback = function()
                    library.options.clickTeleport:SetState(not library.flags.clickTeleport)
                end
            })
        end

        do
            playerTpSection:AddList({
                flag = 'Players',
                playerOnly = true,
                skipflag = true
            })

            playerTpSection:AddButton({
                text = 'Teleport to player',
                callback = function()
                    local player = playersService[library.flags.players.Name].Character
                    if not player:FindFirstChild('HumanoidRootPart') then return end

                    teleport(player.HumanoidRootPart.CFrame.Position)
                end
            }):AddBind({
                flag = 'Player Tp Bind',
                callback = library.options.teleportToPlayer.callback
            })
        end

        do
            local list = {}
            for location, position in next, locations do
                list[#list + 1] = location
            end

            locationsTpSection:AddList({
                flag = 'Teleport Locations',
                values = list,
                skipflag = true,
                noload = true
            })

            locationsTpSection:AddButton({
                text = 'Teleport to location',
                callback = function() teleport(locations[library.flags.teleportLocations]) end
            }):AddBind({
                flag = 'Location Tp Bind',
                callback = library.options.teleportToLocation.callback
            })
        end

        do
            settingsTpSection:AddSlider({
                text = 'Timeout',
                tip = 'how long before the teleport times out and breaks out of loops',
                min = 5,
                max = 10,
                value = 5
            })
            settingsTpSection:AddToggle({
                text = 'Safe Load',
                tip = 'make sures the floor loads before leting you stand on it'
            })
            settingsTpSection:AddToggle({
                text = 'Hold When Sitting',
                tip = 'does not let you teleport if you are sitting'
            })
        end

        do
            local constants = {
                ['Refill Ammo'] = vector3New(-1626, 4, -98),
                ['Get Armour'] = vector3New(-1615, 3, -548),
                ['Uzi'] = vector3New(-1642, 4, -84),
                ['Draco'] = vector3New(-1638, 4, -87),
                ['AR Pistol'] = vector3New(-1630, 4, -79),
                ['M4A1'] = vector3New(-1633, 4, -76),
                ['Micro AR Pistol'] = vector3New(-1637, 4, -74),
                ['Glock 17'] = vector3New(-1641, 4, -93),
                ['Ruger'] = vector3New(-1637, 4, -96)
            }

            local function getItem(itemName, actionText, cost)
                if lplr.stats.Money.Value < cost then
                    local moreDollars = tonumber(cost - lplr.stats.Money.Value)
                    return notif.new({text = `you need ${moreDollars} more to buy: {itemName}`, duration = 10})
                end

                local previousPosition = lplr.Character.HumanoidRootPart.CFrame.Position
                teleport(constants[itemName])
                task.wait(0.1)
                for i, v in next, workspace:GetDescendants() do
                    if v:IsA('ProximityPrompt') and v.ActionText == actionText then
                        fireproximityprompt(v)
                    end
                end
                task.wait(0.1)
                teleport(previousPosition)
            end

            utilityTpSection:AddButton({
                text = 'Refill Ammo',
                callback = function()
                    local previousPosition = lplr.Character.HumanoidRootPart.CFrame.Position
                    teleport(constants['Refill Ammo'])
                    task.wait(0.1)
                    for i, v in next, workspace:GetDescendants() do
                        if v:IsA('ProximityPrompt') and v.Parent.Parent.Name == 'AmmoBox (Unlimited Use)' then
                            fireproximityprompt(v)
                        end
                    end
                    task.wait(0.1)
                    teleport(previousPosition)
                end
            })
            utilityTpSection:AddButton({
                text = 'Get Armour',
                callback = function()
                    local previousPosition = lplr.Character.HumanoidRootPart.CFrame.Position
                    teleport(constants['Get Armour'])
                    task.wait(0.1)
                    for i, v in next, workspace:GetDescendants() do
                        if v:IsA('ProximityPrompt') and v.Parent.CFrame.Position == vector3New(-1614.6724853515625, 4.4449944496154785, -549.386962890625) then
                            fireproximityprompt(v)
                        end
                    end
                    task.wait(0.1)
                    teleport(previousPosition)
                end
            })

            utilityTpSection:AddLabel('\nWeapons')

            -- // getItem Params: 1 = constant table index, 2 = proximity prompt Action Text, 3 = cost
            utilityTpSection:AddButton({
                text = 'Ruger - 900',
                callback = function() getItem('Ruger', 'Buy Ruger for $900', 900) end
            })
            utilityTpSection:AddButton({
                text = 'Glock 17 - 1000',
                callback = function() getItem('Glock 17', 'Buy Glock 17 for $1000', 1000) end
            })
            utilityTpSection:AddButton({
                text = 'Buy Uzi - 2000',
                callback = function() getItem('Uzi', 'Buy Uzi for $2000', 2000) end
            })
            utilityTpSection:AddButton({
                text = 'Buy Draco - 2500',
                callback = function() getItem('Draco', 'Buy Draco for $2500', 2500) end
            })
            utilityTpSection:AddButton({
                text = 'Buy M4A1 - 3000',
                callback = function() getItem('M4A1', 'Buy M4A1 for $3000', 3000) end
            })
            utilityTpSection:AddButton({
                text = 'Buy AR Pistol - 4000',
                callback = function() getItem('AR Pistol', 'Buy AR Pistol for $4000', 4000) end
            })
            utilityTpSection:AddButton({
                text = 'Buy Micro AR Pistol - 4000',
                callback = function() getItem('Micro AR Pistol', 'Buy Micro AR Pistol for $4000', 4000) end
            })
        end
    end

    do -- misc
        do
            do
                characterSection:AddToggle({
                    text = 'Speed',
                    callback = function(t)
                        if t then
                            maid.speedLoop = runService.Heartbeat:Connect(function(delta)
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end

                                lplr.Character.HumanoidRootPart.AssemblyLinearVelocity *= vector3New(0, 1, 0)

                                local vector = lplr.Character.Humanoid.MoveDirection
                                lplr.Character.HumanoidRootPart.CFrame += vector3New(vector.X * library.flags.speedValue * delta, 0, vector.Z * library.flags.speedValue * delta)
                            end)
                        else
                            lplr.Character.HumanoidRootPart.AssemblyLinearVelocity = vector3Zero
                            maid.speedLoop = nil
                        end
                    end
                }):AddBind({
                    flag = 'Speed Bind',
                    callback = function()
                        library.options.speed:SetState(not library.flags.speed)
                    end
                })
                characterSection:AddSlider({
                    text = 'Speed Value',
                    textpos = 2,
                    min = 1,
                    max = 500
                })

                local flyVertical = 0
                local flyBV

                characterSection:AddToggle({
                    text = 'Fly',
                    callback = function(t)
                        if t then
                            maid.flyLoop = runService.Heartbeat:Connect(function(delta)
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end

                                if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                                    flyVertical = library.flags.flyVerticalValue
                                elseif userInputService:IsKeyDown(Enum.KeyCode.LeftShift) or userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                                    flyVertical = -library.flags.flyVerticalValue
                                else
                                    flyVertical = 0
                                end

                                if lplr.Character.Humanoid.SeatPart then lplr.Character.Humanoid.Sit = false end
                                lplr.Character.HumanoidRootPart.AssemblyLinearVelocity = vector3Zero
                                local vector = lplr.Character.Humanoid.MoveDirection

                                flyBV = flyBV or Instance.new('BodyVelocity', lplr.Character.HumanoidRootPart)
                                flyBV.MaxForce = vector3One * math.huge
                                flyBV.Velocity = vector3New(vector.X * library.flags.flyHorizontalValue * delta, flyVertical * delta, vector.Z * library.flags.flyHorizontalValue * delta)
                                
                                lplr.Character.HumanoidRootPart.CFrame += vector3New(vector.X * library.flags.flyHorizontalValue * delta, flyVertical * delta, vector.Z * library.flags.flyHorizontalValue * delta)
                            end)
                        else
                            maid.flyLoop = nil
                            if flyBV then flyBV:Destroy(); flyBV = nil end
                        end
                    end
                }):AddBind({
                    flag = 'Fly Bind',
                    callback = function()
                        library.options.fly:SetState(not library.flags.fly)
                    end
                })
                characterSection:AddSlider({
                    text = 'Fly Horizontal Value',
                    textpos = 2,
                    min = 1,
                    max = 500,
                    value = 100
                })
                characterSection:AddSlider({
                    text = 'Fly Vertical Value',
                    textpos = 2,
                    min = 1,
                    max = 500,
                    value = 200
                })

                characterSection:AddToggle({
                    text = 'High Jump',
                    callback = function(t)
                        if t then
                            maid.highJumpLoop = runService.Heartbeat:Connect(function()
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                
                                lplr.Character.Humanoid.UseJumpPower = true
                                lplr.Character.Humanoid.JumpPower = library.flags.jumpPower
                            end)
                        else
                            maid.highJumpLoop = nil

                            if not lplr.Character then return end
                            if not lplr.Character:FindFirstChild('Humanoid') then return end
                            lplr.Character.Humanoid.JumpPower = 50.145
                            lplr.Character.Humanoid.UseJumpPower = false
                        end
                    end
                }):AddBind({
                    flag = 'High Jump Bind',
                    callback = function()
                        library.options.highJump:SetState(not library.flags.highJump)
                    end
                })
                characterSection:AddSlider({
                    text = 'Jump Power',
                    textpos = 2,
                    min = 50,
                    max = 500,
                    value = 100
                })
            end

            do
                characterSection:AddToggle({
                    text = 'Inf Jump',
                    callback = function(t)
                        if t then
                            maid.infJump = runService.Heartbeat:Connect(function()
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end

                                if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                                    local velocity = lplr.Character.HumanoidRootPart.AssemblyLinearVelocity
                                    lplr.Character.HumanoidRootPart.AssemblyLinearVelocity = vector3New(velocity.X, lplr.Character.Humanoid.JumpPower, velocity.Z)
                                end
                            end)
                        else
                            maid.infJump = nil
                        end
                    end
                }):AddBind({
                    flag = 'Inf Jump Bind',
                    callback = function()
                        library.options.infJump:SetState(not library.flags.infJump)
                    end
                })

                characterSection:AddToggle({
                    text = 'No Clip',
                    callback = function(t)
                        if t then
                            maid.noClip = runService.Stepped:Connect(function()
                                if not lplr.Character then return end

                                for _, v in next, lplr.Character:GetDescendants() do
                                    if v:IsA('BasePart') then
                                        v.CanCollide = false
                                    end
                                end
                            end)
                        else
                            maid.noClip = nil

                            if not lplr.Character then return end
                            if not lplr.Character:WaitForChild('Humanoid') then return end

                            if lplr.Character.Humanoid.SeatPart then return end

                            lplr.Character.Humanoid:ChangeState('Physics')
                            task.wait()
                            lplr.Character.Humanoid:ChangeState('RunningNoPhysics')
                        end
                    end
                }):AddBind({
                    flag = 'No Clip Bind',
                    callback = function()
                        library.options.noClip:SetState(not library.flags.noClip)
                    end
                })

                characterSection:AddToggle({
                    text = 'Auto Sprint',
                    callback = function(t)
                        if t then
                            maid.autoSprintLoop = runService.Heartbeat:Connect(function()
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                if not lplr.Character.Humanoid:FindFirstChild('Animator') then return end

                                maid.autoSprintSpeedChanged = lplr.Character.Humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(function()
                                    lplr.Character.Humanoid.WalkSpeed = 20
                                end)
                                lplr.Character.Humanoid.WalkSpeed = 20
                            end)
                        else
                            if var10 then var10:Stop(0.2) end
                            maid.autoSprintSpeedChanged = nil
                            maid.autoSprintLoop = nil
                            lplr.Character.Humanoid.WalkSpeed = 10
                        end
                    end
                }):AddBind({
                    flag = 'Auto Spring Bind',
                    callback = function()
                        library.options.autoSprint:SetState(not library.flags.autoSprint)
                    end
                })
            end

            do
                local oldCframe
                local oldSize
                local part
                
                characterSection:AddToggle({
                    text = 'GodMode',
                    callback = function(t)
                        if t then
                            repeat
                                for _, v in next, safeZones:GetChildren() do
                                    if v.Name == 'safeZoneArea' and v:IsA('BasePart') then
                                        part = v
                                        break
                                    end
                                end
                                task.wait()
                            until part
                            oldCframe = part.CFrame
                            oldSize = part.Size
            
                            maid.godmodeLoop = runService.RenderStepped:Connect(function()
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end
                                if not part then return end
            
                                part.Size = vector3One * 2040
                                part.CFrame = lplr.Character.HumanoidRootPart.CFrame
                            end)
                        else
                            maid.godmodeLoop = nil
                            if part and oldCframe and oldSize then
                                part.CFrame = oldCframe
                                part.Size = oldSize
                            end
                        end
                    end
                }):AddBind({
                    flag = 'Godmode Bind',
                    callback = function()
                        library.options.godmode:SetState(not library.flags.godmode)
                    end
                })
            end

            do
                local clonesuccess = false
                local disabledproper = true
                local oldcloneroot
                local cloned
                local clone
                local bodyvelo

                local overlap = OverlapParams.new()
                overlap.MaxParts = 9e9
                overlap.FilterDescendantsInstances = {}
                overlap.RespectCanCollide = true

                characterSection:AddToggle({ -- vape infinite fly LOL
                    text = 'Invisibility',
                    callback = function(t)
                        if t then
                            clonesuccess = false
                            if lplr.Character and lplr.Character:FindFirstChild('Humanoid') and lplr.Character.Humanoid.Health > 0 then
                                cloned = lplr.Character
                                oldcloneroot = lplr.Character.HumanoidRootPart
                                if not lplr.Character.Parent then library.flags.testInvisibility:SetState(false); return end
                                lplr.Character.Parent = game
                                clone = oldcloneroot:Clone()
                                clone.Parent = lplr.Character
                                oldcloneroot.Parent = workspace.CurrentCamera
                                clone.CFrame = oldcloneroot.CFrame
                                lplr.Character.PrimaryPart = clone
                                lplr.Character.Parent = workspace
                                for i,v in pairs(lplr.Character:GetDescendants()) do
                                    if v:IsA("Weld") or v:IsA("Motor6D") then
                                        if v.Part0 == oldcloneroot then v.Part0 = clone end
                                        if v.Part1 == oldcloneroot then v.Part1 = clone end
                                    end
                                    if v:IsA("BodyVelocity") then
                                        v:Destroy()
                                    end
                                end
                                for i,v in pairs(oldcloneroot:GetChildren()) do
                                    if v:IsA("BodyVelocity") then
                                        v:Destroy()
                                    end
                                end
                                if hip then
                                    lplr.Character.Humanoid.HipHeight = hip
                                end
                                hip = lplr.Character.Humanoid.HipHeight
                                clonesuccess = true
                            end
                            if not clonesuccess then
                                notif.new({text = 'invis: an error occurred', duration = 5})
                                library.flags.testInvisibility:SetState(false)
                                return
                            end
                            local goneup = false
                            maid.invis = runService.Heartbeat:Connect(function(delta)
                                local components = {oldcloneroot.CFrame:GetComponents()}
                                components[1] = clone.CFrame.X
                                if components[2] < 1000 or not goneup then
                                    components[2] = 100000
                                    goneup = true
                                end
                                components[3] = clone.CFrame.Z
                                oldcloneroot.CFrame = CFrame.new(unpack(components))
                                oldcloneroot.Velocity = Vector3.new(clone.Velocity.X, oldcloneroot.Velocity.Y, clone.Velocity.Z)
                            end)
                        else
                            maid.invis = nil
                            if clonesuccess and oldcloneroot and clone and lplr.Character.Parent == workspace and oldcloneroot.Parent ~= nil and disabledproper and cloned == lplr.Character then
                                local rayparams = RaycastParams.new()
                                rayparams.FilterDescendantsInstances = {lplr.Character, workspace.CurrentCamera}
                                rayparams.RespectCanCollide = true
                                local ray = workspace:Raycast(Vector3.new(oldcloneroot.Position.X, clone.CFrame.p.Y, oldcloneroot.Position.Z), Vector3.new(0, -1000, 0), rayparams)
                                local origcf = {clone.CFrame:GetComponents()}
                                origcf[1] = oldcloneroot.Position.X
                                origcf[2] = ray and ray.Position.Y + (lplr.Character.Humanoid.HipHeight + (oldcloneroot.Size.Y / 2)) or clone.CFrame.p.Y
                                origcf[3] = oldcloneroot.Position.Z
                                oldcloneroot.CanCollide = true
                                bodyvelo = Instance.new("BodyVelocity")
                                bodyvelo.MaxForce = Vector3.new(0, 9e9, 0)
                                bodyvelo.Velocity = Vector3.new(0, -1, 0)
                                bodyvelo.Parent = oldcloneroot
                                oldcloneroot.Velocity = Vector3.new(clone.Velocity.X, -1, clone.Velocity.Z)
                                
                                maid.disableInvis = runService.Heartbeat:Connect(function(delta)
                                    if oldcloneroot then
                                        oldcloneroot.Velocity = Vector3.new(clone.Velocity.X, -1, clone.Velocity.Z)
                                        local bruh = {clone.CFrame:GetComponents()}
                                        bruh[2] = oldcloneroot.CFrame.Y
                                        local newcf = CFrame.new(unpack(bruh))
                                        overlap.FilterDescendantsInstances = {lplr.Character, workspace.CurrentCamera}
                                        local allowed = true
                                        for i,v in pairs(workspace:GetPartBoundsInRadius(newcf.p, 2, overlap)) do
                                            if (v.Position.Y + (v.Size.Y / 2)) > (newcf.p.Y + 0.5) then
                                                allowed = false
                                                break
                                            end
                                        end
                                        if allowed then
                                            oldcloneroot.CFrame = newcf
                                        end
                                    end
                                end)

                                oldcloneroot.CFrame = CFrame.new(unpack(origcf))
                                lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
                                disabledproper = false
                                
                                if bodyvelo then bodyvelo:Destroy() end
                                maid.disableInvis = nil
                                disabledproper = true
                                if not oldcloneroot or not oldcloneroot.Parent then return end
                                lplr.Character.Parent = game
                                oldcloneroot.Parent = lplr.Character
                                lplr.Character.PrimaryPart = oldcloneroot
                                lplr.Character.Parent = workspace
                                oldcloneroot.CanCollide = true
                                for i,v in pairs(lplr.Character:GetDescendants()) do
                                    if v:IsA("Weld") or v:IsA("Motor6D") then
                                        if v.Part0 == clone then v.Part0 = oldcloneroot end
                                        if v.Part1 == clone then v.Part1 = oldcloneroot end
                                    end
                                    if v:IsA("BodyVelocity") then
                                        v:Destroy()
                                    end
                                end
                                for i,v in pairs(oldcloneroot:GetChildren()) do
                                    if v:IsA("BodyVelocity") then
                                        v:Destroy()
                                    end
                                end
                                local oldclonepos = clone.Position.Y
                                if clone then
                                    clone:Destroy()
                                    clone = nil
                                end
                                lplr.Character.Humanoid.HipHeight = hip or 2
                                local origcf = {oldcloneroot.CFrame:GetComponents()}
                                origcf[2] = oldclonepos
                                oldcloneroot.CFrame = CFrame.new(unpack(origcf))
                                oldcloneroot = nil
                            end
                        end
                    end
                }):AddBind({
                    flag = 'Invisibility Bind',
                    callback = function()
                        library.options.invisibility:SetState(not library.flags.invisibility)
                    end
                })
            end
            
            do
                local function disableRagdoll()
                    task.wait(0.2)
                    if not lplr.Character then return end
                    if not lplr.Character:FindFirstChild('RagdollConstraints') then return end

                    for i, v in next, lplr.Character.RagdollConstraints:GetChildren() do
                        if v:IsA('HingeConstraint') or v:IsA('BallSocketConstraint') then
                            task.spawn(function() v.Enabled = false end)
                        end
                    end
                end

                characterSection:AddToggle({
                    text = 'Anti Ragdoll',
                    callback = function(t)
                        repeat
                            events.ragdollVariableServer:FireServer('ragdoll', false)
                            task.wait()
                        until not library.flags.antiRagdoll
                    end
                }):AddBind({
                    flag = 'Anti Ragdoll Bind',
                    callback = function()
                        library.options.antiRagdoll:SetState(not library.flags.antiRagdoll)
                    end
                })
            end
        end

        do
            
            extrasSection:AddToggle({
                text = 'Equip All Tools',
                tip = 'un-toggling this will un-equip your tools',
                callback = function(t)
                    if t then
                        if not lplr.Character then return end
                        if not lplr.Character:FindFirstChild('Humanoid') then return end
                        
                        lplr.Character.Humanoid:UnequipTools()
                        task.wait()
                        for i, v in next, lplr.Backpack:GetChildren() do
                            if not v:IsA('Tool') then continue end
                            if not table.find(gunsList, v.Name) then continue end

                            task.spawn(function()
                                v.Parent = lplr.Character
                            end)
                        end
                    else
                        if not lplr.Character then return end
                        if not lplr.Character:FindFirstChild('Humanoid') then return end

                        lplr.Character.Humanoid:UnequipTools()
                    end
                end
            }):AddBind({
                flag = 'Equip All Tools Bind',
                callback = function()
                    library.options.equipAllTools:SetState(not library.flags.equipAllTools)
                end
            })

            extrasSection:AddToggle({
                text = 'Instant Interact',
                callback = function(t)
                    if t then
                        maid.instantInteract = proximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
                            fireproximityprompt(prompt)
                        end)
                    else
                        maid.instantInteract = nil
                    end
                end
            })

            do
                local function destroyTools()
                    if not lplr.Character then return end

                    for i, v in next, lplr.Backpack:GetChildren() do
                        if not v:IsA('Tool') then continue end
                        if not table.find(unnecessaryTools, v.Name) then continue end
                        
                        v:Destroy()
                    end
                    for i, v in next, lplr.Character:GetChildren() do
                        if not v:IsA('Tool') then continue end
                        if not table.find(unnecessaryTools, v.Name) then continue end

                        v.Parent = workspace
                    end
                end

                extrasSection:AddToggle({
                    text = 'Drop Unnecessary Tools',
                    callback = function(t)
                        if t then
                            task.spawn(function()
                                repeat
                                    destroyTools()
                                    task.wait(2)
                                until not library.flags.dropUnnecessaryTools
                            end)
                        end
                    end
                })
            end

            do
                local oldBlurFunction = modules.blurModule.Create
                local oldSmokEmmitFunction = modules.smokeTrailModule.EmitSmokeTrail

                extrasSection:AddToggle({
                    text = 'No Gun Blur',
                    callback = function(t)
                        modules.blurModule.Create = t and function() end or oldBlurFunction
                    end
                })

                extrasSection:AddToggle({
                    text = 'No Smoke Trail',
                    callback = function(t)
                        modules.smokeTrailModule.EmitSmokeTrail = t and function() end or oldSmokEmmitFunction
                    end
                })
            end

            do
                local chatRemote = replicatedStorageService:WaitForChild('DefaultChatSystemChatEvents', 10):WaitForChild('SayMessageRequest', 10)

                local killSayList = {
                    '<player> just died the same way as those requisition users',
                    '<player>, maybe buy Requisition??/k9ryKMbJ5m',
                    '<player> would not have died if he used Requisition: /k9ryKMbJ5m',
                    '<player> might be tempted to get scripts to spin back at me, but the truth is, he cannot',
                    'Requisition on top | k9ryKMbJ5m',
                    'BUY Requisition NOW: /k9ryKMbJ5m',
                    '<player> should buy Requisition now: /k9ryKMbJ5m'
                }

                extrasSection:AddToggle({
                    text = 'Kill Say',
                    callback = function(t)
                        if t then
                            maid.killSay = events.killed.OnClientEvent:Connect(function(playerName)
                                local message = killSayList[math.random(1, #killSayList)]
                                if message then message = message:gsub('<player>', playerName) end
                                chatRemote:FireServer(message, 'All')
                            end)
                        else
                            maid.killSay = nil
                        end
                    end
                })
            end

            do
                local otherFolder = workspace:WaitForChild('Buildings', 10):WaitForChild('Other', 10)
                extrasSection:AddToggle({
                    text = 'No Fence Collisions',
                    callback = function(t)
                        for i, v in next, otherFolder:GetChildren() do
                            if not v:IsA('MeshPart') then continue end
                            if not v.Name == 'TallFence' then continue end

                            v.CanCollide = not t
                        end
                    end
                })
            end

            do
                local redeemCodeButtons = {}
                local function redeemCode(code) events.codeRedeem:FireServer(code) end
                local function changeTeam(team) events.changeTeam:FireServer(team) end
                
                local function redeemAllCodes()
                    for i, v in next, lplr.CodesFolder:GetChildren() do
                        if not v:IsA('BoolValue') then continue end
                        if v.Value then continue end

                        redeemCode(v.Name)
                        notif.new({text = 'redeemed: '.. v.Name, duration = 5})
                        task.wait()
                    end
                end

                extrasSection:AddButton({text = 'Redeem All Codes', callback = redeemAllCodes})

                extrasSection:AddDivider('teams')
                extrasSection:AddButton({text = 'Civilian', callback = function() changeTeam('Civilian') end})
                extrasSection:AddButton({text = 'Police', callback = function() changeTeam('Police') end})
                extrasSection:AddButton({text = 'Prisoner', callback = function() changeTeam('Prisoner') end})
            end
        end

        do
            autoFarmSection:AddLabel('please dont turn on more\nthan 1 farm at a time\n')

            local function isJobLoaded(jobName)
                for i, v in next, jobSystem:GetChildren() do
                    if v.Name == jobName then
                        local t = {}
                        for i2, v2 in next, v:GetChildren() do
                            table.insert(t, v2)
                        end
                        return #t > 1
                    end
                end
            end

            local rayParams = RaycastParams.new()
            rayParams.RespectCanCollide = true
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            rayParams.FilterDescendantsInstances = {workspace.CurrentCamera, lplr.Character}

            local function loadJob(position, floorMaterial, weed)
                if not lplr.Character then return end
                if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end
            
                lplr.Character.HumanoidRootPart.Anchored = true
                lplr.Character.HumanoidRootPart.CFrame = cframeNew(position)
            
                repeat
                    local ray = workspace:Raycast(lplr.Character.HumanoidRootPart.CFrame.Position, Vector3.new(0, -10, 0), rayParams)
                    task.wait()
                until not weed and (ray and ray.Instance.Material == floorMaterial and ray.Instance:IsA('BasePart')) or (ray and ray.Instance.Material == Enum.Material.SmoothPlastic and ray.Instance:FindFirstChildOfClass('Texture'))

                task.wait(0.5)
                lplr.Character.HumanoidRootPart.Anchored = false
            end

            do
                local constants = {
                    ['load point'] = vector3New(-1986, 7, 177),
                    ['nigger'] = vector3New(-2005, 3, 195),
                    ['nigger closer'] = vector3New(-2004, 3, 197),
                }

                local foundWeedPot = {}

                local function getData()
                    for i, v in next, workspace:GetDescendants() do
                        if v:IsA('ProximityPrompt') and v.Parent.Name == 'Grass' and v.Parent:IsA('MeshPart') then
                            if v.Parent.Transparency == 0 then
                                foundWeedPot.ProximityPrompt = v
                                foundWeedPot.ParentPart = v.Parent
                            end
                        end
                    end
                end

                local function equipRequiredTool(delay)
                    if lplr.Backpack:FindFirstChild('Grass') then
                        if not lplr.Backpack.Grass:IsA('Tool') then return end

                        if not lplr.Character:FindFirstChild('Grass') then lplr.Character.Humanoid:UnequipTools() end
                        if delay then task.wait(delay) end
                        lplr.Backpack.Grass.Parent = lplr.Character
                    end
                end

                local function check()
                    if lplr.Backpack:FindFirstChild('Grass') and lplr.Backpack:FindFirstChild('Grass'):IsA('Tool') then
                        if not lplr.Character:FindFirstChild('Grass') then lplr.Character.Humanoid:UnequipTools() end
                        lplr.Backpack.Grass.Parent = lplr.Character
                    end
                end

                autoFarmSection:AddToggle({
                    text = 'Weed Farm',
                    callback = function(t)
                        if t then
                            loadJob(constants['load point'], Enum.Material.SmoothPlastic, true)
                            repeat
                                if not library.flags.weedFarm then break end
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end

                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['load point'] - Vector3.new(0, 4, 0))

                                repeat
                                    if not library.flags.weedFarm then break end
                                    getData()
                                    task.wait()
                                until foundWeedPot.ProximityPrompt and foundWeedPot.ParentPart

                                lplr.Character.HumanoidRootPart.CFrame = foundWeedPot.ParentPart.CFrame

                                fireproximityprompt(foundWeedPot.ProximityPrompt)
                                equipRequiredTool(0.5)
                                task.wait(0.2)
                                repeat
                                    if not library.flags.weedFarm then break end
                                    equipRequiredTool()
                                    lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['load point'] - Vector3.new(0, 4, 0))
                                    task.wait(0.2)
                                    lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['nigger closer'])
                                    task.wait()
                                until not lplr.Character:FindFirstChild('Grass')
                                foundWeedPot = {}
                            until not library.flags.weedFarm
                            foundWeedPot = {}
                        end
                    end
                })
            end

            do
                local constants = {
                    ['load point'] = vector3New(-1936, 10, -37),
                    ['crates'] = vector3New(-1941, 3, -47),
                    ['crates safe'] = vector3New(-1937, 3, -43),
                    ['truck'] = vector3New(-1925, 3, -22),
                    ['truck closer'] = vector3New(-1922, 3, -22),
                    ['prompt text'] = '📦Deliver the crate to the truck'
                }

                local ProximityPrompt
                local function getProximityPrompt()
                    for i, v in next, jobSystem:GetDescendants() do
                        if v:IsA('ProximityPrompt') and v.ObjectText == constants['prompt text'] then
                            ProximityPrompt = v
                        end
                    end
                end

                local function equipRequiredTool(delay)
                    if lplr.Backpack:FindFirstChild('BOX') then
                        if not lplr.Backpack.BOX:IsA('Tool') then return end

                        if not lplr.Character:FindFirstChild('BOX') then lplr.Character.Humanoid:UnequipTools() end
                        if delay then task.wait(delay) end
                        lplr.Backpack.BOX.Parent = lplr.Character
                    end
                end

                autoFarmSection:AddToggle({
                    text = 'Crate Farm',
                    callback = function(t)
                        if t then
                            if not isJobLoaded('BoxPickingJob') then loadJob(constants['load point'], Enum.Material.Concrete) end
                            repeat
                                if not library.flags.crateFarm then break end
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end

                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['crates safe'])
                                task.wait(1)
                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['crates'])

                                if not ProximityPrompt then getProximityPrompt() end
                                fireproximityprompt(ProximityPrompt)
                                equipRequiredTool(0.5)
                                task.wait(0.3)
                                repeat
                                    if not library.flags.crateFarm then break end
                                    equipRequiredTool()
                                    lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['truck'])
                                    task.wait(0.3)
                                    equipRequiredTool()
                                    lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['truck closer'])
                                    task.wait(0.2)
                                until not lplr.Character:FindFirstChild('BOX')
                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['load point'])
                                task.wait(3.4)
                            until not library.flags.crateFarm
                        end
                    end
                })
            end

            do
                local constants = {
                    ['load point'] = vector3New(-1399, 3, 24),
                    ['garbage'] = vector3New(-1386, 3, 27),
                    ['garbage safe'] = vector3New(-1391, 3, 25),
                    ['truck'] = vector3New(-1409, 3, 28),
                    ['truck closer'] = vector3New(-1409, 3, 31),
                    ['prompt text'] = '🗑️Deliver the trash to the truck'
                }

                local ProximityPrompt
                local function getProximityPrompt()
                    for i, v in next, jobSystem:GetDescendants() do
                        if v:IsA('ProximityPrompt') and v.ObjectText == constants['prompt text'] then
                            ProximityPrompt = v
                        end
                    end
                end

                local function equipRequiredTool(delay)
                    if lplr.Backpack:FindFirstChild('Garbage') then
                        if not lplr.Backpack.Garbage:IsA('Tool') then return end

                        if not lplr.Character:FindFirstChild('Garbage') then lplr.Character.Humanoid:UnequipTools() end
                        if delay then task.wait(delay) end
                        lplr.Backpack.Garbage.Parent = lplr.Character
                    end
                end

                autoFarmSection:AddToggle({
                    text = 'Garbage Farm',
                    callback = function(t)
                        if t then
                            if not isJobLoaded('GarbageJob') then loadJob(constants['load point'], Enum.Material.Concrete) end
                            repeat
                                if not library.flags.garbageFarm then break end
                                if not lplr.Character then return end
                                if not lplr.Character:FindFirstChild('Humanoid') then return end
                                if not lplr.Character:FindFirstChild('HumanoidRootPart') then return end

                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['garbage safe'])
                                task.wait(1)
                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['garbage'])

                                if not ProximityPrompt then getProximityPrompt() end
                                fireproximityprompt(ProximityPrompt)
                                equipRequiredTool(0.5)
                                task.wait(0.3)
                                repeat
                                    if not library.flags.garbageFarm then break end
                                    equipRequiredTool()
                                    lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['truck'])
                                    task.wait(0.3)
                                    equipRequiredTool()
                                    lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['truck closer'])
                                    task.wait(0.2)
                                until not lplr.Character:FindFirstChild('Garbage')
                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(constants['load point'])
                                task.wait(3.4)
                            until not library.flags.garbageFarm
                        end
                    end
                })
            end
        end

        do
            local gunRestorationSave = {}
            local gunSettings = gameModules.WeaponSettings.Gun

            for i, v in next, gameModules.WeaponSettings.Gun:GetChildren() do
                if v:IsA('Folder') and #v:GetDescendants() == 2 then
                    table.insert(gunsList, v.Name)
                end
            end

            local function clearRestorationSave(gunName)
                if not gunRestorationSave[gunName] then return end
                local temp = gunRestorationSave[gunName]
                table.clear(temp)
                temp = nil
            end

            local function restoreGun(gunName, property)
                if gunRestorationSave[gunName] then
                    local savedData = gunRestorationSave[gunName]

                    if property then
                        require(gunSettings[gunName].Setting['1'])[property] = savedData[property]
                    else
                        local settings = require(gunSettings[gunName].Setting['1'])
                        settings = savedData
                    end
                end
            end

            local function modifyGun(gunName, property, value)
                if not gunSettings:FindFirstChild(gunName) then return end
                local localGunSettings = require(gunSettings[gunName].Setting['1'])
                clearRestorationSave(gunName)
                task.wait()
                gunRestorationSave[gunName] = copyTable(localGunSettings)
                task.wait()
                localGunSettings[property] = value
            end

            local function modifyFunc(gunName, property, value, toggle)
                if toggle then
                    modifyGun(gunName, property, value)
                else
                    restoreGun(gunName, property)
                end
            end

            gunModsSection:AddToggle({
                text = 'Instant Kill',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'BaseDamage', 9e9, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'Bullet Visualizer',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'LaserTrailEnabled', t, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'Sniper Scope',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'SniperEnabled', t, t)
                    end
                end
            })
            gunModsSection:AddDivider()
            gunModsSection:AddToggle({
                text = 'Instant Reload',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'ReloadTime', 0, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'Infinite Ammo',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'AmmoCost', 0, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'No Spread',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'Spread', 0, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'High Fire Rate',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'FireRate', 0.001, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'No Camera Recoil',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'CameraRecoilingEnabled', t, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'No Gun Recoil',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'Recoil', 0, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'Shotgun Bullets',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'ShotgunEnabled', t, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'Explosive Bullets',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'ExplosiveEnabled', t, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'No Bullet Shells',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'BulletShellEnabled', not t, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'Always Automatic',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'Auto', t, t)
                    end
                end
            })
            gunModsSection:AddToggle({
                text = 'Infinite Bullet Range',
                callback = function(t)
                    for i, v in next, gunsList do
                        modifyFunc(v, 'Range', 9e9, t)
                        modifyFunc(v, 'ZeroDamageDistance', 9e9, t)
                        modifyFunc(v, 'FullDamageDistance', 9e9, t)
                    end
                end
            })
        end

        do
            rageSection:AddLabel('you need a gun for these\n')

            local function checkTool() -- what the fuck
                if not lplr.Character then return end
                if not lplr.Character:FindFirstChildOfClass('Tool') then
                    for i, v in next, lplr.Backpack:GetChildren() do
                        if v:IsA('Tool') and table.find(gunsList, v.Name) then
                            v.Parent = lplr.Character
                            return true
                        else
                            return false
                        end
                    end
                end
                return true
            end

            do
                rageSection:AddToggle({
                    text = 'Kill All',
                    callback = function(t)
                        if t then
                            if library.flags.explodeAllCars then
                                library.options.killAll:SetState(false)
                                notif.new({text = 'turn of Explode All Cars if you want to use this', duration = 10})
                                return
                            end
                            if not library.flags.antiRagdoll then library.options.antiRagdoll:SetState(true) end
                            maid.killAll = runService.Heartbeat:Connect(function()
                                local character = Util:getClosestCharacter({maxHealth = 200})
                                character = character and character.Character
                                if not character then lplr.CameraMaxZoomDistance = 30 return end

                                local hit = character:FindFirstChild('HumanoidRootPart')
                                local hitPos = hit and hit.CFrame.Position

                                local camera = workspace.CurrentCamera
                                if not camera then return end
                                if not checkTool() then lplr.CameraMaxZoomDistance = 30 return end

                                camera.CFrame = camera.CFrame:lerp(cframeNew(camera.CFrame.Position, hitPos), 1 / 1)

                                lplr.Character.HumanoidRootPart.AssemblyLinearVelocity = vector3Zero
                                lplr.Character.HumanoidRootPart.AssemblyAngularVelocity = vector3Zero

                                lplr.CameraMaxZoomDistance = 0
                                lplr.Character.HumanoidRootPart.CFrame = cframeNew(hitPos) * cframeNew(0, library.flags.killAllHeight, library.flags.killAllSpace)
                                mouse1click()
                            end)
                        else
                            maid.killAll = nil
                            lplr.CameraMaxZoomDistance = 30
                        end
                    end
                }):AddBind({
                    flag = 'Kill All Bind',
                    callback = function()
                        library.options.killAll:SetState(not library.flags.killAll)
                    end
                })

                rageSection:AddSlider({text = 'Snap Height', textpos = 2, flag = 'Kill All Height', min = 0, max = 10, float = 0.1})
                rageSection:AddSlider({text = 'Snap Space', textpos = 2, flag = 'Kill All Space', min = -10, max = 10, float = 0.1})
            end
            
            rageSection:AddDivider()


        end
    end

    task.spawn(function()
        (function()
            for i, v in next, workspace:GetChildren() do
                if v:IsA('BasePart') and v.Name == 'Particles' then
                    v:Destroy()
                end
            end
        end)()
    end)

    library:Init(false)
    local timeTookToLoad = tick() - scriptLoadAt
    notif.new({text = string.format('%s script loaded in %.02f seconds', library.gameName, timeTookToLoad), duration = 20})
    warn(string.format('%s script loaded in %.02f seconds', library.gameName, timeTookToLoad))
end  

local function isValidKey(key)
    
    local whitelistURL = "https://raw.githubusercontent.com/UnstableSolutions/Whitelist-sys/main/Keys.lua"
    local whitelist = game:GetService("HttpService"):GetAsync(whitelistURL)
    
    
    whitelist = loadstring(whitelist)()
    
    
    for _, whitelistKey in ipairs(whitelist) do
        if whitelistKey == key then
            return true
        end
    end
    
    return false
end

-- Check if the provided key is valid
if _G.Key and isValidKey(_G.Key) then
    print("Key is valid.")
else
    game.Players.LocalPlayer:Kick("Not Whitelisted")
end
