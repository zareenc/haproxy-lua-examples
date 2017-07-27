core.register_service("hello_world", "tcp", function(applet)
   applet:send("hello world\n")
end)

core.register_service("hello_world_http", "http", function(applet)
  applet:start_response()   
  applet:send("hello world\n")
end)