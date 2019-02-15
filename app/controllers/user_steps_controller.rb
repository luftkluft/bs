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
      @deliveries = Delivery.all || []
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

  def update
    @cart = cart
    # @card = card
    # @delivery = Delivery.find_by(id: @cart.delivery_id)
    @billing = Address.where(user_id: current_user.id, address_type: 'billing')
    @shipping = Address.where(user_id: current_user.id, address_type: 'shipping')
    case step
    when :checkout_address
      flash[:alert] = 'update address!' + checkout_params.to_s
    when :checkout_delivery
      flash[:alert] = 'update delivery!' + checkout_params.to_s
    when :checkout_payment
      @cart_service = cart_service
      result = @cart_service.choose_delivery(checkout_params[:delivery])
      flash[:alert] = 'Error add delivery!' unless result
      flash[:notice] = 'Delivery was added!' if result
    # when :checkout_confirm
    #   @cart_service = cart_service
    #   @card_service = card_service
    #   errors = @card_service.save_card(param = checkout_params)
    #   @card_number = []
    #   @exp_date = []
    #   if errors.nil?
    #     @card_number = @card.card_number
    #     @exp_date = @card.expiration_month_year
    #     flash[:notice] = 'Card saved!'
    #   else
    #     flash[:alert] = 'Error save card! ' + errors.to_s
    #     # redirect_back(fallback_location: root_path)
    #   end
    # when :checkout_complete
    #   @order_service = order_service
    #   copied_data = {
    #     billing_address: @billing,
    #     shipping_address: @shipping,
    #     delivery: @delivery,
    #     card: @card,
    #     cart: @cart
    #   }
    #   errors = @order_service.copy_data(copied_data)
    #   if errors.nil?
    #     flash[:notice] = 'Order saved!'
    #   else
    #     flash[:alert] = 'Error save order! ' + errors.to_s
    #     # redirect_back(fallback_location: root_path)
    #   end
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
