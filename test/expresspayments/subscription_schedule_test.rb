# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class SubscriptionScheduleTest < Test::Unit::TestCase
    should "be listable" do
      subscriptions = ExpressPayments::SubscriptionSchedule.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/subscription_schedules"
      assert subscriptions.data.is_a?(Array)
      assert subscriptions.data[0].is_a?(ExpressPayments::SubscriptionSchedule)
    end

    should "be retrievable" do
      schedule = ExpressPayments::SubscriptionSchedule.retrieve("sub_sched_123")
      assert_requested :get,
                       "#{ExpressPayments.api_base}/v1/subscription_schedules/sub_sched_123"
      assert schedule.is_a?(ExpressPayments::SubscriptionSchedule)
    end

    should "be creatable" do
      schedule = ExpressPayments::SubscriptionSchedule.create(
        customer: "cus_123"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/subscription_schedules"
      assert schedule.is_a?(ExpressPayments::SubscriptionSchedule)
    end

    should "be saveable" do
      schedule = ExpressPayments::SubscriptionSchedule.retrieve("sub_sched_123")
      schedule.metadata["key"] = "value"
      schedule.save
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/subscription_schedules/#{schedule.id}"
    end

    should "be updateable" do
      schedule = ExpressPayments::SubscriptionSchedule.update("sub_sched_123", metadata: { foo: "bar" })
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/subscription_schedules/sub_sched_123"
      assert schedule.is_a?(ExpressPayments::SubscriptionSchedule)
    end

    context "#cancel" do
      should "cancel a subscription schedule" do
        schedule = ExpressPayments::SubscriptionSchedule.retrieve("sub_sched_123")
        schedule = schedule.cancel
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/subscription_schedules/#{schedule.id}/cancel"
        assert schedule.is_a?(ExpressPayments::SubscriptionSchedule)
      end
    end

    context ".cancel" do
      should "cancel a subscription schedule" do
        schedule = ExpressPayments::SubscriptionSchedule.cancel("sub_sched_123")
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/subscription_schedules/sub_sched_123/cancel"
        assert schedule.is_a?(ExpressPayments::SubscriptionSchedule)
      end
    end

    context "#release" do
      should "release a subscription schedule" do
        schedule = ExpressPayments::SubscriptionSchedule.retrieve("sub_sched_123")
        schedule = schedule.release
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/subscription_schedules/#{schedule.id}/release"
        assert schedule.is_a?(ExpressPayments::SubscriptionSchedule)
      end
    end

    context ".release" do
      should "release a subscription schedule" do
        schedule = ExpressPayments::SubscriptionSchedule.release("sub_sched_123")
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/subscription_schedules/sub_sched_123/release"
        assert schedule.is_a?(ExpressPayments::SubscriptionSchedule)
      end
    end
  end
end
