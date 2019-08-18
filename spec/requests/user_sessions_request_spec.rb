require 'rails_helper'

RSpec.feature 'Sign up with Facebook' do
  def user_auth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: '123545',
      info:
      { email: 'user@example.com',
        first_name: 'First',
        last_name: 'Last' }
    )
  end

  scenario 'with invalid email and password' do
    visit '/users/sign_in'
    page.find('#new-sessions-sign-up').click
    expect(page).to have_no_content I18n.t('facebook.sign_out')
    page.find('#facebook_sign_up').click
    expect(page).to have_no_content I18n.t('facebook.auth_ok')
    expect(page).to have_no_content I18n.t('facebook.sign_out')
  end

  scenario 'with valid email and password' do
    user_auth
    visit '/users/sign_in'
    page.find('#new-sessions-sign-up').click
    expect(page).to have_no_content I18n.t('facebook.sign_out')
    page.find('#facebook_sign_up').click
    expect(page).to have_content I18n.t('facebook.auth_ok')
    expect(page).to have_content I18n.t('facebook.sign_out')
  end
end
