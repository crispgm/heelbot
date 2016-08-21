source "https://rubygems.org"
gemspec

$:.unshift File.expand_path("../lib", __FILE__)

group :runtime do
  gem "webrick"
  gem "mail"
  gem "liquid"
  gem "os"
  gem "json"
  gem "nokogiri"
end

group :test do
  gem "minitest"
  gem "codeclimate-test-reporter", require: nil
  gem "rubocop"
  gem "shoulda-context"
end
