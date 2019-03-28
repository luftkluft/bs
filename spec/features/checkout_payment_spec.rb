RSpec.feature 'Checkout_payment Features', type: :feature, js: true do
  let(:card_number) { '0000 1111 2222 3333' }
  let(:card_name) { 'master' }
  let(:card_exp) { '05/19' }
  let(:card_cvv) { '123' }
  let(:card_mask) { '** ** **' }
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
    visit '/checkout_steps/checkout_payment'
  end

  scenario 'visit checkout_payment page' do
    expect(page).to have_content I18n.t('credit_card.attrs.number.title')
  end

  scenario 'fill card data' do
    page.find('#cardNumber').set(card_number)
    page.find('#cardName').set(card_name)
    page.find('#exp_date').set(card_exp)
    page.find('#cvv').set(card_cvv)
    page.find('#card_cubmit').click
    expect(page).to have_content card_mask
  end
end
