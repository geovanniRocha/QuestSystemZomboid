function ZombRandBetween(min,max)
    if min > max then
        min, max = max, min
    end
    return math.random(min, max) 
end

QuestSystem = {
    MapLocation = {{x=7296,y=8388},{x=7252,y=8378},{x=7258,y=8431},{x=5499,y=9582},{x=12444,y=1609},{x=12458,y=3702},{x=13347,y=1295},{x=12417,y=3690},{x=12560,y=3696},{x=12583,y=3274},{x=13689,y=1779},{x=12363,y=1760},{x=12940,y=2076},{x=13943,y=3047},{x=12961,y=1379},{x=13217,y=3044},{x=13220,y=3087},{x=12560,y=1931},{x=13446,y=4077},{x=12375,y=1510},{x=12733,y=3969},{x=13240,y=1658},{x=10160,y=12761},{x=10876,y=10028},{x=10631,y=10405},{x=10610,y=10365},{x=6437,y=5269},{x=6082,y=5261},{x=7693,y=11873},{x=8089,y=11526},{x=8087,y=11512},{x=8138,y=11741},{x=5564,y=12476},{x=5464,y=9511},{x=13604,y=5668},{x=14556,y=4972},{x=11896,y=6880},{x=11898,y=6940},{x=8063,y=11735}};
    Visited = {};
    currentMission = 1;
    pointRadius = 0.3;
    distanceToWaypoint = 20;
    mapSize = 1000;

    GetCurrentMission = function (self)
        if(#self.Visited == 0) then
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
    end
}


print(QuestSystem:GetCurrentMission().x)
print(QuestSystem:NextMission())
print(QuestSystem:GetCurrentMission().x)


print(QuestSystem)

