# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Radar
    # Value list items allow you to add specific values to a given Radar value list, which can then be used in rules.
    #
    # Related guide: [Managing list items](https://docs.epayments.network/radar/lists#managing-list-items)
    class ValueListItem < APIResource
      extend ExpressPayments::APIOperations::Create
      include ExpressPayments::APIOperations::Delete
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "radar.value_list_item"
    end
  end
end
