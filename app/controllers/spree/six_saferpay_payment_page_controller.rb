module Spree
  class SixSaferpayPaymentPageController < StoreController

    def initialize_payment
      load_order
      payment_page_initialize = SolidusSixPayments::InitializeSaferpayPaymentPage.call(@order)

      redirect_to payment_page_initialize.redirect_url
    end

    def success
      load_order

      checkout = SolidusSixPayments::SaferpayCheckout.where(order: @order).order(:created_at).last

      unless checkout
        raise "No Saferpay Token found for order #{@order}"
      end

      payment_page_assert = SolidusSixPayments::AssertSaferpayPaymentPage.call(checkout)
      if payment_page_assert.success?
        @order.next! if @order.payment?
      end

      redirect_to order_checkout_path(@order.state)
    end

    def fail
      redirect_to order_checkout_path(:delivery)
    end

    private

    def load_order
      @order = current_order
      redirect_to(spree.cart_path) && return unless @order
    end

    def order_checkout_path(state)
      Spree::Core::Engine.routes.url_helpers.checkout_state_path(state)
    end

    def log(stuff)
      puts stuff
    end
  end
end
