# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Issue a credit note to adjust an invoice's amount after the invoice is finalized.
  #
  # Related guide: [Credit notes](https://docs.epayments.network/billing/invoices/credit-notes)
  class CreditNote < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "credit_note"

    def void_credit_note(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/credit_notes/%<id>s/void", { id: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.list_preview_line_items(params = {}, opts = {})
      request_expresspayments_object(
        method: :get,
        path: "/v1/credit_notes/preview/lines",
        params: params,
        opts: opts
      )
    end

    def self.preview(params = {}, opts = {})
      request_expresspayments_object(
        method: :get,
        path: "/v1/credit_notes/preview",
        params: params,
        opts: opts
      )
    end

    def self.void_credit_note(id, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/credit_notes/%<id>s/void", { id: CGI.escape(id) }),
        params: params,
        opts: opts
      )
    end
  end
end
