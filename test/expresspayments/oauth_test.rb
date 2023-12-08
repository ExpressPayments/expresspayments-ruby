# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class OAuthTest < Test::Unit::TestCase
    setup do
      ExpressPayments.client_id = "ca_test"
    end

    teardown do
      ExpressPayments.client_id = nil
    end

    context ".authorize_url" do
      should "return the authorize URL" do
        uri_str = OAuth.authorize_url(scope: "read_write",
                                      state: "csrf_token",
                                      expresspayments_user: {
                                        email: "test@example.com",
                                        url: "https://example.com/profile/test",
                                        country: "US",
                                      })

        uri = URI.parse(uri_str)
        params = CGI.parse(uri.query)

        assert_equal("https", uri.scheme)
        assert_equal("connect.epayments.network", uri.host)
        assert_equal("/oauth/authorize", uri.path)

        assert_equal(["ca_test"], params["client_id"])
        assert_equal(["read_write"], params["scope"])
        assert_equal(["test@example.com"], params["expresspayments_user[email]"])
        assert_equal(["https://example.com/profile/test"], params["expresspayments_user[url]"])
        assert_equal(["US"], params["expresspayments_user[country]"])
      end

      should "optionally return an express path" do
        uri_str = OAuth.authorize_url({}, express: true)

        uri = URI.parse(uri_str)
        assert_equal("https", uri.scheme)
        assert_equal("connect.epayments.network", uri.host)
        assert_equal("/express/oauth/authorize", uri.path)
      end

      should "override the api base path when an ExpressPaymentsClient is provided" do
        client = ExpressPayments::ExpressPaymentsClient.new(connect_base: "https://other.epayments.network")
        uri_str = OAuth.authorize_url({}, client: client)

        uri = URI.parse(uri_str)
        assert_equal("other.epayments.network", uri.host)
      end
    end

    context ".token" do
      should "exchange a code for an access token" do
        # The OpenAPI fixtures don't cover the OAuth endpoints, so we just
        # stub the request manually.
        stub_request(:post, "#{ExpressPayments.connect_base}/oauth/token")
          .with(body: {
            "grant_type" => "authorization_code",
            "code" => "this_is_an_authorization_code",
          })
          .to_return(body: JSON.generate(access_token: "sk_access_token",
                                         scope: "read_only",
                                         livemode: false,
                                         token_type: "bearer",
                                         refresh_token: "sk_refresh_token",
                                         ep_user_id: "acct_test",
                                         ep_publishable_key: "pk_test"))

        resp = OAuth.token(grant_type: "authorization_code",
                           code: "this_is_an_authorization_code")
        assert_equal("sk_access_token", resp.access_token)
      end

      should "override the API key when client_secret is passed" do
        stub_request(:post, "#{ExpressPayments.connect_base}/oauth/token")
          .with(body: {
            "client_secret" => "client_secret_override",
            "grant_type" => "authorization_code",
            "code" => "this_is_an_authorization_code",
          })
          .with(headers: { Authorization: "Bearer client_secret_override" })
          .to_return(body: JSON.generate(access_token: "another_access_token"))

        resp = OAuth.token(client_secret: "client_secret_override",
                           grant_type: "authorization_code",
                           code: "this_is_an_authorization_code")
        assert_equal("another_access_token", resp.access_token)
      end

      should "override the api base path when an ExpressPaymentsClient is provided" do
        stub_request(:post, "https://other.epayments.network/oauth/token")
          .with(body: {
            "grant_type" => "authorization_code",
            "code" => "this_is_an_authorization_code",
          })
          .to_return(body: JSON.generate(access_token: "sk_access_token",
                                         scope: "read_only",
                                         livemode: false,
                                         token_type: "bearer",
                                         refresh_token: "sk_refresh_token",
                                         ep_user_id: "acct_test",
                                         ep_publishable_key: "pk_test"))

        client = ExpressPayments::ExpressPaymentsClient.new(connect_base: "https://other.epayments.network")
        resp = OAuth.token(
          { grant_type: "authorization_code", code: "this_is_an_authorization_code" },
          client: client
        )

        assert_equal("sk_access_token", resp.access_token)
      end
    end

    context ".deauthorize" do
      should "deauthorize an account" do
        # The OpenAPI fixtures don't cover the OAuth endpoints, so we just
        # stub the request manually.
        stub_request(:post, "#{ExpressPayments.connect_base}/oauth/deauthorize")
          .with(body: {
            "client_id" => "ca_test",
            "ep_user_id" => "acct_test_deauth",
          })
          .to_return(body: JSON.generate(ep_user_id: "acct_test_deauth"))

        resp = OAuth.deauthorize(ep_user_id: "acct_test_deauth")
        assert_equal("acct_test_deauth", resp.ep_user_id)
      end

      should "override the api base path when an ExpressPaymentsClient is provided" do
        stub_request(:post, "https://other.epayments.network/oauth/deauthorize")
          .with(body: {
            "client_id" => "ca_test",
            "ep_user_id" => "acct_test_deauth",
          })
          .to_return(body: JSON.generate(ep_user_id: "acct_test_deauth"))

        client = ExpressPayments::ExpressPaymentsClient.new(connect_base: "https://other.epayments.network")
        resp = OAuth.deauthorize({ ep_user_id: "acct_test_deauth" }, client: client)

        assert_equal("acct_test_deauth", resp.ep_user_id)
      end
    end
  end
end
