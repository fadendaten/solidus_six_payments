module SolidusSixPayments
  class CaptureSaferpayTransaction

    attr_reader :transaction_id

    def self.call(transaction_id)
      new(transaction_id).call
    end

    def initialize(transaction_id)
      @transaction_id = transaction_id
    end

    def call
      if request_payment_page_capture
        success = true
      end

      self
    end

    def success?
      success || false
    end

    private

    def request_payment_page_capture
      payment_page_capture = SixSaferpay::Transaction::Capture.new(transaction_id)

      saferpay_response = SixSaferpay::Client.post(payment_page_capture)

      # TODO: Let the Client handle this
      JSON.parse(saferpay_response.body).with_indifferent_access
    end
  end
end
