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

    def self.reset!
      @@count = 0
    end
  end

  after do
    RatingModel.reset!
  end

  it "rate for order_items & delivery" do
    rating = Rating.new(rating_model_klass: RatingModel)
    result = rating.rate(order_item: { 1 => 2, 2 => 3 }, delivery: {4 => 5})
    expect(RatingModel.count).to eq 3
  end
end
