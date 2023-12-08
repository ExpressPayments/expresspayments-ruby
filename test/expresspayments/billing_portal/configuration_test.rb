# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module BillingPortal
    class ConfigurationTest < Test::Unit::TestCase
      should "be creatable" do
        session = ExpressPayments::BillingPortal::Configuration.create({
          business_profile: {
            privacy_policy_url: "https://example.com/privacy",
            terms_of_service_url: "https://example.com/tos",
          },
          features: { customer_update: { allowed_updates: ["address"], enabled: true } },
        })
        assert_requested :post, "#{ExpressPayments.api_base}/v1/billing_portal/configurations"
        assert session.is_a?(ExpressPayments::BillingPortal::Configuration)
      end
      should "be retrievable" do
        session = ExpressPayments::BillingPortal::Configuration.retrieve("bpc_xyz")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/billing_portal/configurations/bpc_xyz"
        assert session.is_a?(ExpressPayments::BillingPortal::Configuration)
      end

      should "be updateable" do
        session = ExpressPayments::BillingPortal::Configuration.update("bpc_xyz", { active: false })
        assert_requested :post, "#{ExpressPayments.api_base}/v1/billing_portal/configurations/bpc_xyz"
        assert session.is_a?(ExpressPayments::BillingPortal::Configuration)
      end
      should "be listable" do
        sessions = ExpressPayments::BillingPortal::Configuration.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/billing_portal/configurations"
        assert sessions.data[0].is_a?(ExpressPayments::BillingPortal::Configuration)
      end
    end
  end
end
