# frozen_string_literal: true

require "test_helper"

class GeoLocationTest < ActiveSupport::TestCase
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
