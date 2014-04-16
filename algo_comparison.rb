require_relative 'classes/Instance'

def generateRandomInstance
  maxItemCount = rand(2..4)
  numberOfStacks = rand(2..maxItemCount*2)
  numberOfItems = rand(numberOfStacks..(numberOfStacks-0.8)*maxItemCount)
  items = []
  for i in 1..numberOfItems do
    items.push i
  end
  items.shuffle!
  stacks = []
  itemIndex = 1
  for i in 1..numberOfStacks do
    stack = []

    while stack.size < maxItemCount && !items.empty?
      stack.push items.pop
    end

    stacks.push stack
  end
  instance = Instance.new maxItemCount, stacks
end

if ARGV[0].to_i < 1
  puts "You need to supply an integer greater than 0 as the first argument."
  print "This will be used to determine the number of times the program"
  puts "generates a random instance and compares both algorithms. "
else
  bestInstanceDesc = nil
  bestValue = -Float::INFINITY

  for i in 0..ARGV[0].to_i
    instance = generateRandomInstance
    instanceCopy =  Marshal.load Marshal.dump instance
    instanceDesc = instance.to_s
    value = instance.solve(1).to_f / instanceCopy.solve(3)
    if value > bestValue
      bestValue = value
      bestInstanceDesc = instanceDesc
    end
  end

  puts "Found an instance with an improvement of #{bestValue}:"
  puts bestInstanceDesc
end