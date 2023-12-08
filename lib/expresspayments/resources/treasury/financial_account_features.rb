# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Treasury
    # Encodes whether a FinancialAccount has access to a particular Feature, with a `status` enum and associated `status_details`.
    # ExpressPayments or the platform can control Features via the requested field.
    class FinancialAccountFeatures < APIResource
      OBJECT_NAME = "treasury.financial_account_features"
    end
  end
end
