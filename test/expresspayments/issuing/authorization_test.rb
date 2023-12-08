# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Issuing
    class AuthorizationTest < Test::Unit::TestCase
      should "be listable" do
        authorizations = ExpressPayments::Issuing::Authorization.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/authorizations"
        assert authorizations.data.is_a?(Array)
        assert authorizations.data[0].is_a?(ExpressPayments::Issuing::Authorization)
      end

      should "be retrievable" do
        authorization = ExpressPayments::Issuing::Authorization.retrieve("iauth_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/issuing/authorizations/iauth_123"
        assert authorization.is_a?(ExpressPayments::Issuing::Authorization)
      end

      should "be saveable" do
        authorization = ExpressPayments::Issuing::Authorization.retrieve("iauth_123")
        authorization.metadata["key"] = "value"
        authorization.save
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/authorizations/#{authorization.id}"
        assert authorization.is_a?(ExpressPayments::Issuing::Authorization)
      end

      should "be updateable" do
        authorization = ExpressPayments::Issuing::Authorization.update("iauth_123", metadata: { foo: "bar" })
        assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/authorizations/iauth_123"
        assert authorization.is_a?(ExpressPayments::Issuing::Authorization)
      end

      context ".approve" do
        should "approve an authorization" do
          payment_intent = ExpressPayments::Issuing::Authorization.approve("iauth_123")

          assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/authorizations/iauth_123/approve"
          assert payment_intent.is_a?(ExpressPayments::Issuing::Authorization)
        end
      end

      context "#approve" do
        should "approve an authorization" do
          authorization = ExpressPayments::Issuing::Authorization.retrieve("iauth_123")
          authorization.approve
          assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/authorizations/iauth_123/approve"
          assert authorization.is_a?(ExpressPayments::Issuing::Authorization)
        end
      end

      context ".decline" do
        should "decline an authorization" do
          payment_intent = ExpressPayments::Issuing::Authorization.decline("iauth_123")

          assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/authorizations/iauth_123/decline"
          assert payment_intent.is_a?(ExpressPayments::Issuing::Authorization)
        end
      end

      context "#decline" do
        should "decline an authorization" do
          authorization = ExpressPayments::Issuing::Authorization.retrieve("iauth_123")
          authorization.decline
          assert_requested :post, "#{ExpressPayments.api_base}/v1/issuing/authorizations/iauth_123/decline"
          assert authorization.is_a?(ExpressPayments::Issuing::Authorization)
        end
      end
    end
  end
end
