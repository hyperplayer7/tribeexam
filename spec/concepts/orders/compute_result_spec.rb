require 'rails_helper'

RSpec.describe Orders::ComputeResult do

  before do
    Bundle.create(code: 'IMG', quantity: 5, price: 450.00)
    Bundle.create(code: 'IMG', quantity: 10, price: 800.00)
    Bundle.create(code: 'Flac', quantity: 3, price: 427.50)
    Bundle.create(code: 'Flac', quantity: 6, price: 810.00)
    Bundle.create(code: 'Flac', quantity: 9, price: 1147.50)
    Bundle.create(code: 'VID', quantity: 3, price: 570.00)
    Bundle.create(code: 'VID', quantity: 5, price: 900.00)
    Bundle.create(code: 'VID', quantity: 9, price: 1530.00)
  end

  describe '#initialize' do
    context 'with nil submission format' do
      it 'return a string called Invalid Code' do
        result = Orders::ComputeResult.new(nil)
        expect(result.call).to eq('Invalid codes')
      end
    end

    context 'with non-nil submission format' do
      it 'does not raise an error' do
        expect do
          Orders::ComputeResult.new('10 IMG 15 FLAC 13 VID')
        end.not_to raise_error
      end
    end
  end

  describe '#call' do
    it 'returns the submission format' do
      result = Orders::ComputeResult.new('10 IMG 15 FLAC 13 VID')
      allow(result).to receive(:all_codes_are_valid).and_return(true)
      expect(result.call).to eq("10 IMG $800.00\n - 1 x 10 $800.00\n15 FLAC $1957.50\n - 1 x 9 $1147.50\n - 1 x 6 $810.00\n13 VID $2370.00\n - 2 x 5 $1800.00\n - 1 x 3 $570.00\n")
    end
  end
end
