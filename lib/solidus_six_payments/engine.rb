module SolidusSixPayments
  class Engine < ::Rails::Engine
    require 'spree/core'
    engine_name 'six_payments'

    # isolate_namespace SolidusSixPayments

    initializer "spree.six_payment.payment_methods", :after => "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::SixPaymentPage
    end

  end
end
