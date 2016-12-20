# Dummy Model
Order = Struct.new(:id, :date, :order_items)
OrderItem = Struct.new(:id, :meal_name)

class OrderFeedbackController < ApplicationController
  before_action :signed_in?

  def new
    @order = find_order(params[:id])
  end

  private

  def signed_in?
    redirect_to new_session_path unless cookies[:user_id]
  end

  def find_order(order_id)
    # Will return an Order Model or nil
    # feel free to implement this with ActiveRecord if this is insufficient

    Order.new(
      "GO#{order_id}",
      Date.new(2016, 4, 10),
      [ OrderItem.new(101, "Samsui Chicken Rice"), OrderItem.new(121, "Grilled Farm Fresh Chicken") ]
    )
  end
end
