# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module BillingPortal
    class SessionTest < Test::Unit::TestCase
      should "be creatable" do
        session = ExpressPayments::BillingPortal::Session.create(
          customer: "cus_123",
          return_url: "https://epayments.network/return"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/billing_portal/sessions"
        assert session.is_a?(ExpressPayments::BillingPortal::Session)
      end
    end
  end
end
