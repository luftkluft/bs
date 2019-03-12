require 'rails_helper'
RSpec.feature 'Auth Features', type: :feature, js: true do
  def sign_up
    visit '/users/sign_in'
    page.find('#new-sessions-sign-up').click
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[name]', with: 'Name'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Sign up'
  end

  def sign_out
    page.find('#account-dropdown').click
    page.find('#link-sign-out').click
  end

  scenario 'sign up' do
    sign_up
    expect(page).to have_content 'Welcome!'
  end

  scenario 'sign out' do
    sign_up
    sign_out
    expect(page).to have_content 'Signed out successfully'
  end

  scenario 'sign in' do
    sign_up
    sign_out
    visit '/users/sign_in'
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
