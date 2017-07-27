-- Sample server responses for different code versions and paths
function default_server(applet)
  local response = "Request has been forwarded to the default server running V1.0.0\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end
core.register_service("default_server", "http", default_server)


-- User servers
function user_v1_server(applet)
  local response = "Request has been forwarded to user service running V1.0.0\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end
core.register_service("user_v1_server", "http", user_v1_server)

function user_v2_server(applet)
  local response = "Request has been forwarded to user service running V2.0.0\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end
core.register_service("user_v2_server", "http", user_v2_server)


-- Biz servers
function biz_v1_server(applet)
  local response = "Request has been forwarded to biz service running V1.0.0\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end
core.register_service("biz_v1_server", "http", biz_v1_server)

function biz_v2_server(applet)
  local response = "Request has been forwarded to biz service running V2.0.0\n"
  applet:set_status(200)
  applet:start_response()
  applet:send(response)
end
core.register_service("biz_v2_server", "http", biz_v2_server)
