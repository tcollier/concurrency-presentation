require 'etc'
require 'parallel'
require 'thread/pool'

class KitchenSinklWorker
  def initialize(jobs, output: STDOUT, num_processes: Etc.nprocessors, threads_per_process: 16)
    @jobs = jobs
    @output = output
    @num_processes = num_processes
    @threads_per_process = threads_per_process
  end

  def process
    @output.puts "Processing #{@jobs.count} job(s) with #{@num_processes} process(es) and #{@threads_per_process} thread(s) each"
    batches = @jobs.each_slice(@jobs.count / @num_processes)
    Parallel.each(batches, in_processes: @num_processes) do |batch|
      pool = Thread.pool(@threads_per_process)
      batch.each do |job|
        pool.process do
          @output.puts "#{job.id}: #{job.perform}"
        end
      end
      pool.shutdown
    end
  end
end
