# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Terminal
    class ReaderTest < Test::Unit::TestCase
      should "be creatable" do
        reader = ExpressPayments::Terminal::Reader.create(
          registration_code: "elegant-orange-aqua",
          label: "label"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/terminal/readers"
        assert reader.is_a?(ExpressPayments::Terminal::Reader)
      end

      should "be listable" do
        readers = ExpressPayments::Terminal::Reader.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/terminal/readers"
        assert readers.data.is_a?(Array)
        assert readers.data[0].is_a?(ExpressPayments::Terminal::Reader)
      end

      should "be retrievable" do
        reader = ExpressPayments::Terminal::Reader.retrieve("rdr_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/terminal/readers/rdr_123"
        assert reader.is_a?(ExpressPayments::Terminal::Reader)
      end

      should "be saveable" do
        reader = ExpressPayments::Terminal::Reader.retrieve("rdr_123")
        reader["label"] = "new label"
        reader.save
        assert_requested :post, "#{ExpressPayments.api_base}/v1/terminal/readers/rdr_123"
        assert reader.is_a?(ExpressPayments::Terminal::Reader)
      end

      should "be updateable" do
        reader = ExpressPayments::Terminal::Reader.update("rdr_123", label: "new label")
        assert_requested :post, "#{ExpressPayments.api_base}/v1/terminal/readers/rdr_123"
        assert reader.is_a?(ExpressPayments::Terminal::Reader)
      end

      context "#delete" do
        should "be deletable" do
          reader = ExpressPayments::Terminal::Reader.retrieve("rdr_123")
          reader = reader.delete
          assert_requested :delete, "#{ExpressPayments.api_base}/v1/terminal/readers/#{reader.id}"
          assert reader.is_a?(ExpressPayments::Terminal::Reader)
        end
      end

      context ".delete" do
        should "be deletable" do
          reader = ExpressPayments::Terminal::Reader.delete("rdr_123")
          assert_requested :delete, "#{ExpressPayments.api_base}/v1/terminal/readers/rdr_123"
          assert reader.is_a?(ExpressPayments::Terminal::Reader)
        end
      end

      should "be able to present a payment method" do
        reader = ExpressPayments::Terminal::Reader.retrieve("rdr_123")
        reader = reader.test_helpers.present_payment_method
        assert_requested :post, "#{ExpressPayments.api_base}/v1/test_helpers/terminal/readers/rdr_123/present_payment_method"
        assert reader.is_a?(ExpressPayments::Terminal::Reader)
      end
    end
  end
end
