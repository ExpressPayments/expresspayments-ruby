# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class PlanTest < Test::Unit::TestCase
    should "be listable" do
      plans = ExpressPayments::Plan.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/plans"
      assert plans.data.is_a?(Array)
      assert plans.data[0].is_a?(ExpressPayments::Plan)
    end

    should "be retrievable" do
      plan = ExpressPayments::Plan.retrieve("pl_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/plans/pl_123"
      assert plan.is_a?(ExpressPayments::Plan)
    end

    should "be creatable" do
      plan = ExpressPayments::Plan.create(
        amount: 5000,
        interval: "month",
        nickname: "Sapphire elite",
        currency: "usd"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/plans"
      assert plan.is_a?(ExpressPayments::Plan)
    end

    should "be creatable with metered configuration" do
      plan = ExpressPayments::Plan.create(
        amount: 5000,
        interval: "month",
        nickname: "Sapphire elite",
        currency: "usd",
        usage_type: "metered"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/plans"
      assert plan.is_a?(ExpressPayments::Plan)
    end

    should "be creatable with tiered configuration" do
      plan = ExpressPayments::Plan.create(
        interval: "month",
        nickname: "Sapphire elite",
        currency: "usd",
        billing_scheme: "tiered",
        tiers_mode: "volume",
        tiers: [{ up_to: 100, amount: 1000 }, { up_to: "inf", amount: 2000 }]
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/plans"
      assert plan.is_a?(ExpressPayments::Plan)
    end

    should "be creatable with transform_usage" do
      plan = ExpressPayments::Plan.create(
        interval: "month",
        nickname: "Sapphire elite",
        currency: "usd",
        amount: 5000,
        transform_usage: { round: "up", divide_by: 50 }
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/plans"
      assert plan.is_a?(ExpressPayments::Plan)
    end

    should "be saveable" do
      plan = ExpressPayments::Plan.retrieve("pl_123")
      plan.metadata["key"] = "value"
      plan.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/plans/#{plan.id}"
    end

    should "be updateable" do
      plan = ExpressPayments::Plan.update("pl_123", metadata: { foo: "bar" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/plans/pl_123"
      assert plan.is_a?(ExpressPayments::Plan)
    end

    context "#delete" do
      should "be deletable" do
        plan = ExpressPayments::Plan.retrieve("pl_123")
        plan = plan.delete
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/plans/#{plan.id}"
        assert plan.is_a?(ExpressPayments::Plan)
      end
    end

    context ".delete" do
      should "be deletable" do
        plan = ExpressPayments::Plan.delete("pl_123")
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/plans/pl_123"
        assert plan.is_a?(ExpressPayments::Plan)
      end
    end
  end
end
