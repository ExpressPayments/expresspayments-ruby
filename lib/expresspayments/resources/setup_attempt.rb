# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A SetupAttempt describes one attempted confirmation of a SetupIntent,
  # whether that confirmation is successful or unsuccessful. You can use
  # SetupAttempts to inspect details of a specific attempt at setting up a
  # payment method using a SetupIntent.
  class SetupAttempt < APIResource
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "setup_attempt"
  end
end
