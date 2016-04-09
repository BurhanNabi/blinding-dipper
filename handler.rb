require_relative 'Timer'


$mHash = Hash.new

# Handles a new connection and populates the database
def handleNewConnection arg
  args = arg.split '&'

  # TODO Handle exception string->number
  connId = args[0].split('=')[1].to_i
  timeout = args[1].split('=')[1].to_i
  $mHash[connId] = timeout

  Timer.new.handleTimeout($mHash,connId)

  # Check how the connection was terminated
  if $mHash[connId] == 0
    $mHash.delete connId
    return "{\"Status\" : \"OK\"} \r\n"
  elsif $mHash[connId] <= -16
    $mHash.delete connId
    return "{\"Status\" : \"Terminated\"}\r\n"
  end
end

# Gets the requests currently in the server along with their reamaining
# timeouts. Returns the mapped timeouts as a string
def getServerStatus
  s = "{"
  $mHash.each do | k , v |
    s += " \"#{k}\":\"#{v}\" ,"
  end
  if s.length > 2
    s = s[0..-2]
  end
  s += "}\r\n"
  return s
end

# Terminates a connection if it exists
def terminateConnection dataHash
  id = dataHash['connId']
  if $mHash.has_key? id
    $mHash[id] = -16
    return "{\"Status\" : \"OK\"} \r\n"
  else
    return "{\"Status\" : \"No such connID: #{id}\"} \r\n"
  end
end