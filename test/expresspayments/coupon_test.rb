# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class CouponTest < Test::Unit::TestCase
    should "be listable" do
      coupons = ExpressPayments::Coupon.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/coupons"
      assert coupons.data.is_a?(Array)
      assert coupons.first.is_a?(ExpressPayments::Coupon)
    end

    should "be retrievable" do
      coupon = ExpressPayments::Coupon.retrieve("25OFF")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/coupons/25OFF"
      assert coupon.is_a?(ExpressPayments::Coupon)
    end

    should "be creatable" do
      coupon = ExpressPayments::Coupon.create(
        percent_off: 25,
        duration: "repeating",
        duration_in_months: 3,
        id: "25OFF"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/coupons"
      assert coupon.is_a?(ExpressPayments::Coupon)
    end

    should "be saveable" do
      coupon = ExpressPayments::Coupon.retrieve("25OFF")
      coupon.metadata["key"] = "value"
      coupon.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/coupons/#{coupon.id}"
    end

    should "be updateable" do
      coupon = ExpressPayments::Coupon.update("25OFF", metadata: { key: "value" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/coupons/25OFF"
      assert coupon.is_a?(ExpressPayments::Coupon)
    end

    context "#delete" do
      should "be deletable" do
        coupon = ExpressPayments::Coupon.delete("25OFF")
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/coupons/#{coupon.id}"
        assert coupon.is_a?(ExpressPayments::Coupon)
      end
    end

    context ".delete" do
      should "be deletable" do
        coupon = ExpressPayments::Coupon.retrieve("25OFF")
        coupon = coupon.delete
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/coupons/25OFF"
        assert coupon.is_a?(ExpressPayments::Coupon)
      end
    end
  end
end
