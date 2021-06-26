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