# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module FinancialConnections
    # A Financial Connections Session is the secure way to programmatically launch the client-side ExpressPayments.js modal that lets your users link their accounts.
    class Session < APIResource
      extend ExpressPayments::APIOperations::Create

      OBJECT_NAME = "financial_connections.session"
    end
  end
end
