class SettingsController < ApplicationController
  before_action :authenticate_user!
  def show
    addr = AddressService.new
    @billing = addr.billing_address(current_user)
    @shipping = addr.shipping_address(current_user)
  end

  def save
    errors = AddressService.new.save(current_user, address_params)
    if errors.nil?
      flash[:notice] = I18n.t('address.save_success')
    else
      flash[:alert] = I18n.t('address.error_save_address')
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def address_params
    params.permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type, :user_id, :checkbox)
  end
end
