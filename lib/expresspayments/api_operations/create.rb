# frozen_string_literal: true

module ExpressPayments
  module APIOperations
    module Create
      def create(params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: resource_url,
          params: params,
          opts: opts
        )
      end
    end
  end
end
