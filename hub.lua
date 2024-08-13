local ESP = {
   Bones = {},
}


local function createBones(character)
   if not character or not character:FindFirstChild("Humanoid") then
       return
   end

   local humanoid = character:FindFirstChild("Humanoid")
   local rootPart = character:FindFirstChild("HumanoidRootPart")

   if not humanoid or not rootPart then
       return
   end

   for _, bone in pairs(ESP.Bones) do
       if bone and bone.Parent then
           bone:Destroy()
       end
   end


   local bones = {}
   for i, child in ipairs(rootPart:GetChildren()) do
       if child:IsA("BasePart") then
           local bone = Instance.new("BoxHandleAdornment")
           bone.Name = "Bone"
           bone.Parent = child
           bone.AlwaysOnTop = true
           bone.Transparency = 0.5
           bone.Size = Vector3.new(1, 1, 1)
           bone.Color3 = Color3.new(1, 0, 0)
           bones[i] = bone
       end
   end


   ESP.Bones = bones
end


local function updateBones()
   if next(ESP.Bones) then
       for _, bone in pairs(ESP.Bones) do
           if bone and bone.Parent then
               local rootPart = bone.Parent
               local character = rootPart.Parent
               local humanoid = character:FindFirstChild("Humanoid")

               if humanoid and humanoid.Health > 0 then
                   local position = rootPart.Position
                   local rotation = rootPart.Rotation
                   bone.Adornee = rootPart
                   bone.Size = Vector3.new(1, 1, 1)
                   bone.CFrame = CFrame.new(position, position + Vector3.new(0, 3, 0)) * CFrame.fromEulerAnglesXYZ(math.rad(rotation.Y), 0, 0)
               else
                   bone.Adornee = nil
               end
            end
         end
     end
 end
 

 game.Players.PlayerAdded:Connect(function(player)
     player.CharacterAdded:Connect(createBones)
 end)
 

 game.Players.ChildAdded:Connect(createBones)
 

 game:GetService("RunService").Heartbeat:Connect(function()
     updateBones()
 end)
