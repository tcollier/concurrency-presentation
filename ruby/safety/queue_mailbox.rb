class QueueMailbox
  def initialize
    @queue = Queue.new
  end

  def deliver(message)
    sleep(0.000001)
    @queue << message
  end

  def size
    @queue.size
  end
end
