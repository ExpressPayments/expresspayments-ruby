# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Tax rates can be applied to [invoices](https://docs.epayments.network/billing/invoices/tax-rates), [subscriptions](https://docs.epayments.network/billing/subscriptions/taxes) and [Checkout Sessions](https://docs.epayments.network/payments/checkout/set-up-a-subscription#tax-rates) to collect tax.
  #
  # Related guide: [Tax rates](https://docs.epayments.network/billing/taxes/tax-rates)
  class TaxRate < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "tax_rate"
  end
end
