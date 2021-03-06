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


require 'whois/answer/super_struct'


module Whois
  class Answer

    # Holds the details of a contact extracted from the WHOIS response.
    #
    # A contact is composed by the several attributes,
    # accessible through corresponding getter / setter methods.
    #
    # Please note that a response is not required to provide
    # all the attributes. When an attribute is not available,
    # the corresponding value is set to nil.
    #
    # @attr [String] id
    # @attr [String] type
    # @attr [String] name
    # @attr [String] organization
    # @attr [String] address
    # @attr [String] city
    # @attr [String] zip
    # @attr [String] state
    # @attr [String] country
    # @attr [String] country_code
    # @attr [String] phone
    # @attr [String] fax
    # @attr [String] email
    # @attr [Time] created_on
    # @attr [Time] updated_on
    #
    class Contact < SuperStruct.new(:id, :type, :name, :organization,
                                    :address, :city, :zip, :state, :country, :country_code,
                                    :phone, :fax, :email,
                                    :created_on, :updated_on)

      TYPE_REGISTRANT = 1
      TYPE_ADMIN = 2
      TYPE_TECHNICAL = 3

    end

  end
end
