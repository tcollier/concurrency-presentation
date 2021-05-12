#!/usr/bin/env ruby

NUM_THREADS = 10
NUM_MESSAGES_PER_THREAD = 100
NUM_MESSAGES = NUM_THREADS * NUM_MESSAGES_PER_THREAD

MAILBOX = if ARGV.include?('--mutex')
  require_relative 'mutex_mailbox'
  MutexMailbox.new
elsif ARGV.include?('--queue')
  require_relative 'queue_mailbox'
  QueueMailbox.new
else
  require_relative 'custom_mailbox'
  CustomMailbox.new
end

worker = if ARGV.include?('--threaded')
  require_relative 'threaded_worker'
  ThreadedWorker.new(MAILBOX, NUM_MESSAGES, NUM_THREADS)
else
  require_relative 'sequential_worker'
  SequentialWorker.new(MAILBOX, NUM_MESSAGES)
end

worker.process
puts "Delivered #{NUM_MESSAGES} messages, mailbox size is #{MAILBOX.size}"
