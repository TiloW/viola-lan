require_relative 'Item'

class Stack
  def initialize(name, maxItemCount, itemArray)
    raise ArgumentError, 'item array length exceeds maximum number of items' if maxItemCount < itemArray.size
    @maxItemCount = maxItemCount
    @name = name
    @items = []
    itemArray.each do |i|
      @items.push Item.new(self, i)
    end
  end

  def getLowestItem
    if isEmpty
      nil
    else
      @items.min
    end
  end

  def getItemCount
    @items.size
  end

  def getTop
    @items[-1]
  end

  def isEmpty
    getItemCount == 0
  end

  def isFull
    getItemCount >= @maxItemCount
  end

  def pop
    @items = @items[0..-2]
  end

  def push(item)
    raise ArgumentError, 'cannot push item on current stack' if item.getStack == self
    rause ArgumentError, 'cannot relocate a item which is not on top of some other stack' unless item.getStack.getTop == item
    item.getStack.pop
    @items.push item
    item.setStack self
  end

  def getItems
    @items.dup
  end

  def to_s
    "Stack #{@name}"
  end
end