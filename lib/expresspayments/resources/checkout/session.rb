# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Checkout
    # A Checkout Session represents your customer's session as they pay for
    # one-time purchases or subscriptions through [Checkout](https://docs.epayments.network/payments/checkout)
    # or [Payment Links](https://docs.epayments.network/payments/payment-links). We recommend creating a
    # new Session each time your customer attempts to pay.
    #
    # Once payment is successful, the Checkout Session will contain a reference
    # to the [Customer](https://docs.epayments.network/api/customers), and either the successful
    # [PaymentIntent](https://docs.epayments.network/api/payment_intents) or an active
    # [Subscription](https://docs.epayments.network/api/subscriptions).
    #
    # You can create a Checkout Session on your server and redirect to its URL
    # to begin Checkout.
    #
    # Related guide: [Checkout quickstart](https://docs.epayments.network/checkout/quickstart)
    class Session < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "checkout.session"

      def expire(params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: format("/v1/checkout/sessions/%<session>s/expire", { session: CGI.escape(self["id"]) }),
          params: params,
          opts: opts
        )
      end

      def list_line_items(params = {}, opts = {})
        request_expresspayments_object(
          method: :get,
          path: format("/v1/checkout/sessions/%<session>s/line_items", { session: CGI.escape(self["id"]) }),
          params: params,
          opts: opts
        )
      end

      def self.expire(session, params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: format("/v1/checkout/sessions/%<session>s/expire", { session: CGI.escape(session) }),
          params: params,
          opts: opts
        )
      end

      def self.list_line_items(session, params = {}, opts = {})
        request_expresspayments_object(
          method: :get,
          path: format("/v1/checkout/sessions/%<session>s/line_items", { session: CGI.escape(session) }),
          params: params,
          opts: opts
        )
      end
    end
  end
end
