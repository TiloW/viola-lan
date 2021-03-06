require_relative '../classes/Instance'

describe Instance do
  before(:each) do
    stacks = [
      [6,7,9],
      [1,3,4],
      [2,8,5]
    ]
    @instanceA = Instance.new Float::INFINITY, stacks
    @instanceB = Instance.new 5, stacks
    @instanceC = Instance.new 4, [
      [6,3,1,4],
      [2,5,7,8],
      []
    ]
  end

  it 'can not hold multiple items with the same order' do
    expect{ Instance.new Float::INFINITY, [[1,2],[3,2]] }.to raise_error
  end

  it 'can apply LA-1' do
    expect(@instanceA.solve(1).size).to eq 16
    expect(@instanceB.solve(1).size).to eq 16
    expect(@instanceC.solve(1).size).to eq 17
  end

  it 'can apply LA-2' do
    expect(@instanceA.solve(2).size).to eq 15
    expect(@instanceB.solve(2).size).to eq 17
    expect(@instanceC.solve(2).size).to eq 12
  end

  it 'can apply LA-3' do
    expect(@instanceA.solve(3).size).to eq 15
    expect(@instanceB.solve(3).size).to eq 17
    expect(@instanceC.solve(3).size).to eq 12
  end
end
