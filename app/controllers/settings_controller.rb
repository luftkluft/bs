class SettingsController < ApplicationController
  before_action :authenticate_user!
  def show
    addr = AddressService.new
    @billing = addr.billing_address(current_user)
    @shipping = addr.shipping_address(current_user)
  end

  def save
    addr = AddressService.new
    errors = addr.save(current_user, address_params)
    if errors.nil?
      flash[:notice] = 'Address saved!'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Address not saved!' + errors.to_s
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def address_params
    params.permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type, :user_id, :checkbox)
  end
end
