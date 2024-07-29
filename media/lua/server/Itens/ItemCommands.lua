
local function onClientCommandRec(module, command, player, data)
    
	if module ~= 'QuestSystem' then return end
    if command == 'DestinationReached' then
        local rand = ZombRandBetween(1,#MapLocation)
        if rand ==  MapLocation.currentMission then
            rand = ZombRandBetween(1,#MapLocation)
        end
        MapLocation.currentMission =  rand
        QuestSysSaveData()
        sendServerCommand("QuestSystem", 'NextQuest', MapLocation)
    elseif command == 'GetDestination' then
        sendServerCommand("QuestSystem", 'NextQuest', MapLocation)
    end
end

local function OnConnectedServer()
	sendServerCommand("QuestSystem", 'NextQuest', MapLocation)
end


local function OnServerStarted()
    MapLocation.currentMission = QuestSysLoadData()
    sendServerCommand("QuestSystem", 'NextQuest', MapLocation)  
end


function QuestSysSaveData ()
	output = getFileOutput("QuestSysProgress.save");
	output:writeInt(MapLocation.currentMission);
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
Events.OnClientCommand.Add(onClientCommandRec)
Events.OnConnected.Add(OnConnectedServer)