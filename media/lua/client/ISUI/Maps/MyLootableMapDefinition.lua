--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

MapUtils = MapUtils or {}

function MapUtils.initDirectoryMapData(mapUI, directory)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local file = directory..'/worldmap-forest.xml'
	if fileExists(file) then
		mapAPI:addData(file)
	end
	file = directory..'/worldmap.xml'
	if fileExists(file) then
		mapAPI:addData(file)
	end

	-- This call indicates the end of XML data files for the directory.
	-- If map features exist for a particular cell in this directory,
	-- then no data added afterwards will be used for that same cell.
	mapAPI:endDirectoryData()

	mapAPI:addImages(directory)
end

function MapUtils.initDefaultMapData(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	mapAPI:clearData()
	-- Add data from highest priority (mods) to lowest priority (vanilla)
	local dirs = getLotDirectories()
	for i=1,dirs:size() do
		MapUtils.initDirectoryMapData(mapUI, 'media/maps/'..dirs:get(i-1))
	end
end

local MINZ = 0
local MAXZ = 24

local WATER_TEXTURE = false 

function MapUtils.initDefaultStyleV1(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()

	local r,g,b = 219/255, 215/255, 192/255
	mapAPI:setBackgroundRGBA(r, g, b, 1.0)
	mapAPI:setUnvisitedRGBA(r * 0.915, g * 0.915, b * 0.915, 1.0)
	mapAPI:setUnvisitedGridRGBA(r * 0.777, g * 0.777, b * 0.777, 1.0)

	styleAPI:clear()

	local layer = styleAPI:newPolygonLayer("forest")
	layer:setMinZoom(13.5)
	layer:setFilter("natural", "forest")
	if true then
		layer:addFill(MINZ, 189, 197, 163, 0)
		layer:addFill(13.5, 189, 197, 163, 0)
		layer:addFill(14, 189, 197, 163, 255)
		layer:addFill(MAXZ, 189, 197, 163, 255)
	else
		layer:addFill(MINZ, 255, 255, 255, 255)
		layer:addFill(MAXZ, 255, 255, 255, 255)
		layer:addTexture(MINZ, "media/textures/worldMap/Grass.png")
		layer:addTexture(MAXZ, "media/textures/worldMap/Grass.png")
		layer:addScale(13.5, 4.0)
		layer:addScale(MAXZ, 4.0)
	end
	
	layer = styleAPI:newPolygonLayer("water")
	layer:setMinZoom(MINZ)
	layer:setFilter("water", "river")
	if not WATER_TEXTURE then
		layer:addFill(MINZ, 59, 141, 149, 255)
		layer:addFill(MAXZ, 59, 141, 149, 255)
	else
		layer:addFill(MINZ, 59, 141, 149, 255)
		layer:addFill(14.5, 59, 141, 149, 255)
		layer:addFill(14.5, 255, 255, 255, 255)
		layer:addTexture(MINZ, nil)
		layer:addTexture(14.5, nil)
		layer:addTexture(14.5, "media/textures/worldMap/Water.png")
		layer:addTexture(MAXZ, "media/textures/worldMap/Water.png")
--		layer:addScale(MINZ, 4.0)
--		layer:addScale(MAX, 4.0)
	end

	layer = styleAPI:newPolygonLayer("road-trail")
	layer:setMinZoom(12.0)
	layer:setFilter("highway", "trail")
	layer:addFill(12.25, 185, 122, 87, 0)
	layer:addFill(13, 185, 122, 87, 255)
	layer:addFill(MAXZ, 185, 122, 87, 255)

	layer = styleAPI:newPolygonLayer("road-tertiary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "tertiary")
	layer:addFill(11.5, 171, 158, 143, 0)
	layer:addFill(13, 171, 158, 143, 255)
	layer:addFill(MAXZ, 171, 158, 143, 255)

	layer = styleAPI:newPolygonLayer("road-secondary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "secondary")
	layer:addFill(MINZ, 134, 125, 113, 255)
	layer:addFill(MAXZ, 134, 125, 113, 255)

	layer = styleAPI:newPolygonLayer("road-primary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "primary")
	layer:addFill(MINZ, 134, 125, 113, 255)
	layer:addFill(MAXZ, 134, 125, 113, 255)

	layer = styleAPI:newPolygonLayer("railway")
	layer:setMinZoom(14.0)
	layer:setFilter("railway", "*")
	layer:addFill(MINZ, 200, 191, 231, 255)
	layer:addFill(MAXZ, 200, 191, 231, 255)

	-- Default, same as building-Residential
	layer = styleAPI:newPolygonLayer("building")
	layer:setMinZoom(13.0)
	layer:setFilter("building", "yes")
	layer:addFill(13.0, 210, 158, 105, 0)
	layer:addFill(13.5, 210, 158, 105, 255)
	layer:addFill(MAXZ, 210, 158, 105, 255)

	layer = styleAPI:newPolygonLayer("building-Residential")
	layer:setMinZoom(13.0)
	layer:setFilter("building", "Residential")
	layer:addFill(13.0, 210, 158, 105, 0)
	layer:addFill(13.5, 210, 158, 105, 255)
	layer:addFill(MAXZ, 210, 158, 105, 255)

	layer = styleAPI:newPolygonLayer("building-CommunityServices")
	layer:setMinZoom(13.0)
	layer:setFilter("building", "CommunityServices")
	layer:addFill(13.0, 139, 117, 235, 0)
	layer:addFill(13.5, 139, 117, 235, 255)
	layer:addFill(MAXZ, 139, 117, 235, 255)

	layer = styleAPI:newPolygonLayer("building-Hospitality")
	layer:setMinZoom(13.0)
	layer:setFilter("building", "Hospitality")
	layer:addFill(13.0, 127, 206, 225, 0)
	layer:addFill(13.5, 127, 206, 225, 255)
	layer:addFill(MAXZ, 127, 206, 225, 255)

	layer = styleAPI:newPolygonLayer("building-Industrial")
	layer:setMinZoom(13.0)
	layer:setFilter("building", "Industrial")
	layer:addFill(13.0, 56, 54, 53, 0)
	layer:addFill(13.5, 56, 54, 53, 255)
	layer:addFill(MAXZ, 56, 54, 53, 255)

	layer = styleAPI:newPolygonLayer("building-Medical")
	layer:setMinZoom(13.0)
	layer:setFilter("building", "Medical")
	layer:addFill(13.0, 229, 128, 151, 0)
	layer:addFill(13.5, 229, 128, 151, 255)
	layer:addFill(MAXZ, 229, 128, 151, 255)

	layer = styleAPI:newPolygonLayer("building-RestaurantsAndEntertainment")
	layer:setMinZoom(13.0)
	layer:setFilter("building", "RestaurantsAndEntertainment")
	layer:addFill(13.0, 245, 225, 60, 0)
	layer:addFill(13.5, 245, 225, 60, 255)
	layer:addFill(MAXZ, 245, 225, 60, 255)

	layer = styleAPI:newPolygonLayer("building-RetailAndCommercial")
	layer:setMinZoom(13.0)
	layer:setFilter("building", "RetailAndCommercial")
	layer:addFill(13.0, 184, 205, 84, 0)
	layer:addFill(13.5, 184, 205, 84, 255)
	layer:addFill(MAXZ, 184, 205, 84, 255)
end

function MapUtils.overlayPaper(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:newTextureLayer("paper")
	layer:setMinZoom(0.00)
	local x1 = mapAPI:getMinXInSquares()
	local y1 = mapAPI:getMinYInSquares()
	local x2 = mapAPI:getMaxXInSquares() + 1
	local y2 = mapAPI:getMaxYInSquares() + 1
	layer:setBoundsInSquares(x1, y1, x2, y2)
	layer:setTile(true)
	layer:setUseWorldBounds(true)
	layer:addFill(14.00, 128, 128, 128, 0)
	layer:addFill(15.00, 128, 128, 128, 32)
	layer:addFill(15.00, 255, 255, 255, 32)
	layer:addTexture(0.00, "media/white.png")
	layer:addTexture(15.00, "media/white.png")
	layer:addTexture(15.00, "media/textures/worldMap/Paper.png")
end

function MapUtils.revealKnownArea(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local x1 = mapAPI:getMinXInSquares()
	local y1 = mapAPI:getMinYInSquares()
	local x2 = mapAPI:getMaxXInSquares()
	local y2 = mapAPI:getMaxYInSquares()
	WorldMapVisited.getInstance():setKnownInSquares(x1, y1, x2, y2)
end

-----

local function replaceWaterStyle(mapUI)
	if not WATER_TEXTURE then return end
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:getLayerByName("water")
	if not layer then return end
	layer:setMinZoom(MINZ)
	layer:setFilter("water", "river")
	layer:removeAllFill()
	layer:removeAllTexture()
	layer:addFill(MINZ, 59, 141, 149, 255)
	layer:addFill(MAXZ, 59, 141, 149, 255)
end

local function overlayPNG(mapUI, x, y, scale, layerName, tex, alpha)
	local texture = getTexture(tex)
	if not texture then return end
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:newTextureLayer(layerName)
	layer:setMinZoom(MINZ)
	layer:addFill(MINZ, 255, 255, 255, (alpha or 1.0) * 255)
	layer:addTexture(MINZ, tex)
	layer:setBoundsInSquares(x, y, x + texture:getWidth() * scale, y + texture:getHeight() * scale)
end

local function overlayPNG3(mapUI, x, y, scale, tex, alpha)
	local texture = getTexture(tex)
	if not texture then return end
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:newTextureLayer("lootMapPNG")
	layer:setMinZoom(MINZ)
	layer:addFill(MINZ, 255, 255, 255, (alpha or 1.0) * 255)
	layer:addTexture(MINZ, tex)
	layer:setBoundsInSquares(x - texture:getWidth() * scale / 2, y - texture:getHeight() * scale / 2, x + texture:getWidth() * scale / 2 , y + texture:getHeight() * scale / 2 )
end

LootMaps.Init.StashMapQuestSys2 = function(mapUI)
	local x = QuestSystem:GetCurrentMission().x  or 0 
	local y = QuestSystem:GetCurrentMission().y  or 0 
	local roundX = Math.round( x / 1000) * 1000
	local roundY = Math.round( y / 1000) * 1000
	local mapSize = QuestSystem:GetMapSize() or 1000
	local radius = QuestSystem:GetPointRadius() or 0.5

	local mapAPI = mapUI.javaObject:getAPIv1()
	MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	MapUtils.initDefaultStyleV1(mapUI)
	overlayPNG3(mapUI, x, y, radius, "media/textures/worldMap/handdrawCircle.png")
	mapAPI:setBoundsInSquares(roundX-mapSize/2, roundY-mapSize/2, roundX+mapSize/2, roundY+mapSize/2)
	MapUtils.overlayPaper(mapUI)
end


