class RatesController < ApplicationController
  before_action :authenticate_user!

  def create
    rating = Rating.new(rating_model_klass: Rate)
    #rating.rate(rate_params)

    redirect_to order_feedback_path(params[:order_id])
  end

  def rate_params
    {
      order_id: order_id,
      user_id: current_user.id,
      ratable_id: params["ratable_id"],
      ratable_type: params["ratable_type"],
      point: params["point"]
    }
  end

  def order_id
    params[:order_id]
  end
end
