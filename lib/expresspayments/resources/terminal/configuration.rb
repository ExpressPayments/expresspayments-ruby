# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Terminal
    # A Configurations object represents how features should be configured for terminal readers.
    class Configuration < APIResource
      extend ExpressPayments::APIOperations::Create
      include ExpressPayments::APIOperations::Delete
      extend ExpressPayments::APIOperations::List
      include ExpressPayments::APIOperations::Save

      OBJECT_NAME = "terminal.configuration"
    end
  end
end
