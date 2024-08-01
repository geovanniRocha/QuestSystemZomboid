 

function LogDebug(level, str, d) 
    local l = ""
    local dumper = dump(d) or {}

    if level  == 1 then l = "DEBUG:" end
    if level  == 2 then l = "WARN:" end
    if level  == 3 then l = "ERROR:" end

    print(l.."QuestSystem - ".. str .. " Dumped: "..tostring(dumper).." END QuestSystem")
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

    if (angle >= 337.5 or angle < 22.5) then return "E"
    elseif (angle >= 22.5 and angle < 67.5) then return "SE"
    elseif (angle >= 67.5 and angle < 112.5) then return "S"
    elseif (angle >= 112.5 and angle < 157.5) then return "SO"
    elseif (angle >= 157.5 and angle < 202.5) then return "O"
    elseif (angle >= 202.5 and angle < 247.5) then return "NO"
    elseif (angle >= 247.5 and angle < 292.5) then return "N"
    elseif (angle >= 292.5 and angle < 337.5) then return "NE" end
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

function Serialize(visited)
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

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for i = 1, #o, 1 do
        k = i
        v = o[i]
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end