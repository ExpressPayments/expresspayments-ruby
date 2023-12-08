# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A Promotion Code represents a customer-redeemable code for a [coupon](https://docs.epayments.network/api#coupons). It can be used to
  # create multiple codes for a single coupon.
  class PromotionCode < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "promotion_code"
  end
end
