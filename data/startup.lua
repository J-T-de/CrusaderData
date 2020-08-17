require("good_id")

GAME_TYPE_ID = {}
GAME_TYPE_ID.normal     = 1
GAME_TYPE_ID.crusader   = 2
GAME_TYPE_ID.deathmatch = 3
GAME_TYPE_LENGTH        = 3

GAME_DIFFICULTY_ID = {}
GAME_DIFFICULTY_ID.human_big  = 1
GAME_DIFFICULTY_ID.human      = 2
GAME_DIFFICULTY_ID.balanced   = 3
GAME_DIFFICULTY_ID.ai         = 4
GAME_DIFFICULTY_ID.ai_big     = 5
GAME_DIFFICULTY_LENGTH        = 5

UNIT_STARTUP_ID = {}
-- UNIT_STARTUP_ID.???        = 0 -- does not spawn anything, always zero
UNIT_STARTUP_ID.e_archer      = 1
UNIT_STARTUP_ID.e_xbow        = 2
UNIT_STARTUP_ID.e_spear       = 3
UNIT_STARTUP_ID.e_pike        = 4
UNIT_STARTUP_ID.e_mace        = 5
UNIT_STARTUP_ID.e_sword       = 6
UNIT_STARTUP_ID.e_knight      = 7
-- UNIT_STARTUP_ID.???        = 8  -- does not get spawned, but most likely ladderman (ai uses startup units as initial defense, so ladderman don't make sense)
UNIT_STARTUP_ID.e_engineer    = 9
UNIT_STARTUP_ID.e_monk        = 10
UNIT_STARTUP_ID.a_archer      = 11
UNIT_STARTUP_ID.a_slave       = 12
UNIT_STARTUP_ID.a_slinger     = 13
UNIT_STARTUP_ID.a_assasin     = 14
UNIT_STARTUP_ID.a_haracher    = 15
UNIT_STARTUP_ID.a_sword       = 16
UNIT_STARTUP_ID.a_firethrower = 17
UNIT_STARTUP_ID.s_fballista   = 18 -- spawns unmanned fire_ballista, ai does not seem to man it
-- UNIT_STARTUP_ID.???        = 19 -- completely bugged: displays archers, but just adds 10 unusable peasants (could replace this with e_tunneler)
UNIT_STARTUP_LENGTH           = 20


-- AI_STARTUP_UNIT_BASE = 0x0000614444  -- 1.3.0
AI_STARTUP_UNIT_BASE = 0x0000615444  -- 1.4.1
AI_STARTUP_UNIT_AOB = "00 00 00 00 00 00 00 00 00 00 00 00 0C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 28 00 00 00"

function getAIUnitStartupAddress(ai, game_type, unit)
  return AI_STARTUP_UNIT_BASE
  + 4 * UNIT_STARTUP_LENGTH * GAME_TYPE_LENGTH * (AI_ID[ai] - 1)
  + 4 * UNIT_STARTUP_LENGTH * (GAME_TYPE_ID[game_type] - 1)
  + 4 * UNIT_STARTUP_ID[unit]
end

function getPlayerUnitStartupAddress(lord_type, game_type, unit)
  -- similar to getAIStartupTroopAddress, but
  -- +4 -- 1.3.1
  -- +something -- 1.4.1
  -- and ai_id==17 for euro and ai_id==18 for arab lord
  return AI_STARTUP_UNIT_BASE + something -- 1.4.1
  + 4 * UNIT_STARTUP_LENGTH * GAME_TYPE_LENGTH * (17 + (LORD_TYPE_ID[lord_type] - 1))
  + 4 * UNIT_STARTUP_LENGTH * (GAME_TYPE_ID[game_type] - 1)
  + 4 * UNIT_STARTUP_ID[unit]
end

STARTUP_GOLD_BASE = 0x00615680  -- 1.3.0
STARTUP_GOLD_AOB = "40 1F 00 00 D0 07 00 00 A0 0F 00 00 D0 07 00 00 D0 07 00 00 D0 07 00 00 D0 07 00 00 A0 0F 00 00 D0 07 00 00 40 1F 00 00 40 1F 00 00 D0 07 00 00 A0 0F 00 00 D0 07 00 00 D0 07 00 00 D0 07 00 00 D0 07 00 00 A0 0F 00 00 D0 07 00 00 40 1F 00 00 40 9C 00 00 B8 0B 00 00 20 4E 00 00 58 1B 00 00 10 27 00 00 10 27 00 00 58 1B 00 00 20 4E 00 00 B8 0B 00 00 40 9C 00 00"

function getStartupGoldAddress(game_type, game_difficulty, player_type)
  return STARTUP_GOLD_BASE
  + 4 * PLAYER_TYPE_LENGTH * GAME_DIFFICULTY_LENGTH * (GAME_TYPE_ID[game_type] - 1)
  + 4 * PLAYER_TYPE_LENGTH * GAME_DIFFICULTY_ID[game_difficulty]
  + 4 * PLAYER_TYPE_ID[player_type]
end