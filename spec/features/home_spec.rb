require 'rails_helper'

RSpec.feature 'Home Features', type: :feature do
  scenario 'visit home page' do
    visit '/'
    # save_and_open_page
    expect(page).to have_content 'Welcome to our amazing Bookstore!'
  end
  scenario 'click on button `Get Started`' do
    visit '/'
    find(:id, 'btn_get_started').click
    expect(page).to have_content 'hfhjgfjhgfjhf'
  end
end
