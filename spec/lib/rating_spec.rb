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

  it "rate for meal" do
    rating = Rating.new(rating_model_klass: RatingModel)
    result = rating.rate(points: 4, ratable_id: 123, user_id: 6, ratable_type: :meal)
    expect(RatingModel.count).to eq 1
  end

  it "rate for delivery" do
    rating = Rating.new(rating_model_klass: RatingModel)
    result = rating.rate(points: 4, ratable_id: 125, user_id: 5, ratable_type: :delivery)
    expect(RatingModel.count).to eq 1
  end

  it "lack of user_id" do
    rating = Rating.new(rating_model_klass: RatingModel)
    expect do
      rating.rate(points: 4, ratable_id: 125, ratable_type: :delivery)
    end.to raise_error StandardError
  end

  it "lack of ratable_type" do
    rating = Rating.new(rating_model_klass: RatingModel)
    expect do
      rating.rate(points: 4, ratable_id: 125, user_id: 5)
    end.to raise_error StandardError
  end

  it "lack of ratable_id" do
    rating = Rating.new(rating_model_klass: RatingModel)

    expect do
      rating.rate(points: 4, ratable_type: :meal, user_id: 5)
    end.to raise_error StandardError
  end
end
