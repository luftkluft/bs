class CartsController < ApplicationController
  before_action :authenticate_user!
  def show
    @cart_service = cart_service
  end

  def incrememt_quantity(param = cart_params)
    item_owner(param[:increment])
    @cart_service = cart_service
    errors = @cart_service.increment_quantity(param[:increment])
    if errors.nil?
      # TODO
    else
      flash[:alert].now = I18n.t('order_item.error_increment_quantity')
    end
  end

  def decrememt_quantity(param = cart_params)
    item_owner(param[:decrement])
    @cart_service = cart_service
    errors = @cart_service.decrement_quantity(param[:decrement])
    if errors.nil?
      # TODO
    else
      flash[:alert].now = I18n.t('order_item.error_decrement_quantity')
    end
  end

  def delete_item(param = cart_params)
    item_owner(param[:delete_item])
    @cart_service = cart_service
    errors = @cart_service.delete_item(param[:delete_item])
    if errors.nil?
      flash[:notice] = I18n.t('order_item.book_delete_success')
    else
      flash[:alert] = I18n.t('order_item.error_delete_book')
    end
    redirect_back(fallback_location: root_path)
  end

  def coupon(param = cart_params)
    code = param[:code]
    return redirect_back(fallback_location: root_path) if code == '' || code.nil?

    cart = Cart.find_by(user_id: current_user.id)
    coupon = Coupon.find_by(code: code).value
    cart.update(coupon: coupon)
    flash[:notice] = I18n.t('cart.coupon.update.success')
    redirect_back(fallback_location: root_path)
  rescue StandardError
    flash[:alert] = I18n.t('cart.coupon.update.failure')
    redirect_back(fallback_location: root_path)
  end

  def add_item(param = cart_params)
    @cart_service = cart_service
    errors = @cart_service.add_item(param[:add_item], param[:quantity])
    if errors.nil?
      flash[:notice] = I18n.t('order_item.book_add_success')
    else
      flash[:alert] = I18n.t('order_item.error_add_book')
    end
    redirect_back(fallback_location: root_path)
  end

  def checkout
    @cart_service = cart_service
    errors = @cart_service.payment
    if errors.nil?
      redirect_to checkout_steps_path
    else
      flash[:alert] = I18n.t('cart.error_payment')
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def cart_params
    params.permit(:code, :increment, :decrement, :delete_item, :add_item, :quantity)
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

  def item_owner(item_id)
    result = cart_service.items.find(item_id)
    if result.nil?
      flash[:alert] = I18n.t('shared.forbidden_operation')
      redirect_back(fallback_location: root_path)
    end
  rescue StandardError
    flash[:alert] = I18n.t('shared.forbidden_operation')
    redirect_back(fallback_location: root_path)
  end
end
