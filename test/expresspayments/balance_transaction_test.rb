# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class BalanceTransactionTest < Test::Unit::TestCase
    should "be listable" do
      balance_transactions = ExpressPayments::BalanceTransaction.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/balance_transactions"
      assert balance_transactions.data.is_a?(Array)
      assert balance_transactions.first.is_a?(ExpressPayments::BalanceTransaction)
    end

    should "be retrievable" do
      balance_transaction = ExpressPayments::BalanceTransaction.retrieve("txn_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/balance_transactions/txn_123"
      assert balance_transaction.is_a?(ExpressPayments::BalanceTransaction)
    end
  end
end
