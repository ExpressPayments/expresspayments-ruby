# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Radar
    # Value lists allow you to group values together which can then be referenced in rules.
    #
    # Related guide: [Default ExpressPayments lists](https://docs.epayments.network/radar/lists#managing-list-items)
    class ValueList < APIResource
      extend ExpressPayments::APIOperations::Create
      include ExpressPayments::APIOperations::Delete
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "radar.value_list"
    end
  end
end
