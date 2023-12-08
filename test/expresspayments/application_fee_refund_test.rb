# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class ApplicationFeeRefundTest < Test::Unit::TestCase
    setup do
      @fee = ExpressPayments::ApplicationFee.retrieve("fee_123")
    end

    should "be listable" do
      refunds = @fee.refunds

      # notably this *doesn't* make an API call
      assert_not_requested :get,
                           "#{ExpressPayments.api_base}/v1/application_fees/#{@fee.id}/refunds"

      assert refunds.data.is_a?(Array)
      assert refunds.first.is_a?(ExpressPayments::ApplicationFeeRefund)
    end

    should "be creatable" do
      refund = @fee.refunds.create
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/application_fees/#{@fee.id}/refunds"
      assert refund.is_a?(ExpressPayments::ApplicationFeeRefund)
    end

    should "be saveable" do
      refund = @fee.refunds.first
      refund.metadata["key"] = "value"
      refund.save
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/application_fees/#{@fee.id}/refunds/#{refund.id}"
    end
  end
end
