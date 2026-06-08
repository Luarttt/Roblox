game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Notification";
	Text = "Pets added! Trying to force visual equip...";
	Icon = "rbxassetid://0"
})
local Duration = 7;

local lp = game:GetService("Players").LocalPlayer
local petsPath = lp:WaitForChild("petsFolder"):WaitForChild("Skyblade")
-- Locate the game's equip remote event
local equipRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("equipPetRemote") 

local function addVal(class, name, val, parent)
    local v = Instance.new(class)
    v.Name = name
    v.Value = val
    v.Parent = parent
    return v
end

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

    local evosShadow = {
        "evolved", "eternalized", "immortalized", "legend", "elementalized",
        "X-GENESIS", "Z-MASTER", "ULTRA-BEAST", "INFINITY-LORD", "CHAOS-TITAN",
        "ZX-LEGEND", "DARK-ELEMENT", "SHADOWSTORM"
    }

    local evosVortex = {
        "evolved", "eternalized", "immortalized", "legend", "elementalized",
        "X-GENESIS", "Z-MASTER", "ULTRA-BEAST", "INFINITY-LORD", "CHAOS-TITAN",
        "ZX-LEGEND", "DARK-ELEMENT", "SHADOWSTORM", "VORTEX-ELITE"
    }

    local targetList = (data.forcedEvo == "SHADOWSTORM") and evosShadow or evosVortex

    for _, evoName in ipairs(targetList) do
        local state = (evoName == data.forcedEvo)
        addVal("BoolValue", evoName, state, pet)
    end
    
    -- Fire the remote event to visually equip the pet to your character
    task.spawn(function()
        pcall(function()
            equipRemote:FireServer(pet)
        end)
    end)
end

local petTypes = {
    {
        name = "Ultra Doom Colossus", 
        assetId = "http://www.roblox.com/asset/?id=6112446866", 
        multiplier = 1.265625e+22, 
        forcedEvo = "VORTEX-ELITE",
        count = 1
    },
    {
        name = "Secret Chaos Sorcerer", 
        assetId = "http://www.roblox.com/asset/?id=6121834276", 
        multiplier = 5.2734375e+21, 
        forcedEvo = "VORTEX-ELITE",
        count = 2
    },
    {
        name = "Relentless Nightcrawler", 
        assetId = "rbxassetid://5877758659", 
        multiplier = 2.81e+19, 
        forcedEvo = "SHADOWSTORM",
        count = 3
    },
    {
        name = "Chaos Master Titan", 
        assetId = "http://www.roblox.com/asset/?id=6109241883", 
        multiplier = 1.68e+19, 
        forcedEvo = "SHADOWSTORM",
        count = 4
    }
}

for _, petData in ipairs(petTypes) do
    for i = 1, petData.count do
        createPet(petData)
    end
end
