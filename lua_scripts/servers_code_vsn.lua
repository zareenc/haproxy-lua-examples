-- Sample server responses for different code versions

function default_server(applet)
  local response = "Request has been forwarded to the default server running V1.0.0\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end

core.register_service("default_server", "http", default_server)


function server2(applet)
  local response = "Request has been forwarded to server #2 running V2.0.0\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end

core.register_service("server2", "http", server2)


function server3(applet)
  local response = "Request has been forwarded to server #3 running V3.0.0\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end

core.register_service("server3", "http", server3)
