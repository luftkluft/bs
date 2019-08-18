class ApplicationController < ActionController::Base
  include Pundit
  include Pagy::Backend

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_header_variables

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def set_header_variables
    @categories = Category.all || []
    @items_count = 0
    if current_user
      cart = Cart.find_by(user_id: current_user.id)
      return unless cart

      @items_count = cart.items.count
    end
  end
end
