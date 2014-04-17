require_relative 'classes/Instance'

puts 'LA-1'
puts '*****'
instance = Instance.new 4, [
  [4,3,1,5],
  [2,6,7,8],
  []
]
actions = instance.solve(1)
puts "number of actions: #{actions.size}"
puts actions

puts ''
puts 'LA-2'
puts '*****'
instance = Instance.new 4, [
  [4,3,1,5],
  [2,6,7,8],
  []
]
actions = instance.solve(2)
puts "number of actions: #{actions.size}"
puts actions