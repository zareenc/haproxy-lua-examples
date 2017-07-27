-- Log where requests are sent from and to

mp = Map.new("maps/ip_svc.map", Map.str)

function log_from(txn)
  -- local date = txn.sc:http_date(txn.f:date())
  -- local log_text = date .. " Request sent to: " .. txn.sf:base()
  -- local log_text = date .. " Request from: " .. txn.f:req_hdr("From",-1)
  -- local hdr_from = txn.f:req_hdr("From", -1)
  -- local ip_from = txn.f:req_hdr("X-Forwarded-For", -1)
  ip_from = txn.f:src()
  txn.Info(txn, 'Source: ' .. txn.f:src())
  -- local hdr_from = txn.http:req_get_headers()["from"][0]
  if ip_from == nil then
     return 'N/A'
  end
  
  local svc_from = mp:lookup(ip_from)
  if svc_from == nil then
     return 'N/A'
  end
  txn.set_var(txn, 'from_svc', svc_from)
  txn.Info(txn, 'From: ' .. svc_from)
  return svc_from
end

core.register_fetches("log_from", log_from)

function log_to(txn)
  local from_svc = txn.get_var(txn, 'txn.from_svc')
  local to_svc = txn.get_var(txn, 'req.backend_name')
  local date = txn.sc:http_date(txn.f:date())
  local log_text = date .. " Request from: " .. from_svc .. " Request to: " .. to_svc .. "\n"
  txn.Info(txn, log_text)

  local log_file = io.open("logs/demo_logs.txt", "a")
  log_file:write(log_text)
  log_file:close()
end

core.register_action("log_to", {"tcp-req","http-req"}, log_to)
