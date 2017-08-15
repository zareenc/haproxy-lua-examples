mname = "maps/ip_svc.map"
mp = Map.new(mname, Map.str)
fname = "maps/ip_to_svc.txt"
sleep_time = 5

function read_file()
  while true do
    core.log(core.info, "In background thread")
    local diff = False

    for line in io.lines(fname) do
      local ip, svc = string.match(line, '([^ ]+) ([^ ]+)')
      local txt = "IP: " .. ip .. " Svc: " .. svc
      core.log(core.info, txt)
      in_map = mp:lookup(ip)

      if in_map == nil then
        diff = True
        local mp_txt = "\n" .. ip .. " " .. svc
        core.log(core.info, "Adding to map: " .. mp_txt)
	local mp_file = io.open(mname, "a")
	mp_file:write(mp_txt)
	io.close(mp_file)
      end
    end

    core.sleep(sleep_time)
  end
end

core.register_task(read_file)