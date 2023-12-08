# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # These bank accounts are payment methods on `Customer` objects.
  #
  # On the other hand [External Accounts](https://docs.epayments.network/api#external_accounts) are transfer
  # destinations on `Account` objects for [Custom accounts](https://docs.epayments.network/connect/custom-accounts).
  # They can be bank accounts or debit cards as well, and are documented in the links above.
  #
  # Related guide: [Bank debits and transfers](https://docs.epayments.network/payments/bank-debits-transfers)
  class BankAccount < APIResource
    include ExpressPayments::APIOperations::Delete
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "bank_account"

    def verify(params = {}, opts = {})
      resp, opts = execute_resource_request(:post, resource_url + "/verify", params, opts)
      initialize_from(resp.data, opts)
    end

    def resource_url
      if respond_to?(:customer)
        "#{Customer.resource_url}/#{CGI.escape(customer)}/sources/#{CGI.escape(id)}"
      elsif respond_to?(:account)
        "#{Account.resource_url}/#{CGI.escape(account)}/external_accounts/#{CGI.escape(id)}"
      end
    end

    def self.update(_id, _params = nil, _opts = nil)
      raise NotImplementedError,
            "Bank accounts cannot be updated without a customer ID or an  " \
            "account ID. Update a bank account using " \
            "`Customer.update_source('customer_id', 'bank_account_id', " \
            "update_params)` or `Account.update_external_account(" \
            "'account_id', 'bank_account_id', update_params)`"
    end

    def self.retrieve(_id, _opts = nil)
      raise NotImplementedError,
            "Bank accounts cannot be retrieve without a customer ID or an " \
            "account ID. Retrieve a bank account using " \
            "`Customer.retrieve_source('customer_id', 'bank_account_id')` " \
            "or `Account.retrieve_external_account('account_id', " \
            "'bank_account_id')`"
    end
  end
end
