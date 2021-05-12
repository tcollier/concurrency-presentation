require 'thread/pool'

class ThreadedWorker
  def initialize(mailbox, num_messages, num_threads)
    @mailbox = mailbox
    @messages_per_thread = num_messages / num_threads
    @num_threads = num_threads
  end

  def process
    pool = Thread.pool(@num_threads)
    @num_threads.times do |thread_id|
      pool.process do
        puts "#{thread_id}: delivering #{@messages_per_thread} messages in a thread"
        @messages_per_thread.times do |message|
          @mailbox.deliver(thread_id * @messages_per_thread + message)
        end
      end
    end
    pool.shutdown
  end
end
