module Enumerable

  def my_each
    return to_enum(:my_each) unless block_given?

    size.times do |x|
      yield to_a[x]
    end
    self
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
    return to_enum(:my_select) unless block_given?

    my_arr = []
    self.my_each{ |x| my_arr << x if yield(x) }
    my_arr
  end

    def my_all?
      return to_enum(:my_all?) unless block_given?

      self.my_each do |index|
        return true unless block_given?
        true_false = yield(index)
        return false unless true_false
      end
      true
    end

  def my_any?(elem = 0)
    return to_enum(:my_any?) unless block_given?

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
    return to_enum(:my_none?) unless block_given?

    my_each do |y|
      return false if block_given? && yield(y) || !block_given? && y
    end
    true
  end

  def my_count(*arg)
    return to_enum(:my_count) unless block_given?

    result = 0
    unless block_given?
      if result.include?(arg)
        my_each { |x| result += 1 if x == arg }
        return result
      end
      return arg.length
    end
    my_each { |x| result += 1 if yield(x) }
    result
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    mapped_arr = []
    my_each { |x| mapped_arr << yield(x) if yield(x) != 0 } and return mapped_arr if block_given?
    to_enum
  end

  def my_inject(*arg)
    new_array = to_a
    total = arg[0]
    if arg[0].instance_of?(Symbol)
      total = new_array[0]
      new_array = new_array[1..-1]
      new_array.my_each { |x| total = total.send(arg[0], x) }
    elsif arg[0].class < Numeric && arg[1].class != Symbol
      new_array.my_each { |x| total = yield(total, x) }
    elsif arg[0].class < Numeric && arg[1].instance_of?(Symbol)
      new_array.my_each { |x| total = total.send(arg[1], x) }
    else
      total = new_array[0]
      new_array = new_array[1..-1]
      new_array.my_each { |x| total = yield(total, x) }
    end
    total
  end
end

def multiply_els(array = [])
  array.my_inject(:*)
end