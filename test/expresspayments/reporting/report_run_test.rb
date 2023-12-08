# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Reporting
    class ReportRunTest < Test::Unit::TestCase
      should "be creatable" do
        report_run = ExpressPayments::Reporting::ReportRun.create(
          parameters: {
            connected_account: "acct_123",
          },
          report_type: "activity.summary.1"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/reporting/report_runs"
        assert report_run.is_a?(ExpressPayments::Reporting::ReportRun)
      end

      should "be listable" do
        report_runs = ExpressPayments::Reporting::ReportRun.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/reporting/report_runs"
        assert report_runs.data.is_a?(Array)
        assert report_runs.data[0].is_a?(ExpressPayments::Reporting::ReportRun)
      end

      should "be retrievable" do
        report_run = ExpressPayments::Reporting::ReportRun.retrieve("frr_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/reporting/report_runs/frr_123"
        assert report_run.is_a?(ExpressPayments::Reporting::ReportRun)
      end
    end
  end
end
