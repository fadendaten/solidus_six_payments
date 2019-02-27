module Spree
  class PaymentMethod::SixPaymentPage < Spree::PaymentMethod::CreditCard

    def gateway_class
      PaymentMethod::SixPaymentPage
    end

    def payment_source_class
      Spree::CreditCard
    end

    def profiles_supported?
      false
    end

    def partial_name
      :sixpaymentpage
    end


    def authorize(cents, source, gateway_options)
      require 'pry'; binding.pry

      params = {}
      options = {}

      ActiveMerchant::Billing::Response.new(true, "Authorize Successful", params, options)
    end

    def purchase(cents, source, gateway_options)

      params = {}
      options = {}

      payment = gateway_options[:originator]
      capture_payment(payment.number)

      ActiveMerchant::Billing::Response.new(true, "Capture Successful", params, options)
    end

    # We want to automatically capture the payment when the order is completed
    def auto_capture
      true
    end



    private

    def capture_payment(number)
      uri = URI.parse('https://test.saferpay.com/api/Payment/v1/Transaction/Capture')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})

      request.body = capture_payment_params(number).to_json

      request.basic_auth 'API_245294_08700063', 'mei4Xoozle4doi0A'

      JSON.parse(https.request(request).body).with_indifferent_access
    end

    def capture_payment_params(number)
      {
        "RequestHeader": {
          "SpecVersion": "1.10",
          "CustomerId": "245294",
          "RequestId": "R1",
          "RetryIndicator": 0
        },
        "TransactionReference": {
          "TransactionId": number
        }
      }.with_indifferent_access
    end
  end
end
