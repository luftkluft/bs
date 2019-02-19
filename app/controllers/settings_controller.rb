class SettingsController < ApplicationController
  before_action :authenticate_user!
  def show
    @billing = Address.where(user_id: current_user.id, address_type: 'billing')
    @shipping = Address.where(user_id: current_user.id, address_type: 'shipping')
  end

  def save
    if params[:address_type] == 'billing'
      billing_addr = Address.find_by(user_id: current_user, order_id: 0, address_type: 'billing')
      billing_addr = Address.create(address_params) if billing_addr.nil?
      if billing_addr.update(address_params)
        flash[:notice] = 'Billing address saved!'
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = 'Billing address not saved!'
        redirect_back(fallback_location: root_path)
      end
    elsif params[:address_type] == 'shipping'
      shipping_addr = Address.find_by(user_id: current_user, order_id: 0, address_type: 'shipping')
      shipping_addr = Address.create(address_params) if shipping_addr.nil?
      if shipping_addr.update(address_params)
        flash[:notice] = 'Shipping address saved!'
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = 'Shipping address not saved!'
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = 'Wrong params!'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def address_params
    params.permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type, :user_id)
  end
end
