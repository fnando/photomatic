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

    trait :exif do
      meta do
        {
          exif: Exif.extract_from_file(
            Rails.root.join("test/fixtures/files/beach.jpg")
          )
        }
      end
    end
  end

  factory :comment do
    association :user
    association :post
    text { "comment" }
  end

  preload do
    factory(:default) { create(:user) }
    factory(:default) { create(:post, user: users(:default)) }
    factory(:default) do
      create(:comment, user: users(:default), post: posts(:default))
    end
  end
end
