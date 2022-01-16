# frozen_string_literal: true

module GeoLocation
  module PositionStack
    def self.call(latitude:, longitude:)
      return unless latitude && longitude

      response = Aitch.get do
        url "http://api.positionstack.com/v1/reverse"
        params access_key: Photomatic::Config.position_stack_api_key,
               query: "#{latitude},#{longitude}"
      end

      return find_location(response) if response.success?

      return if response.unprocessable_entity?

      error = StandardError.new(
        "PositionStack has failed (status=#{response.code})"
      )

      ErrorTracker.track(error, context: {body: response.body})

      nil
    end

    def self.find_location(response)
      address = response.data["data"].find {|item| item["type"] == "address" }
      address ||= response.data.first

      return unless address

      Location.new(
        address["country_code"],
        address["region_code"],
        address["locality"]
      )
    end
  end
end
