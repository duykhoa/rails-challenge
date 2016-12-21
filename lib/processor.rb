class Processor
  INTERVAL_TIME = 5.freeze

  def initialize(options = {})
    @daemon = options[:daemon] || false
    @fork_per_job = options[:fork_per_job] || false
    prehooks << register_signal
  end

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
    return nil unless block
    Process.daemon() if @daemon

    interval do
      prehooks_execute
      if @fork_per_job
        fork_per_job(&block)
      else
        block.call
      end
    end
  end

  def interval(&block)
    loop do
      break if @shutdown

      block.call unless block
      sleep INTERVAL_TIME
    end
  end

  def fork_per_job(&block)
    return nil unless block

    fork { block.call }
    Process.wait id
  end

  def execute_jobs
    @jobs.each { |job| job.perform }
  end

  def register_signal
    lambda do
      trap "INT" do
        shutdown
      end

      trap "TERM" do
        shutdown
      end
    end
  end

  def shutdown
    @shutdown = true
  end

  def prehooks_execute
    prehooks.map(&:call)
  end

  def prehooks
    @prehooks ||= []
  end
end