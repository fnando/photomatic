# frozen_string_literal: true

Sidekiq::Clockwork.run do
  # This is the default timeout
  # sleep_timeout 0.1

  # By default, it comes with a error handler like the following:
  # error_handler do |error|
  #   $stderr << "[CLOCKWORK] #{error.class}: #{error.message}"
  #   $stderr << " (" << error.backtrace_locations.first << ")\n"
  # end
  #
  # You can clean up error handlers with:
  # error_handlers.clear
  #
  # You may want to use an exception tracker like Rollbar:
  # error_handler do |error|
  #   Rollbar.error(error)
  # end
  #

  # You can schedule jobs by using `every`, which receives
  # an interval in seconds.
  every(5.minutes) { CleanUnusedUploadsWorker.perform_async }
end
