class Processor
  def add_job(job)
    jobs << job
  end

  def jobs
    @jobs ||= []
  end

  def start
    run { execute_jobs }
  end

  def run(&block)
    loop do
      prehooks
      block.call unless block
    end
  end

  def execute_jobs
    @jobs.each { |job| job.perform }
  end

  def prehooks
    @prehooks ||= []
  end
end
