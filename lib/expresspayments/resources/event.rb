# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Events are our way of letting you know when something interesting happens in
  # your account. When an interesting event occurs, we create a new `Event`
  # object. For example, when a charge succeeds, we create a `charge.succeeded`
  # event, and when an invoice payment attempt fails, we create an
  # `invoice.payment_failed` event. Certain API requests might create multiple
  # events. For example, if you create a new subscription for a
  # customer, you receive both a `customer.subscription.created` event and a
  # `charge.succeeded` event.
  #
  # Events occur when the state of another API resource changes. The event's data
  # field embeds the resource's state at the time of the change. For
  # example, a `charge.succeeded` event contains a charge, and an
  # `invoice.payment_failed` event contains an invoice.
  #
  # As with other API resources, you can use endpoints to retrieve an
  # [individual event](https://docs.epayments.network/api#retrieve_event) or a [list of events](https://docs.epayments.network/api#list_events)
  # from the API. We also have a separate
  # [webhooks](http://en.wikipedia.org/wiki/Webhook) system for sending the
  # `Event` objects directly to an endpoint on your server. You can manage
  # webhooks in your
  # [account settings](https://dashboard.epayments.network/account/webhooks). Learn how
  # to [listen for events](https://docs.epayments.network/webhooks)
  # so that your integration can automatically trigger reactions.
  #
  # When using [Connect](https://docs.epayments.network/connect), you can also receive event notifications
  # that occur in connected accounts. For these events, there's an
  # additional `account` attribute in the received `Event` object.
  #
  # We only guarantee access to events through the [Retrieve Event API](https://docs.epayments.network/api#retrieve_event)
  # for 30 days.
  class Event < APIResource
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "event"
  end
end
