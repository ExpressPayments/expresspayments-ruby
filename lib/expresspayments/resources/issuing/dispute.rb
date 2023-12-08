# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Issuing
    # As a [card issuer](https://docs.epayments.network/issuing), you can dispute transactions that the cardholder does not recognize, suspects to be fraudulent, or has other issues with.
    #
    # Related guide: [Issuing disputes](https://docs.epayments.network/issuing/purchases/disputes)
    class Dispute < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "issuing.dispute"

      def submit(params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: format("/v1/issuing/disputes/%<dispute>s/submit", { dispute: CGI.escape(self["id"]) }),
          params: params,
          opts: opts
        )
      end

      def self.submit(dispute, params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: format("/v1/issuing/disputes/%<dispute>s/submit", { dispute: CGI.escape(dispute) }),
          params: params,
          opts: opts
        )
      end
    end
  end
end
