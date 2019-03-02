require 'rails_helper'

RSpec.feature 'Home Features', type: :feature, :js => true do
# RSpec.feature 'Home Features', type: :feature do
  before(:each) do
    visit root_path
end
  scenario 'visit home page' do
    expect(page).to have_content I18n.t('header.shop_title')
    expect(page).to have_content I18n.t('home.invitation')
    expect(page).to have_content I18n.t('footer.shop_link')
    expect(page).not_to have_content I18n.t('footer.settings_link')
  end
  scenario 'click on button `Get Started`' do
    page.find('#btn_get_started').click
    expect(page).to have_content 'Сatalog'
  end

  scenario 'click on button link `Shop`' do
    page.find('#header_shop_link').click
    expect(page).to have_content 'All categories'
  end

  scenario 'click on button `Buy now`' do
    # page.find('#btn_buy_now').click
    click_on 'Buy now'
    expect(page).to have_content 'Сatalog'
  end
end
