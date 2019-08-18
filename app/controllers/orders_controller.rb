class OrdersController < ApplicationController
  before_action :authenticate_user!
  def show
    @orders = Order.where(user_id: current_user.id)
  end
end
