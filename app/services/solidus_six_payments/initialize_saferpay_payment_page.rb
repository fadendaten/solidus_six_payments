module SolidusSixPayments
  class InitializeSaferpayPaymentPage

    attr_reader :order, :token, :redirect_url

    def self.call(order)
      new(order).call
    end

    def initialize(order)
      @order = order
    end

    def call
      payment_page_response = request_payment_page_initialize

      @token = payment_page_response[:Token]
      @redirect_url = payment_page_response[:RedirectUrl]

      SaferpayCheckout.create(token: payment_page_response[:Token], order_id: @order.id)

      self
    end

    private

    def request_payment_page_initialize
      payment_page_initialize = SixSaferpay::PaymentPage::Initialize.new(
        (order.total * 100).to_i,
        order.currency,
        order.number,
        order.to_s
      )

      saferpay_response = SixSaferpay::Client.post(payment_page_initialize)

      # TODO: Let the Client handle this
      JSON.parse(saferpay_response.body).with_indifferent_access
    end
  end
end
