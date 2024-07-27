require "TimedActions/ISCraftAction" 

function QuestSystemMyItemOnCanPerform(recipe, player, item)
	if item and (item:getType() == "MyItem") then
		return true
	end
	return false
end


local QuestSys_ISCraftAction_perform = ISCraftAction.perform
function ISCraftAction:perform()
    QuestSys_ISCraftAction_perform(self)
	if self.recipe and self.recipe:getOriginalname() == "Use MyItem" and self.item and self.item:getType() == "MyItem" then
		LogDebug(1, "QuestSystem-DestinationReached", out)
		sendClientCommand(getPlayer(),'QuestSystem','DestinationReached', {})
	end
end

local function onserverCommandRec (module, command, args)

	if not module == 'QuestSystem' then return end
	if command ~= 'NextQuest' then return end
	MapLocation = args
	
end
Events.OnServerCommand.Add(onserverCommandRec)

local function OnConnected()
	sendClientCommand(getPlayer(),'QuestSystem','GetDestination', {})
end

Events.OnConnected.Add(OnConnected)
