# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module BillingPortal
    # A portal configuration describes the functionality and behavior of a portal session.
    class Configuration < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "billing_portal.configuration"
    end
  end
end
