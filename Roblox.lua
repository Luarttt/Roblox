-- Visual Confirmation
game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "UI Unlock Active";
	Text = "Bypassing pack menu locks...";
	Icon = "rbxassetid://0"
})

local lp = game:GetService("Players").LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

local function forceUnlockPacks()
    -- 1. Scan Ninja Legends main interface panels
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            -- Search for layout frames matching typical pack/shop templates
            for _, frame in ipairs(gui:GetDescendants()) do
                
                -- Unlock grayed-out or restricted shop buttons
                if frame:IsA("ImageButton") or frame:IsA("TextButton") then
                    if string.find(string.lower(frame.Name), "pack") or string.find(string.lower(frame.Name), "vortex") then
                        frame.Visible = true
                        frame.Active = true
                        frame.Selectable = true
                        
                        -- Force clickable color filters
                        if frame:IsA("ImageButton") then
                            frame.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                end
                
                -- Force hidden Blazing Vortex / Pack menus to become visible
                if frame:IsA("Frame") or frame:IsA("ScrollingFrame") then
                    if frame.Name == "PacksFrame" or frame.Name == "BlazingVortexFrame" or string.find(string.lower(frame.Name), "packshop") then
                        frame.Visible = true
                        frame.Active = true
                        
                        -- Bypass position locks that slide the menu off-screen
                        if frame.Position.Y.Scale > 1 or frame.Position.X.Scale > 1 then
                            frame.Position = UDim2.new(0.5, -250, 0.5, -175) -- Center it on your screen
                        end
                    end
                end
                
            end
        end
    end
end

-- Run the layout unlock engine
task.spawn(function()
    pcall(forceUnlockPacks)
end)
