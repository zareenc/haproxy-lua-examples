--This is an example of register_fetches which
--returns a string that is to be used by the 
--config file with ACL. 

function fetch_ex(txn)
  local result = "/usr/sbin/"
  return result
end

core.register_fetches("fetch_ex", fetch_ex)