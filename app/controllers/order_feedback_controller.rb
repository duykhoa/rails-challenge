class OrderFeedbackController < ApplicationController
  before_action :authenticate_user!
  before_action :owner_order

  def new
    @order = Order.find_by_id(params[:id])
    @delivery = @order.delivery

    if @order
      @order_items = @order.order_items.includes(:meal)
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
