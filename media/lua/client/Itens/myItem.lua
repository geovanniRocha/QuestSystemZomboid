require "TimedActions/ISCraftAction" 

function QuestSystemMyItemOnCanPerform(recipe, player, item)

	
	if item and (item:getType() == "MyItem")   then	return true	end
	return false
end

function QuestSys_GetDistance (x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

function QuestSys_GetDirection(playerX, playerY, missionX, missionY)
    local dx = missionX - playerX
    local dy = missionY - playerY
    local angle = Math.atan(dy / dx)
	angle = angle * 57.2957795131
	if dx < 0 and dy >= 0 then
		angle = angle + 180
	elseif dx < 0 and dy < 0 then
		angle = angle + 180
	elseif dx >= 0 and dy < 0 then
		angle = angle + 360
	end

    if (angle >= 337.5 or angle < 22.5) then return "N"
    elseif (angle >= 22.5 and angle < 67.5) then return "NE"
    elseif (angle >= 67.5 and angle < 112.5) then return "L"
    elseif (angle >= 112.5 and angle < 157.5) then return "SE"
    elseif (angle >= 157.5 and angle < 202.5) then return "S"
    elseif (angle >= 202.5 and angle < 247.5) then return "SO"
    elseif (angle >= 247.5 and angle < 292.5) then return "O"
    elseif (angle >= 292.5 and angle < 337.5) then return "NO" end
end

function QuestSys_GetDistance (x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

function QuestSys_GetDirection(playerX, playerY, missionX, missionY)
    local dx = missionX - playerX
    local dy = missionY - playerY
    local angle = Math.atan(dy / dx)
	angle = angle * 57.2957795131
	if dx < 0 and dy >= 0 then
		angle = angle + 180
	elseif dx < 0 and dy < 0 then
		angle = angle + 180
	elseif dx >= 0 and dy < 0 then
		angle = angle + 360
	end

    if (angle >= 337.5 or angle < 22.5) then return "N"
    elseif (angle >= 22.5 and angle < 67.5) then return "NE"
    elseif (angle >= 67.5 and angle < 112.5) then return "L"
    elseif (angle >= 112.5 and angle < 157.5) then return "SE"
    elseif (angle >= 157.5 and angle < 202.5) then return "S"
    elseif (angle >= 202.5 and angle < 247.5) then return "SO"
    elseif (angle >= 247.5 and angle < 292.5) then return "O"
    elseif (angle >= 292.5 and angle < 337.5) then return "NO" end
end

local QuestSys_ISCraftAction_perform = ISCraftAction.perform
function ISCraftAction:perform()
    QuestSys_ISCraftAction_perform(self)
	if self.recipe and self.recipe:getOriginalname() == "Use MyItem" and self.item and self.item:getType() == "MyItem" then
		local d = QuestSys_GetDistance(getPlayer():getX(),getPlayer():getY(),GetCurrentMission().x,GetCurrentMission().y)
		local dir = QuestSys_GetDirection(getPlayer():getX(),getPlayer():getY(),GetCurrentMission().x,GetCurrentMission().y)
		if(d > MapLocation.distanceToWaypoint) then
			getPlayer():Say("Estamos a ".. Math.round(d).." ".. dir .. " metros")
		else
			getPlayer():Say("Consegui as informações, ja tenho o proximo local")
			sendClientCommand(getPlayer(),'QuestSystem','DestinationReached', {})

		end
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

