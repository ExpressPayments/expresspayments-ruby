# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Treasury
    # ReceivedCredits represent funds sent to a [FinancialAccount](https://docs.epayments.network/api#financial_accounts) (for example, via ACH or wire). These money movements are not initiated from the FinancialAccount.
    class ReceivedCredit < APIResource
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "treasury.received_credit"

      def test_helpers
        TestHelpers.new(self)
      end

      class TestHelpers < APIResourceTestHelpers
        RESOURCE_CLASS = ReceivedCredit

        def self.create(params = {}, opts = {})
          request_expresspayments_object(
            method: :post,
            path: "/v1/test_helpers/treasury/received_credits",
            params: params,
            opts: opts
          )
        end
      end
    end
  end
end
