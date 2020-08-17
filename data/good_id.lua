GOOD_NAME = {}
GOOD_NAME[2]    = "wood"
GOOD_NAME[3]    = "hop"
GOOD_NAME[4]    = "stone"
GOOD_NAME[6]    = "iron"
GOOD_NAME[7]    = "pitch"
GOOD_NAME[9]    = "wheat"
GOOD_NAME[10]   = "bread"
GOOD_NAME[11]   = "cheese"
GOOD_NAME[12]   = "meat"
GOOD_NAME[13]   = "fruit"
GOOD_NAME[14]   = "beer"
GOOD_NAME[16]   = "flour"
GOOD_NAME[17]   = "bow"
GOOD_NAME[18]   = "xbow"
GOOD_NAME[19]   = "spear"
GOOD_NAME[20]   = "pike"
GOOD_NAME[21]   = "mace"
GOOD_NAME[22]   = "sword"
GOOD_NAME[23]   = "leather"
GOOD_NAME[24]   = "armor"
GOOD_LENGTH = 25

-- inverse table
GOOD_ID = {}
for key, value in pairs(GOOD_NAME) do
    GOOD_ID[value] = key
end