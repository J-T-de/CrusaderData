require("good_id")

AI_ID = {}
AI_ID.rat       = 1
AI_ID.snake     = 2
AI_ID.pig       = 3
AI_ID.wolf      = 4
AI_ID.saladin   = 5
AI_ID.caliph    = 6
AI_ID.sultan    = 7
AI_ID.richard   = 8
AI_ID.frederick = 9
AI_ID.philipp   = 10
AI_ID.wazir     = 11
AI_ID.emir      = 12
AI_ID.nizar     = 13
AI_ID.sheriff   = 14
AI_ID.marshal   = 15
AI_ID.abbot     = 16
AI_LENGTH       = 16

LORD_TYPE_ID = {}
LORD_TYPE_ID.euro = 1
LORD_TYPE_ID.arab = 2
LORD_TYPE_LENGTH  = 2

PLAYER_TYPE_ID = {}
PLAYER_TYPE_ID.human  = 1
PLAYER_TYPE_ID.ai     = 2
PLAYER_TYPE_LENGTH    = 2

PLAYER_OFFSET = 0x39F4  -- == 4 * 0xE7D
-- here could be potentially a 0xE7D = 3709 entry table with lots of things in it... number of resources, number of buildings, number of troops, %drunk, ... some important ones below


-- player always ranges from 1 up to 8 (no player 0)!

function getGoldAddress(player)
  local PLAYER_GOLD_BASE = 0x0115FCF8  -- 1.4.1
  return PLAYER_GOLD_BASE
  + PLAYER_OFFSET * (player - 1) 
end

function getPopularityAddress(player)
  local PLAYER_POPULARITY_BASE = 0x115F84C  -- 1.4.1
  return PLAYER_POPULARITY_BASE
  + PLAYER_OFFSET * (player - 1)
end  -- returns 0 - 10000

--[[ TODO: does not work for non-european units. suggests UNIT_COST_ID
function getTroopCountAddress(player, troop)
  local PLAYER_TROOP_COUNT_BASE = 0x116184C  -- 1.4.1
  return PLAYER_TROOP_COUNT_BASE
  + PLAYER_OFFSET * (player - 1)
  + 4 * TROOP_ID[troop]
end
--]]

function getGoodCountAddress(player, good)
  local PLAYER_GOOD_BASE = 0x0115FCBC  -- 1.4.1
  return PLAYER_GOOD_BASE
  + PLAYER_OFFSET * (player - 1)
  + 4 * GOOD_ID[good]
end