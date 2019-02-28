module Spree
  class SaferpayPaymentPageController < StoreController

    def init
      load_order
      payment_page_initialize = SolidusSixPayments::InitializeSaferpayPaymentPageCheckout.call(@order)

      if payment_page_initialize.success?
        redirect_url = payment_page_initialize.redirect_url
        render json: { redirect_url: redirect_url }
      else
        render json: { errors: "Payment could not be initialized" }, status: 422
      end
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
  end
end
