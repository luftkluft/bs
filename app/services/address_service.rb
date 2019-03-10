class AddressService
  def initialize
    @errors = []
  end

  def save(user, address_params)
    @user = user
    @address_params = address_params
    @checkbox = @address_params[:checkbox]
    address_type = @address_params[:address_type]
    case address_type
    when I18n.t('services.billing_type') then billing_address_update
    when I18n.t('services.shipping_type') then shipping_address_update
    else @errors.push(I18n.t('services.unknown_type'))
    end
    return nil unless @errors.size.positive?

    @errors
  rescue StandardError
    @errors.push(I18n.t('services.error_save_address'))
  end

  def billing_address_update
    billing_addr = Address.find_by(user_id: @user.id, order_id: 0, address_type: I18n.t('services.billing_type'))
    billing_addr = Address.create(create_address_params) if billing_addr.nil?
    billing_addr.update(create_address_params)
  rescue StandardError
    @errors.push(I18n.t('services.error_update_billing_address'))
  end

  def create_address_params
    @address_params.delete('checkbox')
    @address_params
  end

  def shipping_address_update
    shipping_addr = Address.find_by(user_id: @user.id, order_id: 0, address_type: I18n.t('services.shipping_type'))
    shipping_addr = Address.create(create_address_params) if shipping_addr.nil?
    if @checkbox.nil?
      shipping_addr.update(create_address_params)
    else
      use_billing_address(shipping_addr)
    end
  rescue StandardError
    @errors.push(I18n.t('services.error_update_shipping_address'))
  end

  def use_billing_address(shipping_addr)
    billing_addr = Address.find_by(user_id: @user.id, order_id: 0, address_type: I18n.t('services.billing_type'))
    shipping_addr.address_type = I18n.t('services.shipping_type')
    shipping_addr.first_name = billing_addr.first_name
    shipping_addr.last_name = billing_addr.last_name
    shipping_addr.address = billing_addr.address
    shipping_addr.city = billing_addr.city
    shipping_addr.zip = billing_addr.zip
    shipping_addr.country = billing_addr.country
    shipping_addr.phone = billing_addr.phone
    shipping_addr.save
  rescue StandardError
    @errors.push(I18n.t('services.error_copy_billing_address'))
  end

  def billing_address(user)
    Address.find_by(user_id: user.id, order_id: 0, address_type: I18n.t('services.billing_type')) || Address.new
  end

  def shipping_address(user)
    
    Address.find_by(user_id: user.id, order_id: 0, address_type: I18n.t('services.shipping_type')) || Address.new
  end
end
