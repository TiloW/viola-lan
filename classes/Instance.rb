require_relative 'Stack'

# Class for describing an instance of the BRP.
# Also holds the LA-N algorithm for solving it.
#
class Instance
  def initialize(maxItemCount, stackArray)
    raise ArgumentError, 'there can only be one item with a specific order' unless stackArray.flatten.uniq.size == stackArray.flatten.size
    @maxItemCount = maxItemCount
    @stacks = []
    stackArray.each_with_index do |s,i|
      @stacks.push Stack.new(i+1, maxItemCount, s)
    end
  end

  def solve(lookAhead = 1)
    actions = []
    raise ArgumentError, 'parameter lookAhead must at least 1' if lookAhead < 1

    relocCounter = 0
    while countItems > 0 do
      # Step 1
      nextItem = getNextItem
      if nextItem.isTop
        nextItem.getStack.pop
        actions.push "retrieving #{nextItem} from stack #{nextItem.getStack}"
      else

        # Step 2
        n = [lookAhead, countItems].min
        n += 1
        # Step 3
        nextItems = nil
        nextStacks = nil
        begin
          n -= 1
          raise RuntimeError, "Look ahead variable too low, this instance does not seem solveable!" if n < 1
          nextItems = getNextNItems(n)
          nextStacks = getStacksOfItems nextItems
          otherStacks = @stacks - nextStacks
          otherStacksNotFull = otherStacks.map{ |s| s.isFull }.include? false
        end while nextStacks.size == @stacks.size || !otherStacksNotFull

        r = 1
        relocateCurrent = false
        until relocateCurrent do

          # Step 4
          topItems = nextStacks.map{ |s| s.getTop }.sort
          currentItem = topItems[-r]
          relocateCurrent = currentItem.getStack == nextItem.getStack

          # Step 5
          relocationStacks = @stacks.dup.keep_if do |stack|
            stack.isEmpty ||
              stack.getLowestItem.getOrder > currentItem.getOrder &&
              !stack.isFull
          end

          relocateCurrent |= !relocationStacks.empty? && currentItem != currentItem.getStack.getLowestItem

          # Step 6
          if relocateCurrent
            targetStack = nil
            if relocationStacks.empty?
              targetStack = @stacks.dup.keep_if{ |s| !s.isFull && s != currentItem.getStack }.sort_by{ |s| s.isEmpty ? Float::INFINITY : s.getLowestItem.getOrder }[-1]
            else
              targetStack = relocationStacks.sort_by{ |s| s.isEmpty ? -Float::INFINITY : s.getLowestItem.getOrder }[0]
            end
            actions.push "relocating #{currentItem} from #{currentItem.getStack} to #{targetStack}"
            targetStack.push currentItem
          else
            r += 1
          end
        end
      end
    end
    actions
  end

  def countItems
    result = 0
    @stacks.each{ |s| result += s.getItemCount }
    result
  end

  def getNextItem
    items = @stacks.map{ |s| s.getLowestItem }.compact

    if items.empty?
      nil
    else
      items.min
    end
  end

  def getNextNItems(n)
    items = @stacks.map{ |s| s.getItems }.flatten.sort
    items[0..n-1]
  end

  def getStacksOfItems(items)
    stacks = []
    items.each do |item|
      stacks.push item.getStack
    end
    stacks.uniq
  end

  def to_s
    result ="Instance with a maximum of #{@maxItemCount} items per stack:"
    @stacks.each do |stack|
      result += "\n #{stack.getItems}"
    end
    result
  end
end
