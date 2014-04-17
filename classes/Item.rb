require_relative 'Stack'

# Item with associated order and a stack.
# While the item does not assert it is located in the supplied stack,
# one should only give a stack in the constructor the item will actually
# be added to.
# Can be compared by its order.
#
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

  def to_s
    "Item #{@order}"
  end
end