module Spree
  class PaymentMethod::SixPaymentPage < Spree::PaymentMethod

    def partial_name
      :sixpaymentpage
    end

    preference :terminal_id, :string, default: '17925560'
    preference :customer_id, :string, default: '245294'
    preference :spec_version, :string, default: '1.10'
    preference :payment_description, :string, default: "NILE Bestellung"
    preference :success_url, :string, default: '/create_payment'
    preference :fail_url, :string, default: '/fail_payment'

  end
end
