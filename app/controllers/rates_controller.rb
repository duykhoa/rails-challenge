class RatesController < ApplicationController
  before_action :authenticate_user!

  # Create rate & comment
  #
  # TODO Check user permission for order, order item and delivery before calling rating
  # and delivery
  def create
    rating = Rating.new(rating_model_klass: Rate)
    rating.rate(rate_params)

    comment_creator = CommentCreator.new
    comment_creator.create(comment_params, current_user.id)

    redirect_to order_feedback_path(params[:order_id])
  end

  def rate_params
    {
      order_item: params[:order_item],
      delivery: params[:delivery]
    }
  end

  def comment_params
    params[:comment]
  end

  def order_id
    params[:order_id]
  end
end
