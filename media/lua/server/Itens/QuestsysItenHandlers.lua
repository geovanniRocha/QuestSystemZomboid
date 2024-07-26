
HandleQuestSystem = function (module, command, player, data)
	if module ~= "QuestSystem" then return end
    if command == "DestinationReached" then
        debugger()
        MapLocation.currentMission = ZombRandBetween(1,#MapLocation) 
        sendServerCommand(player, module, "NextQuest", MapLocation)
    end
end
Events.OnClientCommand.Add(handleQuestSystem)
