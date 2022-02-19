# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  get "home" => "home#index"

  route :login do
    create as: "login", bare: true
    get :check_inbox
    get :verify_email
  end

  post "logout" => "login#destroy"
  get "u/:username" => "profile#show",
      as: :profile

  route :posts do
    create
    update
    show
  end

  post "posts/:post_id/like" => "likes#create", as: :like_post, format: false
  delete "posts/:post_id/like" => "likes#delete", format: false
end
