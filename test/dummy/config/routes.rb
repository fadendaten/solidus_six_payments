Rails.application.routes.draw do
  mount SolidusSixPayments::Engine => "/solidus_six_payments"
end
