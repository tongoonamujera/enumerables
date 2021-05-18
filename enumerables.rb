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
      to_enum
    end

  def my_any?(elem = 0)
    unless block_given?
      if elem.instance_of?(Class)
        my_each { |x| return true if x.is_a? elem }
      elsif elem.instance_of?(Regexp)
        my_each { |x| return true if elem.match?(x.to_s) }
      elsif [nil, false].include?(elem)
        my_each { |x| return true if x == elem }
      end
      return false
    end
    my_each { |x| return true if yield(x) }
    false
  end

  def my_none?
    my_each do |y|
      return false if block_given? && yield(y) || !block_given? && y
    end
    true
    to_enum
  end

  def my_count(*arg)
    result = 0
    unless block_given?
      if include?(arg)
        my_each { |x| result += 1 if x == arg }
        return result
      end
      return arg.length
    end
    my_each { |x| result += 1 if yield(x) }
    result
  end

  def my_map(&block)
    map_arr = []
    self.my_each do |i|
      map_arr.push(block.call(i))
    end
    map_arr
    to_enum
  end

  def my_inject(accumulator = nil, operator = nill, &block)
    if !block
      if operator.nil?
        operator = accumulator
        acumulator = nil
      end
      operator.to_sym
      each { |itm| accumulator = accumulator.nil? ? itm : accumulator.send(operator, itm) }
    else
      each { |itm| accumulator = accumulator.nil? ? itm : block.call(accumulator, itm) }
    end
    accumulator
  end

  def multiply_els(array = [])
    array.my_inject(:*)
  end
end
