module OpenStreetMap
  class Client
    # Search objects by query
    module Search
      def search(args = {})
        response = RestClient.get("#{BASE_URI}search?#{search_arg(args[:q])}&#{search_args_to_url(args)}")
        args[:format] == 'xml' ? response.body : JSON.parse(response.body)
      rescue
        { 'errors' => 'Bad request' }
      end

      private

      def search_arg(arg)
        "q=#{arg.gsub(/\s+/, '+')}"
      end

      def search_args_to_url(args, result = [])
        valid_search_args(args).each do |key, value|
          key = 'accept-language' if key == :accept_language
          result << "#{key}=#{value}"
        end
        result.join('&')
      end

      def valid_search_args(args)
        args.slice(:format, :addressdetails, :extratags, :namedetails, :viewbox, :bounded, :exclude_place_ids, :limit, :accept_language, :email)
      end
    end
  end
end
