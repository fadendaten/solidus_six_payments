require File.expand_path("../../spec/dummy/config/environment.rb", __FILE__)
require 'bundler/setup'
require 'rspec/rails'

require 'solidus_six_payments'

RSpec.configure do |config|
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  else
    config.profile_examples = true
  end

  config.order = :random
  Kernel.srand config.seed
end

SolidusSixPayments.configure do |config|
  config.spec_version = '1.10'
  config.customer_id = '245294'
  config.terminal_id = '17925560'
  config.username = 'API_245294_08700063'
  config.password = 'mei4Xoozle4doi0A'
  config.success_url = 'http://localhost:3004'
  config.fail_url = 'http://localhost:3004'
end
