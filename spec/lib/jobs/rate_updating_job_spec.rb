require 'rails_helper'

describe RateUpdatingJob do
  it "need_to_run?" do
    job = RateUpdatingJob.new
    expect(job.need_to_run?).to be true
  end

  it "no need_to_run" do
    job = RateUpdatingJob.new
    job.last_run_at = job.current_time

    expect(job.need_to_run?).to be false
  end

  class MealRepository
    def update_rate
      @_update_rate = true
    end

    def update_rate?
      @_update_rate
    end
  end

  class DeliveryRepository
    def update_rate
      @_update_rate = true
    end

    def update_rate?
      @_update_rate
    end
  end

  describe "#run" do
    it "update_meal_rate" do
      meal_repository = MealRepository.new
      delivery_repository = DeliveryRepository.new
      job =  RateUpdatingJob.new(meal_repository: meal_repository, delivery_repository: delivery_repository)
      job.run

      expect(meal_repository.update_rate?).to be true
    end

    it "update_deliver_rate" do
      meal_repository = MealRepository.new
      delivery_repository = DeliveryRepository.new
      job =  RateUpdatingJob.new(meal_repository: meal_repository, delivery_repository: delivery_repository)
      job.run

      expect(delivery_repository.update_rate?).to be true
    end
  end
end
