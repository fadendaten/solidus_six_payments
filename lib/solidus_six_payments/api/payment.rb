module SolidusSixPayments
  class Payment
    attr_accessor :order

    def initialize(order)
      @order = order
    end

    def to_hash
      {
        'Payment': {
          'Amount': {
            'Value': @order.total.to_s,
            'CurrencyCode': @order.currency
          },
          'OrderId': @order.number,
          'Description': @order.to_s
        }
      }
    end
    alias_method :to_h, :to_hash
  end
end
