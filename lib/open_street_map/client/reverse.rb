module OpenStreetMap
  class Client
    # Reverse geocoding generates an address from a latitude and longitude
    module Reverse
      def reverse(args = {})
        response = RestClient.get("#{args[:hostname] || BASE_URI}reverse?#{reverse_args_to_url(args)}", user_agent: args[:user_agent] || DEFAULT_USER_AGENT)
        sleep(REQUEST_TIMEOUT)
        args[:format] == 'xml' ? response.body : JSON.parse(response.body)
      rescue
        { 'errors' => 'Bad request' }
      end

      private

      def reverse_args_to_url(args, result = [])
        valid_reverse_args(args).each do |key, value|
          key = 'accept-language' if key == :accept_language
          result << "#{key}=#{value}"
        end
        result.join('&')
      end

      def valid_reverse_args(args)
        args.slice(:format, :lat, :lon, :zoom, :addressdetails, :extratags, :namedetails, :accept_language, :email)
      end
    end
  end
end
