# This class implements the handle timeout method that handles a timeout for
# a single request.
class Timer

  # Updates the timeout each second
  def handleTimeout mHash, k
    while mHash[k] > 0 do
      mHash[k] -=1
      sleep 1
      # puts "#{k} : #{mHash[k]}"
    end
    # mHash.delete(k)
  end
end
