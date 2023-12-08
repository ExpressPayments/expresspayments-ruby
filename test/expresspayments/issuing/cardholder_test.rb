# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Issuing
    class CardholderTest < Test::Unit::TestCase
      should "be creatable" do
        cardholder = ExpressPayments::Issuing::Cardholder.create(
          billing: {
            address: {
              city: "city",
              country: "US",
              line1: "line1",
              postal_code: "postal_code",
            },
          },
          name: "Jenny Rosen",
          type: "individual"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/cardholders"
        assert cardholder.is_a?(ExpressPayments::Issuing::Cardholder)
      end

      should "be listable" do
        cardholders = ExpressPayments::Issuing::Cardholder.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/cardholders"
        assert cardholders.data.is_a?(Array)
        assert cardholders.data[0].is_a?(ExpressPayments::Issuing::Cardholder)
      end

      should "be retrievable" do
        cardholder = ExpressPayments::Issuing::Cardholder.retrieve("ich_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/cardholders/ich_123"
        assert cardholder.is_a?(ExpressPayments::Issuing::Cardholder)
      end

      should "be saveable" do
        cardholder = ExpressPayments::Issuing::Cardholder.retrieve("ich_123")
        cardholder.metadata["key"] = "value"
        cardholder.save
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/cardholders/#{cardholder.id}"
        assert cardholder.is_a?(ExpressPayments::Issuing::Cardholder)
      end

      should "be updateable" do
        cardholder = ExpressPayments::Issuing::Cardholder.update("ich_123", metadata: { foo: "bar" })
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/cardholders/ich_123"
        assert cardholder.is_a?(ExpressPayments::Issuing::Cardholder)
      end
    end
  end
end
