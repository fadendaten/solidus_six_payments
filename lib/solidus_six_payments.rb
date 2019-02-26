require "solidus_six_payments/engine"

require 'solidus_six_payments/api/request_header'
require 'solidus_six_payments/api/terminal'
require 'solidus_six_payments/api/payment'
require 'solidus_six_payments/api/return_urls'
require 'solidus_six_payments/api/payment_page'


module SolidusSixPayments
  class Config
    attr_accessor :spec_version,       # Version of the SIX Saferpay API
      :customer_id,                    # ID of the Customer by SIX Saferpay
      :terminal_id,                     # ID of the Terminal by SIX Saferpay
      :username,
      :password,
      :success_url,
      :fail_url
  end

  # Initalize the Config class
  def self.config
    @@config ||= Config.new
  end

  # Set the configs
  def self.configure
    yield self.config
  end
end
