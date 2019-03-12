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

  scenario 'visit catalog page' do
    visit '/catalog'
    expect(page).to have_content 'Сatalog'
    expect(page).not_to have_link('link-catalog-cart')
  end

  scenario 'sign up and visit catalog page' do
    sign_up
    visit '/catalog'
    expect(page).to have_content 'Сatalog'
    expect(page).to have_link('link-catalog-cart')
  end

  scenario 'choose book' do
    sign_up
    visit '/catalog'
    page.all('.thumb-hover-link')[1].click # TODO
    expect(page).to have_content 'Book was added' # TODO
  end

  scenario 'click on cart link' do
    sign_up
    visit '/catalog'
    page.all('.thumb-hover-link')[1].click # TODO
    page.find('#link-catalog-cart').click
    expect(page).to have_content 'Cart'
  end
end
