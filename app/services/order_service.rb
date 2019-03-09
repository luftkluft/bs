class OrderService
  attr_reader :order
  def initialize
    @errors = []
  end

  def load(order)
    @order = order
    load_copied_data
  end

  def load_copied_data
    @cart = Cart.find_by(user_id: @order.user_id)
    @errors += I18n.t('services.order_cart_not_fined') if @cart.nil?
  end

  def order_shipping
    Address.where(order_id: @order.id, address_type: I18n.t('services.shipping_type'))
  end

  def assembling_data
    invoice_order
    add_prices
    add_billing_address
    add_shipping_address
    add_order_items
    add_delivery
    return nil unless @errors.size.positive?

    @errors
  end

  def add_delivery
    @order.delivery_id = @cart.delivery_id
    @order.save
  rescue StandardError
    @errors.push(I18n.t('services.order_error_add_delivery'))
  end

  def order_items
    order_items = OrderItem.where(order_id: @order.id) || []
    order_items
  end

  def add_order_items
    @cart.items.each do |item|
      OrderItem.create!(
        book_id: item.book_id,
        order_id: @order.id,
        quantity: item.quantity
      )
      add_book_to_user(item)
      add_popularity_to_book(item)
    end
  rescue StandardError
    @errors.push(I18n.t('services.order_error_add_items'))
  end

  def add_popularity_to_book(item)
    book = find_book(item)
    book.popularity += item.quantity
    book.save
  rescue StandardError
    @errors.push('Order: Error added popularity!')
  end

  def add_book_to_user(item)
    user = User.find_by(id: @order.user_id)
    user.purchased_books.push(item.book_id) unless user.purchased_books.include?(item.book_id)
    user.save
  rescue StandardError
    @errors.push(I18n.t('services.order_error_add_book'))
  end

  def invoice_order
    @order.invoice = generate_invoice
    @order.save
  rescue StandardError
    @errors.push(I18n.t('services.order_error_create_invoice'))
  end

  def add_prices
    @order.item_total_price = @cart.item_total_price
    @order.order_total_price = @cart.order_total_price
    @order.coupon = @cart.coupon
    @order.save
  rescue StandardError
    @errors.push(I18n.t('services.order_error_add_prices'))
  end

  def add_shipping_address
    shipping_address = Address.where(user_id: @cart.user_id, address_type: I18n.t('services.shipping_type')).first
    address = Address.create!(
      order_id: @order.id,
      user_id: @order.user_id,
      address_type: shipping_address[:address_type],
      first_name: shipping_address[:first_name],
      last_name: shipping_address[:last_name],
      address: shipping_address[:address],
      city: shipping_address[:city],
      zip: shipping_address[:zip],
      country: shipping_address[:country],
      phone: shipping_address[:phone]
    )
  rescue StandardError
    @errors.push(I18n.t('services.order_error_add_shipping_address'))
  end

  def add_billing_address
    billing_address = Address.where(user_id: @cart.user_id, address_type: I18n.t('services.billing_type')).first
    address = Address.create!(
      order_id: @order.id,
      user_id: @order.user_id,
      address_type: billing_address[:address_type],
      first_name: billing_address[:first_name],
      last_name: billing_address[:last_name],
      address: billing_address[:address],
      city: billing_address[:city],
      zip: billing_address[:zip],
      country: billing_address[:country],
      phone: billing_address[:phone]
    )
  rescue StandardError
    @errors.push(I18n.t('services. order_error_add_billing_address'))
  end

  def generate_invoice
    time = Time.now.to_s
    time_zone_offset = -5
    "R##{time.gsub(/[-:\s]/, '')[0...time_zone_offset]}"
  end

  def image(item)
    book = find_book(item)
    book.image.url(:size400x300)
  end

  def book_title(item)
    book = find_book(item)
    book.title
  end

  def book_description(item)
    book = find_book(item)
    book.description
  end

  def book_price(item)
    book = find_book(item)
    book.price
  end

  def find_book(item)
    Book.find_by(id: item.book_id)
  end

  def delivery_price
    price = Delivery.find_by(id: @order.delivery_id).price
    price
  rescue StandardError
    0.0
  end

  def item_subtotal(item)
    item_quantity(item) * book_price(item)
  end

  def item_quantity(item)
    item.quantity
  end
end
