MapLocation = {{x=7296,y=8388},{x=7252,y=8378},{x=7258,y=8431},{x=5499,y=9582},{x=12444,y=1609},{x=12458,y=3702},{x=13347,y=1295},{x=12417,y=3690},{x=12560,y=3696},{x=12583,y=3274},{x=13689,y=1779},{x=12363,y=1760},{x=12940,y=2076},{x=13943,y=3047},{x=12961,y=1379},{x=13217,y=3044},{x=13220,y=3087},{x=12560,y=1931},{x=13446,y=4077},{x=12375,y=1510},{x=12733,y=3969},{x=13240,y=1658},{x=10160,y=12761},{x=10876,y=10028},{x=10631,y=10405},{x=10610,y=10365},{x=6437,y=5269},{x=6082,y=5261},{x=7693,y=11873},{x=8089,y=11526},{x=8087,y=11512},{x=8138,y=11741},{x=5564,y=12476},{x=5464,y=9511},{x=13604,y=5668},{x=14556,y=4972},{x=11896,y=6880},{x=11898,y=6940},{x=8063,y=11735}}
MapLocation.Visited = {}
MapLocation.currentMission = Math.round(Math.random()*#MapLocation)
MapLocation.pointRadius = 0.3
MapLocation.distanceToWaypoint = 10

function GetCurrentMission()
    return MapLocation[MapLocation.currentMission]  

function LogDebug(level, str, d)

    local l = ""
    local dumper = d
    
    if level  == 1 then l = "DEBUG:" end
    if level  == 2 then l = "WARN:" end
    if level  == 3 then l = "ERROR:" end
        
    print(l.."QuestSystem - ".. str .. " Dumped: "..tostring(dumper).." END QuestSystem")
end
