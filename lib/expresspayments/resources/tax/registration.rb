# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Tax
    # A Tax `Registration` lets us know that your business is registered to collect tax on payments within a region, enabling you to [automatically collect tax](https://docs.epayments.network/tax).
    #
    # ExpressPayments doesn't register on your behalf with the relevant authorities when you create a Tax `Registration` object. For more information on how to register to collect tax, see [our guide](https://docs.epayments.network/tax/registering).
    #
    # Related guide: [Using the Registrations API](https://docs.epayments.network/tax/registrations-api)
    class Registration < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "tax.registration"
    end
  end
end
