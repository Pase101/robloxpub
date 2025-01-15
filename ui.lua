local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pase101/robloxpub/refs/heads/main/lib.lua", true))()

local window = library:AddWindow("Veyna", {
	main_color = Color3.fromRGB(141, 45, 150),
	min_size = Vector2.new(580, 500),
	can_resize = true,
})



local automation = window:AddTab("Automation")
automation:Show()

automation:AddLabel("Settings")

automation:AddTextBox("Speed", function(speed)
    print("speed set")
end)

local swSpeed = automation:AddSwitch("Set", function()

end)
swSpeed:Set(false)

automation:AddTextBox("Size", function(size)
    print("size set")
end)

local swSize = automation:AddSwitch("Set", function()

end)
swSize:Set(false)

automation:AddLabel(" ")
automation:AddLabel("Misc")


automation:AddTextBox("Camera Zoom", function(text)
    local zoom = tonumber(text) 
    if zoom then
        local player = game.Players.LocalPlayer
        player.CameraMinZoomDistance = zoom
        player.CameraMaxZoomDistance = zoom
    end
end)



local swMusic = automation:AddSwitch("Music", function()

end)
swMusic:Set(false)

local swPet1 = automation:AddSwitch("Show My Pets", function()

end)
swPet1:Set(false)

local swPet2 = automation:AddSwitch("Show Other Pets", function()

end)
swPet2:Set(false)

local swAfk = automation:AddSwitch("Anti AFK", function()

end)
swAfk:Set(false)

automation:AddLabel(" ")
automation:AddLabel("Protection")

local isFlingEnabled = false

local function applyAntiFling()
    local character = game.Players.LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if character and humanoidRootPart then
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.Parent = humanoidRootPart

        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = humanoidRootPart

        local lastPosition = humanoidRootPart.Position

        while isFlingEnabled do
            local currentPosition = humanoidRootPart.Position
            local offset = lastPosition - currentPosition
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + offset * 0.1
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyGyro.CFrame = humanoidRootPart.CFrame
            lastPosition = humanoidRootPart.Position
            wait(0.03)
        end

        bodyGyro:Destroy()
        bodyVelocity:Destroy()
    end
end

local function removeAntiFling()
    local character = game.Players.LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if character and humanoid then
        humanoid.PlatformStand = false
    end
end

local swFling = automation:AddSwitch("Anti Fling", function(state)
    if state then
        isFlingEnabled = true
        task.spawn(applyAntiFling)
    else
        isFlingEnabled = false
        removeAntiFling()
    end
end)
swFling:Set(false)


local isLockEnabled = false
local previousPosition = nil

local function lockPositionAtCurrentLocation()
    local character = game.Players.LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if character and humanoidRootPart then
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.Parent = humanoidRootPart

        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = humanoidRootPart

        while isLockEnabled do
            humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyGyro.CFrame = humanoidRootPart.CFrame
            wait(0.1)
        end

        bodyGyro:Destroy()
        bodyVelocity:Destroy()
    end
end

local function stopLockingPosition()
    local character = game.Players.LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if character and humanoid then
        humanoid.PlatformStand = false
    end
end

local swLock = automation:AddSwitch("Position Lock", function(state)
    if state then
        isLockEnabled = true
        previousPosition = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
        task.spawn(lockPositionAtCurrentLocation)
    else
        isLockEnabled = false
        stopLockingPosition()
    end
end)
swLock:Set(false)

local swGod = automation:AddSwitch("Godmode", function()

end)
swGod:Set(false)






local killing = window:AddTab("Killing")

killing:AddLabel("Punches")

local swPunch = killing:AddSwitch("Punch", function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local backpack = player:WaitForChild("Backpack")
    local punchTool = backpack:FindFirstChild("Punch")
    local keepLooping = true

    local function equipPunch()
        if punchTool and not character:FindFirstChild("Punch") then
            punchTool.Parent = character
        end
    end

    local function keepEquipped()
        while keepLooping do
            if not character:FindFirstChild("Punch") then
                equipPunch()
            end
            wait(0.1)
        end
    end

    if state then
        equipPunch()
        spawn(function()
            keepEquipped()
        end)
    else
        keepLooping = false
        local equippedPunchTool = character:FindFirstChild("Punch")
        if equippedPunchTool then
            equippedPunchTool.Parent = backpack
        end
    end
end)
swPunch:Set(false) 









local swPunch2 = killing:AddSwitch("Fast Punch", function()

end)
swPunch2:Set(false)

local swInsta = killing:AddSwitch("Instant Kill", function()

end)
swInsta:Set(false)

killing:AddLabel("")
killing:AddLabel("Kill Aura")

local dWhitelist = killing:AddDropdown("Whitelist", function(player1)
	if player1 == "m" then
		print("o")
	elseif player1 == "n" then
	print("o")
	elseif player1 == "g" then
	print("o")
	end
end)
local p1 = dWhitelist:Add("m")
local p2 = dWhitelist:Add("n")
local p3 = dWhitelist:Add("g")

