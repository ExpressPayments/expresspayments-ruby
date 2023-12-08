# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Identity
    # A VerificationReport is the result of an attempt to collect and verify data from a user.
    # The collection of verification checks performed is determined from the `type` and `options`
    # parameters used. You can find the result of each verification check performed in the
    # appropriate sub-resource: `document`, `id_number`, `selfie`.
    #
    # Each VerificationReport contains a copy of any data collected by the user as well as
    # reference IDs which can be used to access collected images through the [FileUpload](https://docs.epayments.network/api/files)
    # API. To configure and create VerificationReports, use the
    # [VerificationSession](https://docs.epayments.network/api/identity/verification_sessions) API.
    #
    # Related guides: [Accessing verification results](https://docs.epayments.network/identity/verification-sessions#results).
    class VerificationReport < APIResource
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "identity.verification_report"
    end
  end
end
