# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Invoice Items represent the component lines of an [invoice](https://docs.epayments.network/api/invoices). An invoice item is added to an
  # invoice by creating or updating it with an `invoice` field, at which point it will be included as
  # [an invoice line item](https://docs.epayments.network/api/invoices/line_item) within
  # [invoice.lines](https://docs.epayments.network/api/invoices/object#invoice_object-lines).
  #
  # Invoice Items can be created before you are ready to actually send the invoice. This can be particularly useful when combined
  # with a [subscription](https://docs.epayments.network/api/subscriptions). Sometimes you want to add a charge or credit to a customer, but actually charge
  # or credit the customer's card only at the end of a regular billing cycle. This is useful for combining several charges
  # (to minimize per-transaction fees), or for having ExpressPayments tabulate your usage-based billing totals.
  #
  # Related guides: [Integrate with the Invoicing API](https://docs.epayments.network/invoicing/integration), [Subscription Invoices](https://docs.epayments.network/billing/invoices/subscription#adding-upcoming-invoice-items).
  class InvoiceItem < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Delete
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "invoiceitem"
  end
end
