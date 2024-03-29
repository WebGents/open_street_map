# frozen_string_literal: true

require 'httparty'
require_relative 'client/request'

module OpenStreetMap
  class Client
    include HTTParty
    include OpenStreetMap::Client::Request

    BASE_URI = 'https://nominatim.openstreetmap.org/'
    DEFAULT_USER_AGENT = "webgents/open_street_map_gem_#{SecureRandom.urlsafe_base64}"

    # Search objects by query
    def search(args = {})
      call('search', args)
    end

    # Reverse geocoding generates an address from a latitude and longitude
    def reverse(args = {})
      call('reverse', args)
    end
  end
end
