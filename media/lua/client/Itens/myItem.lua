require "TimedActions/ISCraftAction" 

local function FetchLocation()
	sendClientCommand(getPlayer(),'QuestSystem','GetDestination', {})
end


function QuestSystemMyItemOnCanPerform(recipe, player, item)
	if item and (item:getType() == "MyItem")   then	return true	end
	return false
end


local QuestSys_ISCraftAction_perform = ISCraftAction.perform
function ISCraftAction:perform()
    QuestSys_ISCraftAction_perform(self)
	if self.recipe and self.recipe:getOriginalname() == "Use MyItem" and self.item and self.item:getType() == "MyItem" then
		local questMission = QuestSystem:GetCurrentMission()
		local player = getPlayer()
		local playerX = player:getX()
		local playerY = player:getY()

		local d = QuestSys_GetDistance(playerX,playerY,questMission.x,questMission.y)
		local dir = QuestSys_GetDirection(playerX,playerY,questMission.x,questMission.y)
		if(d > QuestSystem:GetDistanceToWaypoint()) then
			player:Say("Estamos a ".. Math.round(d).." ".. dir .. " metros")
		else
			player:Say("Consegui as informações, ja tenho o proximo local")
			sendClientCommand(player,'QuestSystem','DestinationReached', {})
		end
	end
end

 
local function onserverCommandRec (module, command, args)

	if module ~= 'QuestSystem' then return end
	if command == 'NextQuest' then 
		LogDebug(1, "onserverCommandRec "..command, args)
		LogDebug(1, "onserverCommandRec "..command, {Serialize(QuestSystem.Visited)})
		QuestSystem.Visited = args
	end
	
end
Events.OnServerCommand.Add(onserverCommandRec)
Events.EveryOneMinute.Add(FetchLocation)


