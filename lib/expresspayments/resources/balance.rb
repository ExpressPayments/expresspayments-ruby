# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # This is an object representing your ExpressPayments balance. You can retrieve it to see
  # the balance currently on your ExpressPayments account.
  #
  # You can also retrieve the balance history, which contains a list of
  # [transactions](https://docs.epayments.network/reporting/balance-transaction-types) that contributed to the balance
  # (charges, payouts, and so forth).
  #
  # The available and pending amounts for each currency are broken down further by
  # payment source types.
  #
  # Related guide: [Understanding Connect account balances](https://docs.epayments.network/connect/account-balances)
  class Balance < SingletonAPIResource
    OBJECT_NAME = "balance"
  end
end
