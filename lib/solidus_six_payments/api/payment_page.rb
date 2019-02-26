module SolidusSixPayments
  class PaymentPage

    attr_accessor :request_header, :terminal_id, :payment, :return_urls

    def initialize(order)
      @request_header = SolidusSixPayments::RequestHeader.new
      @terminal_id = SolidusSixPayments::Terminal.new
      @payment = SolidusSixPayments::Payment.new(order)
      @return_urls = SolidusSixPayments::ReturnUrls.new
    end

    def to_hash
      hash = Hash.new
      hash.merge!(@request_header.to_h)
      hash.merge!(@terminal_id.to_h)
      hash.merge!(@payment.to_h)
      hash.merge!(@return_urls.to_h)
      hash
    end
    alias_method :to_h, :to_hash

  end
end
