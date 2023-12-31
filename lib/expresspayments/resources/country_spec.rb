# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # ExpressPayments needs to collect certain pieces of information about each account
  # created. These requirements can differ depending on the account's country. The
  # Country Specs API makes these rules available to your integration.
  #
  # You can also view the information from this API call as [an online
  # guide](https://docs.epayments.network/connect/required-verification-information).
  class CountrySpec < APIResource
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "country_spec"
  end
end
