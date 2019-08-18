require 'rails_helper'
RSpec.feature 'Catalog Features', type: :feature, js: true do
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
  end

  scenario 'sign up and visit catalog page' do
    expect(page).to have_content 'Сatalog'
    expect(page).to have_link('link-catalog-cart')
  end

  scenario 'choose book' do
    page.all('.thumb-hover-link')[1].click # TODO
    expect(page).to have_content 'Book was added' # TODO
  end

  scenario 'click on cart link' do
    page.all('.thumb-hover-link')[1].click # TODO
    page.find('#link-catalog-cart').click
    expect(page).to have_content 'Cart'
  end

  scenario 'sort by newest first' do
    page.find('#sort_dropdown').click
    page.find('#newest-first').click
    expect(page).to have_content I18n.t('catalog.filters.by_date_desc')
  end

  scenario 'sort by popular first' do
    page.find('#sort_dropdown').click
    page.find('#popular-first').click
    expect(page).to have_content I18n.t('catalog.filters.popular_first')
  end

  scenario 'sort by low-to-hight' do
    page.find('#sort_dropdown').click
    page.find('#low-to-hight').click
    expect(page).to have_content I18n.t('catalog.filters.by_price_asc')
  end

  scenario 'sort by hight-to-low' do
    page.find('#sort_dropdown').click
    page.find('#hight-to-low').click
    expect(page).to have_content I18n.t('catalog.filters.by_price_desc')
  end

  scenario 'view Web design books' do
    page.find('#catalog-Webdesign').click
  end

  scenario 'view Mobile development books' do
    page.find('#catalog-Mobiledevelopment').click
  end

  scenario 'view Databases books' do
    page.find('#catalog-Databases').click
  end

  scenario 'view Web development books' do
    page.find('#catalog-Webdevelopment').click
  end
end
