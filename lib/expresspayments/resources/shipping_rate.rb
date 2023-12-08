# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Shipping rates describe the price of shipping presented to your customers and
  # applied to a purchase. For more information, see [Charge for shipping](https://docs.epayments.network/payments/during-payment/charge-shipping).
  class ShippingRate < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "shipping_rate"
  end
end
