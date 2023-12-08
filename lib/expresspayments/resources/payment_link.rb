# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A payment link is a shareable URL that will take your customers to a hosted payment page. A payment link can be shared and used multiple times.
  #
  # When a customer opens a payment link it will open a new [checkout session](https://docs.epayments.network/api/checkout/sessions) to render the payment page. You can use [checkout session events](https://docs.epayments.network/api/events/types#event_types-checkout.session.completed) to track payments through payment links.
  #
  # Related guide: [Payment Links API](https://docs.epayments.network/payment-links)
  class PaymentLink < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "payment_link"

    def list_line_items(params = {}, opts = {})
      request_expresspayments_object(
        method: :get,
        path: format("/v1/payment_links/%<payment_link>s/line_items", { payment_link: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.list_line_items(payment_link, params = {}, opts = {})
      request_expresspayments_object(
        method: :get,
        path: format("/v1/payment_links/%<payment_link>s/line_items", { payment_link: CGI.escape(payment_link) }),
        params: params,
        opts: opts
      )
    end
  end
end
