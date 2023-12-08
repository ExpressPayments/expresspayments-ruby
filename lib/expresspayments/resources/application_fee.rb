# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  class ApplicationFee < APIResource
    extend ExpressPayments::APIOperations::List
    extend ExpressPayments::APIOperations::NestedResource

    OBJECT_NAME = "application_fee"

    nested_resource_class_methods :refund, operations: %i[create retrieve update list]
  end
end
