# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # Subscriptions allow you to charge a customer on a recurring basis.
  #
  # Related guide: [Creating subscriptions](https://docs.epayments.network/billing/subscriptions/creating)
  class Subscription < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    extend ExpressPayments::APIOperations::Search
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "subscription"

    def cancel(params = {}, opts = {})
      request_expresspayments_object(
        method: :delete,
        path: format("/v1/subscriptions/%<subscription_exposed_id>s", { subscription_exposed_id: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def delete_discount(params = {}, opts = {})
      request_expresspayments_object(
        method: :delete,
        path: format("/v1/subscriptions/%<subscription_exposed_id>s/discount", { subscription_exposed_id: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def resume(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/subscriptions/%<subscription>s/resume", { subscription: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.cancel(subscription_exposed_id, params = {}, opts = {})
      request_expresspayments_object(
        method: :delete,
        path: format("/v1/subscriptions/%<subscription_exposed_id>s", { subscription_exposed_id: CGI.escape(subscription_exposed_id) }),
        params: params,
        opts: opts
      )
    end

    def self.delete_discount(subscription_exposed_id, params = {}, opts = {})
      request_expresspayments_object(
        method: :delete,
        path: format("/v1/subscriptions/%<subscription_exposed_id>s/discount", { subscription_exposed_id: CGI.escape(subscription_exposed_id) }),
        params: params,
        opts: opts
      )
    end

    def self.resume(subscription, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/subscriptions/%<subscription>s/resume", { subscription: CGI.escape(subscription) }),
        params: params,
        opts: opts
      )
    end

    save_nested_resource :source

    def self.search(params = {}, opts = {})
      _search("/v1/subscriptions/search", params, opts)
    end

    def self.search_auto_paging_each(params = {}, opts = {}, &blk)
      search(params, opts).auto_paging_each(&blk)
    end
  end
end
