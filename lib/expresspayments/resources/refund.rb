# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Refund objects allow you to refund a previously created charge that isn't
  # refunded yet. Funds are refunded to the credit or debit card that's
  # initially charged.
  #
  # Related guide: [Refunds](https://docs.epayments.network/refunds)
  class Refund < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "refund"

    def cancel(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/refunds/%<refund>s/cancel", { refund: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.cancel(refund, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/refunds/%<refund>s/cancel", { refund: CGI.escape(refund) }),
        params: params,
        opts: opts
      )
    end

    def test_helpers
      TestHelpers.new(self)
    end

    class TestHelpers < APIResourceTestHelpers
      RESOURCE_CLASS = Refund

      def self.expire(refund, params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: format("/v1/test_helpers/refunds/%<refund>s/expire", { refund: CGI.escape(refund) }),
          params: params,
          opts: opts
        )
      end

      def expire(params = {}, opts = {})
        @resource.request_expresspayments_object(
          method: :post,
          path: format("/v1/test_helpers/refunds/%<refund>s/expire", { refund: CGI.escape(@resource["id"]) }),
          params: params,
          opts: opts
        )
      end
    end
  end
end
