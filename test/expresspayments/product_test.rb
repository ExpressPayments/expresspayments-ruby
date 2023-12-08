# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class ProductTest < Test::Unit::TestCase
    should "be listable" do
      products = ExpressPayments::Product.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/products"
      assert products.data.is_a?(Array)
      assert products.data[0].is_a?(ExpressPayments::Product)
    end

    should "be retrievable" do
      product = ExpressPayments::Product.retrieve("prod_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/products/prod_123"
      assert product.is_a?(ExpressPayments::Product)
    end

    should "be creatable" do
      product = ExpressPayments::Product.create(
        name: "My Product"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/products"
      assert product.is_a?(ExpressPayments::Product)
    end

    should "be saveable" do
      product = ExpressPayments::Product.retrieve("prod_123")
      product.metadata["key"] = "value"
      product.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/products/#{product.id}"
    end

    should "be updateable" do
      product = ExpressPayments::Product.update("prod_123", metadata: { foo: "bar" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/products/prod_123"
      assert product.is_a?(ExpressPayments::Product)
    end

    context "#delete" do
      should "be deletable" do
        product = ExpressPayments::Product.retrieve("prod_123")
        product = product.delete
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/products/#{product.id}"
        assert product.is_a?(ExpressPayments::Product)
      end
    end

    context ".delete" do
      should "be deletable" do
        product = ExpressPayments::Product.delete("prod_123")
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/products/prod_123"
        assert product.is_a?(ExpressPayments::Product)
      end
    end
  end
end
