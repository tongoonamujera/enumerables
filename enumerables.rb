module Enumerables
  def my_each
    count = 0
    while count < self.size do
      yield(self[count])
      count += 1
    end
    self
  end

  def my_each_with_index
    
  end

  def my_select
    my_arr = []
    count = 0
    while count < self .length
      my_arr << (self[count]) if yield(self[count]) == true
      count += 1
    end
    my_arr
  end

  def my_all?
  end

  def my_any?
  end

  def my_none?
  end

  def my_count
  end

  def my_map(&block)
    map_arr = []
    self.my_each do |i|
      map_arr.push(block.call(i))
    end
    map_arr
  end

  def my_inject(thread, &block)
    my_each do |item|
      thread = block.call(thread, item)
    end
    thread
  end
end