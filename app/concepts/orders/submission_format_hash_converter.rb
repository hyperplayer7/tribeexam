class Orders::SubmissionFormatHashConverter
  def initialize(submission_format)
    @submission_format = submission_format
    @results = {}
  end

  def call
    return {} unless @submission_format

    @submission_format.split.each_slice(2) do |count, code|
      code = code.upcase unless code.blank?
      @results[code] ||= 0
      @results[code] += count.to_i
    end

    @results
  end
end
