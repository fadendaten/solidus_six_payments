Spree::Core::Engine.routes.draw do

  scope :six_saferpay do
    get 'confirm', controller: 'six_saferpay', as: :confirm_saferpay
    get 'cancel', controller: 'six_saferpay', as: :cancel_saferpay
  end

end
