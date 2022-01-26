# frozen_string_literal: true

Rails.env.on(:development) do
  $stdout.sync = true
  $stderr.sync = true
end
