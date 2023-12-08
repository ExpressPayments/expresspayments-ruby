# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class PaymentMethodTest < Test::Unit::TestCase
    should "be listable" do
      payment_methods = ExpressPayments::PaymentMethod.list(
        customer: "cus_123",
        type: "card"
      )
      assert_requested :get, "#{ExpressPayments.api_base}/v1/payment_methods?customer=cus_123&type=card"
      assert payment_methods.data.is_a?(Array)
      assert payment_methods.first.is_a?(ExpressPayments::PaymentMethod)
    end

    should "be retrievable" do
      payment_method = ExpressPayments::PaymentMethod.retrieve("pm_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/payment_methods/pm_123"
      assert payment_method.is_a?(ExpressPayments::PaymentMethod)
    end

    should "be creatable" do
      payment_method = ExpressPayments::PaymentMethod.create(
        type: "card"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/payment_methods"
      assert payment_method.is_a?(ExpressPayments::PaymentMethod)
    end

    should "be saveable" do
      payment_method = ExpressPayments::PaymentMethod.retrieve("pm_123")
      payment_method.metadata["key"] = "value"
      payment_method.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/payment_methods/#{payment_method.id}"
    end

    should "be updateable" do
      payment_method = ExpressPayments::PaymentMethod.update("pm_123", metadata: { key: "value" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/payment_methods/pm_123"
      assert payment_method.is_a?(ExpressPayments::PaymentMethod)
    end

    context "#attach" do
      should "attach payment_method" do
        payment_method = ExpressPayments::PaymentMethod.construct_from(id: "pm_123", object: "payment_method")
        payment_method = payment_method.attach(
          customer: "cus_123"
        )

        assert_requested :post, "#{ExpressPayments.api_base}/v1/payment_methods/pm_123/attach"
        assert payment_method.is_a?(ExpressPayments::PaymentMethod)
      end
    end

    context ".attach" do
      should "attach payment_method" do
        payment_method = ExpressPayments::PaymentMethod.attach("pm_123", customer: "cus_123")

        assert_requested :post, "#{ExpressPayments.api_base}/v1/payment_methods/pm_123/attach"
        assert payment_method.is_a?(ExpressPayments::PaymentMethod)
      end
    end

    context "#detach" do
      should "detach payment_method" do
        payment_method = ExpressPayments::PaymentMethod.construct_from(id: "pm_123", object: "payment_method")
        payment_method = payment_method.detach

        assert_requested :post, "#{ExpressPayments.api_base}/v1/payment_methods/pm_123/detach"
        assert payment_method.is_a?(ExpressPayments::PaymentMethod)
      end
    end

    context ".detach" do
      should "detach payment_method" do
        payment_method = ExpressPayments::PaymentMethod.detach("pm_123")

        assert_requested :post, "#{ExpressPayments.api_base}/v1/payment_methods/pm_123/detach"
        assert payment_method.is_a?(ExpressPayments::PaymentMethod)
      end
    end
  end
end
