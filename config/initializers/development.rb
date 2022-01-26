# frozen_string_literal: true

Rails.env.on(:development) do
  $stdout.sync = true
  $stderr.sync = true

  logger = ActiveSupport::Logger.new($stdout)
  logger.formatter = config.log_formatter
  config.logger = ActiveSupport::TaggedLogging.new(logger)
end
