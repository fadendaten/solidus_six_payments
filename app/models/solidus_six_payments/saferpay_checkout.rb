module SolidusSixPayments
  class SaferpayCheckout < ApplicationRecord
    belongs_to :order, class_name: "Spree::Order"

    def to_s
      "Checkout #{token} for #{order}"
    end
  end
end
