require("util")

-- This is the base address that is used for any map data accesses
local MapDataBaseAddressName = '"Stronghold Crusader.exe"+1693208'
-- The following two offsets are probably used when iterating over the positions that belong to a building
local MapDataSecondOffset    = 0x554990
local MapDataFirstOffset     = 0x55498C
local MapDataAreaOffset      = 0x554984


-- entry = 196 * [BUILDING SIZE] + [TILE_ID]
local TileFirstCoordinateOffsetArray = MakeStridedArray('"Stronghold Crusader.exe"+AD31E0', 24, 4, "First Coordinate Tile Offsets")
local TileFirstCoordinateOffsetArray = MakeStridedArray('"Stronghold Crusader.exe"+AD31E4', 24, 4, "Second Coordinate Tile Offsets")


local FirstCoordinateOffsetArray = MakeStridedArray('"Stronghold Crusader.exe"+1F37300', 12, 4, "First Coordinate Offsets")

-- Maps
BuildingIndexMap = MakeStridedArray(MapDataBaseAddressName .. '+2029B0', 2, 2)			-- alternative: "Stronghold Crusader.exe"+1895BB8
FlagsMap         = MakeStridedArray(MapDataBaseAddressName .. '+165160', 4, 4)          -- alt:  -- 1024 is set when placing a building? // 10000000
HeightMap        = MakeStridedArray(MapDataBaseAddressName .. '+29FA30', 1, 1)			-- alt: "Stronghold Crusader.exe"+1932C38
Unknown2Map      = MakeStridedArray(MapDataBaseAddressName .. '+1C7B80', 1, 1)			-- Set to 2 when building is placed
BuildingTypeMap  = MakeStridedArray(MapDataBaseAddressName .. '+229DD0', 1, 1)

GlobalBuildingLookupOffset = 0x002029B0
GlobalBuildingLookupStride = 2

function Coordinate2BuildingOffset(first, second)
	local base_address = getAddress(MapDataBaseAddressName)
	local result_address = '"Stronghold Crusader.exe"+1F37300'
	local result = FirstCoordinateOffsetArray:read(second)
	return result + first
end

function read_map_raw(source_array)
	local data = {}
	for i=0,399 do
		data[i] = {}
		for j=0, 399 do
			data[i][j] = source_array:read(400*i+j)
		end
	end
	return data
end

function read_map_coordinates(source_array)
	local data = {}
	for i=14, 386 do
		data[i-13] = {}
		for j=0, 399 do
			local value = source_array:read(Coordinate2BuildingOffset(j, i))
			if value ~= 0 then 
				print(i, " ", j)
			end
			data[i-13][j+1] = value
		end
	end
	return data
end

function DEBUG_save_map_csv(target_file, data, sep)
	if sep == nil then 
		sep = ","
	end
	local file = io.open(target_file, "w")
	for i, row in ipairs(data) do
		for j, v in ipairs(row) do
			file:write(v)
		end
		file:write("\n")
	end
	file:close()
end

function DEBUG_maps()
	DEBUG_save_map_csv("bldidx_map.txt", read_map_coordinates(BuildingIndexMap), "")
	--[[
	DEBUG_save_map_csv("flags_map.csv", read_map_raw(FlagsMap))
	DEBUG_save_map_csv("u01_map.csv", read_map_raw(Unknown1Map))
	DEBUG_save_map_csv("u02_map.csv", read_map_raw(Unknown2Map))
	DEBUG_save_map_csv("bldtype_map.csv", read_map_raw(BuildingTypeMap))
	]]
end

DEBUG_maps()
