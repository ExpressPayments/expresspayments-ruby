# frozen_string_literal: true

# Report test coverage to coveralls for only one Ruby version to avoid
# repeated builds. This also accounts for coveralls_reborn requiring
# RUBY_VERSION >= 2.5.
if ENV.key?("COVERALLS_REPO_TOKEN") && RUBY_VERSION.start_with?("3.1.")
  require "coveralls"
  Coveralls.wear!
end

require "expresspayments"
require "test/unit"
require "mocha/setup"
require "stringio"
require "shoulda/context"
require "webmock/test_unit"

PROJECT_ROOT = File.expand_path("../", __dir__)

require File.expand_path("test_data", __dir__)
require File.expand_path("expresspayments_mock", __dir__)

MOCK_MINIMUM_VERSION = "0.109.0"
MOCK_PORT = ExpressPayments::ExpressPaymentsMock.start

# Disable all real network connections except those that are outgoing to
# expresspayments-mock.
WebMock.disable_net_connect!(allow: "localhost:#{MOCK_PORT}")

# Try one initial test connection to expresspayments-mock so that if there's a problem
# we can print one error and fail fast so that it's more clear to the user how
# they should fix the problem.
begin
  resp = Net::HTTP.get_response(URI("http://localhost:#{MOCK_PORT}/"))
  version = resp["EP-Mock-Version"]

  if version.nil?
    abort("Couldn't find `EP-Mock-Version` in response from " \
          "`localhost:#{MOCK_PORT}`. Is the service running there expresspayments-mock?")
  end

  if version != "master" &&
     Gem::Version.new(version) < Gem::Version.new(MOCK_MINIMUM_VERSION)
    abort("Your version of expresspayments-mock (#{version}) is too old. The minimum " \
          "version to run this test suite is #{MOCK_MINIMUM_VERSION}. Please " \
          "see its repository for upgrade instructions.")
  end
rescue Errno::ECONNREFUSED
  abort("Couldn't reach expresspayments-mock at `localhost:#{MOCK_PORT}`. Is " \
        "it running? Please see README for setup instructions.")
end

Test::Unit.at_exit do
  ExpressPayments::ExpressPaymentsMock.stop
end

module Test
  module Unit
    class TestCase
      include ExpressPayments::TestData
      include Mocha

      WRITE_TIMEOUT_SUPPORTED = Net::HTTP.instance_methods.include?(:write_timeout=)

      setup do
        ExpressPayments.api_key = "sk_test_123"
        ExpressPayments.api_base = "http://localhost:#{MOCK_PORT}"
        ExpressPayments.uploads_base = "http://localhost:#{MOCK_PORT}"

        stub_connect
      end

      teardown do
        ExpressPayments.api_key = nil
      end

      private def stub_connect
        stub_request(:any, /^#{ExpressPayments.connect_base}/).to_return(body: "{}")
      end
    end
  end
end
