require_relative '../classes/Stack'
require_relative '../classes/Item'

describe Stack do
  it 'can not be constructed with too many items' do
    expect{ Stack.new 'my Stack', 1, [1,2] }.to raise_error
  end

  it 'supports simple queries' do
    stack = Stack.new 'my Stack', 5, [1,2,4,3]

    expect(stack.getTop.getOrder).to eq 3
    expect(stack.getItemCount).to eq 4
    expect(stack.getLowestItem.getOrder).to eq 1
    expect(stack.isFull).to eq false
    expect(stack.isEmpty).to eq false
  end

  it 'can relocate items' do
    stack = Stack.new 'my Stack', 5, [2,4,3]
    stack2 = Stack.new 'my second Stack', 1, [1]
    item = stack2.getTop
    stack.push item

    expect(stack.getItemCount).to eq 4
    expect(stack2.isEmpty).to eq true
    expect(item.getStack).to eq stack
  end

  it 'can not relocate its own items' do
    stack = Stack.new 'my Stack', 5, [2,4,3]
    expect{ stack.push stack.getTop }.to raise_error
  end

  it 'can be accessed from its items' do
    stack = Stack.new 'my Stack', 5, [2,4,3]
    expect(stack.getTop.getStack).to eq stack
  end

  it 'can remove the top item' do
    stack = Stack.new 'my Stack', 5, [2,4,3]
    stack.pop
    expect(stack.getTop.getOrder).to eq 4
    expect(stack.getItemCount).to eq 2
    stack.pop
    expect(stack.getTop.getOrder).to eq 2
    expect(stack.getItemCount).to eq 1
  end

  it 'can not relocate any item not on top' do
    stack = Stack.new 'my Stack', 5, [2,4,3]
    stack2 = Stack.new 'my second Stack', 2, [1]
    expect{ stack2.push stack.getLowestItem }.to raise_error
  end
end
