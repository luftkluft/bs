require 'rails_helper'
RSpec.feature 'Home Features', type: :feature, :js => true do
  let!(:category1) { create(:category, id: 1, category_type: 'Web design')}
  let!(:category2) { create(:category, id: 2, category_type: 'Mobile development')}
  let!(:category3) { create(:category, id: 3, category_type: 'Databases')}
  let!(:category4) { create(:category, id: 4, category_type: 'Web development')}
  let!(:books) { create_list(:book, 10 )}
  def sign_up
    visit '/users/sign_in'
    click_on 'Sign up'
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Sign up'
  end
  before(:each) do
    visit root_path
  end
  scenario 'visit home page' do
    # sleep(5)
    # puts Category.all.inspect
    expect(page).to have_content I18n.t('header.shop_title')
    expect(page).to have_content I18n.t('home.invitation')
    expect(page).to have_content I18n.t('footer.shop_link')
    expect(page).not_to have_content I18n.t('footer.settings_link')
  end

  scenario 'click on button `Get Started` and redirect to `/catalog`' do
    # puts Category.all.inspect
    page.find('#btn_get_started').click
    expect(page).to have_content 'Сatalog'
  end

  scenario 'click on link `Shop`' do
    page.find('#header_shop_link').click
    expect(page).to have_content 'All categories'
    expect(page).to have_content 'Web design'
  end

  scenario 'click on button `Buy now` and redirect to `books/:id`' do
    page.find('#btn_buy_now').click
    expect(page).to have_content 'Read More'
  end

  scenario 'click on link `View book` and redirect to `books/:id`' do # TODO
    page.all('.thumb-hover-link')[0].click
    expect(page).to have_content 'Read More'
  end

  scenario 'click on link `Add to cart` and redirect to `/users/sign_in`' do # TODO
    page.all('.thumb-hover-link')[1].click
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
