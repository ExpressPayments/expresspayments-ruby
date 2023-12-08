# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Radar
    # An early fraud warning indicates that the card issuer has notified us that a
    # charge may be fraudulent.
    #
    # Related guide: [Early fraud warnings](https://docs.epayments.network/disputes/measuring#early-fraud-warnings)
    class EarlyFraudWarning < APIResource
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "radar.early_fraud_warning"
    end
  end
end
