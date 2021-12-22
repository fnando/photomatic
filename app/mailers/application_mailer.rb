# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Photomatic::Config.default_email_sender
  layout "mailer"
end
