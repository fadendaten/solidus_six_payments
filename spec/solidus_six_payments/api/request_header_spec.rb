require "spec_helper"

RSpec.describe SolidusSixPayments::RequestHeader do
  subject { described_class.new }
  let(:request_id) { SecureRandom.uuid }

  before do
    subject.request_id = request_id
  end

  let(:hash) {
    {
      "RequestHeader": {
        "SpecVersion": '1.10',
        "CustomerId": '245294',
        "RequestId": request_id,
        "RetryIndicator":0
      }
    }
  }


  describe 'to_hash' do
    it 'returns the hash representation of the request header' do
      expect(subject.to_hash).to eq(hash)
    end
  end
end
