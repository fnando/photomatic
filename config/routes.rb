# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  get "home" => "home#index"

  route :login do
    create as: "login", bare: true
    get :check_inbox
    get :verify_email
  end

  route :posts do
    create
    update
    show
  end
end
