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
		print("Used item")
		MapLocation.currentMission = Math.round(Math.random()*#MapLocation)	
		table.insert(MapLocation.Visited, MapLocation[MapLocation.currentMission])
		table.remove(MapLocation, MapLocation.currentMission )		
	end
end

