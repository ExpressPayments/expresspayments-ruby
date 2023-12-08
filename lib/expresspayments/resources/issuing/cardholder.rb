# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Issuing
    # An Issuing `Cardholder` object represents an individual or business entity who is [issued](https://docs.epayments.network/issuing) cards.
    #
    # Related guide: [How to create a cardholder](https://docs.epayments.network/issuing/cards#create-cardholder)
    class Cardholder < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "issuing.cardholder"
    end
  end
end
