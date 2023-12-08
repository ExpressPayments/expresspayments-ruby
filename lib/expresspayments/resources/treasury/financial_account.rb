# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Treasury
    # ExpressPayments Treasury provides users with a container for money called a FinancialAccount that is separate from their Payments balance.
    # FinancialAccounts serve as the source and destination of Treasury's money movement APIs.
    class FinancialAccount < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "treasury.financial_account"

      def retrieve_features(params = {}, opts = {})
        request_expresspayments_object(
          method: :get,
          path: format("/v1/treasury/financial_accounts/%<financial_account>s/features", { financial_account: CGI.escape(self["id"]) }),
          params: params,
          opts: opts
        )
      end

      def update_features(params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: format("/v1/treasury/financial_accounts/%<financial_account>s/features", { financial_account: CGI.escape(self["id"]) }),
          params: params,
          opts: opts
        )
      end

      def self.retrieve_features(financial_account, params = {}, opts = {})
        request_expresspayments_object(
          method: :get,
          path: format("/v1/treasury/financial_accounts/%<financial_account>s/features", { financial_account: CGI.escape(financial_account) }),
          params: params,
          opts: opts
        )
      end

      def self.update_features(financial_account, params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: format("/v1/treasury/financial_accounts/%<financial_account>s/features", { financial_account: CGI.escape(financial_account) }),
          params: params,
          opts: opts
        )
      end
    end
  end
end
