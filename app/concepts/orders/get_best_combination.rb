class Orders::GetBestCombination
  def initialize(format_code, quantity)
    @format_code = format_code
    @quantity = quantity
    @best_combination = nil
  end

  def call
    return {} if @quantity.blank? || @quantity < 1

    # Generate all possible combinations of bundles, allowing repeats
    # Use recursion to handle bundles of any length
    generate_combinations = lambda do |t, i, c|
      return if @best_combination && c.length >= @best_combination.length

      if i == bundle_quantity_array.length
        @best_combination = c if t.zero? && (@best_combination.nil? || c.length < @best_combination.length)
      else
        max_count = t / bundle_quantity_array[i]
        max_count.downto(0) do |n|
          generate_combinations.call(t - n * bundle_quantity_array[i], i + 1, c + [n])
        end
      end
    end

    generate_combinations.call(@quantity, 0, [])

    final_hash
  end

  private

  def bundles
    @bundles ||= Bundle.where('lower(code) = ?', @format_code.downcase).sort_by(&:quantity).reverse
  end

  def bundle_quantity_array
    @bundle_quantity_array ||= bundles.map(&:quantity)
  end

  def final_hash
    return {} if @best_combination.blank?

    breakdown = []
    @best_combination.zip(bundle_quantity_array).flat_map do |n, p|
      next if n.zero?

      breakdown << { 'count' => n, 'price' => bundles[bundle_quantity_array.index(p)].price,
                     'quantity' => bundles[bundle_quantity_array.index(p)].quantity }
    end

    {
      'best_combination' => @best_combination,
      'code' => @format_code.upcase,
      'breakdown' => breakdown
    }
  end
end
