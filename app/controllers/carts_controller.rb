class CartsController < ApplicationController
  before_action :authenticate_user!
  def show
    @cart_service = cart_service
  end

  def incrememt_quantity(param = cart_params)
    item_owner(param[:increment])
    @cart_service = cart_service
    result = @cart_service.increment_quantity(param[:increment])
    flash[:alert].now = 'Error increment quantity!' unless result
  end

  def decrememt_quantity(param = cart_params)
    item_owner(param[:decrement])
    @cart_service = cart_service
    result = @cart_service.decrement_quantity(param[:decrement])
    flash[:alert].now = 'Error decrement quantity!' unless result
  end

  def delete_item(param = cart_params)
    item_owner(param[:delete_item])
    @cart_service = cart_service
    result = @cart_service.delete_item(param[:delete_item])
    flash[:alert] = 'Error delete item!' unless result
    flash[:notice] = 'Item was deleted!' if result
    redirect_back(fallback_location: root_path)
  end

  def coupon(param = cart_params)
    code = param[:code]
    return redirect_back(fallback_location: root_path) if code == '' || code.nil?

    cart = Cart.find_by(user_id: current_user.id)
    coupon = Coupon.find_by(code: code).value
    cart.update(coupon: coupon)
    flash[:notice] = 'Coupon added!'
    redirect_back(fallback_location: root_path)
  rescue StandardError
    flash[:alert] = 'Wrong coupon code!'
    redirect_back(fallback_location: root_path)
  end

  def add_item(param = cart_params)
    @cart_service = cart_service
    result = @cart_service.add_item(param[:add_item], param[:quantity])
    flash[:alert] = 'Error add item!' unless result
    flash[:notice] = 'Item was added!' if result
    redirect_back(fallback_location: root_path)
  end

  def checkout
    @cart_service = cart_service
    result = @cart_service.checkout
    if result
      redirect_to user_steps_path
    else
      flash[:alert] = 'Error checkout!'
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
    cart_service ||= CartService.new
    cart_service.load(cart)
    cart_service
  end

  def item_owner(item_id)
    cart_servise = cart_service
    result = cart_service.items.find(item_id)
    if result.nil?
      flash[:alert] = 'Forbidden operation!'
      redirect_back(fallback_location: root_path)
    end
  rescue StandardError
    flash[:alert] = 'Forbidden operation!'
    redirect_back(fallback_location: root_path)
  end
end
