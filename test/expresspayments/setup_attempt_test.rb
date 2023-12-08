# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class SetupAttemptTest < Test::Unit::TestCase
    should "be listable" do
      setup_attempts = ExpressPayments::SetupAttempt.list({
        setup_intent: "seti_123",
      })
      assert_requested :get, "#{ExpressPayments.api_base}/v1/setup_attempts?setup_intent=seti_123"
      assert setup_attempts.data.is_a?(Array)
      assert setup_attempts.data[0].is_a?(ExpressPayments::SetupAttempt)
    end
  end
end
