# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class PriceTest < Test::Unit::TestCase
    should "be listable" do
      prices = ExpressPayments::Price.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/prices"
      assert prices.data.is_a?(Array)
      assert prices.data[0].is_a?(ExpressPayments::Price)
    end

    should "be retrievable" do
      price = ExpressPayments::Price.retrieve("price_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/prices/price_123"
      assert price.is_a?(ExpressPayments::Price)
    end

    should "be creatable" do
      price = ExpressPayments::Price.create(
        unit_amount: 5000,
        currency: "usd",
        recurring: {
          interval: "month",
        },
        product_data: {
          name: "Product name",
        }
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/prices"
      assert price.is_a?(ExpressPayments::Price)
    end

    should "be saveable" do
      price = ExpressPayments::Price.retrieve("price_123")
      price.metadata["key"] = "value"
      price.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/prices/#{price.id}"
    end

    should "be updateable" do
      price = ExpressPayments::Price.update("price_123", metadata: { foo: "bar" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/prices/price_123"
      assert price.is_a?(ExpressPayments::Price)
    end
  end
end
