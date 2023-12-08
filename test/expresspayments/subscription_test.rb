# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class SubscriptionTest < Test::Unit::TestCase
    should "be listable" do
      subscriptions = ExpressPayments::Subscription.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/subscriptions"
      assert subscriptions.data.is_a?(Array)
      assert subscriptions.data[0].is_a?(ExpressPayments::Subscription)
    end

    should "be retrievable" do
      subscription = ExpressPayments::Subscription.retrieve("sub_123")
      assert_requested :get,
                       "#{ExpressPayments.api_base}/v1/subscriptions/sub_123"
      assert subscription.is_a?(ExpressPayments::Subscription)
    end

    should "be creatable" do
      subscription = ExpressPayments::Subscription.create(
        customer: "cus_123"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/subscriptions"
      assert subscription.is_a?(ExpressPayments::Subscription)
    end

    should "be saveable" do
      subscription = ExpressPayments::Subscription.retrieve("sub_123")
      subscription.metadata["key"] = "value"
      subscription.save
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/subscriptions/#{subscription.id}"
    end

    should "be updateable" do
      subscription = ExpressPayments::Subscription.update("sub_123", metadata: { foo: "bar" })
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/subscriptions/sub_123"
      assert subscription.is_a?(ExpressPayments::Subscription)
    end

    context "#delete" do
      should "be deletable" do
        subscription = ExpressPayments::Subscription.retrieve("sub_123")
        subscription = subscription.cancel
        assert_requested :delete,
                         "#{ExpressPayments.api_base}/v1/subscriptions/#{subscription.id}"
        assert subscription.is_a?(ExpressPayments::Subscription)
      end
    end

    context ".delete" do
      should "be deletable" do
        subscription = ExpressPayments::Subscription.cancel("sub_123")
        assert_requested :delete,
                         "#{ExpressPayments.api_base}/v1/subscriptions/sub_123"
        assert subscription.is_a?(ExpressPayments::Subscription)
      end
    end

    context "#delete_discount" do
      should "be able to delete a subscriptions's discount" do
        subscription = ExpressPayments::Subscription.retrieve("sub_123")
        discount = subscription.delete_discount
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/subscriptions/sub_123/discount"
        assert discount.is_a?(ExpressPayments::Discount)
      end
    end

    context ".delete_discount" do
      should "be able to delete a subscriptions's discount" do
        discount = ExpressPayments::Subscription.delete_discount("sub_123")
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/subscriptions/sub_123/discount"
        assert discount.is_a?(ExpressPayments::Discount)
      end
    end
  end
end
