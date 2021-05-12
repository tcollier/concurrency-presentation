#!/usr/bin/env ruby

require 'benchmark'

require_relative 'sequential_worker'

CPU_BOUND = ARGV.include?('--cpu')
THREADED = (ARGV & ['--all', '--parallel', '--threaded']).any?
PARALLEL = (ARGV & ['--all', '--parallel']).any?
ALL = ARGV.include?('--all')
DEV_NULL = File.open(File::NULL, 'w')

jobs = if CPU_BOUND
  require_relative 'factorize_job'
  Array.new(32) { |i| FactorizeJob.new(i) }
else
  require_relative 'fetch_ip_address_job'
  Array.new(64) { |i| FetchIpAddressJob.new(i) }
end

puts "Benchmarking #{CPU_BOUND ? 'CPU' : 'I/O'} Bound Jobs"
puts "==========================="
Benchmark.bm(18) do |bm|
  bm.report('sequential (1)') { SequentialWorker.new([jobs.first], output: DEV_NULL).process }
  bm.report("sequential (#{jobs.count})") { SequentialWorker.new(jobs, output: DEV_NULL).process }
  if THREADED
    require_relative 'threaded_worker'
    bm.report("threaded (#{jobs.count})") { ThreadedWorker.new(jobs, output: DEV_NULL).process }
  end
  if PARALLEL
    require_relative 'parallel_worker'
    bm.report("parallel (#{jobs.count})") { ParallelWorker.new(jobs, output: DEV_NULL).process }
  end
  if ALL
    require_relative 'kitchen_sink_worker'
    lotsa_jobs = jobs * 64
    worker = KitchenSinklWorker.new(lotsa_jobs, output: DEV_NULL, threads_per_process: 64)
    bm.report("kitchen sink (#{lotsa_jobs.count})") { worker.process }
  end
end
