require 'rails_helper'

describe RateUpdateJob do
  class MealRepository
    def update_rate_point
    end
  end

  class DeliveryRepository
    def update_rate_point
    end
  end

  let(:meal_repository) { MealRepository.new }
  let(:delivery_repository) { DeliveryRepository.new }

  describe "need_to_run" do
    it "need_to_run" do
      job = RateUpdateJob.new
      expect(job.need_to_run?).to eq true
    end

    it "update last_run_at" do
      job = RateUpdateJob.new(meal_repository: meal_repository, delivery_repository: delivery_repository)
      job.run
      expect(job.need_to_run?).to be false
    end
  end

  describe "run" do
    it do
      job = RateUpdateJob.new(meal_repository: meal_repository, delivery_repository: delivery_repository)
      expect(meal_repository).to receive(:update_rate_point).once
      expect(delivery_repository).to receive(:update_rate_point).once
      job.run
    end
  end
end
