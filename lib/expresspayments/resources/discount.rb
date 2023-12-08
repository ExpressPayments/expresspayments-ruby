# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A discount represents the actual application of a [coupon](https://docs.epayments.network/api#coupons) or [promotion code](https://docs.epayments.network/api#promotion_codes).
  # It contains information about when the discount began, when it will end, and what it is applied to.
  #
  # Related guide: [Applying discounts to subscriptions](https://docs.epayments.network/billing/subscriptions/discounts)
  class Discount < ExpressPaymentsObject
    OBJECT_NAME = "discount"
  end
end
