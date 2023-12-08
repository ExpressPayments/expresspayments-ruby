# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module BillingPortal
    # The Billing customer portal is an ExpressPayments-hosted UI for subscription and
    # billing management.
    #
    # A portal configuration describes the functionality and features that you
    # want to provide to your customers through the portal.
    #
    # A portal session describes the instantiation of the customer portal for
    # a particular customer. By visiting the session's URL, the customer
    # can manage their subscriptions and billing details. For security reasons,
    # sessions are short-lived and will expire if the customer does not visit the URL.
    # Create sessions on-demand when customers intend to manage their subscriptions
    # and billing details.
    #
    # Learn more in the [integration guide](https://docs.epayments.network/billing/subscriptions/integrating-customer-portal).
    class Session < APIResource
      extend ExpressPayments::APIOperations::Create

      OBJECT_NAME = "billing_portal.session"
    end
  end
end
