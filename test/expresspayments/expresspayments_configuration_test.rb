# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class ExpressPaymentsConfigurationTest < Test::Unit::TestCase
    context ".setup" do
      should "initialize a new configuration with defaults" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        assert_equal ExpressPayments::DEFAULT_CA_BUNDLE_PATH, config.ca_bundle_path
        assert_equal true, config.enable_telemetry
        assert_equal true, config.verify_ssl_certs
        assert_equal 2, config.max_network_retry_delay
        assert_equal 0.5, config.initial_network_retry_delay
        assert_equal 0, config.max_network_retries
        assert_equal 30, config.open_timeout
        assert_equal 80, config.read_timeout
        assert_equal 30, config.write_timeout
        assert_equal "https://api.epayments.network", config.api_base
        assert_equal "https://connect.epayments.network", config.connect_base
        assert_equal "https://files.epayments.network", config.uploads_base
        assert !config.api_version.nil?
      end

      should "allow for overrides when a block is passed" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup do |c|
          c.open_timeout = 100
          c.read_timeout = 100
          c.write_timeout = 100 if WRITE_TIMEOUT_SUPPORTED
        end

        assert_equal 100, config.open_timeout
        assert_equal 100, config.read_timeout
        assert_equal 100, config.write_timeout if WRITE_TIMEOUT_SUPPORTED
      end
    end

    context "#reverse_duplicate_merge" do
      should "return a duplicate object with overrides" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup do |c|
          c.open_timeout = 100
        end

        duped_config = config.reverse_duplicate_merge(read_timeout: 500, api_version: "2018-08-02")

        assert_equal config.open_timeout, duped_config.open_timeout
        assert_equal 500, duped_config.read_timeout
      end
    end

    context "#max_network_retries=" do
      should "coerce the option into an integer" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        config.max_network_retries = "10"
        assert_equal 10, config.max_network_retries
      end
    end

    context "#max_network_retry_delay=" do
      should "coerce the option into an integer" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        config.max_network_retry_delay = "10"
        assert_equal 10, config.max_network_retry_delay
      end
    end

    context "#initial_network_retry_delay=" do
      should "coerce the option into an integer" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        config.initial_network_retry_delay = "10"
        assert_equal 10, config.initial_network_retry_delay
      end
    end

    context "#log_level=" do
      should "be backwards compatible with old values" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        config.log_level = "debug"
        assert_equal ExpressPayments::LEVEL_DEBUG, config.log_level

        config.log_level = "info"
        assert_equal ExpressPayments::LEVEL_INFO, config.log_level
      end

      should "raise an error if the value isn't valid" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        assert_raises ArgumentError do
          config.log_level = "Foo"
        end
      end
    end

    context "options that require all connection managers to be cleared" do
      should "clear when setting allow ca_bundle_path" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        ExpressPaymentsClient.expects(:clear_all_connection_managers).with(config: config)
        config.ca_bundle_path = "/path/to/ca/bundle"
      end

      should "clear when setting open timeout" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        ExpressPaymentsClient.expects(:clear_all_connection_managers).with(config: config)
        config.open_timeout = 10
      end

      should "clear when setting read timeout" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        ExpressPaymentsClient.expects(:clear_all_connection_managers).with(config: config)
        config.read_timeout = 10
      end

      should "clear when setting uploads_base" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        ExpressPaymentsClient.expects(:clear_all_connection_managers).with(config: config)
        config.uploads_base = "https://other.epayments.network"
      end

      should "clear when setting api_base to be configured" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        ExpressPaymentsClient.expects(:clear_all_connection_managers).with(config: config)
        config.api_base = "https://other.epayments.network"
      end

      should "clear when setting connect_base" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        ExpressPaymentsClient.expects(:clear_all_connection_managers).with(config: config)
        config.connect_base = "https://other.epayments.network"
      end

      should "clear when setting verify_ssl_certs" do
        config = ExpressPayments::ExpressPaymentsConfiguration.setup

        ExpressPaymentsClient.expects(:clear_all_connection_managers).with(config: config)
        config.verify_ssl_certs = false
      end
    end

    context "#key" do
      should "generate the same key when values are identical" do
        assert_equal ExpressPaymentsConfiguration.setup.key, ExpressPaymentsConfiguration.setup.key

        custom_config = ExpressPaymentsConfiguration.setup { |c| c.open_timeout = 1000 }
        refute_equal ExpressPaymentsConfiguration.setup.key, custom_config.key
      end
    end
  end
end
