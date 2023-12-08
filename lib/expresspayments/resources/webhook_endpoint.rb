# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # You can configure [webhook endpoints](https://docs.epayments.network/webhooks/) via the API to be
  # notified about events that happen in your ExpressPayments account or connected
  # accounts.
  #
  # Most users configure webhooks from [the dashboard](https://dashboard.epayments.network/webhooks), which provides a user interface for registering and testing your webhook endpoints.
  #
  # Related guide: [Setting up webhooks](https://docs.epayments.network/webhooks/configure)
  class WebhookEndpoint < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Delete
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "webhook_endpoint"
  end
end
