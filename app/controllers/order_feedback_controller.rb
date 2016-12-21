class OrderFeedbackController < ApplicationController
  before_action :signed_in?

  def new
    @order = Order.find_by_id(params[:id])

    if @order
      @meals = @order.meals
    else
      @meals = []
    end
  end

  private

  def signed_in?
   if !cookies[:user_id]
     cookies[:after_login_path] = request.original_url
     redirect_to new_session_path
   end
  end
end
