# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  route :login do
    create as: "login"
  end

  # Shows a screen saying that the email has been sent.
  get "check-inbox" => "login#check_inbox", as: :check_inbox

  # Confirms the email that has been sent by validating it against the auth
  # code.
  get "verify-email" => "login#verify_email", as: :verify_email
end
