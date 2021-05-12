module Enumerables

  def my_each
    return to_enum unless block_given?

    for i in 0..self.length
      yield(self[i])
    end
  end

  def my_each_with_index
    return to_enum unless block_given?
    my_index = 0
    self.my_each do |i|
      yield i, my_index
      my_index += 1
    end
  end

  def my_select
    my_arr = []
    self.my_each{ |x| my_arr << x if yield(x) }
    my_arr
  end

    def my_all?
      self.my_each do |index|
        return true unless block_given?
        true_false = yield(index)
        return false unless true_false
      end
      true
    end

  def my_any?(arg = nil, &block)
    if block_given? || arg.nil?
      helper = block_given? ? block : proc { |x| x }
      my_each { |x| return true if helper.call(x) }
    else
      my_each { |x| return true if check_pattern?(x, arg) }
    end
  false
  end

  def my_none?(arg = nil)
    my_each do |y|
      return false if block_given? && yield(y) || !block_given? && y
    end
    true
  end

  def my_count(arg = nil, &block)
    return my_count { |y| y == arg} unless arg.nil?
    return (my_count { |_y| true}) unless block_given?

    my_select(&block).length
  end

  def my_map(&block)
    map_arr = []
    self.my_each do |i|
      map_arr.push(block.call(i))
    end
    map_arr
  end

  def my_inject(number = nil, sym = nil)
    if block_given?
      accumulator = number
      my_each { |index| accumulator = accumulator.nil? ? index : yield(accumulator, index) }
      raise LocalJumpError unless block_given? || !sym.empty? || !number.empty?

      accumulator
    elsif !number.nil? && (number.is_a?(Symbol) || number.is_a?(String))
      raise LocalJumpError unless block_given? || !number.empty?

      accumulator = nil
      my_each { |index| accumulator = accumulator.nil? ? index : accumulator.send(number, index) }
      accumulator
    elsif !sym.nil? && (sym.is_a?(Symbol) || sym.is_a?(String))
      raise LocalJumpError unless block_given? || !sym.empty?

      accumulator = number
      my_each { |index| accumulator = accumulator.nil? ? index : accumulator.send(sym, index) }
      accumulator
    else
      raise LocalJumpError
    end
  end

  def multiply_els(array = [])
    array.my_inject { |x, y| x * y }
  end
end
