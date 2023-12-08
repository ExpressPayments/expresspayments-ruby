# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # To top up your ExpressPayments balance, you create a top-up object. You can retrieve
  # individual top-ups, as well as list all top-ups. Top-ups are identified by a
  # unique, random ID.
  #
  # Related guide: [Topping up your platform account](https://docs.epayments.network/connect/top-ups)
  class Topup < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "topup"

    def cancel(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/topups/%<topup>s/cancel", { topup: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.cancel(topup, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/topups/%<topup>s/cancel", { topup: CGI.escape(topup) }),
        params: params,
        opts: opts
      )
    end
  end
end
