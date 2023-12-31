# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # An AccountSession allows a Connect platform to grant access to a connected account in Connect embedded components.
  #
  # We recommend that you create an AccountSession each time you need to display an embedded component
  # to your user. Do not save AccountSessions to your database as they expire relatively
  # quickly, and cannot be used more than once.
  #
  # Related guide: [Connect embedded components](https://docs.epayments.network/connect/get-started-connect-embedded-components)
  class AccountSession < APIResource
    extend ExpressPayments::APIOperations::Create

    OBJECT_NAME = "account_session"
  end
end
