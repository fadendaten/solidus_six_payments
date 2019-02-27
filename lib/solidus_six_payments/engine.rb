module SolidusSixPayments
  class Engine < ::Rails::Engine
    require 'spree/core'
    engine_name 'six_payments'

    isolate_namespace SolidusSixPayments

    initializer "spree.six_payment.payment_methods", :after => "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::SixPaymentPage
    end


    SixSaferpay.configure do |config|
      config.customer_id = '245294'#ENV.fetch('SIX_SAFERPAY_CUSTOMER_ID')
      config.terminal_id = '17925560'#ENV.fetch('SIX_SAFERPAY_TERMINAL_ID')
      config.username = 'API_245294_08700063'#ENV.fetch('SIX_SAFERPAY_USERNAME')
      config.password = 'mei4Xoozle4doi0A'#ENV.fetch('SIX_SAFERPAY_PASSWORD')
      config.success_url = 'http://localhost:3000/six_saferpay/confirm'#ENV.fetch('SIX_SAFERPAY_FAIL_URL')
      config.fail_url = 'http://localhost:3000/six_saferpay/confirm'#ENV.fetch('SIX_SAFERPAY_FAIL_URL')
      config.base_url = 'https://test.saferpay.com/api/'#ENV.fetch('SIX_SAFERPAY_BASE_URL')
      config.css_url = ''#ENV.fetch('SIX_SAFERPAY_CSS_URL')
    end

  end
end
