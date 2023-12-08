# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Tax
    # You can use Tax `Settings` to manage configurations used by ExpressPayments Tax calculations.
    #
    # Related guide: [Using the Settings API](https://docs.epayments.network/tax/settings-api)
    class Settings < SingletonAPIResource
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "tax.settings"
    end
  end
end
