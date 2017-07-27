-- Log which backend server a request is sent to

function log_req(txn)
  local req = txn.req:dup()
  txn.Info(txn, 'FRONTEND Request:' .. req)
  --[[
  local res = txn.res:dup()
  txn.Info(txn, 'Result:' .. res)
  ]]
end
core.register_action("log_req", {"tcp-req","http-req"}, log_req)


function log_res(txn)
  --[[
  txn.res:set("This is a test")
  local res = txn.res:get()
  txn.Info(txn, 'BACKEND Request:' .. res)
  ]]
  txn.res:send("This is a test")
end
core.register_action("log_res", {"tcp-req","http-req"}, log_res)