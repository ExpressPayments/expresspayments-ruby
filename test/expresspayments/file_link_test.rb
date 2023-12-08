# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class FileLinkTest < Test::Unit::TestCase
    should "be listable" do
      file_links = ExpressPayments::FileLink.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/file_links"
      assert file_links.data.is_a?(Array)
      assert file_links.first.is_a?(ExpressPayments::FileLink)
    end

    should "be retrievable" do
      file_link = ExpressPayments::FileLink.retrieve("link_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/file_links/link_123"
      assert file_link.is_a?(ExpressPayments::FileLink)
    end

    should "be creatable" do
      file_link = ExpressPayments::FileLink.create(
        file: "file_123"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/file_links"
      assert file_link.is_a?(ExpressPayments::FileLink)
    end

    should "be saveable" do
      file_link = ExpressPayments::FileLink.retrieve("link_123")
      file_link.metadata["key"] = "value"
      file_link.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/file_links/#{file_link.id}"
    end

    should "be updateable" do
      file_link = ExpressPayments::FileLink.update("link_123", metadata: { key: "value" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/file_links/link_123"
      assert file_link.is_a?(ExpressPayments::FileLink)
    end
  end
end
