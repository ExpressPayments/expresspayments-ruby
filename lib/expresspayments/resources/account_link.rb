# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Account Links are the means by which a Connect platform grants a connected account permission to access
  # ExpressPayments-hosted applications, such as Connect Onboarding.
  #
  # Related guide: [Connect Onboarding](https://docs.epayments.network/connect/custom/hosted-onboarding)
  class AccountLink < APIResource
    extend ExpressPayments::APIOperations::Create

    OBJECT_NAME = "account_link"
  end
end
