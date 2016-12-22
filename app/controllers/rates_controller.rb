class RatesController < ApplicationController
  before_action :authenticate_user!

  def create
    rating = Rating.new(rating_model_klass: Rate)
    rating.rate(rate_params)

    redirect_to order_feedback_path(params[:order_id])
  end

  def rate_params
    {
      order_item: params[:order_item],
      delivery: params[:delivery]
    }
  end

  def order_id
    params[:order_id]
  end
end
