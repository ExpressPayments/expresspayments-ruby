# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Checkout
    class SessionTest < Test::Unit::TestCase
      should "be creatable" do
        session = ExpressPayments::Checkout::Session.create(
          cancel_url: "https://epayments.network/cancel",
          client_reference_id: "1234",
          line_items: [
            {
              amount: 123,
              currency: "usd",
              description: "item 1",
              images: [
                "https://epayments.network/img1",
              ],
              name: "name",
              quantity: 2,
            },
          ],
          payment_intent_data: [
            receipt_email: "test@epayments.network",
          ],
          payment_method_types: ["card"],
          success_url: "https://epayments.network/success"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/checkout/sessions"
        assert session.is_a?(ExpressPayments::Checkout::Session)
      end

      should "be retrievable" do
        charge = ExpressPayments::Checkout::Session.retrieve("cs_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/checkout/sessions/cs_123"
        assert charge.is_a?(ExpressPayments::Checkout::Session)
      end

      context "#list_line_items" do
        should "list the session's line items" do
          sources = ExpressPayments::Checkout::Session.list_line_items(
            "cs_123"
          )
          assert_requested :get, "#{ExpressPayments.api_base}/v1/checkout/sessions/cs_123/line_items"
          assert sources.is_a?(ExpressPayments::ListObject)
          assert sources.data.is_a?(Array)
          assert sources.data[0].is_a?(ExpressPayments::LineItem)
        end
      end
    end
  end
end
