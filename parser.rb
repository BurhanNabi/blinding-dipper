require 'json'
require_relative 'handler'

# Parses the request and handles it accordingly
def parseAndHandleRequest request

  # Type of HTTP request
  type = getRequestType request[0]

  # Handle request based on type
  if type == "GET"
    response = GETRequestMapper request
  else
    response = PUTRequestMapper request
  end

  response
end

# Returns the type of HTTP request
def getRequestType req
  req_type = req[0..2]
  STDOUT.puts req[0..2] + "request from client"
  req_type
end

# Maps the passed GET request to the correct handler or handles it
def GETRequestMapper arg
  arg = arg[0][4..-1]
  arg = arg[5..-1]

  requestAction = arg.split('?')[0].split(' ')[0]

  # STDOUT.puts requestAction #FOR DEBUG

  if requestAction == 'response'
    res = handleNewConnection arg.split('?')[1].split(' ')[0]
  elsif requestAction == 'serverStatus'
    res = getServerStatus
  end
  res
end

# Maps the passed PUT request to correct handler or handles it
def PUTRequestMapper ar

  req = ar[0]
  requestPage = req.split(' ')[1]

  if requestPage == '/api/kill'
    jsonString = ar[-1]
    dataHash = JSON.parse jsonString
    terminateConnection dataHash
  end

end