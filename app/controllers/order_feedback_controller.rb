class OrderFeedbackController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.find_by_id(params[:id])
    @delivery = @order.delivery

    if @order
      @order_items = @order.order_items.includes(:meal)
    else
      @order_items = []
    end
  end

  private
end
