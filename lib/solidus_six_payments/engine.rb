module SolidusSixPayments
  class Engine < ::Rails::Engine
    require 'spree/core'
    engine_name 'six_payments'

    isolate_namespace SolidusSixPayments

    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    initializer "spree.six_payment.payment_methods", :after => "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::SaferpayPaymentPage
    end

    initializer "solidus_six_payments.assets.precompile" do |app|
      app.config.assets.precompile += %w( solidus_six_payments/saferpay_payment_page.js )
    end
  end
end
