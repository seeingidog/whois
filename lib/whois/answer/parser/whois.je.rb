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
      # = whois.je parser
      #
      # Parser for the whois.je server.
      #
      # NOTE: This parser is just a stub and provides only a few basic methods
      # to check for domain availability and get domain status.
      # Please consider to contribute implementing missing methods.
      # See WhoisNicIt parser for an explanation of all available methods
      # and examples.
      #
      class WhoisJe < Base

        property_supported :status do
          @status ||= if content_for_scanner =~ /status:(.+?)\n/
            case $1.downcase
              when "0" then :available
              when "1" then :registered
              else
                Whois.bug!(ParserError, "Unknown status `#{$1}'.")
            end
          else
            Whois.bug!(ParserError, "Unable to parse status.")
          end
        end

        property_supported :available? do
          @available  ||= (status == :available)
        end

        property_supported :registered? do
          @registered ||= !available?
        end


        property_not_supported :created_on

        property_not_supported :updated_on

        property_not_supported :expires_on


        property_supported :nameservers do
          @nameservers ||= if content_for_scanner =~ /Registered Nameservers\n[-]+\n((.+\n)+)\n/
            $1.split("\n").map { |value| value.chomp(".") }
          else
            []
          end
        end

      end

    end
  end
end
