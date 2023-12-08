# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  module Apps
    # Secret Store is an API that allows ExpressPayments Apps developers to securely persist secrets for use by UI Extensions and app backends.
    #
    # The primary resource in Secret Store is a `secret`. Other apps can't view secrets created by an app. Additionally, secrets are scoped to provide further permission control.
    #
    # All Dashboard users and the app backend share `account` scoped secrets. Use the `account` scope for secrets that don't change per-user, like a third-party API key.
    #
    # A `user` scoped secret is accessible by the app backend and one specific Dashboard user. Use the `user` scope for per-user secrets like per-user OAuth tokens, where different users might have different permissions.
    #
    # Related guide: [Store data between page reloads](https://docs.epayments.network/expresspayments-apps/store-auth-data-custom-objects)
    class Secret < APIResource
      extend ExpressPayments::APIOperations::Create
      extend ExpressPayments::APIOperations::List

      OBJECT_NAME = "apps.secret"

      def self.delete_where(params = {}, opts = {})
        request_expresspayments_object(
          method: :post,
          path: "/v1/apps/secrets/delete",
          params: params,
          opts: opts
        )
      end

      def self.find(params = {}, opts = {})
        request_expresspayments_object(
          method: :get,
          path: "/v1/apps/secrets/find",
          params: params,
          opts: opts
        )
      end
    end
  end
end
