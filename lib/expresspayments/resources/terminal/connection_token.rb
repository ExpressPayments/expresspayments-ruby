# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Terminal
    # A Connection Token is used by the ExpressPayments Terminal SDK to connect to a reader.
    #
    # Related guide: [Fleet management](https://docs.epayments.network/terminal/fleet/locations)
    class ConnectionToken < APIResource
      extend ExpressPayments::APIOperations::Create

      OBJECT_NAME = "terminal.connection_token"
    end
  end
end
