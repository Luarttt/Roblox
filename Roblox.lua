-- Visual Confirmation
game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Ninja Legends Visuals";
	Text = "Injecting custom visual meshes...";
	Icon = "rbxassetid://0"
})

local lp = game:GetService("Players").LocalPlayer

local function spawnNinjaLegendsPet(name, tier, meshId, textureId, offset)
    local character = lp.Character or lp.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart", 10)
    if not root then return end

    -- 1. Create the base physical part
    local petModel = Instance.new("Part")
    petModel.Size = Vector3.new(2, 2, 2)
    petModel.CanCollide = false
    petModel.Anchored = false
    petModel.Transparency = 0
    petModel.Parent = character

    -- 2. Insert the actual SpecialMesh to give it the proper 3D shape and skin
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = meshId
    mesh.TextureId = textureId
    mesh.Scale = Vector3.new(1.5, 1.5, 1.5) -- Adjust scale as needed
    mesh.Parent = petModel

    -- 3. Create the Billboard GUI for the Tier nameplates
    local bg = Instance.new("BillboardGui", petModel)
    bg.Size = UDim2.new(0, 200, 0, 50)
    bg.AlwaysOnTop = true
    bg.StudsOffset = Vector3.new(0, 3, 0)

    local tl = Instance.new("TextLabel", bg)
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.TextColor3 = Color3.fromRGB(0, 255, 255) -- Cyan Aura Color
    tl.TextStrokeTransparency = 0
    tl.TextSize = 15
    tl.Text = "[" .. tier .. "] " .. name

    -- 4. Attachment physics to follow your ninja character smoothly
    local bp = Instance.new("BodyPosition", petModel)
    bp.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bp.P = 12000 

    local bg_align = Instance.new("BodyGyro", petModel)
    bg_align.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

    -- Looped thread to calculate placements relative to character angle
    task.spawn(function()
        while petModel and petModel.Parent and character:FindFirstChild("HumanoidRootPart") do
            local currentRoot = character.HumanoidRootPart
            bp.Position = (currentRoot.CFrame * offset).Position
            bg_align.CFrame = currentRoot.CFrame
            task.wait(0.01)
        end
    end)
end

-- Render the pets using default placeholder assets to test execution paths
spawnNinjaLegendsPet(
    "Ultra Doom Colossus", 
    "VORTEX-ELITE", 
    "rbxassetid://6112446866", -- Handled via Asset ID matching
    "", 
    CFrame.new(4, 3, 4)
)

spawnNinjaLegendsPet(
    "Secret Chaos Sorcerer", 
    "VORTEX-ELITE", 
    "rbxassetid://6121834276", 
    "", 
    CFrame.new(-4, 3, 4)
)
