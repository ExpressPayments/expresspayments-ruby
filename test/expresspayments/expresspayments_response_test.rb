# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class ExpressPaymentsResponseTest < Test::Unit::TestCase
    context "ExpressPaymentsResponseHeaders" do
      should "allow case-insensitive header access" do
        headers = { "Request-Id" => "request-id" }
        http_resp = create_net_http_resp(200, "", headers)

        headers = ExpressPaymentsResponseHeaders.from_net_http(http_resp)

        assert_equal "request-id", headers["request-id"]
        assert_equal "request-id", headers["Request-Id"]
        assert_equal "request-id", headers["Request-ID"]
      end

      should "initialize without error" do
        ExpressPaymentsResponseHeaders.new({})
        ExpressPaymentsResponseHeaders.new("Request-Id" => [])
        ExpressPaymentsResponseHeaders.new("Request-Id" => ["request-id"])
      end

      should "initialize with error on a malformed hash" do
        assert_raises(ArgumentError) do
          ExpressPaymentsResponseHeaders.new(nil)
        end

        assert_raises(ArgumentError) do
          ExpressPaymentsResponseHeaders.new(1 => [])
        end

        assert_raises(ArgumentError) do
          ExpressPaymentsResponseHeaders.new("Request-Id" => 1)
        end

        assert_raises(ArgumentError) do
          ExpressPaymentsResponseHeaders.new("Request-Id" => [1])
        end
      end

      should "warn on duplicate header values" do
        old_stderr = $stderr
        $stderr = StringIO.new
        begin
          headers = ExpressPaymentsResponseHeaders.new("Duplicated" => %w[a b])
          assert_equal "a", headers["Duplicated"]
          assert_equal "Duplicate header values for `Duplicated`; returning only first",
                       $stderr.string.rstrip
        ensure
          $stderr = old_stderr
        end
      end
    end

    [ExpressPaymentsResponse, ExpressPaymentsHeadersOnlyResponse].each do |response_class|
      context "ExpressPaymentsResponseBase mixin for #{response_class}" do
        context ".from_net_http" do
          should "populate the base fields" do
            code = 200
            body = '{"foo": "bar"}'
            headers = { "Request-Id" => "request-id" }
            http_resp = create_net_http_resp(code, body, headers)

            resp = response_class.from_net_http(http_resp)

            assert_equal "request-id", resp.http_headers["Request-ID"]
            assert_equal code, resp.http_status
            assert_equal "request-id", resp.request_id
          end
        end
      end
    end

    context "#ExpressPaymentsResponse" do
      context ".from_net_http" do
        should "converts to ExpressPaymentsResponse" do
          code = 200
          body = '{"foo": "bar"}'
          http_resp = create_net_http_resp(code, body, {})

          resp = ExpressPaymentsResponse.from_net_http(http_resp)

          assert_instance_of ExpressPaymentsResponse, resp
          assert_equal JSON.parse(body, symbolize_names: true), resp.data
          assert_equal body, resp.http_body
        end
      end

      context "Headers backwards compatibility" do
        should "alias ExpressPaymentsResponseHeaders" do
          headers = ExpressPaymentsResponse::Headers.new("Request-Id" => ["request-id"])

          assert_instance_of ExpressPaymentsResponseHeaders, headers
        end
      end
    end

    # Synthesizes a `Net::HTTPResponse` object for testing purposes.
    private def create_net_http_resp(code, body, headers)
      # The "1.1" is HTTP version.
      http_resp = Net::HTTPResponse.new("1.1", code.to_s, nil)
      http_resp.body = body

      # This is obviously super sketchy, but the Ruby team has done everything
      # in their power to make these objects as difficult to test with as
      # possible. Even if you specify a body, accessing `#body` the first time
      # will attempt to read from a non-existent socket which will subsequently
      # blow up. Setting this internal variable skips that read and allows the
      # object to use the body that we specified above.
      http_resp.instance_variable_set(:@read, true)

      headers.each do |name, value|
        http_resp[name] = value
      end

      http_resp
    end
  end
end
