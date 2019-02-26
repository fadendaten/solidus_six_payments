module SolidusSixPayments
  class SixPaymentsController < Spree::CheckoutController

    def create
      require 'pry'; binding.pry

      if update_order

      redirect_to 
    end
  end
end
