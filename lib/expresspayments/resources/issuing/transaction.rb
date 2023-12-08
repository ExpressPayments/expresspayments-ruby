# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Issuing
    # Any use of an [issued card](https://docs.epayments.network/issuing) that results in funds entering or leaving
    # your ExpressPayments account, such as a completed purchase or refund, is represented by an Issuing
    # `Transaction` object.
    #
    # Related guide: [Issued card transactions](https://docs.epayments.network/issuing/purchases/transactions)
    class Transaction < APIResource
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "issuing.transaction"

      def test_helpers
        TestHelpers.new(self)
      end

      class TestHelpers < APIResourceTestHelpers
        RESOURCE_CLASS = Transaction

        def self.create_force_capture(params = {}, opts = {})
          request_expresspayments_object(
            method: :post,
            path: "/v1/test_helpers/issuing/transactions/create_force_capture",
            params: params,
            opts: opts
          )
        end

        def self.create_unlinked_refund(params = {}, opts = {})
          request_expresspayments_object(
            method: :post,
            path: "/v1/test_helpers/issuing/transactions/create_unlinked_refund",
            params: params,
            opts: opts
          )
        end

        def self.refund(transaction, params = {}, opts = {})
          request_expresspayments_object(
            method: :post,
            path: format("/v1/test_helpers/issuing/transactions/%<transaction>s/refund", { transaction: CGI.escape(transaction) }),
            params: params,
            opts: opts
          )
        end

        def refund(params = {}, opts = {})
          @resource.request_expresspayments_object(
            method: :post,
            path: format("/v1/test_helpers/issuing/transactions/%<transaction>s/refund", { transaction: CGI.escape(@resource["id"]) }),
            params: params,
            opts: opts
          )
        end
      end
    end
  end
end
