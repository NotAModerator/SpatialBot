--[[
 _____             _   _       _______       _   
/  ___|           | | (_)     | | ___ \     | |  
\ `--. _ __   __ _| |_ _  __ _| | |_/ / ___ | |_ 
 `--. \ '_ \ / _` | __| |/ _` | | ___ \/ _ \| __|
/\__/ / |_) | (_| | |_| | (_| | | |_/ / (_) | |_ 
\____/| .__/ \__,_|\__|_|\__,_|_\____/ \___/ \__|
      | |                                        
      |_|                                        

      A VBScript+Lua bot for Youtube Music.

]]

--settings
--#
_G.dir = "./sdev";
_G.maxStuds = 20;
--#

local Players = game['Players']
local _playlist = {
}

function sayMsg(msg)
game:WaitForChild("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(msg,"All")
end

function onChatted(msg,user)

--[[if msg[1] == ".testCommand" then
sayMsg("Hello world. " .. user)
end]]

if msg[1] == ".help" then
sayMsg("All commands: .play, .random")
end

if msg[1] == ".play" then

if msg[2] ~= nil then
if #msg <= 2 then
if not msg[2]:match("#") then

sayMsg("Preparing to play... Song was requested by: "..user)
table.insert(_playlist,msg[2]);
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

if msg[1] == ".random" then
    if #_playlist > 0 then
local randSong = _playlist[math.random(1,#_playlist)];
sayMsg("Song "..randSong.." has been randomly requested by: "..user)
else
sayMsg("No songs currently in playlist. Use .play to add songs!")
end
end
end

local df = game:WaitForChild("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents").OnMessageDoneFiltering.OnClientEvent:Connect(function (msgData)
if (Players[msgData.FromSpeaker].Character.HumanoidRootPart.Position - Players["LocalPlayer"].Character.HumanoidRootPart.Position).Magnitude <= _G.maxStuds then
onChatted(string.split(msgData.Message," "),msgData.FromSpeaker);
end
end)

Players['LocalPlayer'].CharacterRemoving:Connect(function ()
    df:Disconnect();
    end)

