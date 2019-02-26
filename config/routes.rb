SolidusSixPayments::Engine.routes.draw do

  get '/payments/create', to: 'six_payments#create', as: :create_six_payment

end
