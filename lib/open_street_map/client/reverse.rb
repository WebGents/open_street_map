module OpenStreetMap
  class Client
    # Reverse geocoding generates an address from a latitude and longitude
    module Reverse
      def reverse(args = {})
        response = RestClient.get("#{BASE_URI}reverse?#{args_to_url(args)}")
        args[:format] == 'xml' ? response.body : JSON.parse(response.body)
      rescue RestClient::BadRequest
        { 'errors' => 'Bad request' }
      end

      private

      def args_to_url(args, result = [])
        permitted_args(args).each do |key, value|
          result << "#{key}=#{value}"
        end
        result.join('&')
      end

      def permitted_args(args)
        args.slice(:format, :lat, :lon, :zoom, :addressdetails)
      end
    end
  end
end
