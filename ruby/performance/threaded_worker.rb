require 'thread/pool'

class ThreadedWorker
  def initialize(jobs, output: STDOUT, num_threads: 16)
    @jobs = jobs
    @output = output
    @num_threads = num_threads
  end

  def process
    pool = Thread.pool(@num_threads)
    @output.puts "Processing #{@jobs.count} job(s) with #{@num_threads} thread(s)"
    @jobs.each do |job|
      pool.process do
        @output.puts "#{job.id}: #{job.perform}"
      end
    end
    pool.shutdown
  end
end
