# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Identity
    class VerificationReportTest < Test::Unit::TestCase
      should "be listable" do
        verification_reports = ExpressPayments::Identity::VerificationReport.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/identity/verification_reports"
        assert verification_reports.data.is_a?(Array)
        assert verification_reports.data[0].is_a?(ExpressPayments::Identity::VerificationReport)
      end

      should "be retrievable" do
        verification_report = ExpressPayments::Identity::VerificationReport.retrieve("vs_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/identity/verification_reports/vs_123"
        assert verification_report.is_a?(ExpressPayments::Identity::VerificationReport)
      end
    end
  end
end
