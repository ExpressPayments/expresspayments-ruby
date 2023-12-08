# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Issuing
    # An issuing token object is created when an issued card is added to a digital wallet. As a [card issuer](https://docs.epayments.network/issuing), you can [view and manage these tokens](https://docs.epayments.network/issuing/controls/token-management) through ExpressPayments.
    class Token < APIResource
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "issuing.token"
    end
  end
end
