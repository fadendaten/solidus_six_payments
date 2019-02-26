require "spec_helper"

RSpec.describe SolidusSixPayments::Terminal do
  subject { described_class.new }

  let(:hash) {
    {
      "TerminalID": '17925560'
    }
  }

  describe 'to_hash' do
    it 'returns the hash representation of the terminal id' do
      expect(subject.to_hash).to eq(hash)
    end
  end
end
