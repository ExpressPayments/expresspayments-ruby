# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  class EphemeralKey < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Delete

    OBJECT_NAME = "ephemeral_key"

    def self.create(params = {}, opts = {})
      opts = Util.normalize_opts(opts)
      unless opts[:ep_version]
        raise ArgumentError,
              "ep_version must be specified to create an ephemeral key"
      end
      super
    end
  end
end
