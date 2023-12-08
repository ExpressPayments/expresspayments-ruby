# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Balance transactions represent funds moving through your ExpressPayments account.
  # ExpressPayments creates them for every type of transaction that enters or leaves your ExpressPayments account balance.
  #
  # Related guide: [Balance transaction types](https://docs.epayments.network/reports/balance-transaction-types)
  class BalanceTransaction < APIResource
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "balance_transaction"
  end
end
