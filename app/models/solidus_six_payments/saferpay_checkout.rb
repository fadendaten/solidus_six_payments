module SolidusSixPayments
  class SaferpayCheckout < ApplicationRecord
    belongs_to :order, class_name: "Spree::Order"
  end
end
