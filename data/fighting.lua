--[[
UNIT_COST_ID = {}
UNIT_COST_ID.e_archer   = 0
UNIT_COST_ID.e_xbow     = 1
UNIT_COST_ID.e_spear    = 2
UNIT_COST_ID.e_pike     = 3
UNIT_COST_ID.e_mace     = 4
UNIT_COST_ID.e_sword    = 5
UNIT_COST_ID.e_knight   = 6
-- UNIT_COST_ID.???     = 7
-- UNIT_COST_ID.???     = 8
-- UNIT_COST_ID.???     = 9
UNIT_COST_ID.a_archer   = 10
UNIT_COST_ID.a_slave    = 11
UNIT_COST_ID.a_slinger  = 12
UNIT_COST_ID.a_assassin = 13
-- UNIT_COST_ID.???     = 14
UNIT_COST_ID.a_harcher  = 15
-- missing: engineer, ladderman, tunneler (7,8,9?); a_sword (14?), a_firethrower (16?); monk?
-- UNIT_COST_ID_LENGTH = 16?


function getUnitGoldAddress(unit)  -- displayed address?
  local UNIT_COST_BASE = 0x00AB8114  -- 1.?.?
	return UNIT_COST_BASE + 4 * UNIT_COST_INDICES[unit]
end

function getHPAddress(troop)
  local UNIT_HP_BASE = 0x00B4D960  -- 1.?.?
	return UNIT_HP_BASE + 4 * TROOP_INDICES[troop]
end

function getArrowDamageAddress(troop)
	local ARROW_DAMAGE_BASE = 0x00B4DAA0  -- 1.?.?
	return ARROW_DAMAGE_BASE + 4 * TROOP_ID[troop]
end

function getStoneDamageAddress(troop)
	local STONE_DAMAGE_BASE = 0x00B4DBE0  -- 1.?.?
	return STONE_DAMAGE_BASE + 4 * TROOP_INDICES[troop]
end

function getBoltDamageAddress(troop)
	local BOLT_DAMAGE_BASE = 0x00B4DD20  -- 1.?.?
	return BOLT_DAMAGE_BASE + 4 * TROOP_INDICES[troop]
end

function getDamageAddress(attacker, attacked)
-- knight vs peasant:   0xB50164
-- knight vs sword      0xB501CC
-- sword vs sword       0xB5008C
-- distance (byte): 320 = 0x140
-- distance          80 =  0x50

  local knight_base   = 0xB50160;  -- not 1.4.1
  local entry_size    = 0x140;  -- not 1.4.1
  local attacker_base = (TROOP_INDICES[attacker] - TROOP_INDICES.knight) * entry_size + knight_base
  local offset = 4 * TROOP_INDICES[attacked]
  return attacker_base + offset
end

function getBuildingHPAddress(building)
  local base = 0x005B9218  -- 1.?.?
return base + 4 * BUILDING_INDICES[building]
end

-- Health table: UnitID * 4 + 0xB4E960

-- Xbow dmg table: 0xB4ED20
-- Bow dmg table: 0xB4EAA0
-- Sling dmg table: 0xB4EBE0

-- Melee dmg table: 0xB4EE60 + (defenderID + 0x50 * attackerID)*4
--]]