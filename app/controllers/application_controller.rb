class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_header_variables

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def set_header_variables
    @category ||= Category.all
    @items_count = 0
    if current_user
      return unless Cart.find_by(user_id: current_user.id)

      @items_count = Cart.find_by(user_id: current_user.id).items.count
    end
  end
end
