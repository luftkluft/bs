class UserStepsController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_data
  before_action :set_state

  include Wicked::Wizard
  steps :checkout_address, :checkout_delivery, :checkout_payment,
        :checkout_confirm, :checkout_complete

  def show
    @deliveries = deliveries
    @delivery_price = @cart_service.delivery_price
    case step
    when :checkout_address
      if Item.count.positive?
        set_checkout_step(step)
      else
        flash[:alert] = I18n.t('checkout.steps.empty_cart')
        redirect_back(fallback_location: root_path) && return
      end
    when :checkout_delivery
      set_checkout_step(step)
    when :checkout_payment
      set_checkout_step(step)
    when :checkout_confirm
      set_checkout_step(step)
      @card_number = card.card_number
      @exp_date = card.expiration_month_year
    when :checkout_complete
      set_checkout_step(step)
    end
    render_wizard
  end

  def update
    case step
    when :checkout_address
      set_checkout_step(step)
    when :checkout_delivery
      set_checkout_step(step)
    when :checkout_payment
      set_checkout_step(step)
      choose_delivery
    when :checkout_confirm
      set_checkout_step(step)
      apply_card
    when :checkout_complete
      set_checkout_step(step)
      redirect_to_finish_wizard && return if @cart_service.items.count.zero?
      create_order
      render_wizard
    end
  end

  private

  def set_checkout_step(step)
    @checkout_state.state = step
    @checkout_state.save
  end

  def choose_delivery
    errors = @cart_service.choose_delivery(checkout_params[:delivery])
    if errors.nil?
      @cart_service.payment
      @delivery_price = @cart_service.delivery_price
      flash[:notice] = I18n.t('checkout.delivery_added_success')
      render_wizard
    else
      flash[:alert] = I18n.t('checkout.delivery_added_fall')
      redirect_back(fallback_location: root_path) && return
    end
  end

  def apply_card
    errors = card_service.save_card(checkout_params)
    if errors.nil?
      @cart_service.payment
      @delivery_price = @cart_service.delivery_price
      @card_number = card.card_number
      @exp_date = card.expiration_month_year
      render_wizard
    else
      flash[:alert] = I18n.t('checkout.card_error')
      redirect_back(fallback_location: root_path) && return
    end
  end

  def create_order
    @order_service = order_service
    errors = @order_service.assembling_data
    if errors.nil?
      @order_shipping = @order_service.order_shipping
      clean_cart
    else
      flash[:alert] = I18n.t('order.created_fall')
    end
  end

  def clean_cart
    errors = @cart_service.clean_cart
    if errors.nil?
      @delivery_price = @order_service.delivery_price
      UserMailer.order_email(current_user).deliver_later
      flash[:notice] = I18n.t('order.created_success')
    else
      flash[:alert] = I18n.t('order.created_fall')
    end
  end

  def prepare_data
    @cart = cart
    @card_number = []
    @cart_service = cart_service
    @delivery = @cart_service.delivery
    addr = AddressService.new
    @billing = addr.billing_address(current_user)
    @shipping = addr.shipping_address(current_user)
  end

  def checkout_params
    params.permit!
  end

  def deliveries
    Delivery.all || []
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
    redirect_to root_path, notice: I18n.t('order.thank_you')
  end

  def set_state
    @checkout_state = CheckoutState.last
    @checkout_state = CheckoutState.new unless @checkout_state
  end
end
