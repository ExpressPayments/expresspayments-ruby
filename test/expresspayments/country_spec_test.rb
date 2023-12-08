# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class CountrySpecTest < Test::Unit::TestCase
    should "be listable" do
      c = ExpressPayments::CountrySpec.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/country_specs"
      assert c.data.is_a?(Array)
      assert c.data[0].is_a?(ExpressPayments::CountrySpec)
    end

    should "be retrievable" do
      s = ExpressPayments::CountrySpec.retrieve("US")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/country_specs/US"
      assert(s.is_a?(ExpressPayments::CountrySpec))
    end
  end
end
