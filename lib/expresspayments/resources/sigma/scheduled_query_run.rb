# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Sigma
    # If you have [scheduled a Sigma query](https://docs.epayments.network/sigma/scheduled-queries), you'll
    # receive a `sigma.scheduled_query_run.created` webhook each time the query
    # runs. The webhook contains a `ScheduledQueryRun` object, which you can use to
    # retrieve the query results.
    class ScheduledQueryRun < APIResource
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "scheduled_query_run"

      def self.resource_url
        "/v1/sigma/scheduled_query_runs"
      end
    end
  end
end
