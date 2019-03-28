require 'rails_helper'
RSpec.feature 'Book Features', type: :feature, js: true do
  let!(:category1) { create(:category, id: 1, category_type: 'Web design') }
  let!(:category2) { create(:category, id: 2, category_type: 'Mobile development') }
  let!(:category3) { create(:category, id: 3, category_type: 'Databases') }
  let!(:category4) { create(:category, id: 4, category_type: 'Web development') }
  let!(:books) { create_list(:book, 10) }
  def sign_up
    visit '/users/sign_in'
    page.find('#new-sessions-sign-up').click
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[name]', with: 'Name'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Sign up'
  end

  before do
    sign_up
    visit '/catalog'
    page.all('.thumb-hover-link')[0].click # TODO
  end

  scenario 'click on view book link' do
    expect(page).to have_content 'Write a Review'
  end

  scenario 'increment book quantity' do
    expect(page.find('#book_count').value).to eq('1')
    page.find('#plus_book').click
    expect(page.find('#book_count').value).to eq('2')
  end

  scenario 'decrement book quantity' do
    page.find('#plus_book').click
    expect(page.find('#book_count').value).to eq('2')
    page.find('#minus_book').click
    expect(page.find('#book_count').value).to eq('1')
  end

  scenario 'click on button `add to cart`' do
    expect(page.find('#shop_item_quantity').text).to eq('0')
    page.find('#book-add-to-cart').click
    expect(page.find('#shop_item_quantity').text).to eq('1')
    expect(page).to have_content I18n.t('order_item.book_add_success')
  end
end
