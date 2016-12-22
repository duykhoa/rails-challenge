namespace :processor do
  desc "run processor"

  task start: :environment do
    job = RateUpdateJob.new(
      meal_repository: Meal,
      delivery_repository: Delivery
    )

    daemon = ENV["PROCESSOR_DAEMON"] == true
    fork_per_job = ENV["PROCESSOR_FORK_PER_JOB"] == true

    processor = Processor.new(daemon: daemon, fork_per_job: fork_per_job)
    processor.add_job(job)
    processor.start
  end
end
