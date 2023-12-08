# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Radar
    class ValueListTest < Test::Unit::TestCase
      should "be listable" do
        lists = ExpressPayments::Radar::ValueList.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/radar/value_lists"
        assert lists.data.is_a?(Array)
        assert lists.first.is_a?(ExpressPayments::Radar::ValueList)
      end

      should "be retrievable" do
        list = ExpressPayments::Radar::ValueList.retrieve("rsl_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/radar/value_lists/rsl_123"
        assert list.is_a?(ExpressPayments::Radar::ValueList)
      end

      should "be creatable" do
        list = ExpressPayments::Radar::ValueList.create(
          alias: "list_alias",
          name: "list_name"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/radar/value_lists"
        assert list.is_a?(ExpressPayments::Radar::ValueList)
      end

      should "be saveable" do
        list = ExpressPayments::Radar::ValueList.retrieve("rsl_123")
        list.metadata["key"] = "value"
        list.save
        assert_requested :post, "#{ExpressPayments.api_base}/v1/radar/value_lists/rsl_123"
      end

      should "be updateable" do
        list = ExpressPayments::Radar::ValueList.update("rsl_123", metadata: { key: "value" })
        assert_requested :post, "#{ExpressPayments.api_base}/v1/radar/value_lists/rsl_123"
        assert list.is_a?(ExpressPayments::Radar::ValueList)
      end

      context "#delete" do
        should "be deletable" do
          list = ExpressPayments::Radar::ValueList.retrieve("rsl_123")
          list = list.delete
          assert_requested :delete, "#{ExpressPayments.api_base}/v1/radar/value_lists/rsl_123"
          assert list.is_a?(ExpressPayments::Radar::ValueList)
        end
      end

      context ".delete" do
        should "be deletable" do
          list = ExpressPayments::Radar::ValueList.delete("rsl_123")
          assert_requested :delete, "#{ExpressPayments.api_base}/v1/radar/value_lists/rsl_123"
          assert list.is_a?(ExpressPayments::Radar::ValueList)
        end
      end
    end
  end
end
