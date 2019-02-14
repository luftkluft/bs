class UserStepsController < ApplicationController
  include Wicked::Wizard
  steps :checkout_address, :checkout_delivery, :checkout_payment,
        :checkout_confirm, :checkout_complete
  
  def show
    @cart = cart
    @billing = Address.where(user_id: current_user.id, address_type: 'billing')
    @shipping = Address.where(user_id: current_user.id, address_type: 'shipping')
    case step
    when :checkout_address
      flash[:alert] = 'show address!' + checkout_params.to_s
    when :checkout_delivery
      # @deliveries = Delivery.all || []
      flash[:alert] = 'show delivery!' + checkout_params.to_s
    when :checkout_payment
      flash[:alert] = 'show payment!' + checkout_params.to_s
    when :checkout_confirm
      flash[:alert] = 'show confirm!' + checkout_params.to_s
    when :checkout_complete
      flash[:alert] = 'show complete!' + checkout_params.to_s
    end
    render_wizard
  end

private

def checkout_params
  params.permit! # TODO
end

def cart
  cart = Cart.find_by(user_id: current_user.id)
  cart = Cart.create(user_id: current_user.id) if cart.nil?
  cart
end

def cart_service
  cart_service ||= CartService.new
  cart_service.load(cart)
  cart_service
end

  def redirect_to_finish_wizard
    redirect_to root_url, notice: "Thank you for signing up."
  end
end
