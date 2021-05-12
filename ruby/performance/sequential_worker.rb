class SequentialWorker
  def initialize(jobs, output: STDOUT)
    @jobs = jobs
    @output = output
  end

  def process
    @output.puts "Processing #{@jobs.count} job(s) sequentially"
    @jobs.each do |job|
      @output.puts "#{job.id}: #{job.perform}"
    end
  end
end
