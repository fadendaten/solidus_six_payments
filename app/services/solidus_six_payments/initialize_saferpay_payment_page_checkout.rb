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
      payment_page_initialize = ActiveMerchant::Billing::Gateways::SixSaferpayGateway.new.initialize_payment_page(order)
      if payment_page_initialize.success?
        @success = payment_page_initialize.success?
        @token = payment_page_initialize.params[:Token]
        @redirect_url = payment_page_initialize.params[:RedirectUrl]
        SolidusSixPayments::SaferpayCheckout.create!(order: order, token: token)
      end
      self
    end

    def success?
      @success
    end
  end
end
