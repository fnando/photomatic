# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    display_name { "john" }
    sequence(:email) {|n| "#{n}@photomatic.app" }
  end

  factory :post do
    association :user

    after(:build) do |record|
      record.raw_photo.attach(
        io: Rails.root.join("test/fixtures/files/beach.jpg").open,
        filename: "beach.jpg",
        content_type: "image/jpeg"
      )
    end
  end

  preload do
    factory(:john) { create(:user) }
    factory(:default) { create(:post, user: users(:john)) }
  end
end
