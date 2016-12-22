require 'rails_helper'

describe Processor do
  class DumbJob;
    def perform; @executed = true; end;
    def executed?; @executed; end;
  end

  it "can add jobs" do
    processor = Processor.new
    processor.add_job(DumbJob.new)
    expect(processor.jobs.size).to eq 1
  end

  it "execute jobs" do
    processor = Processor.new
    job = DumbJob.new
    processor.add_job(job)
    processor.execute_jobs

    expect(job.executed?).to be true
  end
end
