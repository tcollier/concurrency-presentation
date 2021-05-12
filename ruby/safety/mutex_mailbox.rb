class MutexMailbox
  def initialize
    @queue = Array.new
    @lock = Mutex.new
  end

  def deliver(message)
    @lock.synchronize do
      next_index = @queue.size
      sleep(0.000001)
      @queue[next_index] = message
    end
  end

  def size
    @queue.size
  end
end
