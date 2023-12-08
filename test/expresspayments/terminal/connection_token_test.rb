# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

module ExpressPayments
  module Terminal
    class ConnectionTokenTest < Test::Unit::TestCase
      should "be creatable" do
        connection_token = ExpressPayments::Terminal::ConnectionToken.create

        assert_requested :post, "#{ExpressPayments.api_base}/v1/terminal/connection_tokens"
        assert connection_token.is_a?(ExpressPayments::Terminal::ConnectionToken)
      end
    end
  end
end
