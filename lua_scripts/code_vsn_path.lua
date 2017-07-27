-- This Lua script routes the request based on code version
-- and the path of the HTTP request. 

m = Map.new("maps/code_vsn_path.map", Map.str)

function get_code_vsn(txn)
  local hdr = txn.http:req_get_headers()
  if hdr["cookie"] == nil then
     return "1.0.0"
  end

  local cookie = hdr["cookie"][0]
  local c_name, c_val = string.match(cookie, '([^=]+)=([^=]+)')
  if string.lower(c_name) == 'version' then
     return c_val
  end
  return "1.0.0"
end

function get_path(txn)
  local path = txn.sf:path()
  local path_start = string.match(path, '([^/]+)')
  if path_start == nil then
     return ""
  end
  return path_start
end

function code_vsn_path(txn)
  local vsn = get_code_vsn(txn)
  txn.Info(txn, "Code version: " .. vsn)
  local path = get_path(txn)
  be = 'default_backend'
  if path == 'user' then
     if vsn == '2.0.0' then
     	be = 'user_v2'
     else
	be = 'user_v1'
     end
  elseif path == 'biz' then
     if vsn == '2.0.0' then
     	be = 'biz_v2'
     else
	be = 'biz_v1'
     end
  end
  return be
end

function code_vsn_path_map(txn)
  local vsn = get_code_vsn(txn)
  txn.Info(txn, "Code version: " .. vsn)
  local path = get_path(txn)
  txn.Info(txn, "Path: " .. path)
  
  local key = path .. "_" .. vsn
  be = m:lookup(key)
  if be == nil then
     be = "default_backend"
  end
  return be
end

core.register_fetches("code_vsn_path", code_vsn_path_map)