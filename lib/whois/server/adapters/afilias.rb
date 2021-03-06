#
# = Ruby Whois
#
# An intelligent pure Ruby WHOIS client and parser.
#
#
# Category::    Net
# Package::     Whois
# Author::      Simone Carletti <weppos@weppos.net>
# License::     MIT License
#
#--
#
#++


module Whois
  class Server
    module Adapters

      #
      # = Afilias Adapter
      #
      # Provides ability to query Afilias WHOIS interfaces.
      #
      class Afilias < Base

        # Executes a WHOIS query to the Afilias WHOIS interface,
        # resolving any intermediate referral,
        # and appends the response to the client buffer.
        #
        # @param  [String] string
        # @return [void]
        #
        def request(string)
          response = query_the_socket(string, "whois.afilias-grs.info", DEFAULT_WHOIS_PORT)
          append_to_buffer response, "whois.afilias-grs.info"

          if endpoint = extract_referral(response)
            response = query_the_socket(string, endpoint, DEFAULT_WHOIS_PORT)
            append_to_buffer response, endpoint
          end
        end


        private

          def extract_referral(response)
            if response =~ /Domain Name:/ && response =~ /Whois Server:(\S+)/
              $1
            end
          end

      end

    end
  end
end
