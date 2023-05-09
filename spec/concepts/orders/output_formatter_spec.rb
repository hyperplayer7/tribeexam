require 'rails_helper'
RSpec.describe Orders::OutputFormatter do
  describe '#call' do
    let(:results) do
      [
        {
          'code' => 'IMG',
          'breakdown' => [
            { 'count' => 1, 'price' => 800.0, 'quantity' => 10 }
          ]
        },
        {
          'code' => 'FLAC',
          'breakdown' => [
            { 'count' => 1, 'price' => 1147.5, 'quantity' => 9 },
            { 'count' => 1, 'price' => 810.0, 'quantity' => 6 }
          ]
        },
        {
          'code' => 'VID',
          'breakdown' => [
            { 'count' => 2, 'price' => 900.0, 'quantity' => 5 },
            { 'count' => 1, 'price' => 570.0, 'quantity' => 3 }
          ]
        }
      ]
    end

    let(:output_formatter) { Orders::OutputFormatter.new(results) }
    let(:expected_output) do
      "10 IMG $800.00\n - 1 x 10 $800.00\n15 FLAC $1957.50\n - 1 x 9 $1147.50\n - 1 x 6 $810.00\n13 VID $2370.00\n - 2 x 5 $1800.00\n - 1 x 3 $570.00\n"
    end

    it 'returns a formatted string' do
      expect(output_formatter.call).to eq(expected_output)
    end
  end

  context 'when given an empty array of results' do
    let(:results) { [] }
    let(:output_formatter) { Orders::OutputFormatter.new(results) }
    let(:expected_output) { '' }

    it 'returns an empty string' do
      expect(output_formatter.call).to eq(expected_output)
    end
  end

  context 'when given a nil array of results' do
    let(:results) { nil }
    let(:output_formatter) { Orders::OutputFormatter.new(results) }
    let(:expected_output) { '' }

    it 'returns an empty string' do
      expect(output_formatter.call).to eq(expected_output)
    end
  end
end
