-- This Lua script returns the weight of a 
-- server by reading from map.

function code_vsn(txn)
  return 1
end

core.register_fetches("code_vsn", code_vsn)