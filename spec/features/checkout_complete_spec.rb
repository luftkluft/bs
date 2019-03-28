RSpec.feature 'Checkout_complete Features', type: :feature, js: true do
  let!(:category1) { create(:category, id: 1, category_type: 'Web design') }
  let!(:category2) { create(:category, id: 2, category_type: 'Mobile development') }
  let!(:category3) { create(:category, id: 3, category_type: 'Databases') }
  let!(:category4) { create(:category, id: 4, category_type: 'Web development') }
  let!(:books) { create_list(:book, 10) }
  let(:card_mask) { '** ** **' }
  let!(:delivery1) { create(:delivery, id: 1, method: 'Method of delivery') }
  def sign_up
    visit '/users/sign_in'
    page.find('#new-sessions-sign-up').click
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[name]', with: 'Name'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Sign up'
  end

  def add_book
    visit '/catalog'
    page.all('.thumb-hover-link')[0].click # TODO
    page.find('#book-add-to-cart').click
  end

  before do
    sign_up
    add_book
    visit '/checkout_steps/checkout_confirm'
    create(:cart, user_id: User.first.id, delivery_id: Delivery.first.id)
    create(:billing_address, user_id: User.first.id)
    create(:shipping_address, user_id: User.first.id)
    page.find('#place_order').click
  end

  scenario 'visit checkout_complete page' do
    expect(page).to have_content I18n.t('checkout.thanks_for_order')
  end

  scenario 'click on home button' do
    page.find('#btn_home').click
    expect(page).to have_content I18n.t('home.invitation')
  end

  scenario 'visit orders page' do
    page.find('#footer_orders').click
    expect(page).to have_content I18n.t('order.list_title')
  end
end
