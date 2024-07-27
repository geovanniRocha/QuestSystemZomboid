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
		out = {}
		LogDebug(1, "QuestSystem-DestinationReached", out)
		sendClientCommand(getPlayer(),'QuestSystem','DestinationReached', {})
		


		-- MapLocation.currentMission = Math.round(Math.random()*#MapLocation)	
		-- table.insert(MapLocation.Visited, MapLocation[MapLocation.currentMission])
		-- table.remove(MapLocation, MapLocation.currentMission )		
		-- TODO: Verificar edge case do ultimo item, como remove o indice fica n+1, o que é null por conta do remove, passar para softdelete? 
		-- alterar metodo para pegar o ultimo mapa inserido no mapLocation.Visited? assim tem o tracking,
		-- É pra ser facil, é so fazer o MapLocation.Visited[#MapLocation.Visited, o problema é usar essa info para fazer as acoes,
		-- O ideal é um soft delete com um helper para pegar quem não tem tag de Visited
		
	end
end

local function onserverCommandRec (module, command, args)

	if not module == 'QuestSystem' then return end
	if command ~= 'NextQuest' then return end
	MapLocation = args
	
	LogDebug(1, "location", args[args.currentMission]) 
end
Events.OnServerCommand.Add(onserverCommandRec)


