require 'rails_helper'

RSpec.describe Orders::SubmissionFormatHashConverter do
  describe '#call' do
    context 'when submission format is valid' do
      let(:submission_format) { '10 IMG 15 FLAC 13 VID' }

      it 'returns a hash with the correct count for each code' do
        expected_result = { 'IMG' => 10, 'FLAC' => 15, 'VID' => 13 }
        converter = Orders::SubmissionFormatHashConverter.new(submission_format)

        expect(converter.call).to eq(expected_result)
      end
    end

    context 'when submission format has extra whitespace' do
      let(:submission_format) { ' 10 IMG  15 FLAC   13 VID ' }

      it 'returns a hash with the correct count for each code' do
        expected_result = { 'IMG' => 10, 'FLAC' => 15, 'VID' => 13 }
        converter = Orders::SubmissionFormatHashConverter.new(submission_format)

        expect(converter.call).to eq(expected_result)
      end
    end

    context 'when submission format contains a mix of uppercase and lowercase codes' do
      let(:submission_format) { '10 IMG 15 fLaC 13 vid' }

      it 'returns a hash with the correct count for each code (all uppercase)' do
        expected_result = { 'IMG' => 10, 'FLAC' => 15, 'VID' => 13 }
        converter = Orders::SubmissionFormatHashConverter.new(submission_format)

        expect(converter.call).to eq(expected_result)
      end
    end

    context 'when submission format contains a repeating code' do
      let(:submission_format) { '10 IMG 15 FLAC 13 VID 13 vid' }

      it 'returns a hash of submission formats with uppercase codes and adds the similar codes' do
        expected_output = { 'IMG' => 10, 'FLAC' => 15, 'VID' => 26 }
        converter = Orders::SubmissionFormatHashConverter.new(submission_format)

        expect(converter.call).to eq(expected_output)
      end
    end

    context 'when submission format is nil' do
      let(:submission_format) { nil }

      it 'returns an empty hash' do
        expected_output = {}
        converter = Orders::SubmissionFormatHashConverter.new(submission_format)

        expect(converter.call).to eq(expected_output)
      end
    end
  end
end
