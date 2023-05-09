require 'rails_helper'
RSpec.describe Orders::CheckValidCodes do
  describe '#call' do
    let(:valid_codes) { %w[IMG FLAC VID] }

    context 'when hash_submission_format is nil' do
      it 'returns false' do
        checker = Orders::CheckValidCodes.new(nil)
        expect(checker.call).to eq(false)
      end
    end

    context 'when all codes are valid' do
      it 'returns true' do
        hash_submission_format = { 'IMG' => 10, 'FLAC' => 15 }
        checker = Orders::CheckValidCodes.new(hash_submission_format)
        allow(checker).to receive(:valid_codes).and_return(valid_codes)
        expect(checker.call).to eq(true)
      end
    end

    context 'when some codes are invalid' do
      it 'returns false' do
        hash_submission_format = { 'IMG' => 10, 'FLAC' => 15, 'INVALID' => 5 }
        checker = Orders::CheckValidCodes.new(hash_submission_format)
        allow(checker).to receive(:valid_codes).and_return(valid_codes)
        expect(checker.call).to eq(false)
      end
    end

    context 'when all codes are invalid' do
      it 'returns false' do
        hash_submission_format = { 'INVALID1' => 10, 'INVALID2' => 15 }
        checker = Orders::CheckValidCodes.new(hash_submission_format)
        allow(checker).to receive(:valid_codes).and_return(valid_codes)
        expect(checker.call).to eq(false)
      end
    end
  end
end
