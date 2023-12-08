# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Issuing
    class TransactionTest < Test::Unit::TestCase
      should "be listable" do
        stub_request(:get, "#{ExpressPayments.api_base}/v1/issuing/transactions")
          .to_return(body: JSON.generate(object: "list", data: [{ id: "ipi_123", object: "issuing.transaction" }]))

        transactions = ExpressPayments::Issuing::Transaction.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/transactions"
        assert transactions.data.is_a?(Array)
        assert transactions.data[0].is_a?(ExpressPayments::Issuing::Transaction)
      end

      should "be retrievable" do
        stub_request(:get, "#{ExpressPayments.api_base}/v1/issuing/transactions/ipi_123")
          .to_return(body: JSON.generate(id: "ipi_123", object: "issuing.transaction"))

        transaction = ExpressPayments::Issuing::Transaction.retrieve("ipi_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/transactions/ipi_123"
        assert transaction.is_a?(ExpressPayments::Issuing::Transaction)
      end

      should "be saveable" do
        stub_request(:post, "#{ExpressPayments.api_base}/v1/issuing/transactions/ipi_123")
          .to_return(body: JSON.generate(id: "ipi_123", object: "issuing.transaction"))

        transaction = ExpressPayments::Issuing::Transaction.construct_from(id: "ipi_123", object: "issuing.transaction", metadata: {})
        transaction.metadata["key"] = "value"
        transaction.save
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/transactions/#{transaction.id}"
        assert transaction.is_a?(ExpressPayments::Issuing::Transaction)
      end

      should "be updateable" do
        stub_request(:post, "#{ExpressPayments.api_base}/v1/issuing/transactions/ipi_123")
          .to_return(body: JSON.generate(id: "ipi_123", object: "issuing.transaction"))

        transaction = ExpressPayments::Issuing::Transaction.update("ipi_123", metadata: { foo: "bar" })
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/transactions/ipi_123"
        assert transaction.is_a?(ExpressPayments::Issuing::Transaction)
      end
    end
  end
end
