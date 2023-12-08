# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Reviews can be used to supplement automated fraud detection with human expertise.
  #
  # Learn more about [Radar](https://epayments.network/radar) and reviewing payments
  # [here](https://docs.epayments.network/radar/reviews).
  class Review < APIResource
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "review"

    def approve(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/reviews/%<review>s/approve", { review: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.approve(review, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/reviews/%<review>s/approve", { review: CGI.escape(review) }),
        params: params,
        opts: opts
      )
    end
  end
end
