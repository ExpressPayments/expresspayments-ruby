# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Domains registered for Apple Pay on the Web
  class ApplePayDomain < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Delete
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "apple_pay_domain"

    def self.resource_url
      "/v1/apple_pay/domains"
    end
  end
end
