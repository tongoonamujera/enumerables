require_relative "../enumerables"

describe '#my_each' do
    range = Array(1..6)
    array = []

    arr = (1...6)

  it 'should execute each element in an array when block is given' do
    range.my_each { |x| array << x }
    expect(array).to eq(range)
  end

  it 'should execute each element in an array when block is given' do
    range.my_each { |x| array << x }
    expect(array).not_to eq(arr)
  end

  it 'should return an enumerator if no block is given' do
    expect(range.my_each).to be_a(Enumerator)
  end
end

describe '#my_each_with_index' do
  test_array = %w(u v x y z)
  array = []

  it 'should return each element according to its index when block is given' do
    test_array.my_each_with_index { |x, index| array[index] = x }
    expect(array).to eq(test_array)
  end

  it 'should return an enumerator if no block is given' do
    expect(test_array.my_each_with_index).to be_a(Enumerator)
  end
end

describe '#my_select' do
  range = Array(1..6)
  array = []

  it 'should return an array in accordance to condition in the block when block is given' do
    range.my_select { |x| array << x if x.odd?}
    expect(array).to eq([1, 3, 5])
  end

  it 'should return an empty array if no matching condition in the block when block is given' do
    expect(range.my_select { |x| x > 7 }).to eq([])
  end

  it 'should return an enumerator if no block is given' do
    expect(range.my_select).to be_a(Enumerator)
  end
end

describe '#my_none?' do
  range = Array(1..6)
  it 'should return false if  condition is met in the block, when block is given' do
    expect(range.my_none? { |x| x < 8 }).to eq(false)
  end

  it 'should return true if  condition is not met in the block, when block is given' do
    expect(range.my_none? { |x| x > 8 }).to eq(true)
  end

  it 'should return false if an array contains a matching  condition to the block, when block is given' do
    expect(range.my_none? { |x| x.odd? }).to eq(false)
  end

  it 'should return an enumerator if no block is given' do
    expect(range.my_none?).to be_a(Enumerator)
  end
end

describe '#my_all?' do
  range = Array(1..6)
  it 'should return true if  condition is met in the block, when block is given' do
    expect(range.my_all? { |x| x.is_a?(Integer) }).to eq(true)
  end

  it 'should return true if  condition met in the block, when block is given' do
    expect(range.my_all? { |x| x < 8 }).to eq(true)
  end

  it 'should return true if  condition met in the block, when block is given' do
    expect(range.my_all? { |x| x <= 6 }).to eq(true)
  end

  it 'should return false if no  condition met in the block, when block is given' do
    expect(range.my_all? { |x| x >= 6 }).to eq(false)
  end

  it 'should return false if  condition is not met in the block, when block is given' do
    expect(range.my_all? { |x| x.is_a?(String) }).to eq(false)
  end

  it 'should return false if  condition is not met in the block, when block is given' do
    expect(range.my_all? { |x| x.is_a?(Float) }).to eq(false)
  end

  it 'should return an enumerator if no block is given' do
    expect(range.my_all?).to be_a(Enumerator)
  end
end

describe '#my_any?' do
  range = Array(1..6)
  array = range << (7.8)

  it 'should return true if any element in an array meet the condition in the block, when block is given' do
    expect(array.my_any? { |x| x.is_a?(Float) }).to eq(true)
  end

  it 'should return false if no any element in an array meet the condition in the block, when block is given' do
    expect(range.my_any? { |x| x.is_a?(String) }).to eq(false)
  end

  it 'should return true if any element in an array matches the condition in the block, when block is given' do
    expect(range.my_any? { |x| x.is_a?(Integer) }).to eq(true)
  end

  it 'should return an enumerator if no block is given' do
    expect(range.my_any?).to be_a(Enumerator)
  end
end

describe '#my_count' do
  range = Array(1..6)
  array = range << (7.8)

  it 'should return the number of element(s) in an array matching the condition in the block, when block is given' do
    expect(array.my_count { |x| x.is_a?(Float) }).to eq(1)
  end

  it 'should return zero if no any element in an array matching the condition in the block, when block is given' do
    expect(range.my_count { |x| x.is_a?(String) }).to eq(0)
  end

  it 'should return zero if no any element in an array matching the condition in the block, when block is given' do
    expect(range.my_count { |x| x.is_a?(String) }).to eq(0)
  end

  it 'should return the number of element(s) in an array matching the condition in the block, when block is given' do
    expect(array.my_count { |x| x > 3 }).to eq(4)
  end

  it 'should return an enumerator if no block is given' do
    expect(range.my_count).to be_a(Enumerator)
  end
end

describe '#my_map' do
  range = Array(1..6)

  it 'should return a new array when basing on the condition of the given block' do
    expect(range.my_map { |x| x * 2 }).to eq([2, 4, 6, 8, 10, 12])
  end

  it 'should return a new array when basing on the condition of the given block' do
    expect(range.my_map { |x| x * 2 }).not_to eq([2, 4, 6, 8, 10, 12, 14])
  end

  it 'should return an enumerator if no block is given' do
    expect(range.my_map).to be_a(Enumerator)
  end
end

describe '#my_inject' do
  range = Array(1..6)

  it 'sum all elements of an Array' do
    expect(range.my_inject(:+)).to eq(21)
  end

  it 'should return sum of all elements in an array starting from parameter given' do
    expect(range.my_inject(5) { |sum, value| sum + value }).to eq(26)
  end

  it 'should return sum of array elements starting from param( when block is not given, starting point & symbol is given)' do
    expect(range.my_inject(5, :+)).to eq(26)
  end

  it 'multiply all elements of the Array' do
    expect(range.my_inject(:*)).to eq(720)
  end

  it ' should multiply all elements in an array starting from parameter given' do
    expect(range.my_inject(5) { |sum, value| sum * value }).to eq(3600)
  end

  it 'should multiply array elements starting from param( when block is not given, starting point & symbol is given)' do
    expect(range.my_inject(5, :*)).to eq(3600)
  end

  it 'should raise LocalJumpError if no block given' do
    expect { range.my_inject }.to raise_error LocalJumpError
  end
end
