# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Issuing
    class DisputeTest < Test::Unit::TestCase
      should "be creatable" do
        dispute = ExpressPayments::Issuing::Dispute.create(transaction: "ipi_123")

        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/disputes"
        assert dispute.is_a?(ExpressPayments::Issuing::Dispute)
      end

      should "be listable" do
        disputes = ExpressPayments::Issuing::Dispute.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/disputes"
        assert disputes.data.is_a?(Array)
        assert disputes.data[0].is_a?(ExpressPayments::Issuing::Dispute)
      end

      should "be retrievable" do
        dispute = ExpressPayments::Issuing::Dispute.retrieve("ich_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/disputes/ich_123"
        assert dispute.is_a?(ExpressPayments::Issuing::Dispute)
      end

      should "be updateable" do
        dispute = ExpressPayments::Issuing::Dispute.update("ich_123", {})
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/disputes/ich_123"
        assert dispute.is_a?(ExpressPayments::Issuing::Dispute)
      end

      context "#submit" do
        should "submit the dispute" do
          dispute = ExpressPayments::Issuing::Dispute.retrieve("idp_123")
          dispute = dispute.submit
          assert_requested :post,
                           "#{ExpressPayments.api_base}/v1/issuing/disputes/idp_123/submit"
          assert dispute.is_a?(ExpressPayments::Issuing::Dispute)
        end
      end

      context ".submit" do
        should "submit the dispute" do
          dispute = ExpressPayments::Issuing::Dispute.submit("idp_123")
          assert_requested :post,
                           "#{ExpressPayments.api_base}/v1/issuing/disputes/idp_123/submit"
          assert dispute.is_a?(ExpressPayments::Issuing::Dispute)
        end
      end
    end
  end
end
