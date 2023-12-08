# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Reporting
    class ReportTypeTest < Test::Unit::TestCase
      should "be listable" do
        report_types = ExpressPayments::Reporting::ReportType.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/reporting/report_types"
        assert report_types.data.is_a?(Array)
        assert report_types.data[0].is_a?(ExpressPayments::Reporting::ReportType)
      end

      should "be retrievable" do
        report_type = ExpressPayments::Reporting::ReportType.retrieve("activity.summary.1")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/reporting/report_types/activity.summary.1"
        assert report_type.is_a?(ExpressPayments::Reporting::ReportType)
      end
    end
  end
end
