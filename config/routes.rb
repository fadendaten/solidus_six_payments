Spree::Core::Engine.routes.draw do

  # get 'checkout/payment', to: 'six_saferpay_payment_page#external_payment'

  scope :saferpay_payment_page do
    get 'init', controller: 'saferpay_payment_page'
    get 'success', controller: 'saferpay_payment_page'
    get 'fail', controller: 'saferpay_payment_page'
  end

end
