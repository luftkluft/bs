require 'rails_helper'
RSpec.feature 'Cart Features', type: :feature, js: true do
  let!(:category1) { create(:category, id: 1, category_type: 'Web design') }
  let!(:category2) { create(:category, id: 2, category_type: 'Mobile development') }
  let!(:category3) { create(:category, id: 3, category_type: 'Databases') }
  let!(:category4) { create(:category, id: 4, category_type: 'Web development') }
  let!(:books) { create_list(:book, 10) }
  let(:true_coupon_code) { '12345' }
  let(:false_coupon_code) { '11111' }
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
    page.find('#book-add-to-cart').click
    page.find('#link-catalog-cart').click
  end
  scenario 'visit cart page' do
    expect(page).to have_content 'Cart'
  end

  xscenario 'coupon was successfully applied' do
    fill_in I18n.t('cart.coupon.title'), with: true_coupon_code
    page.find('#cart-btn-coupon').click
    expect(page).to have_content I18n.t('cart.coupon.update.success')
  end

  xscenario 'errors occurred while saving your coupon' do
    fill_in I18n.t('cart.coupon.title'), with: false_coupon_code
    page.find('#cart-btn-coupon').click
    expect(page).to have_content I18n.t('cart.coupon.update.failure')
  end
end
