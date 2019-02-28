require 'lib/active_merchant/billing/gateways/six_saferpay_gateway'

module SolidusSixPayments
  class InitializeSaferpayPaymentPageCheckout

    attr_reader :order, :token, :redirect_url

    def self.call(order)
      new(order).call
    end

    def initialize(order)
      @order = order
    end

    def call
      payment_page_initialize = ActiveMerchant::Billing::SixSaferpayGateway.new.initialize_payment_page(order)
      if payment_page_initialize.success?
        SolidusSixPayments::SaferpayCheckout.create!(order: order, token: response.token)
      end
      payment_page_initialize
    end
  end
end
