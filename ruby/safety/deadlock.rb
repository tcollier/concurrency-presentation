#!/usr/bin/env ruby

require 'thread/pool'

require_relative 'pantry'
require_relative 'chef'
require_relative 'lefthanded_chef'

NUM_THREADS = 3
CHEFS_PER_THREAD = 2
PANTRY = Pantry.new

pool = Thread.pool(NUM_THREADS)
NUM_THREADS.times do |thread_id|
  chefs = CHEFS_PER_THREAD.times.map { |i| Chef.new("chef-#{CHEFS_PER_THREAD * thread_id + i}")}
  if thread_id = NUM_THREADS / 2 && ARGV.include?('--lefty')
    chefs[CHEFS_PER_THREAD / 2] = LefthandedChef.new("lefty")
  end
  pool.process do
    chefs.each do |chef|
      chef.make_sandwich(PANTRY)
    end
  end
end
pool.shutdown
