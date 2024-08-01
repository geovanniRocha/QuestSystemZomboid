
local function onClientCommandRec(module, command, player, data)
	if module ~= 'QuestSystem' then return end
    if command == 'DestinationReached' then
        LogDebug(1, "onClientCommandRec "..command, QuestSystem.Visited)
        QuestSystem:NextMission() 
        QuestSysSaveData()
        sendServerCommand("QuestSystem", 'NextQuest', QuestSystem.Visited)
    elseif command == 'GetDestination' then
        LogDebug(1, "onClientCommandRec "..command, QuestSystem.Visited)
        sendServerCommand("QuestSystem", 'NextQuest', QuestSystem.Visited)
    end
end

Events.OnClientCommand.Add(onClientCommandRec)

local function OnConnectedServer()
	sendServerCommand("QuestSystem", 'NextQuest', QuestSystem.Visited)
end


local function OnServerStarted()
    -- QuestSystem:SetCurrentMission() 
    
    LogDebug(1, "OnServerStarted",QuestSystem)
    QuestSystem.Visited = QuestSysLoadData()
    removeDuplicate()
    LogDebug(1, "OnServerStarted",QuestSystem)
    sendServerCommand("QuestSystem", 'NextQuest', QuestSystem.Visited)  
end




function QuestSysSaveData ()
    
    LogDebug(1, "QuestSysSaveData Value",QuestSystem)
	output = getFileOutput("QuestSysProgress.save");
    -- QuestSystem.GetCurrentMission()
	output:writeUTF(Serialize(QuestSystem.Visited));
	endFileOutput();
end


function QuestSysLoadData()
    input = getFileInput("QuestSysProgress.save");
    local value = ""
	if input ~= nil then
		value = input:readUTF();                
		endFileInput();
	end
    v = deserialize(value) 
    LogDebug(1, "QuestSysLoadData DesObject: input:"..dump(input),{})
    LogDebug(1, "QuestSysLoadData DesObject: value"..dump(value),{})
    LogDebug(1, "QuestSysLoadData DesObject: v"..dump(v),{})
    return v
end





Events.OnLoad.Add(OnServerStarted)
Events.OnServerStarted.Add(OnServerStarted)
Events.OnConnected.Add(OnConnectedServer)