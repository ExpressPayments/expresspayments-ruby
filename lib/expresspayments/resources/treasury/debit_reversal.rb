# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Treasury
    # You can reverse some [ReceivedDebits](https://docs.epayments.network/api#received_debits) depending on their network and source flow. Reversing a ReceivedDebit leads to the creation of a new object known as a DebitReversal.
    class DebitReversal < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "treasury.debit_reversal"
    end
  end
end
