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
      if capture_payment(payment.number)
        ActiveMerchant::Billing::Response.new(true, "Capture Successful", params, options)
      else
        ActiveMerchant::Billing::Response.new(false, "Capture Error", params, options)
      end
    end

    # We want to automatically capture the payment when the order is completed
    def auto_capture
      true
    end



    private

    def capture_payment(transaction_id)
      SolidusSixPayments::CaptureSaferpayPaymentPage.call(transaction_id)
    end
  end
end
