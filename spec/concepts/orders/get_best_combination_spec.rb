require 'rails_helper'

RSpec.describe Orders::GetBestCombination do
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

  describe '#call' do
    context 'actual exam samples' do
      it 'returns the best combination for the requested IMG format and quantity' do
        format_code = 'IMG'
        quantity = 10
        expected_result = {
          'best_combination' => [1, 0],
          'code' => 'IMG',
          'breakdown' => [
            { 'count' => 1, 'price' => 800.0, 'quantity' => 10 }
          ]
        }

        result = Orders::GetBestCombination.new(format_code, quantity).call

        expect(result).to eq(expected_result)
      end

      it 'returns the best combination for the requested FLAC format and quantity' do
        format_code = 'FLAC'
        quantity = 15
        expected_result = {
          'best_combination' => [1, 1, 0],
          'code' => 'FLAC',
          'breakdown' => [
            { 'count' => 1, 'price' => 1147.50, 'quantity' => 9 },
            { 'count' => 1, 'price' => 810.00, 'quantity' => 6 }
          ]
        }

        result = Orders::GetBestCombination.new(format_code, quantity).call

        expect(result).to eq(expected_result)
      end

      it 'returns the best combination for the requested VID format and quantity' do
        format_code = 'VID'
        quantity = 13
        expected_result = {
          'best_combination' => [0, 2, 1],
          'code' => 'VID',
          'breakdown' => [
            { 'count' => 2, 'price' => 900.00, 'quantity' => 5 },
            { 'count' => 1, 'price' => 570.00, 'quantity' => 3 }
          ]
        }

        result = Orders::GetBestCombination.new(format_code, quantity).call

        expect(result).to eq(expected_result)
      end
    end

    context 'with valid input' do
      it 'returns the best combination for the requested format and quantity' do
        format_code = 'IMG'
        quantity = 15
        expected_result = {
          'best_combination' => [1, 1],
          'code' => 'IMG',
          'breakdown' => [
            { 'count' => 1, 'price' => 800.0, 'quantity' => 10 },
            { 'count' => 1, 'price' => 450.0, 'quantity' => 5 }
          ]
        }

        result = Orders::GetBestCombination.new(format_code, quantity).call

        expect(result).to eq(expected_result)
      end

      it 'returns an empty hash when there is no best combination' do
        format_code = 'FLAC'
        quantity = 7
        expected_result = {}

        result = Orders::GetBestCombination.new(format_code, quantity).call

        expect(result).to eq(expected_result)
      end

      it 'uniform cases the format code before processing' do
        format_code = 'img'
        quantity = 15
        expected_result = {
          'best_combination' => [1, 1],
          'code' => 'IMG',
          'breakdown' => [
            { 'count' => 1, 'price' => 800.0, 'quantity' => 10 },
            { 'count' => 1, 'price' => 450.0, 'quantity' => 5 }
          ]
        }

        result = Orders::GetBestCombination.new(format_code, quantity).call

        expect(result).to eq(expected_result)
      end

      it 'returns the correct result when only one bundle is needed' do
        format_code = 'FLAC'
        quantity = 3
        expected_result = {
          'best_combination' => [0, 0, 1],
          'code' => 'FLAC',
          'breakdown' => [
            { 'count' => 1, 'price' => 427.50, 'quantity' => 3 }
          ]
        }

        result = Orders::GetBestCombination.new(format_code, quantity).call
        expect(result).to eq(expected_result)
      end

      it 'returns the correct result when multiple bundles are needed' do
        format_code = 'IMG'
        quantity = 10
        expected_result = {
          'best_combination' => [1, 0],
          'code' => 'IMG',
          'breakdown' => [
            { 'count' => 1, 'price' => 800.0, 'quantity' => 10 }
          ]
        }

        result = Orders::GetBestCombination.new(format_code, quantity).call
        expect(result).to eq(expected_result)
      end

      it 'returns the correct result when multiple bundles of different sizes are needed' do
        format_code = 'VID'
        quantity = 13
        expected_result = {
          'best_combination' => [0, 2, 1],
          'code' => 'VID',
          'breakdown' => [
            { 'count' => 2, 'price' => 900.0, 'quantity' => 5 },
            { 'count' => 1, 'price' => 570.0, 'quantity' => 3 }
          ]
        }

        result = Orders::GetBestCombination.new(format_code, quantity).call
        expect(result).to eq(expected_result)
      end
    end

    context 'with invalid input' do
      it 'returns an empty hash when format code is not found' do
        format_code = 'INVALID'
        quantity = 10
        expected_result = {}

        result = Orders::GetBestCombination.new(format_code, quantity).call

        expect(result).to eq(expected_result)
      end

      it 'returns an empty hash when quantity is negative' do
        format_code = 'IMG'
        quantity = -5
        expected_result = {}

        result = Orders::GetBestCombination.new(format_code, quantity).call
        expect(result).to eq(expected_result)
      end

      it 'returns an empty hash when quantity is zero' do
        format_code = 'IMG'
        quantity = 0
        expected_result = {}

        result = Orders::GetBestCombination.new(format_code, quantity).call
        expect(result).to eq(expected_result)
      end
    end
  end
end
