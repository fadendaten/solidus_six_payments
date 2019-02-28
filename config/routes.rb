Spree::Core::Engine.routes.draw do

  get 'checkout/payment', to: 'six_saferpay_payment_page#initialize_payment'

  scope :six_saferpay do
    get 'success', controller: 'six_saferpay_payment_page', as: :confirm_saferpay
    get 'fail', controller: 'six_saferpay_payment_page', as: :cancel_saferpay
  end

end
