# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class UsageRecordSummaryTest < Test::Unit::TestCase
    should "be listable" do
      old_stderr = $stderr
      $stderr = StringIO.new

      begin
        transactions = ExpressPayments::SubscriptionItem.list_usage_record_summaries("si_123")

        assert_requested :get, "#{ExpressPayments.api_base}/v1/subscription_items/si_123/usage_record_summaries"
        assert transactions.data.is_a?(Array)
        assert transactions.first.is_a?(ExpressPayments::UsageRecordSummary)
      ensure
        $stderr = old_stderr
      end
    end
  end
end
