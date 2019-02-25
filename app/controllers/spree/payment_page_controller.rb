module Spree

  class PaymentPageController < StoreController

    def initialize_payment_page
      raise "init"

      uri = URI.parse('https://test.saferpay.com/api/Payment/v1/PaymentPage/Initialize')

      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      request.use_ssl = true
      request.body = six_payment_page_params.to_json
      request.basic_auth 'API_245294_08700063', 'mei4Xoozle4doi0A'

      response = http.request(request)

      require 'pry'; binding.pry

      redirect_to response['RedirectUrl']
    end


    private

    def six_payment_page_params
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
          "Success": "https://webshop4-staging.nile.ch",
          "Fail": "https://webshop4-staging.nile.ch"
        }
      }
    end
  end

end
