# frozen_string_literal: true

Rails.env.on(:development) do
  config.active_storage.service = :local
end

Rails.env.on(:test) do
  config.active_storage.service = :test
end

Rails.env.on(:production) do
  config.active_storage.service = :amazon
end
