require("util")
require("map")
require("UnitIndices")

BuildingData = {}
BuildingData.MaxWorkers = MakeStridedArray('"Stronghold Crusader.exe"+1B8B58', 4, 2, "Max Workers")
BuildingData.Opaque = MakeStridedArray('"Stronghold Crusader.exe"+1B8F30', 4, 2, "Opaque")
BuildingData.CostWood = MakeStridedArray('"Stronghold Crusader.exe"+D24CF4', 20, 4, "Wood Cost")
BuildingData.CostStone = MakeStridedArray('"Stronghold Crusader.exe"+D24CF8', 20, 4, "Stone Cost")
BuildingData.CostIron = MakeStridedArray('"Stronghold Crusader.exe"+D24CFC', 20, 4, "Iron Cost")
BuildingData.CostPitch = MakeStridedArray('"Stronghold Crusader.exe"+D24D00', 20, 4, "Pitch Cost")
BuildingData.CostGold = MakeStridedArray('"Stronghold Crusader.exe"+D24D04', 20, 4, "Gold Cost")
BuildingData.MaxHP = MakeStridedArray('"Stronghold Crusader.exe"+1BA218', 4, 2, "Max HP")

AIParametersBase = '"Stronghold Crusader.exe"+1FFCB8C'
BuildingArrayBase = '"Stronghold Crusader.exe"+B9884c'

-- specs --
-- AI constants
StructAI = StructSpec:declare_array("AI", 4, {"Unknown000", "Unknown001", "Unknown002", "Unknown003", "Unknown004", "Unknown005",
	"CriticalPopularity", "LowestPopularity", "HighestPopularity", "TaxesMin", "TaxesMax", "Unknown011", "Farm1",
	"Farm2", "Farm3", "Farm4", "Farm5", "Farm6", "Farm7", "Farm8", "PopulationPerFarm", "PopulationPerWoodcutter",
	"PopulationPerQuarry", "PopulationPerIronmine", "PopulationPerPitchrig", "MaxQuarries", "MaxIronmines", "MaxWoodcutters",
	"MaxPitchrigs", "MaxFarms", "BuildInterval", "ResourceRebuildDelay", "MaxFood", "MinimumApples", "MinimumCheese", 
	"MinimumBread", "MinimumWheat", "MinimumHop", "TradeAmountFood", "TradeAmountEquipment", "Unknown040", "MinimumGoodsRequiredAfterTrade",
	"DoubleRationsFoodThreshold", "MaxWood", "MaxStone", "MaxResourceOther", "MaxEquipment", "MaxBeer", "MaxResourceVariance", "RecruitGoldThreshold",
	"BlacksmithSetting", "FletcherSetting", "PoleturnerSetting", "SellResource01", "SellResource02", "SellResource03", "SellResource04", "SellResource05",
	"SellResource06", "SellResource07", "SellResource08", "SellResource09", "SellResource10", "SellResource11", "SellResource12", "SellResource13", 
	"SellResource14", "SellResource15", "DefWallPatrolRallyTime", "DefWallPatrolGroups", "DefSiegeEngineGoldThreshold", "DefSiegeEngineBuildDelay",
	"Unknown072", "Unknown073", "RecruitProbDefDefault", "RecruitProbDefWeak", "RecruitProbDefStrong", "RecruitProbRaidDefault", "RecruitProbRaidWeak",
	"RecruitProbRaidStrong", "RecruitProbAttackDefault", "RecruitProbAttackWeak", "RecruitProbAttackStrong", "SortieUnitRangedMin", "SortieUnitRanged",
	"SortieUnitMeleeMin", "SortieUnitMelee", "DefDiggingUnitMax", "DefDiggingUnit", "RecruitInterval", "RecruitIntervalWeak", "RecruitIntervalStrong",
	"DefTotal", "OuterPatrolGroupsCount", "OuterPatrolGroupsMove", "OuterPatrolRallyDelay", "DefWalls", "DefUnit1", "DefUnit2", "DefUnit3", "DefUnit4",
	"DefUnit5", "DefUnit6", "DefUnit7", "DefUnit8", "RaidUnitsBase", "RaidUnitsRandom", "RaidUnit1", "RaidUnit2", "RaidUnit3", "RaidUnit4", "RaidUnit5",
	"RaidUnit6", "RaidUnit7", "RaidUnit8", "HarassingSiegeEngine1", "HarassingSiegeEngine2", "HarassingSiegeEngine3", "HarassingSiegeEngine4", 
	"HarassingSiegeEngine5", "HarassingSiegeEngine6", "HarassingSiegeEngine7", "HarassingSiegeEngine8", "HarassingSiegeEnginesMax", "Unknown124",
	"AttForceBase", "AttForceRandom", "AttForceSupportAllyThreshold", "AttForceRallyPercentage", "Unknown129", "Unknown130", "Unknown131", "Unknown132",
	"SiegeEngine1", "SiegeEngine2", "SiegeEngine3", "SiegeEngine4", "SiegeEngine5", "SiegeEngine6", "SiegeEngine7", "SiegeEngine8", "CowThrowInterval",
	"Unknown142", "AttMaxEngineers", "AttDiggingUnit", "AttDiggingUnitMax", "AttUnit2", "AttUnit2Max", "AttMaxAssassins", "AttMaxLaddermen", 
	"AttMaxTunnelers", "AttUnitPatrol", "AttUnitPatrolMax", "AttUnitPatrolGroupsCount", "AttUnitBackup", "AttUnitBackupMax", "RangedBackupGroupsCount",
	"AttUnitEngage", "AttUnitEngageMax", "AttUnitSiegeDef", "AttUnitSiegeDefMax", "Unknown161", "AttUnitMain1", "AttUnitMain2", "AttUnitMain3", 
	"AttUnitMain4", "AttMaxDefault", "AttMainGroupsCount", "TargetChoice"
})

AIParamsArray = StructSpec:declare_array("AIParamsArray", StructAI, {"Rat", "Snake", "Pig", "Wolf", "Saladin", "Caliph", "Sultan", "Richard", "Frederick", 
"Philipp", "Wazir", "Emir", "Nizar", "Sheriff", "Marshal", "Abbot"})

-- Resource List
StructResources = StructSpec:declare_array("Resources", 4, {"Wood", "Hops", "Stone", "PartialStone", "Iron", "Pitch", "PartialPitch", "Wheat", "Bread", "Cheese", "Meat",
	"Apple", "Beer", "Gold", "Flour", "Bow", "Crossbow", "Spear", "Pike", "Mace", "Sword", "Leather armor", "Iron armor"
})

-- Building params
StructBuildingsMaxHP = StructSpec:declare_array("BuildingHP", 4, BUILDING_NAMES)
BuildingHPBaseAddress = '"Stronghold Crusader.exe"+1BA21C'


-- Building Data
StructBuilding = StructSpec:declare("Building", 816)
StructBuilding:add("Type", 230, 2)
StructBuilding:add("Owner", 234, 2)
StructBuilding:add("CurrentHP", 288, 2)
StructBuilding:add("MaximumHP", 290, 2)
StructBuilding:add("Resources", 316, StructResources)
StructBuilding:add("TotalStorage", 408, 4)
StructBuilding:add("CurrentProduction", 674, 2)
StructBuilding:add("ProductionGoal", 676, 2)
StructBuilding:add("Sleeping", 682, 1)
StructBuilding:add("NumHorses", 683, 1)
StructBuilding:add("HorseSpawnTimer", 686, 2)

-- Player Data
StructPlayer = StructSpec:declare("Player", 14836)
-- StructPlayer:add("AI Character Index", )

