module Spree
  module InitializeSaferpayPaymentPage
    extend ActiveSupport::Concern

    included do
      before_action :init_payment_page, only: :edit
    end

    def init_payment_page
      return unless @order.state == 'payment'

      six_payment = initialize_payment_page

      SolidusSixPayments::SaferpayCheckout.create(token: six_payment[:Token], order_id: @order.id)
      @redirect_url = six_payment[:RedirectUrl]
    end

    private

    def initialize_payment_page
      uri = URI.parse('https://test.saferpay.com/api/Payment/v1/PaymentPage/Initialize')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      request.body = initialize_six_payment_page_params.to_json

      request.basic_auth 'API_245294_08700063', 'mei4Xoozle4doi0A'

      JSON.parse(https.request(request).body).with_indifferent_access
    end

    def initialize_six_payment_page_params
      {
        "RequestHeader": {
          "SpecVersion": "1.10",
          "CustomerId": "245294",
          "RequestId": "T1",
          "RetryIndicator": 0
        },
        "TerminalId": "17925560",
        "Payment": {
          "Amount": {
            "Value": "100",
            "CurrencyCode": "CHF"
          },
          "OrderId": "R123456",
          "Description": "Auftrag für NILE"
        },
        "ReturnUrls": {
          "Success": confirm_saferpay_url,
          "Fail": cancel_saferpay_url,
        }
      }.with_indifferent_access
    end
  end
end
