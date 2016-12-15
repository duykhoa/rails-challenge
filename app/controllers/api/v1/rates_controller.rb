class Api::V1::RatesController < ApplicationController
  def create
    rating = Rating.new(rating_model_klass: Rate)
    rating.rate(rating_params)
  end

  def rating_params
    {
    }
  end
end
