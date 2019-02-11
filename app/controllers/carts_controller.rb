class CartsController < ApplicationController
  before_action :authenticate_user!
  def show
    @cart = setup_cart
  end

  def incrememt_quantity(param = cart_params)
    item_owner(param[:increment])
    @cart = setup_cart
    result = @cart.increment_quantity(param[:increment])
    flash[:alert].now = 'Error increment quantity!' unless result
  end

  def decrememt_quantity(param = cart_params)
    item_owner(param[:decrement])
    @cart = setup_cart
    result = @cart.decrement_quantity(param[:decrement])
    flash[:alert].now = 'Error decrement quantity!' unless result
  end

  def delete_item(param = cart_params)
    item_owner(param[:delete_item])
    @cart = setup_cart
    result = @cart.delete_item(param[:delete_item])
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
    @cart = setup_cart
    result = @cart.add_item(param[:add_item], param[:quantity])
    flash[:alert] = 'Error add item!' unless result
    flash[:notice] = 'Item was added!' if result
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_params
    params.permit(:code, :increment, :decrement, :delete_item, :add_item, :quantity)
  end

  def setup_cart
    cart = Cart.find_by(user_id: current_user.id)
    cart = Cart.create(user_id: current_user.id) if cart.nil?
    cart_service ||= CartService.new
    cart_service.load(cart)
    cart_service
  end

  def item_owner(item_id)
    cart = setup_cart
    result = cart.items.find(item_id)
    if result.nil?
      flash[:alert] = 'Forbidden operation!'
      redirect_back(fallback_location: root_path)
    end
  rescue StandardError
    flash[:alert] = 'Forbidden operation!'
    redirect_back(fallback_location: root_path)
  end
end
