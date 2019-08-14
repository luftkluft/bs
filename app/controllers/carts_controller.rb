class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :cart_service, only: [:show, :incrememt_quantity, :decrememt_quantity,
                                      :delete_item, :add_item, :checkout]
  def show
  end

  def incrememt_quantity
    item_owner(cart_params[:increment])
    errors = @cart_service.increment_quantity(cart_params[:increment])
    flash[:alert].now = I18n.t('order_item.error_increment_quantity') if errors
  end

  def decrememt_quantity
    item_owner(cart_params[:decrement])
    errors = @cart_service.decrement_quantity(cart_params[:decrement])
    flash[:alert].now = I18n.t('order_item.error_increment_quantity') if errors
  end

  def delete_item
    item_owner(cart_params[:delete_item])
    errors = @cart_service.delete_item(cart_params[:delete_item])
    if errors.blank?
      flash[:notice] = I18n.t('order_item.book_delete_success')
    else
      flash[:alert] = I18n.t('order_item.error_delete_book')
    end
    redirect_back(fallback_location: root_path)
  end

  def coupon
    code = cart_params[:code]
    return redirect_back(fallback_location: root_path) if code == '' || code.blank?

    cart = Cart.find_by(user_id: current_user.id)
    coupon = Coupon.find_by(code: code).value
    cart.update(coupon: coupon)
    flash[:notice] = I18n.t('cart.coupon.update.success')
    redirect_back(fallback_location: root_path)
  rescue StandardError
    flash[:alert] = I18n.t('cart.coupon.update.failure')
    redirect_back(fallback_location: root_path)
  end

  def add_item
    errors = @cart_service.add_item(cart_params[:add_item], cart_params[:quantity])
    if errors.blank?
      flash[:notice] = I18n.t('order_item.book_add_success')
    else
      flash[:alert] = I18n.t('order_item.error_add_book')
    end
    redirect_back(fallback_location: root_path)
  end

  def checkout
    errors = @cart_service.payment
    if errors.blank?
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
    cart = Cart.create(user_id: current_user.id) if cart.blank?
    cart
  end

  def cart_service
    @cart_service ||= begin
      cart_service = CartService.new
      cart_service.load(cart)
      cart_service
    end
  end

  def item_owner(item_id)
    result = cart_service.items.find(item_id)
    if result.blank?
      flash[:alert] = I18n.t('shared.forbidden_operation')
      redirect_back(fallback_location: root_path)
    end
  rescue StandardError
    flash[:alert] = I18n.t('shared.forbidden_operation')
    redirect_back(fallback_location: root_path)
  end
end
