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
      flash[:alert].now = 'Error increment quantity!' + errors.to_s
    end
  end

  def decrememt_quantity(param = cart_params)
    item_owner(param[:decrement])
    @cart_service = cart_service
    errors = @cart_service.decrement_quantity(param[:decrement])
    if errors.nil?
      # TODO
    else
      flash[:alert].now = 'Error decrement quantity!' + errors.to_s
    end
  end

  def delete_item(param = cart_params)
    item_owner(param[:delete_item])
    @cart_service = cart_service
    errors = @cart_service.delete_item(param[:delete_item])
    if errors.nil?
      flash[:notice] = 'Item was deleted!'
    else
      flash[:alert] = 'Error delete item!' + errors.to_s
    end
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
    errors = @cart_service.add_item(param[:add_item], param[:quantity])
    if errors.nil?
      flash[:notice] = 'Item was added!'
    else
      flash[:alert] = 'Error add item!'
    end
    redirect_back(fallback_location: root_path)
  end

  def checkout
    @cart_service = cart_service
    errors = @cart_service.payment
    if errors.nil?
      redirect_to user_steps_path
    else
      flash[:alert] = 'Error checkout!' + errors.to_s
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
