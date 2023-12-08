# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Products describe the specific goods or services you offer to your customers.
  # For example, you might offer a Standard and Premium version of your goods or service; each version would be a separate Product.
  # They can be used in conjunction with [Prices](https://docs.epayments.network/api#prices) to configure pricing in Payment Links, Checkout, and Subscriptions.
  #
  # Related guides: [Set up a subscription](https://docs.epayments.network/billing/subscriptions/set-up-subscription),
  # [share a Payment Link](https://docs.epayments.network/payment-links),
  # [accept payments with Checkout](https://docs.epayments.network/payments/accept-a-payment#create-product-prices-upfront),
  # and more about [Products and Prices](https://docs.epayments.network/products-prices/overview)
  class Product < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Delete
    extend ExpressPayments::APIOperations::List
    extend ExpressPayments::APIOperations::Search
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "product"

    def self.search(params = {}, opts = {})
      _search("/v1/products/search", params, opts)
    end

    def self.search_auto_paging_each(params = {}, opts = {}, &blk)
      search(params, opts).auto_paging_each(&blk)
    end
  end
end
