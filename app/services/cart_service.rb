class CartService
  def initialize
    @subtotal = 0.0
    @errors = []
  end

  def load(cart)
    @cart = cart
  end

  def items
    @cart.items || []
  end

  def coupon
    @cart.coupon || 0.0
  end

  ############################## TODO
  def image(item_id)
    book = find_book(item_id)
    book.image.url(:size400x300)
  end

  def book_title(item_id)
    book = find_book(item_id)
    book.title
  end

  def book_description(item_id)
    book = find_book(item_id)
    book.description
  end

  def book_price(item_id)
    book = find_book(item_id)
    book.price
  end

  def find_book(item_id)
    item = find_item(item_id)
    Book.find_by(id: item.book_id)
  end
##################################### TODO
  def subtotal(value = 0)
    @subtotal += value
  end

  def item_subtotal(item_id)
    item_quantity(item_id) * book_price(item_id)
  end

  def item_quantity(item_id)
    item = find_item(item_id)
    item.quantity
  end

  def find_item(item_id)
    items.find_by(id: item_id)
  end

  def increment_quantity(item_id)
    item = find_item(item_id)
    if item.quantity <= 14
      item.quantity += 1
      item.save
    end
    nil
  rescue StandardError
    @errors.push('Cart: Error increment quantity!')
  end

  def decrement_quantity(item_id)
    item = find_item(item_id)
    if item.quantity.positive?
      item.quantity -= 1
      item.save
    end
    nil
  rescue StandardError
    @errors.push('Cart: Error decrement quantity!')
  end

  def delete_item(item_id)
    item = find_item(item_id)
    item.delete
    nil
  rescue StandardError
    @errors.push('Cart: Error delete item!')
  end

  def add_item(book_id, quantity)
    quantity = 1 if quantity.nil?
    Item.create(book_id: book_id, cart_id: @cart.id, quantity: quantity)
    nil
  rescue StandardError
    @errors.push('Cart: Error add item')
  end

  def checkout
    items.each do |item|
      item_sub = item_subtotal(item.id)
      subtotal(item_sub)
    end
    @cart.item_total_price = @subtotal
    @cart.order_total_price = @subtotal - coupon + delivery_price
    @cart.save
    nil
  rescue StandardError
    @errors.push('Cart: Error checkout!')
  end

  def choose_delivery(delivery_id)
    @errors += 'Cart: Delivery is nil!' if delivery_id.nil?
    @cart.delivery_id = delivery_id
    @cart.save
    nil
  rescue StandardError
    @errors.push('Cart: Error choose delivery!')
  end

  def delivery_price
    price = Delivery.find_by(id: @cart.delivery_id).price
    price
    rescue StandardError
      0.0
  end

  def clean_cart
    items = Item.where(cart_id: @cart.id)
    items.each do |item|
      item.delete
    end
    @cart.coupon = 0.0
    @cart.item_total_price = 0.0
    @cart.order_total_price = 0.0
    @cart.delivery_id = nil
    @cart.save
    nil
  rescue StandardError
    @errors.push('Cart: Error clean cart')
  end
end
