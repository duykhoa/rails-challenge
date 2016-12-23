class Processor
  # Public: Integer number of seconds to wait until next processor's circle
  INTERVAL_TIME = 2.freeze

  def initialize(options = {})
    @daemon = options[:daemon] || false
    @fork_per_job = options[:fork_per_job] || false
  end

  # Public: Adding job to processor
  #   job - An Object Job
  #         Processor will call job#perform to execute job in every circle.
  #         The job have to check whether it have to execute in the current circle
  #
  # Examples
  #
  #    class DumbJob
  #      def perform
  #        puts "Current time is #{Time.now}"
  #      end
  #    end
  #
  #    processor = Processor.new
  #    processor.add_job DumbJob.new
  #    processor.start
  def add_job(job)
    jobs << job
  end

  # Public: A list of jobs
  # It's use like a lazy evaluation to init or store a list of job
  #
  # Examples
  #
  #    processor = Processor.new
  #    processor.jobs #=> []
  #
  #    processor.add_job(a_job)
  #    processor.jobs #=> [a_job]
  #
  # Returns an array of jobs
  def jobs
    @jobs ||= []
  end

  # Public: Start the processor
  #   Before runing, it registers 2 signals: INT & TERM
  #   so in terminal mode, we can do a SIGNINT or SIGNTERM kill
  #
  # Examples
  #
  # processor = Processor.new
  # process.start
  def start
    register_signal
    run { execute_jobs }
  end

  # Public: intervally run a block
  #
  #   &block - A block
  #
  #  This method supports:
  #   - Daemon mode - Detach the procesor from current process
  #   - Forking     - When Execute jobs, it can fork to a child process
  #     the child process's memory will be release after the job is finished
  #
  #  These options can be enable when initialize new processor.
  #
  #  TODO: `fork_per_job` term is misunderstand here
  #  (it's fork per execution time, not per job)
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

  # Internal: The interval process
  #   In every circle, this method:
  #
  #   - Checks if shutdown flag is turned on
  #   - Run the given block
  #   - Wait until next circle
  def interval(&block)
    loop do
      break if @shutdown

      block.call if block
      sleep INTERVAL_TIME
    end
  end

  # Internal: Fork a child process to execute the given block
  #   Wait until the child process finished, then return
  def fork_per_job(&block)
    return nil unless block

    fork { block.call }
    Process.wait id
  end

  def execute_jobs
    @jobs.each { |job| job.perform }
  end

  # TODO: should treat INT & TERM signal differently
  def register_signal
    trap "INT" do
      shutdown
    end

    trap "TERM" do
      shutdown
    end
  end

  def shutdown
    @shutdown = true
  end

  def shutdown?
    @shutdown
  end

  def prehooks_execute
    prehooks.map(&:call)
  end

  def prehooks
    @prehooks ||= []
  end

  # Public: Return processor id
  #
  # Examples
  #
  #   processor = Processor.new(daemon: true)
  #   processor.start
  #   pid = processor.pid
  #   Process.kill("INT", pid)
  def pid
    Process.pid
  end
end
