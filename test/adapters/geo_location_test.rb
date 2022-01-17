# frozen_string_literal: true

require "test_helper"

class GeoLocationTest < ActiveSupport::TestCase
  setup do
    GeoLocation.adapter = GeoLocation::PositionStack
  end

  teardown do
    GeoLocation.adapter = GeoLocation::Development
  end

  test "returns hash representation for location" do
    loc = GeoLocation::Location.new("CAN", "BC", "Vancouver").to_h
    expected = {country: "CAN", region: "BC", city: "Vancouver"}

    assert_equal expected, loc
  end

  test "returns location" do
    stub_request(:get, /api\.positionstack\.com/)
      .to_return(
        body: file_fixture("positionstack-success.json").read,
        headers: {"content-type" => "application/json"}
      )

    loc = GeoLocation.call(latitude: "48.42", longitude: "-123.46")

    refute_nil loc
    assert_equal "Colwood", loc.city
    assert_equal "CAN", loc.country
    assert_equal "BC", loc.region
  end

  test "returns nil when one of the coords is unavailable" do
    assert_nil GeoLocation.call(latitude: nil, longitude: "-1234.56")
    assert_nil GeoLocation.call(latitude: "48.42", longitude: nil)
    assert_nil GeoLocation.call(latitude: nil, longitude: nil)
  end

  test "returns nil for invalid coords" do
    stub_request(:get, /api\.positionstack\.com/)
      .to_return(
        body: file_fixture("positionstack-error.json").read,
        headers: {"content-type" => "application/json"},
        status: 422
      )

    loc = GeoLocation.call(latitude: "48.42", longitude: "-1234.56")

    assert_nil loc
  end

  test "tracks other errors" do
    ErrorTracker
      .expects(:track)
      .with(kind_of(StandardError), context: {body: "Server Error"})

    stub_request(:get, /api\.positionstack\.com/)
      .to_return(
        body: "Server Error",
        headers: {"content-type" => "text/plain"},
        status: 500
      )

    loc = GeoLocation.call(latitude: "48.42", longitude: "-1234.56")

    assert_nil loc
  end
end
