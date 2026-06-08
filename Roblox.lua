game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Notification";
	Text = "Executing Inventory & Visual Pet Script...";
	Icon = "rbxassetid://0"
})

local lp = game:GetService("Players").LocalPlayer
local character = lp.Character or lp.CharacterAdded:Wait()
local petsPath = lp:WaitForChild("petsFolder"):WaitForChild("Skyblade")
local equipRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("equipPetRemote") 

local function addVal(class, name, val, parent)
    local v = Instance.new(class)
    v.Name = name
    v.Value = val
    v.Parent = parent
    return v
end

-- PART 1: Inventory Creation
local function createPet(data)
    local pet = Instance.new("StringValue")
    pet.Name = data.name
    pet.Value = data.assetId
    pet.Parent = petsPath

    addVal("IntValue", "level", 1, pet)
    addVal("IntValue", "exp", 0, pet)
    addVal("BoolValue", "untradeable", false, pet)
    addVal("BoolValue", "unsellable", false, pet)
    addVal("StringValue", "chosenName", data.name, pet)

    local perks = Instance.new("Folder", pet)
    perks.Name = "perksFolder"
    addVal("NumberValue", "chi", data.multiplier, perks)
    addVal("NumberValue", "coins", data.multiplier, perks)
    addVal("NumberValue", "ninjitsu", data.multiplier, perks)

    local evosVortex = {"evolved", "eternalized", "immortalized", "legend", "elementalized", "X-GENESIS", "Z-MASTER", "ULTRA-BEAST", "INFINITY-LORD", "CHAOS-TITAN", "ZX-LEGEND", "DARK-ELEMENT", "SHADOWSTORM", "VORTEX-ELITE"}
    for _, evoName in ipairs(evosVortex) do
        addVal("BoolValue", evoName, (evoName == data.forcedEvo), pet)
    end
    
    pcall(function() equipRemote:FireServer(pet) end)
end

-- PART 2: Visual 3D Illusion Spawning
local function spawnVisualPet(name, forcedEvo, offset)
    local visualPet = Instance.new("Part")
    visualPet.Size = Vector3.new(2, 2, 2)
    visualPet.Color = Color3.fromRGB(138, 43, 226) -- Purple theme
    visualPet.CanCollide = false
    visualPet.Parent = character

    local bg = Instance.new("BillboardGui", visualPet)
    bg.Size = UDim2.new(0, 200, 0, 50)
    bg.AlwaysOnTop = true
    bg.StudsOffset = Vector3.new(0, 3, 0)

    local tl = Instance.new("TextLabel", bg)
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.TextColor3 = Color3.fromRGB(255, 69, 0)
    tl.TextStrokeTransparency = 0
    tl.TextSize = 16
    tl.Text = "[" .. forcedEvo .. "] " .. name

    local bp = Instance.new("BodyPosition", visualPet)
    bp.MaxForce = Vector3.new(9e9, 9e9, 9e9)

    task.spawn(function()
        while visualPet and visualPet.Parent and character:FindFirstChild("HumanoidRootPart") do
            local root = character.HumanoidRootPart
            bp.Position = (root.CFrame * offset).Position
            task.wait(0.03)
        end
    end)
end

-- Data Configuration
local petTypes = {
    {name = "Ultra Doom Colossus", assetId = "http://roblox.com", multiplier = 1.265625e+22, forcedEvo = "VORTEX-ELITE", count = 1},
    {name = "Secret Chaos Sorcerer", assetId = "http://roblox.com", multiplier = 5.2734375e+21, forcedEvo = "VORTEX-ELITE", count = 1}
}

-- Run both features
local spacing = 3
for _, petData in ipairs(petTypes) do
    createPet(petData)
    spawnVisualPet(petData.name, petData.forcedEvo, CFrame.new(spacing, 3, 4))
    spacing = spacing - 6 -- Offset the second pet to the other shoulder
end
