class CustomMailbox
  def initialize
    @queue = Array.new
  end

  def deliver(message)
    next_index = @queue.size
    sleep(0.000001)
    @queue[next_index] = message
  end

  def size
    @queue.size
  end
end
