class CartService
  def initialize
    @subtotal = 0.0
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

  def image(item_id)
    book = find_book(item_id)
    book.image.url(:size400x300)
  end

  def book_title(item_id)
    book = find_book(item_id)
    book.title
  end

  def book_price(item_id)
    book = find_book(item_id)
    book.price
  end

  def find_book(item_id)
    item = find_item(item_id)
    Book.find_by(id: item.book_id)
  end

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
    true
  rescue StandardError
    false
  end

  def decrement_quantity(item_id)
    item = find_item(item_id)
    if item.quantity.positive?
      item.quantity -= 1
      item.save
    end
    true
  rescue StandardError
    false
  end

  def delete_item(item_id)
    item = find_item(item_id)
    item.delete
    true
  rescue StandardError
    false
  end

  def add_item(book_id, quantity)
    quantity = 1 if quantity.nil?
    Item.create(book_id: book_id, cart_id: @cart.id, quantity: quantity)
    true
  rescue StandardError
    false
  end
end
