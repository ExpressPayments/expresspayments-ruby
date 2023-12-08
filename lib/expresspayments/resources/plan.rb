# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # You can now model subscriptions more flexibly using the [Prices API](https://docs.epayments.network/api#prices). It replaces the Plans API and is backwards compatible to simplify your migration.
  #
  # Plans define the base price, currency, and billing cycle for recurring purchases of products.
  # [Products](https://docs.epayments.network/api#products) help you track inventory or provisioning, and plans help you track pricing. Different physical goods or levels of service should be represented by products, and pricing options should be represented by plans. This approach lets you change prices without having to change your provisioning scheme.
  #
  # For example, you might have a single "gold" product that has plans for $10/month, $100/year, €9/month, and €90/year.
  #
  # Related guides: [Set up a subscription](https://docs.epayments.network/billing/subscriptions/set-up-subscription) and more about [products and prices](https://docs.epayments.network/products-prices/overview).
  class Plan < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Delete
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "plan"
  end
end
