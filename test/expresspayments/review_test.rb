# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class ReviewTest < Test::Unit::TestCase
    should "be listable" do
      reviews = ExpressPayments::Review.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/reviews"
      assert reviews.data.is_a?(Array)
      assert reviews.first.is_a?(ExpressPayments::Review)
    end

    should "be retrievable" do
      review = ExpressPayments::Review.retrieve("prv_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/reviews/prv_123"
      assert review.is_a?(ExpressPayments::Review)
    end

    should "be approvable" do
      review = ExpressPayments::Review.retrieve("prv_123")
      review.approve
      assert_requested :post, "#{ExpressPayments.api_base}/v1/reviews/prv_123/approve"
      assert review.is_a?(ExpressPayments::Review)
    end
  end
end
