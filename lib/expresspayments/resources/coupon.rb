# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A coupon contains information about a percent-off or amount-off discount you
  # might want to apply to a customer. Coupons may be applied to [subscriptions](https://docs.epayments.network/api#subscriptions), [invoices](https://docs.epayments.network/api#invoices),
  # [checkout sessions](https://docs.epayments.network/api/checkout/sessions), [quotes](https://docs.epayments.network/api#quotes), and more. Coupons do not work with conventional one-off [charges](https://docs.epayments.network/api#create_charge) or [payment intents](https://docs.epayments.network/api/payment_intents).
  class Coupon < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Delete
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "coupon"
  end
end
