function ZombRandBetween(min,max)
    if min > max then
        min, max = max, min
    end
    return math.random(min, max) 
end

QuestSystem = {
    MapLocation = {{x=7252,y=8378},{x=7258,y=8431},{x=5499,y=9582},{x=12444,y=1609},{x=12458,y=3702},{x=13347,y=1295},{x=12417,y=3690},{x=12560,y=3696}};
    Visited = {{x=7296,y=8388},{x=5499,y=9582},{x=12444,y=1609}};
    currentMission = 1;
    pointRadius = 0.3;
    distanceToWaypoint = 20;
    mapSize = 1000;

    GetCurrentMission = function (self)
        if(#self.Visited == 1) then
            self:NextMission()
        end
        return self.Visited[#self.Visited]
    end ;

    SetCurrentMission = function (self, value)
        self.currentMission = value
    end;

    NextMission = function (self)
        local rand = ZombRandBetween(1,#self.MapLocation)
        table.insert(self.Visited, self.MapLocation[rand])
        table.remove(self.MapLocation, rand)
    end;

    GetDistanceToWaypoint = function (self)
        return self.distanceToWaypoint
    end;

    GetMapSize = function (self)
        return self.mapSize
    end;

    GetPointRadius = function (self)
        return self.pointRadius
    end;        
}




function Serialize(visited)
    a = ""
    for i = 1, #visited, 1 do
        el = visited[i]
        a = a .. el.x ..","..el.y..";"
    end
    return a
end
b = "7296,8388;5499,9582;12444,1609;"

function deserialize(str) 
    t = {}
    for a, b in string.gmatch(str, "(%d+),(%d+);") do
        table.insert(t, {x = tonumber(a), y = tonumber(b)})
    end
    return t
end

print(deserialize(b))



doLuaDebug(QuestSystem)





t = {}
for i, el in ipairs(QuestSystem.MapLocation) do
        for index, value in ipairs(QuestSystem.Visited) do
        if(el.x == value.x and el.y == value.y) then            
            table.insert(t, i)
        end
    end
end
for i, _ in ipairs(t) do
    table.remove(QuestSystem.MapLocation, t.i)
end

print("end")







