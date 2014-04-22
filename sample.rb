require_relative 'classes/Instance'

puts 'LA-1'
puts '*****'
instance = Instance.new 4, [
  [6,3,1,4],
  [2,5,7,8],
  []
]
actions = instance.solve(1)
puts "number of actions: #{actions.size}"
puts actions

puts ''
puts 'LA-2'
puts '*****'
instance = Instance.new 4, [
  [6,3,1,4],
  [2,5,7,8],
  []
]
actions = instance.solve(2)
puts "number of actions: #{actions.size}"
puts actions