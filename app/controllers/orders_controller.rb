class OrdersController < ApplicationController
  before_action :authenticate_user!
  def show
    @orders = Order.where(user_id: current_user.id)
  end

  def set_state(params)
    state = params[:state]
  end
end