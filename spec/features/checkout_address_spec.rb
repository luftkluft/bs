RSpec.feature 'Checkout_address Features', type: :feature, js: true do
  let!(:category1) { create(:category, id: 1, category_type: 'Web design') }
  let!(:category2) { create(:category, id: 2, category_type: 'Mobile development') }
  let!(:category3) { create(:category, id: 3, category_type: 'Databases') }
  let!(:category4) { create(:category, id: 4, category_type: 'Web development') }
  let!(:books) { create_list(:book, 10) }
  let!(:billing_address) { create(:billing_address) }
  let!(:shipping_address) { create(:shipping_address, first_name: 'Name') }
  let(:first_name) { 'FirstName' }
  let(:last_name) { 'LastName' }
  let(:address) { 'Address' }
  let(:city) { 'City' }
  let(:zip) { '12345' }
  let(:phone) { '+1234567' }
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
    page.find('#link-catalog-cart').click
    page.find('#cart-btn-checkout').click
  end

  before do
    sign_up
    add_book
  end

  scenario 'visit checkout_address page' do
    expect(page).to have_content I18n.t('address.billing')
  end

  scenario 'fill billing address' do
    page.find('#b_firstName').set(first_name)
    page.find('#b_lastName').set(last_name)
    page.find('#b_address').set(address)
    page.find('#b_city').set(city)
    page.find('#b_zip').set(zip)
    page.find('#b_phone').set(phone)
    page.find('#b_commit').click
    expect(page).to have_content I18n.t('address.save_success')
  end

  scenario 'fill shipping address with checkbox' do
    page.find('#b_firstName').set(first_name)
    page.find('#b_lastName').set(last_name)
    page.find('#b_address').set(address)
    page.find('#b_city').set(city)
    page.find('#b_zip').set(zip)
    page.find('#b_phone').set(phone)
    page.find('#b_commit').click
    billing_address.user_id = User.first.id
    page.find('#checkbox_icon').click
    page.find('#sh_commit').click
    expect(page).to have_content I18n.t('address.save_success')
    expect(page.find('#sh_firstName').value).to eq(first_name)
  end

  scenario 'fill shipping address' do
    page.find('#sh_firstName').set(first_name)
    page.find('#sh_lastName').set(last_name)
    page.find('#sh_address').set(address)
    page.find('#sh_city').set(city)
    page.find('#sh_zip').set(zip)
    page.find('#sh_phone').set(phone)
    page.find('#sh_commit').click
    expect(page).to have_content I18n.t('address.save_success')
    expect(page.find('#sh_firstName').value).to eq(first_name)
  end

  scenario 'click on `continue` button' do
    page.find('#btn_continue').click
    expect(page).to have_content I18n.t('checkout.save_continue_btn')
  end
end
