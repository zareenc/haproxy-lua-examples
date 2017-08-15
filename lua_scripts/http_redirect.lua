-- This Lua script redirects requests based on
-- HTTP request port or path.

function path_redirect(txn)
  local result = ''
  local path = txn.sf:path()
  local path_start = string.match(path, '([^/]+)')
  if path_start == 'foo' then
    result = 'foo_backend'
  elseif path_start == 'bar' then
    result = 'bar_backend'
  else
    result = 'default_backend'
  end
  return result
end

core.register_fetches("path_redirect", path_redirect)

function port_redirect(txn)
  local base = txn.sf:base()
  local host, port, rest = string.match(base, '([^:]+):([^/]+)/?(.+)]?')
  txn.Info(txn, 'Port: ' .. port)
  if port == '8001' or port == '8002' then
     return 'foo_backend'
  elseif port == '8003' then
     return 'bar_backend'
  elseif port == '8004' then
     return 'default_backend'
  end
end

core.register_fetches("host_redirect", port_redirect)