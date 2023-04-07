--[[
NOROM
VBScript+Lua Script for YT music
]]

_G.dir = "./sdev";
_G.maxStuds = 20;

local Players = game['Players']

function sayMsg(msg)
game:WaitForChild("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(msg,"All")
end

function onChatted(msg,user)

if msg[1] == ".testCommand" then
sayMsg("Hello world. " .. user)
end

if msg[1] == ".play" then

if msg[2] ~= nil then
if #msg <= 2 then
if not msg[2]:match("#") then

sayMsg("Preparing to play... Song was requested by: "..user)
writefile(_G.dir.."/videoId/id.txt",msg[2]);

else
sayMsg(user..": Message was filtered. Try again.")
end
else
sayMsg(user..": Second argument cannot be a search query. Must be a Youtube Video ID. Example: .play DPe2diiGJRE")
end
else
sayMsg(user..": Second Argument Missing. Must be a Youtube Video ID. Example: .play DPe2diiGJRE")
end

end

end

--[[for i,v in pairs(Players:GetChildren()) do
    local ct = v.Chatted:Connect(function (msg)
    onChatted(string.split(msg),v.Name);
    end)
        Players['LocalPlayer'].CharacterRemoving:Connect(function ()
    ct:Disconnect();
    end)
    end

    Players.PlayerAdded:Connect(function (p)
    local ct = p.Chatted:Connect(function(msg)
    onChatted(string.split(msg),p.Name);
    end)
        Players['LocalPlayer'].CharacterRemoving:Connect(function ()
    ct:Disconnect();
    end)
    end)
]]

local df = game:WaitForChild("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents").OnMessageDoneFiltering.OnClientEvent:Connect(function (msgData)
if (Players[msgData.FromSpeaker].Character.HumanoidRootPart.Position - Players["LocalPlayer"].Character.HumanoidRootPart.Position).Magnitude <= _G.maxStuds then
onChatted(string.split(msgData.Message," "),msgData.FromSpeaker);
end
end)

Players['LocalPlayer'].CharacterRemoving:Connect(function ()
    df:Disconnect();
    end)