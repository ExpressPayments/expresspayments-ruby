# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Subscription items allow you to create customer subscriptions with more than
  # one plan, making it easy to represent complex billing relationships.
  class SubscriptionItem < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Delete
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save
    extend ExpressPayments::APIOperations::NestedResource

    OBJECT_NAME = "subscription_item"

    nested_resource_class_methods :usage_record, operations: %i[create]
    nested_resource_class_methods :usage_record_summary,
                                  operations: %i[list],
                                  resource_plural: "usage_record_summaries"
  end
end
