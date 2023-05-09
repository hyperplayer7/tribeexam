class Orders::OutputFormatter
  def initialize(results)
    @results = results
    @output = ''
  end

  def call
    return @output if @results.blank?

    @results.each do |result|
      breakdown = result['breakdown']
      total_count = breakdown.sum { |b| b['count'] * b['quantity'] }
      code = result['code']
      total_price = breakdown.sum { |b| b['count'] * b['price'] }

      @output << "#{total_count} #{code} $#{'%.2f' % total_price}\n"
      breakdown.each do |bd|
        @output << " - #{bd['count']} x #{bd['quantity']} $#{format('%.2f', (bd['count'] * bd['price']))}\n"
      end
    end
    @output
  end
end
