# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Tokenization is the process ExpressPayments uses to collect sensitive card or bank
  # account details, or personally identifiable information (PII), directly from
  # your customers in a secure manner. A token representing this information is
  # returned to your server to use. Use our
  # [recommended payments integrations](https://docs.epayments.network/payments) to perform this process
  # on the client-side. This guarantees that no sensitive card data touches your server,
  # and allows your integration to operate in a PCI-compliant way.
  #
  # If you can't use client-side tokenization, you can also create tokens using
  # the API with either your publishable or secret API key. If
  # your integration uses this method, you're responsible for any PCI compliance
  # that it might require, and you must keep your secret API key safe. Unlike with
  # client-side tokenization, your customer's information isn't sent directly to
  # ExpressPayments, so we can't determine how it's handled or stored.
  #
  # You can't store or use tokens more than once. To store card or bank account
  # information for later use, create [Customer](https://docs.epayments.network/api#customers)
  # objects or [Custom accounts](https://docs.epayments.network/api#external_accounts).
  # [Radar](https://docs.epayments.network/radar), our integrated solution for automatic fraud protection,
  # performs best with integrations that use client-side tokenization.
  class Token < APIResource
    extend ExpressPayments::APIOperations::Create

    OBJECT_NAME = "token"
  end
end
