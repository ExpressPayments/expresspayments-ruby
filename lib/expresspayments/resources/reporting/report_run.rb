# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Reporting
    # The Report Run object represents an instance of a report type generated with
    # specific run parameters. Once the object is created, ExpressPayments begins processing the report.
    # When the report has finished running, it will give you a reference to a file
    # where you can retrieve your results. For an overview, see
    # [API Access to Reports](https://docs.epayments.network/reporting/statements/api).
    #
    # Note that certain report types can only be run based on your live-mode data (not test-mode
    # data), and will error when queried without a [live-mode API key](https://docs.epayments.network/keys#test-live-modes).
    class ReportRun < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "reporting.report_run"
    end
  end
end
