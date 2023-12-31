# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # A subscription schedule allows you to create and manage the lifecycle of a subscription by predefining expected changes.
  #
  # Related guide: [Subscription schedules](https://docs.epayments.network/billing/subscriptions/subscription-schedules)
  class SubscriptionSchedule < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "subscription_schedule"

    def cancel(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/subscription_schedules/%<schedule>s/cancel", { schedule: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def release(params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/subscription_schedules/%<schedule>s/release", { schedule: CGI.escape(self["id"]) }),
        params: params,
        opts: opts
      )
    end

    def self.cancel(schedule, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/subscription_schedules/%<schedule>s/cancel", { schedule: CGI.escape(schedule) }),
        params: params,
        opts: opts
      )
    end

    def self.release(schedule, params = {}, opts = {})
      request_expresspayments_object(
        method: :post,
        path: format("/v1/subscription_schedules/%<schedule>s/release", { schedule: CGI.escape(schedule) }),
        params: params,
        opts: opts
      )
    end
  end
end
