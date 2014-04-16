require_relative '../classes/Item'

describe Item do
  it 'requires a valid stack' do
    expect{ Item.new nil, 1 }.to raise_error
  end

  it 'requires a valid order' do
    expect{ Item.new Stack.new, "asdasd" }.to raise_error
  end

  it 'can be queried' do
    stack = Stack.new 'myStack', 1, []
    item = Item.new stack, 1

    expect(item.getOrder).to eq 1
    expect(item.getStack).to eq stack
  end

  it 'is comparable' do
    stack = Stack.new 'myStack', 2, []
    itemA = Item.new stack, 1
    itemB = Item.new stack, 2

    expect(itemA).to be < itemB
  end
end
