Spree::Core::Engine.routes.draw do

  scope :saferpay_payment_page do
    get 'init', controller: 'saferpay_payment_page', as: :saferpay_payment_page_init
    get 'success', controller: 'saferpay_payment_page', as: :saferpay_payment_page_success
    get 'fail', controller: 'saferpay_payment_page', as: :saferpay_payment_page_fail
    get 'cancel', controller: 'saferpay_payment_page', as: :saferpay_payment_page_cancel
  end

end
