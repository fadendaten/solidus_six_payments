require "spec_helper"

RSpec.describe SolidusSixPayments::PaymentPage do
  let(:number) { "R123456789" }
  let(:total) { BigDecimal.new('1.00') }
  let(:currency) { 'CHF' }
  let(:description) { "Order #{number}" }

  let(:order) {
    double('order',
           total: total,
           currency: currency,
           number: number,
           to_s: description
          )
  }

  subject { described_class.new(order) }

  let(:request_header) { subject.request_header }
  let(:request_id) { request_header.request_id }

  let(:hash) {
    {
      "RequestHeader": {
        "SpecVersion": '1.10',
        "CustomerId": '245294',
        "RequestId": request_id,
        "RetryIndicator":0
      },
      "TerminalID": '17925560',
      'Payment': {
        'Amount': {
          'Value': total.to_s,
          'CurrencyCode': currency
        },
        'OrderId': number,
        'Description': description
      },
      'ReturnUrls': {
        'success': 'http://localhost:3004',
        'fail': 'http://localhost:3004'
      }
    }
  }


  describe 'to_hash' do
    it 'returns the hash representation of the payment' do
      expect(subject.to_hash).to eq(hash)
    end
  end
end
