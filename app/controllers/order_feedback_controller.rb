class OrderFeedbackController < ApplicationController
  before_action :authenticate_user!
  before_action :owner_order

  # It provide these instance variables
  #
  #     @order
  #     @order_items
  #     @delivery
  #     @user_ratable
  #
  # TODO: Add a facade pattern to reduce number of instance variables that are passed
  # to view
  def new
    @order = Order.find_by_id(params[:id])
    @delivery = @order.delivery

    if @order
      @order_items = @order.order_items.includes(:meal, :comment)
    else
      @order_items = []
    end

    @user_ratable = current_user.ratable?(@order.id)
  end

  private

  def owner_order
    redirect_to root_path unless current_user.own?(params[:id])
  end
end
