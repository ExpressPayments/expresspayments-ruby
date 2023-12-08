# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class RefundTest < Test::Unit::TestCase
    should "be listable" do
      refunds = ExpressPayments::Refund.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/refunds"
      assert refunds.data.is_a?(Array)
      assert refunds.first.is_a?(ExpressPayments::Refund)
    end

    should "be retrievable" do
      refund = ExpressPayments::Refund.retrieve("re_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/refunds/re_123"
      assert refund.is_a?(ExpressPayments::Refund)
    end

    should "be creatable" do
      refund = ExpressPayments::Refund.create(charge: "ch_123")
      assert_requested :post, "#{ExpressPayments.api_base}/v1/refunds"
      assert refund.is_a?(ExpressPayments::Refund)
    end

    should "be saveable" do
      refund = ExpressPayments::Refund.retrieve("re_123")
      refund.metadata["key"] = "value"
      refund.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/refunds/#{refund.id}"
    end

    should "be updateable" do
      refund = ExpressPayments::Refund.update("re_123", metadata: { key: "value" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/refunds/re_123"
      assert refund.is_a?(ExpressPayments::Refund)
    end
  end
end
