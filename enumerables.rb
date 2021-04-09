module Enumerables

  def my_each
    count = 0
    while count < self.size
      yield(self[count])
      count += 1
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
    my_arr = []
    count = 0
    while count < self.length
      my_arr << (self[count]) if yield(self[count]) == true
      count += 1
    end
    my_arr
  end

  def my_all?(arg = nil, &block)
    if block_given? || arg.nil?
      helper = block_given? ? block : proc { |x| x }
      my_each { |x| return false if helper.call(x) }
    else
      my_each { |x| return false if check_pattern?(x, arg) }
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
    if block_given?
      my_each { |y| return false if yield(y)}
      return true
    end
    unless arg.nil?
      my_each { |y| return false if check_pattern?(y, arg) }
      return true
    end
    !my_any?
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

  def my_inject(accumulator = nil, operation = nil, &block)
    if accumulator.nil? && operation.nil? && block.nil?
      raise ArgumentError, "you must provide an operation or a block"
    end
  
    if operation && block
      raise ArgumentError, "you must provide either an operation symbol or a block, not both"
    end
  
    if operation.nil? && block.nil?
      operation = accumulator
      accumulator = nil
    end
  
    block = case operation
      when Symbol
        lambda { |acc, value| acc.send(operation, value) }
      when nil
        block
      else
      raise ArgumentError, "the operation provided must be a symbol"
    end
  
    if accumulator.nil?
      ignore_first = true
      accumulator = first
    end
  
    index = 0
  
    each do |element|
      unless ignore_first && index == 0
        accumulator = block.call(accumulator, element)
      end
      index += 1
    end
    accumulator
  end

  def multiply_els(array = [])
    array.my_inject { |x, y| x * y }
  end

end
