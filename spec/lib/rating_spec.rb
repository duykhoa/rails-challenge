require 'rails_helper'

describe Rating do
  class RatingModel
    @@count = 0

    def initialize(options = {})
    end

    def self.create(args = {})
      @@count += 1
      true
    end

    def self.count
      @@count
    end

    def self.find
      new
    end
  end

  it "rate for meal" do
    rating = Rating.new(rating_model_klass: RatingModel)
    result = rating.rate(points: 4, ratable_id: 123, ratable_type: :meal)
    expect(RatingModel.count).to eq 1
  end
end
