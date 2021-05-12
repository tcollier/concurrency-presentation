#!/usr/bin/env ruby

if ARGV.include?('--cpu')
  require_relative 'factorize_job'
  jobs = Array.new(16) { |i| FactorizeJob.new(i) }
  puts "Processing CPU Bound Jobs"
  puts "========================="
else
  require_relative 'fetch_ip_address_job'
  jobs = Array.new(16) { |i| FetchIpAddressJob.new(i) }
  puts "Processing I/O Bound Jobs"
  puts "========================="
end

worker_class = if ARGV.include?('--threaded')
  require_relative 'threaded_worker'
  ThreadedWorker
elsif ARGV.include?('--parallel')
  require_relative 'parallel_worker'
  ParallelWorker
else
  require_relative 'sequential_worker'
  SequentialWorker
end

worker_class.new(jobs).process
