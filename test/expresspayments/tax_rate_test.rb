# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class TaxRateTest < Test::Unit::TestCase
    should "be listable" do
      tax_rates = ExpressPayments::TaxRate.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/tax_rates"
      assert tax_rates.data.is_a?(Array)
      assert tax_rates.first.is_a?(ExpressPayments::TaxRate)
    end

    should "be retrievable" do
      tax_rate = ExpressPayments::TaxRate.retrieve("txr_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/tax_rates/txr_123"
      assert tax_rate.is_a?(ExpressPayments::TaxRate)
    end

    should "be creatable" do
      tax_rate = ExpressPayments::TaxRate.create(
        display_name: "name",
        inclusive: false,
        percentage: 10.15
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/tax_rates"
      assert tax_rate.is_a?(ExpressPayments::TaxRate)
    end

    should "be saveable" do
      tax_rate = ExpressPayments::TaxRate.retrieve("txr_123")
      tax_rate.metadata["key"] = "value"
      tax_rate.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/tax_rates/#{tax_rate.id}"
    end

    should "be updateable" do
      tax_rate = ExpressPayments::TaxRate.update("txr_123", metadata: { key: "value" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/tax_rates/txr_123"
      assert tax_rate.is_a?(ExpressPayments::TaxRate)
    end
  end
end
