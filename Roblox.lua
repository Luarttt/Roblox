-- Visual Confirmation
game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Ninja Legends Visuals";
	Text = "Rendering physical pet structures...";
	Icon = "rbxassetid://0"
})

local lp = game:GetService("Players").LocalPlayer

local function spawnNinjaLegendsPet(name, tier, shapeType, auraColor, offset)
    local character = lp.Character or lp.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart", 10)
    if not root then return end

    -- 1. Create a guaranteed physical part body
    local petModel = Instance.new("Part")
    petModel.Size = Vector3.new(2.2, 2.2, 2.2)
    petModel.Color = auraColor
    petModel.Material = Enum.Material.Neon -- Makes the body glow like an aura
    petModel.CanCollide = false
    petModel.Anchored = false
    petModel.Transparency = 0.2 -- Slight transparent aura look
    petModel.Parent = character

    -- 2. Force a physical shape mesh (Bypasses broken Asset IDs)
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = shapeType -- Uses built-in geometry that never breaks
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = petModel

    -- 3. Create a secondary outer spinning ring effect
    local ring = Instance.new("Part")
    ring.Size = Vector3.new(3, 0.2, 3)
    ring.Color = Color3.fromRGB(255, 255, 255)
    ring.Material = Enum.Material.Neon
    ring.CanCollide = false
    ring.Anchored = false
    ring.Parent = character
    
    local ringMesh = Instance.new("SpecialMesh", ring)
    ringMesh.MeshType = Enum.MeshType.FileMesh
    ringMesh.MeshId = "rbxassetid://3270017" -- Stable public ring mesh ID
    ringMesh.Scale = Vector3.new(2, 2, 0.5)

    -- 4. Billboard GUI Nameplates
    local bg = Instance.new("BillboardGui", petModel)
    bg.Size = UDim2.new(0, 200, 0, 50)
    bg.AlwaysOnTop = true
    bg.StudsOffset = Vector3.new(0, 3, 0)

    local tl = Instance.new("TextLabel", bg)
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.TextColor3 = auraColor
    tl.TextStrokeTransparency = 0
    tl.TextSize = 16
    tl.Text = "[" .. tier .. "] " .. name

    -- 5. Strict Physics Attachments
    local bp = Instance.new("BodyPosition", petModel)
    bp.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bp.P = 15000 

    local bg_align = Instance.new("BodyGyro", petModel)
    bg_align.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    local bpRing = Instance.new("BodyPosition", ring)
    bpRing.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    
    local bgRing = Instance.new("BodyGyro", ring)
    bgRing.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

    -- Multi-threaded loop for real-time positioning and spin animations
    task.spawn(function()
        local rotation = 0
        while petModel and petModel.Parent and character:FindFirstChild("HumanoidRootPart") do
            local currentRoot = character.HumanoidRootPart
            local targetPos = (currentRoot.CFrame * offset).Position
            
            -- Keep the pet and its ring attached to you
            bp.Position = targetPos
            bg_align.CFrame = currentRoot.CFrame
            
            bpRing.Position = targetPos
            rotation = rotation + 5
            bgRing.CFrame = currentRoot.CFrame * CFrame.Angles(math.rad(rotation), math.rad(rotation), 0)
            
            task.wait(0.01)
        end
        ring:Destroy()
    end)
end

-- Render the physical items side-by-side using secure geometric meshes
-- Pet 1: Ultra Doom Colossus (Glow Sphere Style)
spawnNinjaLegendsPet(
    "Ultra Doom Colossus", 
    "VORTEX-ELITE", 
    Enum.MeshType.Sphere, 
    Color3.fromRGB(148, 0, 211), -- Dark Violet Neon Aura
    CFrame.new(4, 3, 4)
)

-- Pet 2: Secret Chaos Sorcerer (Crystal Diamond Style)
spawnNinjaLegendsPet(
    "Secret Chaos Sorcerer", 
    "VORTEX-ELITE", 
    Enum.MeshType.Wedge, 
    Color3.fromRGB(255, 0, 0), -- Crimson Red Crystal Aura
    CFrame.new(-4, 3, 4)
)
