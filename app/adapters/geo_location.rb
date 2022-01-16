# frozen_string_literal: true

module GeoLocation
  Location = Struct.new(:country, :region, :city)

  class << self
    attr_accessor :adapter

    delegate :call, to: :adapter
  end

  self.adapter = PositionStack
end
