require 'etc'
require 'parallel'

class ParallelWorker
  def initialize(jobs, output: STDOUT, num_processes: Etc.nprocessors)
    @jobs = jobs
    @output = output
    @num_processes = num_processes
  end

  def process
    @output.puts "Processing #{@jobs.count} job(s) with #{@num_processes} process(es)"
    Parallel.each(@jobs, in_processes: @num_processes) do |job|
      @output.puts "#{job.id}: #{job.perform}"
    end
  end

  private

  attr_reader :jobs
end
