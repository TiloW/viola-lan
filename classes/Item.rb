require_relative 'Stack'

class Item
  include Comparable

  def initialize(stack, order)
    raise ArgumentError, "invalid stack object supplied: #{stack}" unless stack.instance_of? Stack
    @stack = stack
    @order = order.to_i
  end

  def <=>(otherItem)
    @order <=> otherItem.getOrder
  end

  def getStack
    @stack
  end

  def setStack(stack)
    @stack = stack
  end

  def getOrder
    @order
  end

  def isTop
    @stack.getTop == self
  end

  def retrieve
    raise ArgumentError, 'item to be retrieved must be top item' unless @stack.getTop == self
    @stack.pop
  end

  def to_s
    "Item #{@order}"
  end
end