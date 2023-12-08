# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Treasury
    # Transactions represent changes to a [FinancialAccount's](https://docs.epayments.network/api#financial_accounts) balance.
    class Transaction < APIResource
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "treasury.transaction"
    end
  end
end
