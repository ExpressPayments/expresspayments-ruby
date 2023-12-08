# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Treasury
    # TransactionEntries represent individual units of money movements within a single [Transaction](https://docs.epayments.network/api#transactions).
    class TransactionEntry < APIResource
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "treasury.transaction_entry"

      def self.resource_url
        "/v1/treasury/transaction_entries"
      end
    end
  end
end
