# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Issuing
    class CardTest < Test::Unit::TestCase
      should "be creatable" do
        card = ExpressPayments::Issuing::Card.create(
          currency: "usd",
          type: "physical"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/cards"
        assert card.is_a?(ExpressPayments::Issuing::Card)
      end

      should "be listable" do
        cards = ExpressPayments::Issuing::Card.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/cards"
        assert cards.data.is_a?(Array)
        assert cards.data[0].is_a?(ExpressPayments::Issuing::Card)
      end

      should "be retrievable" do
        card = ExpressPayments::Issuing::Card.retrieve("ic_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/cards/ic_123"
        assert card.is_a?(ExpressPayments::Issuing::Card)
      end

      should "be saveable" do
        card = ExpressPayments::Issuing::Card.retrieve("ic_123")
        card.metadata["key"] = "value"
        card.save
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/cards/ic_123"
        assert card.is_a?(ExpressPayments::Issuing::Card)
      end

      should "be updateable" do
        card = ExpressPayments::Issuing::Card.update("ic_123", metadata: { foo: "bar" })
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/cards/ic_123"
        assert card.is_a?(ExpressPayments::Issuing::Card)
      end
    end
  end
end
