# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require "expresspayments/version"

Gem::Specification.new do |s|
  s.name = "expresspayments"
  s.version = ExpressPayments::VERSION
  s.required_ruby_version = ">= 2.3.0"
  s.summary = "Ruby bindings for the ExpressPayments API"
  s.description = "ExpressPayments is the easiest way to accept payments online.  " \
                  "See https://epayments.network for details."
  s.author = "ExpressPayments"
  s.email = "support@epayments.network"
  s.homepage = "https://docs.epayments.network/api?lang=ruby"
  s.license = "MIT"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/expresspayments/expresspayments-ruby/issues",
    "changelog_uri" =>
      "https://github.com/expresspayments/expresspayments-ruby/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://docs.epayments.network/api?lang=ruby",
    "github_repo" => "ssh://github.com/expresspayments/expresspayments-ruby",
    "homepage_uri" => "https://docs.epayments.network/api?lang=ruby",
    "source_code_uri" => "https://github.com/expresspayments/expresspayments-ruby",
    "rubygems_mfa_required" => "true",
  }

  ignored = Regexp.union(
    /\A\.editorconfig/,
    /\A\.git/,
    /\A\.rubocop/,
    /\A\.travis.yml/,
    /\A\.vscode/,
    /\Atest/
  )
  s.files = `git ls-files`.split("\n").reject { |f| ignored.match(f) }
  s.executables   = `git ls-files -- bin/*`.split("\n")
                                           .map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
