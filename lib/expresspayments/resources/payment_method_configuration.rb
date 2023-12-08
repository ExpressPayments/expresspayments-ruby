# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # PaymentMethodConfigurations control which payment methods are displayed to your customers when you don't explicitly specify payment method types. You can have multiple configurations with different sets of payment methods for different scenarios.
  #
  # There are two types of PaymentMethodConfigurations. Which is used depends on the [charge type](https://docs.epayments.network/connect/charges):
  #
  # **Direct** configurations apply to payments created on your account, including Connect destination charges, Connect separate charges and transfers, and payments not involving Connect.
  #
  # **Child** configurations apply to payments created on your connected accounts using direct charges, and charges with the on_behalf_of parameter.
  #
  # Child configurations have a `parent` that sets default values and controls which settings connected accounts may override. You can specify a parent ID at payment time, and ExpressPayments will automatically resolve the connected account's associated child configuration. Parent configurations are [managed in the dashboard](https://dashboard.epayments.network/settings/payment_methods/connected_accounts) and are not available in this API.
  #
  # Related guides:
  # - [Payment Method Configurations API](https://docs.epayments.network/connect/payment-method-configurations)
  # - [Multiple configurations on dynamic payment methods](https://docs.epayments.network/payments/multiple-payment-method-configs)
  # - [Multiple configurations for your Connect accounts](https://docs.epayments.network/connect/multiple-payment-method-configurations)
  class PaymentMethodConfiguration < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "payment_method_configuration"
  end
end
