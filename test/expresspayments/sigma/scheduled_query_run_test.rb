# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Issuing
    class ScheduledQueryRunTest < Test::Unit::TestCase
      should "be listable" do
        runs = ExpressPayments::Sigma::ScheduledQueryRun.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/sigma/scheduled_query_runs"
        assert runs.data.is_a?(Array)
        assert runs.data[0].is_a?(ExpressPayments::Sigma::ScheduledQueryRun)
      end

      should "be retrievable" do
        run = ExpressPayments::Sigma::ScheduledQueryRun.retrieve("sqr_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/sigma/scheduled_query_runs/sqr_123"
        assert run.is_a?(ExpressPayments::Sigma::ScheduledQueryRun)
      end
    end
  end
end
