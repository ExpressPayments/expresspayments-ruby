# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Terminal
    # A Location represents a grouping of readers.
    #
    # Related guide: [Fleet management](https://docs.epayments.network/terminal/fleet/locations)
    class Location < APIResource
      extend ExpressPayments::APIOperations::Create
      include ExpressPayments::APIOperations::Delete
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "terminal.location"
    end
  end
end
