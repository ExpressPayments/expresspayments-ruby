# ExpressPayments Ruby Library

[![Gem Version](https://badge.fury.io/rb/expresspayments.svg)](https://badge.fury.io/rb/expresspayments)
[![Build Status](https://github.com/expresspayments/expresspayments-ruby/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/expresspayments/expresspayments-ruby/actions?query=branch%3Amaster)
[![Coverage Status](https://coveralls.io/repos/github/expresspayments/expresspayments-ruby/badge.svg?branch=master)](https://coveralls.io/github/expresspayments/expresspayments-ruby?branch=master)

The ExpressPayments Ruby library provides convenient access to the ExpressPayments API from
applications written in the Ruby language. It includes a pre-defined set of
classes for API resources that initialize themselves dynamically from API
responses which makes it compatible with a wide range of versions of the ExpressPayments
API.

The library also provides other features. For example:

- Easy configuration path for fast setup and use.
- Helpers for pagination.
- Built-in mechanisms for the serialization of parameters according to the
  expectations of ExpressPayments' API.

## Documentation

See the [Ruby API docs](https://docs.epayments.network/api?lang=ruby).

See [video demonstrations][youtube-playlist] covering how to use the library.


## Installation

You don't need this source code unless you want to modify the gem. If you just
want to use the package, just run:

```sh
gem install expresspayments
```

If you want to build the gem from source:

```sh
gem build expresspayments.gemspec
```

### Requirements

- Ruby 2.3+.

### Bundler

If you are installing via bundler, you should be sure to use the https rubygems
source in your Gemfile, as any gems fetched over http could potentially be
compromised in transit and alter the code of gems fetched securely over https:

```ruby
source 'https://rubygems.org'

gem 'rails'
gem 'expresspayments'
```

## Usage

The library needs to be configured with your account's secret key which is
available in your [ExpressPayments Dashboard][api-keys]. Set `ExpressPayments.api_key` to its
value:

```ruby
require 'expresspayments'
ExpressPayments.api_key = 'sk_test_...'

# list customers
ExpressPayments::Customer.list()

# retrieve single customer
ExpressPayments::Customer.retrieve('cus_123456789')
```

### Per-request Configuration

For apps that need to use multiple keys during the lifetime of a process, like
one that uses [ExpressPayments Connect][connect], it's also possible to set a
per-request key and/or account:

```ruby
require "expresspayments"

ExpressPayments::Customer.list(
  {},
  {
    api_key: 'sk_test_...',
    ep_account: 'acct_...',
    ep_version: '2023-11-01',
  }
)

ExpressPayments::Customer.retrieve(
  'cus_123456789',
  {
    api_key: 'sk_test_...',
    ep_account: 'acct_...',
    ep_version: '2023-11-01',
  }
)

ExpressPayments::Customer.retrieve(
  {
    id: 'cus_123456789',
    expand: %w(balance_transaction)
  },
  {
    ep_version: '2023-11-01',
    api_key: 'sk_test_...',
  }
)

ExpressPayments::Customer.capture(
  'cus_123456789',
  {},
  {
    ep_version: '2023-11-01',
    api_key: 'sk_test_...',
  }
)
```

Keep in mind that there are different method signatures depending on the action:

- When operating on a collection (e.g. `.list`, `.create`) the method signature is
  `method(params, opts)`.
- When operating on resource (e.g. `.capture`, `.update`) the method signature is
  `method(id, params, opts)`.
- One exception is that `retrieve`, despite being an operation on a resource, has the signature
  `retrieve(id, opts)`. In addition, it will accept a Hash for the `id` param but will extract the
  `id` key out and use the others as options.

### Accessing a response object

Get access to response objects by initializing a client and using its `request`
method:

```ruby
client = ExpressPayments::ExpressPaymentsClient.new
customer, resp = client.request do
  ExpressPayments::Customer.retrieve('cus_123456789',)
end
puts resp.request_id
```

### Configuring a proxy

A proxy can be configured with `ExpressPayments.proxy`:

```ruby
ExpressPayments.proxy = 'https://user:pass@example.com:1234'
```

### Configuring an API Version

By default, the library will use the API version pinned to the account making
a request. This can be overridden with this global option:

```ruby
ExpressPayments.api_version = '2023-11-01'
```

See [versioning in the API reference][versioning] for more information.

### Configuring CA Bundles

By default, the library will use its own internal bundle of known CA
certificates, but it's possible to configure your own:

```ruby
ExpressPayments.ca_bundle_path = 'path/to/ca/bundle'
```

### Configuring Automatic Retries

You can enable automatic retries on requests that fail due to a transient
problem by configuring the maximum number of retries:

```ruby
ExpressPayments.max_network_retries = 2
```

Various errors can trigger a retry, like a connection error or a timeout, and
also certain API responses like HTTP status `409 Conflict`.

[Idempotency keys][idempotency-keys] are added to requests to guarantee that
retries are safe.

### Configuring Timeouts

Open, read and write timeouts are configurable:

```ruby
ExpressPayments.open_timeout = 30 # in seconds
ExpressPayments.read_timeout = 80
ExpressPayments.write_timeout = 30 # only supported on Ruby 2.6+
```

Please take care to set conservative read timeouts. Some API requests can take
some time, and a short timeout increases the likelihood of a problem within our
servers.

### Logging

The library can be configured to emit logging that will give you better insight
into what it's doing. The `info` logging level is usually most appropriate for
production use, but `debug` is also available for more verbosity.

There are a few options for enabling it:

1. Set the environment variable `EP_LOG` to the value `debug` or `info`:

   ```sh
   $ export EP_LOG=info
   ```

2. Set `ExpressPayments.log_level`:

   ```ruby
   ExpressPayments.log_level = ExpressPayments::LEVEL_INFO
   ```

### Instrumentation

The library has various hooks that user code can tie into by passing a block to
`ExpressPayments::Instrumentation.subscribe` to be notified about specific events.

#### `request_begin`

Invoked when an HTTP request starts. Receives `RequestBeginEvent` with the
following properties:

- `method`: HTTP method. (`Symbol`)
- `path`: Request path. (`String`)
- `user_data`: A hash on which users can set arbitrary data, and which will be
  passed through to `request_end` invocations. This could be used, for example,
  to assign unique IDs to each request, and it'd work even if many requests are
  running in parallel. All subscribers share the same object for any particular
  request, so they must be careful to use unique keys that will not conflict
  with other subscribers. (`Hash`)

#### `request_end`

Invoked when an HTTP request finishes, regardless of whether it terminated with
a success or error. Receives `RequestEndEvent` with the following properties:

- `duration`: Request duration in seconds. (`Float`)
- `http_status`: HTTP response code (`Integer`) if available, or `nil` in case
  of a lower level network error.
- `method`: HTTP method. (`Symbol`)
- `num_retries`: The number of retries. (`Integer`)
- `path`: Request path. (`String`)
- `user_data`: A hash on which users may have set arbitrary data in
  `request_begin`. See above for more information. (`Hash`)
- `request_id`: HTTP request identifier. (`String`)
- `response_header`: The response headers. (`Hash`)
- `response_body` = The response body. (`String`)
- `request_header` = The request headers. (`Hash`)
- `request_body` = The request body. (`String`)

#### Example

For example:

```ruby
ExpressPayments::Instrumentation.subscribe(:request_end) do |request_event|
  # Filter out high-cardinality ids from `path`
  path_parts = request_event.path.split("/").drop(2)
  resource = path_parts.map { |part| part.match?(/\A[a-z_]+\z/) ? part : ":id" }.join("/")

  tags = {
    method: request_event.method,
    resource: resource,
    code: request_event.http_status,
    retries: request_event.num_retries
  }
  StatsD.distribution('ep_request', request_event.duration, tags: tags)
end
```

### Writing a Plugin

If you're writing a plugin that uses the library, we'd appreciate it if you
identified using `#set_app_info`:

```ruby
ExpressPayments.set_app_info('MyAwesomePlugin', version: '1.2.34', url: 'https://myawesomeplugin.info')
```

This information is passed along when the library makes calls to the ExpressPayments
API.

### Request latency telemetry

By default, the library sends request latency telemetry to ExpressPayments. These
numbers help ExpressPayments improve the overall latency of its API for all users.

You can disable this behavior if you prefer:

```ruby
ExpressPayments.enable_telemetry = false
```

### Beta SDKs

ExpressPayments has features in the beta phase that can be accessed via the beta version of this package.
We would love for you to try these and share feedback with us before these features reach the stable phase.
To install a beta version use `gem install` with the exact version you'd like to use:

```sh
gem install expresspayments -v 7.1.0.pre.beta.2
```

> **Note**
> There can be breaking changes between beta versions. Therefore we recommend pinning the package version to a specific beta version in your Gemfile. This way you can install the same version each time without breaking changes unless you are intentionally looking for the latest beta version.

We highly recommend keeping an eye on when the beta feature you are interested in goes from beta to stable so that you can move from using a beta version of the SDK to the stable version.

If your beta feature requires a `EP-Version` header to be sent, use the `ExpressPayments.api_version` field to set it:

```python
ExpressPayments.api_version += "; feature_beta=v3"
```

## Support

New features and bug fixes are released on the latest major version of the ExpressPayments Ruby library. If you are on an older major version, we recommend that you upgrade to the latest in order to use the new features and bug fixes including those for security vulnerabilities. Older major versions of the package will continue to be available for use, but will not be receiving any updates.

## Development

The test suite depends on [expresspayments-mock], so make sure to fetch and run it from a
background terminal ([expresspayments-mock's README][expresspayments-mock] also contains
instructions for installing via Homebrew and other methods):

```sh
go get -u github.com/expresspayments/expresspayments-mock
expresspayments-mock
```

Run all tests:

```sh
bundle exec rake test
```

Run a single test suite:

```sh
bundle exec ruby -Ilib/ test/expresspayments/util_test.rb
```

Run a single test:

```sh
bundle exec ruby -Ilib/ test/expresspayments/util_test.rb -n /should.convert.names.to.symbols/
```

Run the linter:

```sh
bundle exec rake rubocop
```

Update bundled CA certificates from the [Mozilla cURL release][curl]:

```sh
bundle exec rake update_certs
```

Update the bundled [expresspayments-mock] by editing the version number found in
`.travis.yml`.

[api-keys]: https://dashboard.epayments.network/account/apikeys
[connect]: https://epayments.network/connect
[curl]: http://curl.haxx.se/docs/caextract.html
[idempotency-keys]: https://docs.epayments.network/api/idempotent_requests?lang=ruby
[expresspayments-mock]: https://github.com/expresspayments/expresspayments-mock
[versioning]: https://docs.epayments.network/api/versioning?lang=ruby
[youtube-playlist]: https://www.youtube.com/playlist?list=PLy1nL-pvL2M50RmP6ie-gdcSnfOuQCRYk

<!--
# vim: set tw=79:
-->
