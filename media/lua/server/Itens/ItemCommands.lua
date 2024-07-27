
local function onClientCommandRec(module, command, player, data)
    
	if module ~= 'QuestSystem' then return end
    if command == 'DestinationReached' then
        MapLocation.currentMission = ZombRandBetween(1,#MapLocation) 
        sendServerCommand("QuestSystem", 'NextQuest', MapLocation)
    end
end
Events.OnClientCommand.Add(onClientCommandRec)