module Spree
  class SixSaferpayController < StoreController

    def confirm
      @order = current_order
      checkout = SolidusSixPayments::SaferpayCheckout.where(order: @order).order(:created_at).last

      @asserted_payment = assert_payment_request(checkout.token)

      # TODO: AUTHORIZE PAYMENT
      require 'pry'; binding.pry
      redirect_to after_authorize_url(@order)
    end

    def cancel
      require 'pry'; binding.pry
    end

    private

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
      order_state_checkout_path(order)
    end

    def after_cancel_url(order)
      order_state_checkout_path(order)
    end

    def order_state_checkout_path(order)
      Spree::Core::Engine.routes.url_helpers.checkout_state_path(order.state)
    end


    # def confirm
    #   checkout_token = affirm_params[:checkout_token]
    #   order = Spree::Order.find(affirm_params[:order_id])

    #   if !checkout_token
    #     return redirect_to checkout_state_path(order.state), notice: "Invalid order confirmation data passed in"
    #   end

    #   if order.complete?
    #     return redirect_to spree.order_path(order), notice: "Order is already in complete state"
    #   end

    #   affirm_checkout = SolidusAffirm::Checkout.new(token: checkout_token)

    #   affirm_checkout.transaction do
    #     if affirm_checkout.save!
    #       payment = order.payments.create!({
    #         payment_method_id: affirm_params[:payment_method_id],
    #         source: affirm_checkout
    #       })
    #       hook = SolidusAffirm::Config.callback_hook.new
    #       hook.authorize!(payment)
    #       redirect_to hook.after_authorize_url(order)
    #     end
    #   end
    # end

    # def cancel
    #   order = Spree::Order.find(affirm_params[:order_id])
    #   hook = SolidusAffirm::Config.callback_hook.new
    #   redirect_to hook.after_cancel_url(order)
    # end

    # private

    # def affirm_params
    #   params.permit(:checkout_token, :payment_method_id, :order_id)
    # end

  end
end
    
# module SolidusAffirm
  # module CallbackHook
    # class Base
    #   def authorize!(payment)
    #     payment.process!
    #     authorized_affirm = Affirm::Charge.find(payment.response_code)
    #     payment.amount = authorized_affirm.amount / 100.0
    #     payment.save!
    #     payment.order.next! if payment.order.payment?
    #   end

    #   def after_authorize_url(order)
    #     order_state_checkout_path(order)
    #   end

    #   def after_cancel_url(order)
    #     order_state_checkout_path(order)
    #   end

    #   private

    #   def order_state_checkout_path(order)
    #     Spree::Core::Engine.routes.url_helpers.checkout_state_path(order.state)
    #   end
    # end
  # end
# end
