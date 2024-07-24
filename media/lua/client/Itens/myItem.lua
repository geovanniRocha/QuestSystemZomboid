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
		LootMaps.Init.StashMapQuestSys2 = function(mapUI)
			local x = Math.floor(Math.random()*10000)
			local y = Math.floor(Math.random()*10000+4800)
			local offset = 1000
			local mapAPI = mapUI.javaObject:getAPIv1()
			MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
			MapUtils.initDefaultStyleV1(mapUI)
			-- replaceWaterStyle(mapUI)
			mapAPI:setBoundsInSquares(x, y, x+offset, y+offset)
			MapUtils.overlayPaper(mapUI)
		end
	end
end

