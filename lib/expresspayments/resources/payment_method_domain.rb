# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A payment method domain represents a web domain that you have registered with ExpressPayments.
  # ExpressPayments Elements use registered payment method domains to control where certain payment methods are shown.
  #
  # Related guides: [Payment method domains](https://docs.epayments.network/payments/payment-methods/pmd-registration).
  class PaymentMethodDomain < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "payment_method_domain"

    def validate(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/payment_method_domains/%<payment_method_domain>s/validate", { payment_method_domain: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.validate(payment_method_domain, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/payment_method_domains/%<payment_method_domain>s/validate", { payment_method_domain: CGI.escape(payment_method_domain) }),
        params: params,
        opts: opts
      )
    end
  end
end
