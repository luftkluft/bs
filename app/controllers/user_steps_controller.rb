class UserStepsController < ApplicationController
  before_action :authenticate_user!
  include Wicked::Wizard
  steps :checkout_address, :checkout_delivery, :checkout_payment,
        :checkout_confirm, :checkout_complete

  def show
    @cart = cart
    @billing = Address.where(user_id: current_user.id, address_type: 'billing')
    @shipping = Address.where(user_id: current_user.id, address_type: 'shipping')
    case step
    when :checkout_delivery
      @deliveries = Delivery.all || []
    when :checkout_confirm
      @card_number = card.card_number
      @exp_date = card.expiration_month_year
    end
    render_wizard
  end

  def update
    @cart = cart
    @delivery = Delivery.find_by(id: cart.delivery_id)
    @billing = Address.where(user_id: current_user.id, address_type: 'billing')
    @shipping = Address.where(user_id: current_user.id, address_type: 'shipping')
    case step
    when :checkout_payment
      @cart_service = cart_service
      errors = @cart_service.choose_delivery(checkout_params[:delivery])
      if errors.nil?
        @cart_service.payment
        @delivery_price = @cart_service.delivery_price
        flash[:notice] = 'Delivery was added!'
      else
        flash[:alert] = 'Error add delivery!' + errors.to_s
        redirect_back(fallback_location: root_path) && return
      end
    when :checkout_confirm
      @cart_service = cart_service
      errors = card_service.save_card(param = checkout_params)
      if errors.nil?
        @cart_service.payment
        @delivery_price = @cart_service.delivery_price
        @card_number = card.card_number
        @exp_date = card.expiration_month_year
        flash[:notice] = 'Card saved!'
      else
        flash[:alert] = 'Error save card! ' + errors.to_s
        redirect_back(fallback_location: root_path) && return
      end
    when :checkout_complete
      @cart_service = cart_service
      redirect_to_finish_wizard && return if @cart_service.items.count.zero?
      @order_service = order_service
      errors = @order_service.assembling_data
      if errors.nil?
        @order_shipping = Address.where(order_id: @order_service.order.id, address_type: 'shipping')
        errors = @cart_service.clean_cart
        if errors.nil?
          @delivery_price = @order_service.delivery_price
          UserMailer.order_email(current_user).deliver_later
          flash[:notice] = 'Order saved!'
        else
          flash[:alert] = 'Cart not cleaned!' + errors.to_s
        end
      else
        flash[:alert] = 'Error save order! ' + errors.to_s
      end
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
    cart_service = CartService.new
    cart_service.load(cart)
    cart_service
  end

  def card
    card = Card.find_by(user_id: current_user.id)
    card = Card.create(user_id: current_user.id) if card.nil?
    card
  end

  def card_service
    card_service = CardService.new
    card_service.load(card)
    card_service
  end

  def order_service
    order = Order.create(user_id: current_user.id)
    order_service = OrderService.new
    order_service.load(order)
    order_service
  end

  def redirect_to_finish_wizard
    redirect_to root_path, notice: 'Thank you!'
  end
end
