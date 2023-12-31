# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # `Source` objects allow you to accept a variety of payment methods. They
  # represent a customer's payment instrument, and can be used with the ExpressPayments API
  # just like a `Card` object: once chargeable, they can be charged, or can be
  # attached to customers.
  #
  # ExpressPayments doesn't recommend using the deprecated [Sources API](https://docs.epayments.network/api/sources).
  # We recommend that you adopt the [PaymentMethods API](https://docs.epayments.network/api/payment_methods).
  # This newer API provides access to our latest features and payment method types.
  #
  # Related guides: [Sources API](https://docs.epayments.network/sources) and [Sources & Customers](https://docs.epayments.network/sources/customers).
  class Source < APIResource
    extend ExpressPayments::APIOperations::Create
    include ExpressPayments::APIOperations::Save
    extend ExpressPayments::APIOperations::NestedResource

    OBJECT_NAME = "source"

    nested_resource_class_methods :source_transaction, operations: %i[retrieve list]

    def verify(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/sources/%<source>s/verify", { source: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.verify(source, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/sources/%<source>s/verify", { source: CGI.escape(source) }),
        params: params,
        opts: opts
      )
    end

    def detach(params = {}, opts = {})
      if !respond_to?(:customer) || customer.nil? || customer.empty?
        raise NotImplementedError,
              "This source object does not appear to be currently attached " \
              "to a customer object."
      end

      url = "#{Customer.resource_url}/#{CGI.escape(customer)}/sources" \
            "/#{CGI.escape(id)}"
      resp, opts = execute_resource_request(:delete, url, params, opts)
      initialize_from(resp.data, opts)
    end

    def source_transactions(params = {}, opts = {})
      request_expresspayments_object(
        method: :get,
        path: resource_url + "/source_transactions",
        params: params,
        opts: opts
      )
    end
    extend Gem::Deprecate
    deprecate :source_transactions, :"Source.list_source_transactions", 2020, 1
  end
end
