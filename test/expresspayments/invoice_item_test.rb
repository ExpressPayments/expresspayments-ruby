# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class InvoiceItemTest < Test::Unit::TestCase
    should "be listable" do
      invoiceitems = ExpressPayments::InvoiceItem.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/invoiceitems"
      assert invoiceitems.data.is_a?(Array)
      assert invoiceitems.first.is_a?(ExpressPayments::InvoiceItem)
    end

    should "be retrievable" do
      item = ExpressPayments::InvoiceItem.retrieve("ii_123")
      assert_requested :get,
                       "#{ExpressPayments.api_base}/v1/invoiceitems/ii_123"
      assert item.is_a?(ExpressPayments::InvoiceItem)
    end

    should "be creatable" do
      item = ExpressPayments::InvoiceItem.create(
        amount: 100,
        currency: "USD",
        customer: "cus_123"
      )
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/invoiceitems"
      assert item.is_a?(ExpressPayments::InvoiceItem)
    end

    should "be saveable" do
      item = ExpressPayments::InvoiceItem.retrieve("ii_123")
      item.metadata["key"] = "value"
      item.save
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/invoiceitems/#{item.id}"
    end

    should "be updateable" do
      item = ExpressPayments::InvoiceItem.update("ii_123", metadata: { key: "value" })
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/invoiceitems/ii_123"
      assert item.is_a?(ExpressPayments::InvoiceItem)
    end

    context "#delete" do
      should "be deletable" do
        item = ExpressPayments::InvoiceItem.retrieve("ii_123")
        item = item.delete
        assert_requested :delete,
                         "#{ExpressPayments.api_base}/v1/invoiceitems/#{item.id}"
        assert item.is_a?(ExpressPayments::InvoiceItem)
      end
    end

    context ".delete" do
      should "be deletable" do
        item = ExpressPayments::InvoiceItem.delete("ii_123")
        assert_requested :delete,
                         "#{ExpressPayments.api_base}/v1/invoiceitems/ii_123"
        assert item.is_a?(ExpressPayments::InvoiceItem)
      end
    end
  end
end
