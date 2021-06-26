require_relative "../enumerables"

describe '#my_each' do
    range = Array(1..6)
    array = []
  it 'should execute each element in an array when block is given' do
    range.my_each { |x| array << x }
    expect(array).to eq(range)
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

  it 'should return an enumerator if no block is given' do
    expect(range.my_each).to be_a(Enumerator)
  end
end