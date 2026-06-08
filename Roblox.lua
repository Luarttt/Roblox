-- Visual Confirmation
game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Model Swapper Active";
	Text = "Morphing Golden Sun Pegasus...";
	Icon = "rbxassetid://0"
})

local lp = game:GetService("Players").LocalPlayer

-- Function to monitor and reskin the pet models locally
local function maskPegasus()
    local character = lp.Character or lp.CharacterAdded:Wait()
    
    -- Target the game's official pet model folder attached to your character
    -- Ninja Legends usually spawns visual equipped pets directly inside your character model
    task.spawn(function()
        while character and character.Parent do
            for _, obj in ipairs(character:GetChildren()) do
                -- Locate any model or part representing your Golden Sun Pegasus
                if obj:IsA("Model") or obj:IsA("Part") then
                    if string.find(string.lower(obj.Name), "pegasus") or obj:FindFirstChildOfClass("BillboardGui") then
                        
                        -- 1. Mutate the Display Name Tags
                        local billboard = obj:FindFirstChildOfClass("BillboardGui")
                        if billboard then
                            local textLabel = billboard:FindFirstChildOfClass("TextLabel")
                            if textLabel and not string.find(textLabel.Text, "VORTEX-ELITE") then
                                textLabel.Text = "[VORTEX-ELITE] Ultra Doom Colossus"
                                textLabel.TextColor3 = Color3.fromRGB(148, 0, 211) -- Dark Purple Doom Aura
                            end
                        end

                        -- 2. Force Visual Skin Reshaping
                        -- If the game uses a SpecialMesh structure inside a Part to render the pegasus
                        local mesh = obj:FindFirstChildOfClass("SpecialMesh") or obj
                        if mesh and mesh:IsA("SpecialMesh") then
                            -- Change its texture and mesh shape parameters instantly
                            mesh.MeshId = "rbxassetid://60791937" -- High-tier Star Element Core Mesh
                            mesh.TextureId = "" -- Removes the default yellow pegasus skin texture
                        end
                        
                        -- 3. Apply the Ultra Doom Neon Glow Effect
                        if obj:IsA("Part") then
                            obj.Color = Color3.fromRGB(148, 0, 211)
                            obj.Material = Enum.Material.Neon
                        end
                        
                    end
                end
            end
            task.wait(0.5) -- Low resource check loop to keep assets swapped
        end
    end)
end

-- Run the swapper block
maskPegasus()
lp.CharacterAdded:Connect(maskPegasus)
