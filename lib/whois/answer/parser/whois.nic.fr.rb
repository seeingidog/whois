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


require 'whois/answer/parser/base'


module Whois
  class Answer
    class Parser

      #
      # = whois.nic.fr parser
      #
      # Parser for the whois.nic.fr server.
      #
      # NOTE: This parser is just a stub and provides only a few basic methods
      # to check for domain availability and get domain status.
      # Please consider to contribute implementing missing methods.
      # See WhoisNicIt parser for an explanation of all available methods
      # and examples.
      #
      class WhoisNicFr < Base

        property_supported :status do
          @status ||= if content_for_scanner =~ /status:\s+(.+)\n/
            case $1.downcase
              when "active" then :registered
              when "registered" then :registered
              # NEWSTATUS
              when "frozen" then :frozen
              else
                Whois.bug!(ParserError, "Unknown status `#{$1}'.")
            end
          else
            :available
          end
        end

        property_supported :available? do
          @available  ||= !!(content_for_scanner =~ /No entries found in the AFNIC Database/)
        end

        property_supported :registered? do
          @registered ||= !available?
        end


        property_supported :created_on do
          @created_on ||= if content_for_scanner =~ /created:\s+(.*)\n/
            d, m, y = $1.split("/")
            Time.parse("#{y}-#{m}-#{d}")
          end
        end

        property_supported :updated_on do
          @updated_on ||= if content_for_scanner =~ /last-update:\s+(.*)\n/
            d, m, y = $1.split("/")
            Time.parse("#{y}-#{m}-#{d}")
          end
        end

        # TODO: Use anniversary
        property_not_supported :expires_on


        property_supported :nameservers do
          @nameservers ||= content_for_scanner.scan(/nserver:\s+(.+)\n/).flatten.map { |value| value.split(" ").first }
        end

      end

    end
  end
end
