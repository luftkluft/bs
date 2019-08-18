RSpec.feature 'Checkout_delivery Features', type: :feature, js: true do
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

  before do
    sign_up
    visit '/checkout_steps/checkout_delivery'
  end

  scenario 'visit checkout_delivery page' do
    expect(page).to have_content 'Method of delivery'
  end

  scenario 'delivery not choosed' do
    page.find('#btn_submit').click
    expect(page).to have_content I18n.t('checkout.delivery_added_fall')
  end

  scenario 'choose delivery' do
    page.find('#delivery_1').set(true)
    page.find('#btn_submit').click
    expect(page).to have_content I18n.t('credit_card.attrs.number.title')
  end
end
