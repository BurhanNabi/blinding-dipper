require 'socket' 
require_relative 'parser'

# Opening the server on port 2016
server = TCPServer.new('localhost', 2016)

loop do

  # Start a new thread for each request
  Thread.start(server.accept) do |socket|
    # Note use of thread variable in the above code. Useful to know!

    request = []


    # Read the request
    line = ''
    until line == "\r\n"
      line = socket.readline
      # puts line  #FOR DEBUG
      request << line
      if line.match /Content\-Length\:\s(\d+)/
        length = $1.to_i
      end
    end

    # If request has data, read length of data number of bytes
    if length
      line = socket.read(length)
      request << line
    end

=begin
    # For DEBUG
    puts "The data was: #{line}"
    STDOUT.puts request.to_s
=end

    # Handle request and get response
    responseString = parseAndHandleRequest request

    # Send response to client
    socket.print "HTTP/1.1 200 OK\r\n" +
                     "Content-Type: text/plain\r\n" +
                     "Content-Length: #{responseString.bytesize}\r\n" +
                     "Connection: close\r\n"

    socket.print "\r\n"
    socket.print responseString

    # Close the connection
    socket.close

 end
end