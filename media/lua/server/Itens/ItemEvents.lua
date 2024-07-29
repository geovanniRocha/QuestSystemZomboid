
local function onClientCommandRec(module, command, player, data)
	if module ~= 'QuestSystem' then return end
    if command == 'DestinationReached' then
        QuestSystem:NextMission() 
        QuestSysSaveData()
        sendServerCommand("QuestSystem", 'NextQuest', QuestSystem)
    elseif command == 'GetDestination' then
        sendServerCommand("QuestSystem", 'NextQuest', QuestSystem)
    end
end

local function OnConnectedServer()
	sendServerCommand("QuestSystem", 'NextQuest', QuestSystem)
end


local function OnServerStarted()
    QuestSystem:SetCurrentMission(QuestSysLoadData()) 
    sendServerCommand("QuestSystem", 'NextQuest', QuestSystem)  
end


function QuestSysSaveData ()
	output = getFileOutput("QuestSysProgress.save");
	output:writeInt(QuestSystem.GetCurrentMission());
	endFileOutput();
end

function QuestSysLoadData()
    input = getFileInput("QuestSysProgress.save");
    local value = 1
	if input ~= nil then
		value = input:readInt();
		endFileInput();
	end
    return value
end


Events.OnLoad.Add(OnServerStarted)
Events.OnServerStarted.Add(OnServerStarted)
Events.OnClientCommand.Add(onClientCommandRec)
Events.OnConnected.Add(OnConnectedServer)