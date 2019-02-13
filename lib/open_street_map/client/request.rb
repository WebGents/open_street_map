module OpenStreetMap
  class Client
    # methods for request
    module Request
      private

      def call(type, args)
        url = generate_url(type, args)
        response = fetch(url, args)
        parse(response, args[:format])
      rescue
        { 'errors' => 'Bad request' }
      end

      # generate url from args
      def generate_url(type, args)
        valid_args_list = valid_args(type)
        args = args.select { |key, _value| valid_args_list.include?(key) }
        url = args.inject('') { |acc, (key, value)| acc + add_to_options(key, value, acc) }
        type + url
      end

      # make request to API
      def fetch(url, args)
        url = hostname(args[:hostname]) + url
        RestClient.get(url, user_agent: user_agent(args[:user_agent]))
      end

      # parse response
      def parse(response, format)
        if json_parse_valid?(format)
          JSON.parse(response.body)
        else
          response.body
        end
      end

      # get list of permitted args
      def valid_args(type)
        case type
          when 'search' then %i[q format addressdetails extratags namedetails viewbox bounded exclude_place_ids limit accept_language email]
          when 'reverse' then %i[format lat lon zoom addressdetails extratags namedetails accept_language email]
          else []
        end
      end

      # make combination of special symbol and param with value
      def add_to_options(key, value, acc)
        symbol_for_param(acc) + key_value_param(key, remove_spaces(value))
      end

      # select special symbol
      def symbol_for_param(acc)
        acc == '' ? '?' : '&'
      end

      # make combination of param with value
      def key_value_param(key, value)
        if key == :accept_language
          "accept-language=#{value}"
        else
          "#{key}=#{value}"
        end
      end

      # replace spaces with + for values
      def remove_spaces(value)
        value.gsub(/\s+/, '+')
      end

      # select hostname for request
      def hostname(value)
        value || BASE_URI
      end

      # select user_agent for request
      def user_agent(value)
        value || DEFAULT_USER_AGENT
      end

      # if format equal json then allow parsing
      def json_parse_valid?(format)
        format == 'json' || format == 'jsonv2'
      end
    end
  end
end
