# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A `Transfer` object is created when you move funds between ExpressPayments accounts as
  # part of Connect.
  #
  # Before April 6, 2017, transfers also represented movement of funds from a
  # ExpressPayments account to a card or bank account. This behavior has since been split
  # out into a [Payout](https://docs.epayments.network/api#payout_object) object, with corresponding payout endpoints. For more
  # information, read about the
  # [transfer/payout split](https://docs.epayments.network/transfer-payout-split).
  #
  # Related guide: [Creating separate charges and transfers](https://docs.epayments.network/connect/separate-charges-and-transfers)
  class Transfer < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save
    extend ExpressPayments::APIOperations::NestedResource

    OBJECT_NAME = "transfer"

    nested_resource_class_methods :reversal, operations: %i[create retrieve update list]
  end
end
