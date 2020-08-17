require("building_id")

BUILDING_RESOURCE = {}
BUILDING_RESOURCE.wood    = 0
BUILDING_RESOURCE.stone   = 1
BUILDING_RESOURCE.iron    = 2
BUILDING_RESOURCE.pitch   = 3
BUILDING_RESOURCE.gold    = 4
BUILDING_RESOURCE_LENGTH  = 5


function getBuildingCostAddress(building, resource)
  local BUILDING_COST_BASE = 0x01124CF4  -- 1.4.1
  return BUILDING_COST_BASE 
  + 4 * BUILDING_RESOURCE_LENGTH * BUILDING_ID[building]
  + 4 * BUILDING_RESOURCE[resource]
end

function getSiegEquipmentGoldAddress(siege_equipment)
  -- Redundant, but might be helpful
  return getBuildingCostAddress(siege_equipment, gold)
end


--[[ TODO: check
BUILDING_MATERAL_INDICES = {}
BUILDING_MATERAL_INDICES.wood   = 0
BUILDING_MATERAL_INDICES.stone  = 1
BUILDING_MATERAL_INDICES.iron   = 2
BUILDING_MATERAL_INDICES.pitch  = 3
BUILDING_MATERAL_INDICES.gold   = 4
BUILDING_MATERAL_INDICES.count  = 5  -- ?


function getBuildingCostAddress(building, material)  -- ?
  -- uses relative adresses with square_tower as base;
  local ref = 0x11242f0  -- 1.?.?
  local base = ref + 4 * BUILDING_MATERAL_INDICES.count * (BUILDING_INDICES[building] - BUILDING_INDICES.square_tower)
  return base + 4 * BUILDING_MATERAL_INDICES[material]
end
--]]