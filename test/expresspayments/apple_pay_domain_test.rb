# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class ApplePayDomainTest < Test::Unit::TestCase
    should "be listable" do
      domains = ExpressPayments::ApplePayDomain.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/apple_pay/domains"
      assert domains.data.is_a?(Array)
      assert domains.data[0].is_a?(ExpressPayments::ApplePayDomain)
    end

    should "be retrievable" do
      domain = ExpressPayments::ApplePayDomain.retrieve("apwc_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/apple_pay/domains/apwc_123"
      assert domain.is_a?(ExpressPayments::ApplePayDomain)
    end

    should "be creatable" do
      domain = ExpressPayments::ApplePayDomain.create(domain_name: "example.com")
      assert_requested :post, "#{ExpressPayments.api_base}/v1/apple_pay/domains"
      assert domain.is_a?(ExpressPayments::ApplePayDomain)
    end

    should "be deletable" do # rubocop:todo Lint/EmptyBlock
    end

    context "#delete" do
      should "be deletable" do
        domain = ExpressPayments::ApplePayDomain.retrieve("apwc_123")
        domain = domain.delete
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/apple_pay/domains/#{domain.id}"
        assert domain.is_a?(ExpressPayments::ApplePayDomain)
      end
    end

    context ".delete" do
      should "be deletable" do
        domain = ExpressPayments::ApplePayDomain.delete("apwc_123")
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/apple_pay/domains/apwc_123"
        assert domain.is_a?(ExpressPayments::ApplePayDomain)
      end
    end
  end
end
