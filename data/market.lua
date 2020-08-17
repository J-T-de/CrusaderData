require("good_id")

GOOD_TRADE_BASE = 0x117CFD4  -- 1.4.1, on runtime

TRADE_ACTION_NAME = {}
TRADE_ACTION_NAME[0]    = "buy"
TRADE_ACTION_NAME[1]    = "sell"
TRADE_ACTION_LENGTH = 2

-- inverse table
TRADE_ACTION_ID = {}
TRADE_ACTION_ID["buy"]  = 0
TRADE_ACTION_ID["sell"] = 1

function getGoodTradeAddress(good, action)
  -- price for batches of 5
  return GOOD_TRADE_BASE
  + 4 * TRADE_ACTION_LENGTH * GOOD_ID[good]
  + 4 * TRADE_ACTION_ID[action]
end

function getGoodBuyAddress(good)
  -- price for batches of 5 
  return GOOD_TRADE_BASE
  + 4 * TRADE_ACTION_LENGTH * GOODS_ID[good]
  + 4 * TRADE_ACTION_ID["buy"]
end

function getGoodSellAddress(good)
  -- price for batches of 5
  return GOOD_TRADE_BASE
  + 4 * TRADE_ACTION_LENGTH * GOODS_ID[good]
  + 4 * TRADE_ACTION_ID["sell"]
end