require "spec_helper"

RSpec.describe SolidusSixPayments::ReturnUrls do
  subject { described_class.new }

  let(:hash) {
    {
      'ReturnUrls': {
        'success': 'http://localhost:3004',
        'fail': 'http://localhost:3004'
      }
    }
  }

  describe 'to_hash' do
    it 'returns the hash representation of the return_urls' do
      expect(subject.to_hash).to eq(hash)
    end
  end
end
