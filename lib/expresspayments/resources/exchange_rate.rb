# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # `ExchangeRate` objects allow you to determine the rates that ExpressPayments is currently
  # using to convert from one currency to another. Since this number is variable
  # throughout the day, there are various reasons why you might want to know the current
  # rate (for example, to dynamically price an item for a user with a default
  # payment in a foreign currency).
  #
  # Please refer to our [Exchange Rates API](https://docs.epayments.network/fx-rates) guide for more details.
  #
  # *[Note: this integration path is supported but no longer recommended]* Additionally,
  # you can guarantee that a charge is made with an exchange rate that you expect is
  # current. To do so, you must pass in the exchange_rate to charges endpoints. If the
  # value is no longer up to date, the charge won't go through. Please refer to our
  # [Using with charges](https://docs.epayments.network/exchange-rates) guide for more details.
  #
  # -----
  #
  # &nbsp;
  #
  # *This Exchange Rates API is a Beta Service and is subject to ExpressPayments' terms of service. You may use the API solely for the purpose of transacting on ExpressPayments. For example, the API may be queried in order to:*
  #
  # - *localize prices for processing payments on ExpressPayments*
  # - *reconcile ExpressPayments transactions*
  # - *determine how much money to send to a connected account*
  # - *determine app fees to charge a connected account*
  #
  # *Using this Exchange Rates API beta for any purpose other than to transact on ExpressPayments is strictly prohibited and constitutes a violation of ExpressPayments' terms of service.*
  class ExchangeRate < APIResource
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "exchange_rate"
  end
end
