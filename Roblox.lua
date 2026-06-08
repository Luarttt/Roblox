-- Visual Confirmation
-- Send immediate confirmation notice
game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Visuals Forced";
	Text = "Rendering 3 highly visual elemental cores...";
	Icon = "rbxassetid://0"
})

local lp = game:GetService("Players").LocalPlayer
local character = lp.Character or lp.CharacterAdded:Wait()

-- Create a secure visual folder container
local visualFolder = character:FindFirstChild("ForcedVisuals") or Instance.new("Folder")
visualFolder.Name = "ForcedVisuals"
visualFolder.Parent = character

local function spawnGuaranteedPet(name, tier, coreColor, outerColor, isBlock, offset)
    local root = character:WaitForChild("HumanoidRootPart", 10)
    if not root then return end

    -- 1. Main Core Object (Guaranteed to render physically)
    local core = Instance.new("Part")
    core.Size = Vector3.new(1.8, 1.8, 1.8)
    core.Shape = isBlock and Enum.PartType.Block or Enum.PartType.Ball
    core.Color = coreColor
    core.Material = Enum.Material.Neon -- Bright glowing crystal effect
    core.CanCollide = false
    core.Anchored = false
    core.Parent = visualFolder

    -- 2. Outer Floating Shield Layer
    local shield = Instance.new("Part")
    shield.Size = Vector3.new(2.4, 2.4, 2.4)
    shield.Shape = isBlock and Enum.PartType.Ball or Enum.PartType.Block -- Opposite shape for contrast
    shield.Color = outerColor
    shield.Material = Enum.Material.ForceField -- Translucent shimmering energy skin
    shield.CanCollide = false
    shield.Anchored = false
    shield.Parent = visualFolder

    -- 3. Dynamic Star/Fire Particle Aura
    local particles = Instance.new("ParticleEmitter", core)
    particles.Texture = "rbxassetid://241580175" -- Default star texture
    particles.Color = ColorSequence.new(coreColor, outerColor)
    particles.Rate = 25
    particles.Speed = NumberRange.new(1, 3)
    particles.Size = NumberSequence.new(0.5, 0)
    particles.Lifetime = NumberRange.new(0.5, 1)

    -- 4. Billboard Tier Nameplate
    local bg = Instance.new("BillboardGui", core)
    bg.Size = UDim2.new(0, 200, 0, 50)
    bg.AlwaysOnTop = true
    bg.StudsOffset = Vector3.new(0, 3, 0)

    local tl = Instance.new("TextLabel", bg)
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.TextColor3 = coreColor
    tl.TextStrokeTransparency = 0
    tl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    tl.TextSize = 16
    tl.Font = Enum.Font.GothamBold
    tl.Text = "[" .. tier .. "] " .. name

    -- 5. Physics Alignments
    local bpCore = Instance.new("BodyPosition", core)
    bpCore.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bpCore.P = 15000

    local bgCore = Instance.new("BodyGyro", core)
    bgCore.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

    local bpShield = Instance.new("BodyPosition", shield)
    bpShield.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bpShield.P = 15000

    local bgShield = Instance.new("BodyGyro", shield)
    bgShield.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

    -- Dynamic motion and rotation engine thread
    task.spawn(function()
        local degrees = 0
        while core and core.Parent and shield and shield.Parent and character:FindFirstChild("HumanoidRootPart") do
            local currentRoot = character.HumanoidRootPart
            
            -- Smooth hovering math
            local hover = math.sin(tick() * 4) * 0.5
            local finalOffset = offset + Vector3.new(0, hover, 0)
            local targetPos = (currentRoot.CFrame * finalOffset).Position
            
            -- Update positions
            bpCore.Position = targetPos
            bpShield.Position = targetPos
            
            -- Spin the core and the outer energy shield in opposite directions
            degrees = degrees + 4
            bgCore.CFrame = currentRoot.CFrame * CFrame.Angles(math.rad(degrees), math.rad(degrees), 0)
            bgShield.CFrame = currentRoot.CFrame * CFrame.Angles(math.rad(-degrees), 0, math.rad(degrees))
            
            task.wait(0.01)
        end
    end)
end

-- Clear out stale visual assets
for _, item in ipairs(visualFolder:GetChildren()) do item:Destroy() end

-- Spawn the 3 legendary pets built with guaranteed-render geometry
-- Pet 1: Right Side (Ultra Doom Colossus - Glowing Violet Sphere Core)
spawnGuaranteedPet(
    "Ultra Doom Colossus", 
    "VORTEX-ELITE", 
    Color3.fromRGB(148, 0, 211), -- Violet Core
    Color3.fromRGB(75, 0, 130),   -- Indigo Shield
    false, -- Sphere Shape
    Vector3.new(4.5, 3.5, 2)
)

-- Pet 2: Left Side (Secret Chaos Sorcerer - Glowing Crimson Pyramid/Cube Core)
spawnGuaranteedPet(
    "Secret Chaos Sorcerer", 
    "VORTEX-ELITE", 
    Color3.fromRGB(255, 0, 0),   -- Crimson Core
    Color3.fromRGB(255, 69, 0),  -- Orange Shield
    true, -- Block Shape
    Vector3.new(-4.5, 3.5, 2)
)

-- Pet 3: Overhead Center (Cybernetic Overlord Dragon - Electric Cyan Core)
spawnGuaranteedPet(
    "Cybernetic Overlord Dragon", 
    "SHADOWSTORM", 
    Color3.fromRGB(0, 255, 255),  -- Cyan Core
    Color3.fromRGB(0, 128, 255),  -- Deep Blue Shield
    false, -- Sphere Shape
    Vector3.new(0, 6, 4)
)
