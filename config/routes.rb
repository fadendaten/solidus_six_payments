SolidusSixPayments::Engine.routes.draw do
  get 'initialize_payment_page', to: '/spree/payment_page#initialize_payment_page'
end
