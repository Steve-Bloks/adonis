local cmds = {}

local function addCMD(cmd, func)
    local command = {
        cmdSuffix = cmd,
        cmdFunc = func
    }
    table.insert(cmds, command)
end












addCMD("test", function(...)
    print("TEST FROM ADMIN THINGY")
end)

addCMD("walkspeed", function(...)
    local args = {...}
    if #args < 1 then
        error("NO ARGS FOR WALKSPEED AAAA", 0)
    end
    local ws = tonumber(args[1])
    if not ws then return end

    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = ws
end)

addCMD("jumppower", function(...)
    local args = {...}
    if #args < 1 then
        error("NO ARGS FOR JUMPPOWER AAAA", 0)
    end
    local jp = tonumber(args[1])
    if not jp then return end

    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum.JumpPower = jp
end)

addCMD("rejoin", function(...)
    local PlaceId = game.PlaceId
    local JobId = game.JobId
    local TeleportService = game:GetService("TeleportService")
    if #game.Players:GetPlayers() <= 1 then
		game.Players.LocalPlayer:Kick("\nRejoining...")
		wait()
		TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
	else
		TeleportService:TeleportToPlaceInstance(PlaceId, JobId, game.Players.LocalPlayer)
	end
end)

addCMD("reset", function(...)
    local success, err = pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.Health = -1
    end)
    task.wait()
    if not success then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Vector3.new(0, -450, 0) end
end)

addCMD("iy", function(...)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

addCMD("fakout", function(...)
	local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")
    local oldpos = root.CFrame
    workspace.FallenPartsDestroyHeight = 0/1/0
    root.CFrame = CFrame.new(Vector3.new(0, OrgDestroyHeight - 25, 0))
    wait(1)
    root.CFrame = oldpos
    workspace.FallenPartsDestroyHeight = OrgDestroyHeight
end)









game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if string.sub(msg, 1, 1) ~= "." then return end

    local cmdParts = string.split(msg, " ")
    local cmdName = string.sub(cmdParts[1], 2)
    table.remove(cmdParts, 1)

    for _, command in ipairs(cmds) do
        if command.cmdSuffix == cmdName then
            task.spawn(function()
                pcall(function()
                    command.cmdFunc(table.unpack(cmdParts))
                end)
            end)
            return
        end
    end
end)

if queue_on_teleport then
    game.Players.LocalPlayer.OnTeleport:Connect(function(State) 
        queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Steve-Bloks/my-stuff/refs/heads/main/pro-commands.lua'))()")
    end)
else
    warn("u can use script but ur trash executor doesnt support queue_on_teleport so u gotta re-exectute each time")
end


print("\nhookmetamethod_hook's pro command script loaded :O :O pog :O\n\n[VERSION: 0.1 | BUILD: 11]\n")
