# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class AccountLinkTest < Test::Unit::TestCase
    should "be creatable" do
      link = ExpressPayments::AccountLink.create(
        account: "acct_123",
        refresh_url: "https://epayments.network/refresh",
        return_url: "https://epayments.network/return",
        type: "account_onboarding"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/account_links"
      assert link.is_a?(ExpressPayments::AccountLink)
    end
  end
end
