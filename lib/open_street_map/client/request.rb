module OpenStreetMap
  class Client
    # methods for request
    module Request
      private

      # make request to API
      def call(type, args)
        url = hostname(args[:hostname]) + type
        headers = { 'User-Agent' => user_agent(args[:user_agent]) }
        self.class.get(url, query: generate_body(type, args), headers: headers).parsed_response
      end

      # generate body from args
      def generate_body(type, args)
        args['accept-language'.to_sym] = args[:accept_language] if args.key?(:accept_language)
        args.select { |key, _| valid_args(type).include?(key) }
      end

      # get list of permitted args
      def valid_args(type)
        case type
          when 'search' then %i[q format addressdetails extratags namedetails viewbox bounded exclude_place_ids limit accept-language email]
          when 'reverse' then %i[format lat lon zoom addressdetails extratags namedetails accept-language email]
          else []
        end
      end

      # select hostname for request
      def hostname(value)
        value || BASE_URI
      end

      # select user_agent for request
      def user_agent(value)
        value || DEFAULT_USER_AGENT
      end
    end
  end
end
