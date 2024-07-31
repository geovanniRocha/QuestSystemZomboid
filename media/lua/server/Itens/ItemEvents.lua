
local function onClientCommandRec(module, command, player, data)
	if module ~= 'QuestSystem' then return end
    if command == 'DestinationReached' then
        QuestSystem:NextMission() 
        QuestSysSaveData()
        sendServerCommand("QuestSystem", 'NextQuest', QuestSystem:GetVaribles())
    elseif command == 'GetDestination' then
        sendServerCommand("QuestSystem", 'NextQuest', QuestSystem:GetVaribles())
    end
end

Events.OnClientCommand.Add(onClientCommandRec)

local function OnConnectedServer()
	sendServerCommand("QuestSystem", 'NextQuest', QuestSystem:GetVaribles())
end


local function OnServerStarted()
    -- QuestSystem:SetCurrentMission() 
    QuestSystem.Visited = QuestSysLoadData()
    sendServerCommand("QuestSystem", 'NextQuest', QuestSystem:GetVaribles())  
end




function QuestSysSaveData ()
	output = getFileOutput("QuestSysProgress.save");
    -- QuestSystem.GetCurrentMission()
	output:writeChars(serialize(QuestSystem.Visited));
	endFileOutput();
end


function QuestSysLoadData()
    input = getFileInput("QuestSysProgress.save");
    local value = 1
	if input ~= nil then
		value = input:readUTF();
		endFileInput();
	end
    local v = deserialize(value)
    removeDuplicate()
    return v
end




function removeDuplicate()
    t = {}
        for i = 1, #QuestSystem.MapLocation, 1 do
            el = QuestSystem.MapLocation[i]
            for i = 1, #QuestSystem.Visited, 1 do
                value = QuestSystem.Visited[i]
                if(el.x == value.x and el.y == value.y) then            
                    table.insert(t, i)
            end
        end
    end
    for i = 1, #t, 1 do
        table.remove(QuestSystem.MapLocation, i)
    end
end

function serialize(visited)
    if visited == nil then return end
    str = ""
    for i = 1, #visited, 1 do
        el = visited[i]
        str = str .. el.x ..","..el.y..";"
        
    end
    return str
end


function deserialize(str) 
    t = {}
    for a, b in string.gmatch(str, "(%d+),(%d+);") do
        table.insert(t, {x = tonumber(a), y = tonumber(b)})
    end
    return t
end



Events.OnLoad.Add(OnServerStarted)
Events.OnServerStarted.Add(OnServerStarted)
Events.OnConnected.Add(OnConnectedServer)