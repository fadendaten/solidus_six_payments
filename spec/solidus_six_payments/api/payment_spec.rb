require "spec_helper"

RSpec.describe SolidusSixPayments::Payment do

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

  let(:hash) {
    {
      'Payment': {
        'Amount': {
          'Value': total.to_s,
          'CurrencyCode': currency
        },
        'OrderId': number,
        'Description': description
      }
    }
  }

  subject { described_class.new(order) }

  describe 'to_hash' do
    it 'returns the hash representation of the payment' do
      expect(subject.to_hash).to eq(hash)
    end
  end
end
