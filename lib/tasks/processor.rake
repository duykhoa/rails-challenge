namespace :processor do
  desc "run processor"
  task start: :environment do
    class DumbJob;
      def perform; @executed = true; end;
      def executed?; @executed; end;
    end

    job = DumbJob.new

    processor = Processor.new(daemon: true)
    processor.add_job(job)
    processor.start
  end
end
