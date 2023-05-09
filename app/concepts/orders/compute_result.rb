class Orders::ComputeResult
  def initialize(submission_format)
    @submission_format = submission_format
    @results = []
  end

  def call
    return 'Invalid codes' unless all_codes_are_valid && @submission_format

    hash_submission_format.each do |format_code, quantity|
      @results << Orders::GetBestCombination.new(format_code, quantity).call
    end

    Orders::OutputFormatter.new(@results).call
  end

  private

  def all_codes_are_valid
    @all_codes_are_valid ||= Orders::CheckValidCodes.new(hash_submission_format).call
  end

  def hash_submission_format
    @hash_submission_format ||= Orders::SubmissionFormatHashConverter.new(@submission_format).call
  end
end
