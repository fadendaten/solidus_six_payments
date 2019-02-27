module Spree
  class SixSaferpayController < StoreController

    def initialize_payment
      # TODO CREATE PAYMENT
      @order = current_order # TODO error handling

      payment_page_initialize = SixSaferpay::PaymentPage::Initialize.new((@order.total * 100).to_i, @order.currency, @order.number, @order.to_s)

      payment_page_response = SixSaferpay::Client.post(payment_page_initialize)

      require 'pry'; binding.pry

      payment_page = JSON.parse(payment_page_response.body).with_indifferent_access

      # payment_page = initialize_payment_page
      token = payment_page[:Token]
      redirect_url = payment_page[:RedirectUrl]

      checkout = SolidusSixPayments::SaferpayCheckout.create!(order: current_order, token: token)

      log payment_page.inspect


      redirect_to redirect_url
    end

    def confirm
      # TODO: AUTHORIZE PAYMENT
      @order = current_order
      checkout = SolidusSixPayments::SaferpayCheckout.where(order: @order).order(:created_at).last

      asserted_payment = assert_payment_request(checkout.token)


      transaction = asserted_payment[:Transaction]
      payment_means = asserted_payment[:PaymentMeans]
      payer = asserted_payment[:Payer]
      liability = asserted_payment[:Liability]
      dcc = asserted_payment[:Dcc]

      payment_attributes = {
        amount: transaction[:Amount][:Value],
        number: transaction[:Id],
        payment_method_id: Spree::PaymentMethod.find_by(type: 'Spree::PaymentMethod::SixPaymentPage').id,
        source_attributes: {
          imported: true, # necessary because we don't want to validate CVV
          number: payment_means[:DisplayText],
          month: payment_means[:Card][:ExpMonth],
          year: payment_means[:Card][:ExpMonth],
          cc_type: payment_means[:Brand][:PaymentMethod],
          name: payment_means[:Card][:HolderName],
        }
      }

      payment = Spree::PaymentCreate.new(@order, payment_attributes, request_env: request.headers.env).build
      if payment.save!

        payment.update_attributes(number: transaction[:Id])
        @order.next! if @order.payment?
      end

      redirect_to order_state_checkout_path(@order)
    end

    def cancel
      require 'pry'; binding.pry
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
          "Success": 'http://localhost:3000/six_saferpay/confirm',#'confirm_saferpay_url(host: 'localhost:3000'),
          "Fail": 'http://localhost:3000/six_saferpay/cancel'#cancel_saferpay_url(host: 'localhost:3000'),
        }
      }.with_indifferent_access
    end

    def assert_payment_request(token)
      uri = URI.parse('https://test.saferpay.com/api/Payment/v1/PaymentPage/Assert')

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      request.body = assert_six_payment_page_params(token).to_json

      request.basic_auth 'API_245294_08700063', 'mei4Xoozle4doi0A'

      JSON.parse(https.request(request).body).with_indifferent_access
    end

    def assert_six_payment_page_params(token)
      {
        "RequestHeader": {
          "SpecVersion": "1.10",
          "CustomerId": "245294",
          "RequestId": "T1",
          "RetryIndicator": 0
        },
        "Token": token
      }
    end

    def after_authorize_url(order)
    end

    def after_cancel_url(order)
      order_state_checkout_path(order)
    end

    def order_state_checkout_path(order)
      Spree::Core::Engine.routes.url_helpers.checkout_state_path(order.state)
    end

    def log(stuff)
      puts stuff
    end
  end
end
