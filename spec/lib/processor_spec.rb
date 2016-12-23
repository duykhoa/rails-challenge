require 'rails_helper'

describe Processor do
  class DumbJob;
    def perform; @executed = true; end;
    def executed?; @executed; end;
  end

  class FakeIO
    @@output = ""

    def self.to_s
      @@output
    end

    def self.<<(val)
      @@output << val
    end
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

  it "can pass a list options" do
    processor = Processor.new({fork_per_job: true, daemon: false})
  end

  it "can start" do
    t = Thread.new do
      processor = Processor.new
      job = DumbJob.new
      processor.add_job(job)
      processor.start
    end

    expect(t.stop?).to be false
    t.kill
    sleep 0.05
    expect(t.stop?).to be true
  end

  it "can kill by sending INT signal" do
    fork do
      processor = Processor.new(daemon: true)
      processor.start
      Process.kill("INT", processor.pid)
      expect(processor.shutdown?).to be true
    end
  end

  it "can kill by sending TERM signal" do
    fork do
      processor = Processor.new(daemon: true)
      processor.start
      Process.kill("TERM", processor.pid)
      expect(processor.shutdown?).to be true
    end
  end

  describe "prehooks" do
    it "return empty array" do
      processor = Processor.new
      expect(processor.prehooks).to eq []
    end

    it "can add more hook" do
      processor = Processor.new
      hook = lambda { true }
      expect { processor.prehooks << hook }.not_to raise_error
    end

    it "execute" do
      processor = Processor.new

      hook = lambda do
        FakeIO << "runned"
      end

      processor.prehooks << hook
      processor.prehooks_execute

      expect(FakeIO.to_s).to eq("runned")
    end
  end
end