local dUnwhitelist = killing:AddDropdown("Unwhitelist", function(player2)
	if player2 == "mm" then
		print("o")
	elseif player2 == "nn" then
	print("o")
	elseif player2 == "gg" then
	print("o")
	end
end)
local pn1 = dUnwhitelist:Add("hh")
local pn2 = dUnwhitelist:Add("nn")
local pn3 = dUnwhitelist:Add("gg")

local dBlacklist = killing:AddDropdown("Blacklist", function(player3)
	if player3 == "mn" then
		print("o")
	elseif player3 == "ng" then
	print("o")
	elseif player3 == "gh" then
	print("o")
	end
end)
local pz1 = dBlacklist:Add("mn")
local pz2 = dBlacklist:Add("ng")
local pz3 = dBlacklist:Add("gh")

local swKill = killing:AddSwitch("Kill All", function()

end)
swKill:Set(false)

local swKill1 = killing:AddSwitch("Kill List", function()

end)

killing:AddButton("Clear Whitelist",function()

end)

killing:AddButton("Clear Blacklist",function()

end)

killing:AddLabel("Players in Whitelist: ")





local specs = window:AddTab("Specs")

specs:AddLabel("View Player")

local plrs = specs:AddDropdown("Players", function(players)
	if players == "mn" then
		print("o")
	elseif players == "ng" then
	print("o")
	elseif players == "gh" then
	print("o")
	end
end)
local plr1 = plrs:Add("mn")
local plr2 = plrs:Add("ng")
local plr3 = plrs:Add("gh")

specs:AddButton("Print",function()

end)

local swSpect = specs:AddSwitch("Spectate", function()

end)
swSpect:Set(false)






local glitch = window:AddTab("Glitching")

glitch:AddLabel("Glitching")

local glitchy = glitch:AddDropdown("Rocks", function(rock)
	if rock == "Jungle Rock" then
		print("1")
	elseif rock == "Muscle King Rock" then
	print("2")
	elseif rock == "Legends Gym Rock" then
	print("3")
	end
end)
local rock1 = glitchy:Add("Jungle Rock")
local rock2 = glitchy:Add("Muscle King Rock")
local rock3 = glitchy:Add("Legends Gym Rock")

local swGlitch = glitch:AddSwitch("Glitch", function(bool)

end)
swGlitch:Set(false)

local swGlitch2 = glitch:AddSwitch("Fast Glitch", function(bool)

end)
swGlitch2:Set(false)


local extras = window:AddTab("Extras")

extras:AddLabel("Teleport")

local dTP = extras:AddDropdown("Places", function(place)
	if place == "1" then
			print("o")
		elseif place == "2" then
			print("o")
		elseif place == "3" then
			print("o")
		elseif place == "4" then
			print("o")
		elseif place == "5" then
			print("o")
		elseif place == "6" then
			print("o")
		elseif place == "7" then
			print("o")
		elseif place == "8" then
			print("o")
	end
end)
local tp1 = dTP:Add("1")
local tp2 = dTP:Add("2")
local tp3 = dTP:Add("3")
local tp4 = dTP:Add("4")
local tp5 = dTP:Add("5")
local tp6 = dTP:Add("6")
local tp7 = dTP:Add("7")
local tp8 = dTP:Add("8")

extras:AddButton("Teleport", function()

end)

local previousPosition = nil
local isSwitchEnabled = false
local fixedPosition = Vector3.new(196, 54, 317)

local function lockCharacterAtPosition()
    local character = game.Players.LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if character and humanoidRootPart then
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)  
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.Parent = humanoidRootPart

        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9) 
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)  
        bodyVelocity.Parent = humanoidRootPart
        
        humanoidRootPart.CFrame = CFrame.new(fixedPosition)

        while isSwitchEnabled do
            humanoidRootPart.CFrame = CFrame.new(fixedPosition)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyGyro.CFrame = humanoidRootPart.CFrame
            wait(0.1)
        end

        bodyGyro:Destroy()
        bodyVelocity:Destroy()
    end
end

local function stopLockingPosition()
    local character = game.Players.LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if character and humanoid then
        humanoid.PlatformStand = false
    end
end

extras:AddSwitch("Saveplace", function(state)
    if state then
        previousPosition = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
        isSwitchEnabled = true
        task.spawn(lockCharacterAtPosition)
    else
        if previousPosition then
            game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(previousPosition)
        end
        isSwitchEnabled = false
        stopLockingPosition()
    end
end)







local config1 = window:AddTab("Config")

config1:AddButton("Script")

config1:AddButton("Save",function()

end)


config1:AddButton("Reset Save",function()

end)

config1:AddLabel("")
config1:AddLabel("Saves")


local swSve1 = config1:AddSwitch("Save Automation", function(bool)
    print(bool)
end)
swSve1:Set(false)



local swSave2 = config1:AddSwitch("Save Whitelist", function(bool)

end)
swSave2:Set(false)

local swSave3 = config1:AddSwitch("Save Blacklist", function(bool)

end)
swSave3:Set(false)



local creds = window:AddTab("Credits")

creds:AddLabel("Made by Pase")
creds:AddLabel("Discord: pasee")
creds:AddLabel("")
creds:AddLabel("PRIVATE VERSION")



