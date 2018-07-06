require 'rest-client'
require 'json'
require_relative 'client/reverse'

module OpenStreetMap
  # Client requests
  class Client
    include OpenStreetMap::Client::Reverse

    BASE_URI = 'https://nominatim.openstreetmap.org/'.freeze

    def initialize(args = {}); end
  end
end
