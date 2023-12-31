# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class MandateTest < Test::Unit::TestCase
    should "be retrievable" do
      schedule = ExpressPayments::Mandate.retrieve("mandate_123")
      assert_requested :get,
                       "#{ExpressPayments.api_base}/v1/mandates/mandate_123"
      assert schedule.is_a?(ExpressPayments::Mandate)
    end
  end
end
