require_relative "../enumerables"

describe '#my_each' do
  it 'should execute each element in an array when block is given' do
    range = Array(1..6)
    array = []
    range.my_each { |x| array << x }
    expect(array).to eq(range)
  end
end