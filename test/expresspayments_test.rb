# frozen_string_literal: true

require File.expand_path("test_helper", __dir__)

class ExpresspaymentsTest < Test::Unit::TestCase
  should "allow app_info to be configured" do
    begin
      old = ExpressPayments.app_info
      ExpressPayments.set_app_info(
        "MyAwesomePlugin",
        partner_id: "partner_1234",
        url: "https://myawesomeplugin.info",
        version: "1.2.34"
      )
      assert_equal({
        name: "MyAwesomePlugin",
        partner_id: "partner_1234",
        url: "https://myawesomeplugin.info",
        version: "1.2.34",
      }, ExpressPayments.app_info)
    ensure
      ExpressPayments.app_info = old
    end
  end

  context "forwardable configurations" do
    context "internal configurations" do
      should "return the certificate store" do
        assert ExpressPayments.ca_store.is_a?(OpenSSL::X509::Store)
      end

      should "return the max_network_retry_delay" do
        assert_equal 2, ExpressPayments.max_network_retry_delay
      end

      should "return the initial_network_retry_delay" do
        assert_equal 0.5, ExpressPayments.initial_network_retry_delay
      end
    end

    should "allow ca_bundle_path to be configured" do
      ExpressPayments::ExpressPaymentsClient.expects(:clear_all_connection_managers)
      ExpressPayments.ca_bundle_path = "/path/to/ca/bundle"
      assert_equal "/path/to/ca/bundle", ExpressPayments.ca_bundle_path
    end

    should "allow open timeout to be configured" do
      ExpressPayments.open_timeout = 10
      assert_equal 10, ExpressPayments.open_timeout
    end

    should "allow read timeout to be configured" do
      ExpressPayments.read_timeout = 10
      assert_equal 10, ExpressPayments.read_timeout
    end

    if WRITE_TIMEOUT_SUPPORTED
      should "allow write timeout to be configured" do
        ExpressPayments.write_timeout = 10
        assert_equal 10, ExpressPayments.write_timeout
      end
    else
      should "raise when write timeout to be configured is not supported" do
        assert_raises NotImplementedError do
          ExpressPayments.write_timeout = 10
        end
      end
    end

    should "allow api_key to be configured" do
      ExpressPayments.api_key = "sk_local_test"
      assert_equal "sk_local_test", ExpressPayments.api_key
    end

    should "allow ep_account to be configured" do
      ExpressPayments.ep_account = "acct_1234"
      assert_equal "acct_1234", ExpressPayments.ep_account
    end

    should "allow enable_telemetry to be configured" do
      begin
        old = ExpressPayments.enable_telemetry?

        ExpressPayments.enable_telemetry = false
        assert_equal false, ExpressPayments.enable_telemetry?
      ensure
        ExpressPayments.enable_telemetry = old
      end
    end

    should "allow log_level to be configured" do
      ExpressPayments.log_level = "debug"
      assert_equal ::Logger::DEBUG, ExpressPayments.log_level
    end

    should "allow logger to be configured" do
      logger = Object.new
      ExpressPayments.logger = logger
      assert_equal logger, ExpressPayments.logger
    end

    should "allow proxy to be configured" do
      ExpressPayments.proxy = "http://proxy"
      assert_equal "http://proxy", ExpressPayments.proxy
    end

    should "allow uploads_base to be configured" do
      ExpressPayments.uploads_base = "https://other.epayments.network"
      assert_equal "https://other.epayments.network", ExpressPayments.uploads_base
    end

    should "allow api_base to be configured" do
      ExpressPayments.api_base = "https://other.epayments.network"
      assert_equal "https://other.epayments.network", ExpressPayments.api_base
    end

    should "allow api_version to be configured" do
      ExpressPayments.api_version = "2023-11-01"
      assert_equal "2023-11-01", ExpressPayments.api_version
    end

    should "allow connect_base to be configured" do
      ExpressPayments.connect_base = "https://other.epayments.network"
      assert_equal "https://other.epayments.network", ExpressPayments.connect_base
    end

    should "allow verify_ssl_certs to be configured" do
      ExpressPayments.verify_ssl_certs = false
      assert_equal false, ExpressPayments.verify_ssl_certs
    end

    should "allow client_id to be configured" do
      ExpressPayments.client_id = "client"
      assert_equal "client", ExpressPayments.client_id
    end
  end
end
