# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'bs@system.com'
  layout 'mailer'
end
