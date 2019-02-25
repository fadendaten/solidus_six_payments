SolidusSixPayments::Engine.routes.draw do
  get '/checkout/payment', to: '/spree/payment_page#initialize_payment_page'
end
