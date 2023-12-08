# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Terminal
    class LocationTest < Test::Unit::TestCase
      should "be creatable" do
        location = ExpressPayments::Terminal::Location.create(
          address: {
            line1: "line1",
            country: "US",
            postal_code: "12345",
            city: "San Francisco",
            state: "CA",
          },
          display_name: "name"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/terminal/locations"
        assert location.is_a?(ExpressPayments::Terminal::Location)
      end

      should "be listable" do
        locations = ExpressPayments::Terminal::Location.list
        assert_requested :get, "#{ExpressPayments.api_base}/v1/terminal/locations"
        assert locations.data.is_a?(Array)
        assert locations.data[0].is_a?(ExpressPayments::Terminal::Location)
      end

      should "be retrievable" do
        location = ExpressPayments::Terminal::Location.retrieve("loc_123")
        assert_requested :get, "#{ExpressPayments.api_base}/v1/terminal/locations/loc_123"
        assert location.is_a?(ExpressPayments::Terminal::Location)
      end

      should "be saveable" do
        location = ExpressPayments::Terminal::Location.retrieve("loc_123")
        location["display_name"] = "new name"
        location.save
        assert_requested :post, "#{ExpressPayments.api_base}/v1/terminal/locations/loc_123"
        assert location.is_a?(ExpressPayments::Terminal::Location)
      end

      should "be updateable" do
        location = ExpressPayments::Terminal::Location.update("loc_123", display_name: "new name")
        assert_requested :post, "#{ExpressPayments.api_base}/v1/terminal/locations/loc_123"
        assert location.is_a?(ExpressPayments::Terminal::Location)
      end

      context "#delete" do
        should "be deletable" do
          location = ExpressPayments::Terminal::Location.retrieve("loc_123")
          location = location.delete
          assert_requested :delete, "#{ExpressPayments.api_base}/v1/terminal/locations/#{location.id}"
          assert location.is_a?(ExpressPayments::Terminal::Location)
        end
      end

      context ".delete" do
        should "be deletable" do
          location = ExpressPayments::Terminal::Location.delete("loc_123")
          assert_requested :delete, "#{ExpressPayments.api_base}/v1/terminal/locations/loc_123"
          assert location.is_a?(ExpressPayments::Terminal::Location)
        end
      end
    end
  end
end
