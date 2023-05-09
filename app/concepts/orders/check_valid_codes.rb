class Orders::CheckValidCodes
  def initialize(hash_submission_format)
    @hash_submission_format = hash_submission_format
  end

  def call
    return false unless @hash_submission_format

    user_codes = @hash_submission_format.keys
    user_codes.all? { |code| valid_codes.include?(code) }
  end

  private

  def valid_codes
    @valid_codes ||= Bundle.distinct.pluck(:code).map(&:upcase)
  end
end
