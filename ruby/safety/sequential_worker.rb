class SequentialWorker
  def initialize(mailbox, num_messages)
    @mailbox = mailbox
    @num_messages = num_messages
  end

  def process
    puts "Delivering #{@num_messages} messages sequentially"
    @num_messages.times do |message|
      @mailbox.deliver(message)
    end
  end
end
