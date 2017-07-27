-- This Lua script reads the code version of the requesting client
-- from a cookie and routes the request based on code version.

function code_vsn(txn)
  local hdr = txn.http:req_get_headers()
  if hdr["cookie"] == nil then
     return "version1"
  end

  local cookie = hdr["cookie"][0] 
  txn.Info(txn, "Cookie: " .. cookie)
  local c_name, c_val = string.match(cookie, '([^=]+)=([^=]+)')

  if c_val == "2.0.0" then
     return "version2"
  elseif c_val == "3.0.0" then
     return "version3"
  else 
     return "version1"
  end
end

core.register_fetches("code_vsn", code_vsn)