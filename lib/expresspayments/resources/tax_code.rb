# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # [Tax codes](https://docs.epayments.network/tax/tax-categories) classify goods and services for tax purposes.
  class TaxCode < APIResource
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "tax_code"
  end
end
