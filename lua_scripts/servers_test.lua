-- Sample server responses

function default_server(applet)
  local response = "You are using the default server!\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end

core.register_service("default_server", "http", default_server)

function foo_server(applet)
  local response = "You are using the foo server!\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end

core.register_service("foo_server", "http", foo_server)

function bar_server(applet)
  local response = "You are using the bar server!\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end

core.register_service("bar_server", "http", bar_server)
