# frozen_string_literal: true

module ErrorTracker
  def self.track(error, context:)
    Rails.logger.tagged("error-tracking") do |logger|
      logger.error "#{error.full_message} (context=#{JSON.dump(context)})"
    end
  end
end
