# frozen_string_literal: true

module GeoLocation
  module Development
    def self.call(latitude:, longitude:)
      return unless latitude && longitude

      Location.new("CAN", "BC", "Vancouver")
    end
  end
end
