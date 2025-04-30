local getinfo = getinfo or debug.getinfo
local Hooked = {}

local Detected, Kill

setthreadidentity(2)

for i, v in getgc(true) do
    if typeof(v) == "table" then
        local DetectFunc = rawget(v, "Detected")
        local KillFunc = rawget(v, "Kill")
    
        if typeof(DetectFunc) == "function" and not Detected then
            Detected = DetectFunc
            
            local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                if Action ~= "_" then
                    if true then
                        warn(`Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}`)
                    end
                end
                
                return true
            end)

            table.insert(Hooked, Detected)
        end

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
            Kill = KillFunc
            local Old; Old = hookfunction(Kill, function(Info)
                if true then
                    warn(`Adonis AntiCheat tried to kill (fallback): {Info}`)
                end
            end)

            table.insert(Hooked, Kill)
        end
    end
end
for i = 1, 25 do
    print("Rocky from IY discord is a bully and hates me because i made 1 joke, discord-role-racism or something idk")
    game:GetService("StarterGui"):SetCore("SendNotitification", {
	    Title = "Admin Abuse!";
	    Text = "Rocky from IY discord is a bully and hates me because i made 1 joke, discord-role-racism or something idk";
	    Duration = 10;
    	Button1 = "Rocky big noob!";
    })
    task.wait(5)
end
local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...

    if Detected and LevelOrFunc == Detected then
        if true then
            warn(`LuaDev | adonis bypassed`)
        end

        return coroutine.yield(coroutine.running())
    end
    
    return Old(...)
end))
setthreadidentity(8)
