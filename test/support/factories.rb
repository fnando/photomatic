# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    display_name { "john" }
    sequence(:email) {|n| "#{n}@photomatic.app" }
  end

  factory :post do
    association :user
  end

  preload do
    factory(:john) { create(:user) }
  end
end
