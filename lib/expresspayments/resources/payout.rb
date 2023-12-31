# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A `Payout` object is created when you receive funds from ExpressPayments, or when you
  # initiate a payout to either a bank account or debit card of a [connected
  # ExpressPayments account](https://docs.epayments.network/connect/bank-debit-card-payouts). You can retrieve individual payouts,
  # and list all payouts. Payouts are made on [varying
  # schedules](https://docs.epayments.network/connect/manage-payout-schedule), depending on your country and
  # industry.
  #
  # Related guide: [Receiving payouts](https://docs.epayments.network/payouts)
  class Payout < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "payout"

    def cancel(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/payouts/%<payout>s/cancel", { payout: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def reverse(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/payouts/%<payout>s/reverse", { payout: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.cancel(payout, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/payouts/%<payout>s/cancel", { payout: CGI.escape(payout) }),
        params: params,
        opts: opts
      )
    end

    def self.reverse(payout, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/payouts/%<payout>s/reverse", { payout: CGI.escape(payout) }),
        params: params,
        opts: opts
      )
    end
  end
end
