# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class BalanceTest < Test::Unit::TestCase
    should "be retrievable" do
      balance = ExpressPayments::Balance.retrieve
      assert_requested :get, "#{ExpressPayments.api_base}/v1/balance"
      assert balance.is_a?(ExpressPayments::Balance)
    end
  end
end
