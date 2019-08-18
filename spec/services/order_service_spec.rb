require 'rails_helper'

RSpec.describe OrderService do
  let!(:user) do
    User.create!(email: 'user@example.com',
                 password: 'password',
                 password_confirmation: 'password')
  end

  let(:current_subject) { described_class.new }
  let!(:delivery) { create(:delivery, id: 1, method: 'Walk') }
  let!(:category1) { create(:category, id: 1, category_type: 'Web design') }
  let!(:cart) { create(:cart, user_id: User.last.id, delivery_id: 1) }
  let!(:book) { create(:test_book) }
  let!(:item) { create(:item, book_id: book.id, cart_id: Cart.last.id) }

  it '#add_delivery with error' do
    current_subject.add_delivery
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.order_error_add_delivery')])
  end

  it '#add_order_items with error' do
    current_subject.add_order_items
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.order_error_add_items')])
  end

  it '#add_popularity_to_book with error' do
    current_subject.add_popularity_to_book(nil)
    expect(current_subject.instance_variable_get(:@errors)).to eq(['Order: Error added popularity!'])
  end

  it '#add_book_to_user with error' do
    current_subject.add_book_to_user(nil)
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.order_error_add_book')])
  end

  it '#invoice_order with error' do
    current_subject.invoice_order
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.order_error_create_invoice')])
  end

  it '#add_prices with error' do
    current_subject.add_prices
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.order_error_add_prices')])
  end

  it '#book_title' do
    expect(current_subject.book_title(item)).to eq(book.title)
  end

  it '#book_description' do
    expect(current_subject.book_description(item)).to eq(book.description)
  end

  it '#book_price' do
    expect(current_subject.book_price(item)).to eq(book.price)
  end

  it '#item_subtotal' do
    expect(current_subject.item_subtotal(item)).to eq(book.price * item.quantity)
  end

  it '#item_quantity' do
    expect(current_subject.item_quantity(item)).to eq(item.quantity)
  end
end
