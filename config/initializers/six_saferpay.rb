require 'six_saferpay'

SixSaferpay.configure do |config|
  config.customer_id = '246353'#'245294'#ENV.fetch('SIX_SAFERPAY_CUSTOMER_ID')
  config.terminal_id = '17942698'#'17925560'#ENV.fetch('SIX_SAFERPAY_TERMINAL_ID')
  config.username = 'API_246353_14688433'#'API_245294_08700063'#ENV.fetch('SIX_SAFERPAY_USERNAME')
  config.password = 'JsonApiPwd1_H7wv6aDA'#'mei4Xoozle4doi0A'#ENV.fetch('SIX_SAFERPAY_PASSWORD')
  config.success_url = 'http://localhost:3000/six_saferpay/success'#ENV.fetch('SIX_SAFERPAY_FAIL_URL')
  config.fail_url = 'http://localhost:3000/six_saferpay/fail'#ENV.fetch('SIX_SAFERPAY_FAIL_URL')
  config.base_url = 'https://test.saferpay.com/api/'#ENV.fetch('SIX_SAFERPAY_BASE_URL')
  config.css_url = ''#ENV.fetch('SIX_SAFERPAY_CSS_URL')
end
