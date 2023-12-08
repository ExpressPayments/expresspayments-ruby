# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class EphemeralKeyTest < Test::Unit::TestCase
    context "#create" do
      should "succeed" do
        key = ExpressPayments::EphemeralKey.create(
          { customer: "cus_123" },
          ep_version: "2023-11-01"
        )

        assert_requested(
          :post,
          "#{ExpressPayments.api_base}/v1/ephemeral_keys",
          headers: { "EP-Version" => "2023-11-01" }
        )

        assert key.is_a?(ExpressPayments::EphemeralKey)
      end

      context "#no global version" do
        should "use the correct api version" do
          key = ExpressPayments::EphemeralKey.create(
            { customer: "cus_123" },
            ep_version: "2023-11-01"
          )

          assert_requested(
            :post,
            "#{ExpressPayments.api_base}/v1/ephemeral_keys",
            headers: { "EP-Version" => "2023-11-01" }
          )

          assert key.is_a?(ExpressPayments::EphemeralKey)
        end

        should "error without an explicit api version" do
          e = assert_raises(ArgumentError) do
            ExpressPayments::EphemeralKey.create(customer: "cus_123")
          end
          assert_match("ep_version must be specified", e.message)
        end
      end

      context "#with global version" do
        setup do
          ExpressPayments.api_version = "2023-11-01"
        end

        teardown do
          ExpressPayments.api_version = nil
        end

        should "use the correct api version" do
          key = ExpressPayments::EphemeralKey.create(
            { customer: "cus_123" },
            ep_version: "2023-11-01"
          )

          assert key.is_a?(ExpressPayments::EphemeralKey)
        end

        should "error without an explicit api version" do
          e = assert_raises(ArgumentError) do
            ExpressPayments::EphemeralKey.create(customer: "cus_123")
          end
          assert_match("ep_version must be specified", e.message)
        end
      end
    end

    context "#delete" do
      should "succeed" do
        key = ExpressPayments::EphemeralKey.create(
          { customer: "cus_123" },
          ep_version: "2023-11-01"
        )

        key.delete
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/ephemeral_keys/#{key.id}"
      end
    end

    context ".delete" do
      should "succeed" do
        ExpressPayments::EphemeralKey.delete("ephkey_123")
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/ephemeral_keys/ephkey_123"
      end
    end
  end
end
