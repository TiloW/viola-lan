require_relative 'classes/Instance'

# this sample is given by Petering et. al. in
# "A new mixed integer program and extended look-ahead heuristic algorithm for the block relocation problem"
# see Fig 2

# (i) LA-1 with unlimited stack size
puts 'LA-1'
puts '*****'
instance = Instance.new Float::INFINITY, [
  [6,7,9],
  [1,3,4],
  [2,8,5]
]
puts instance.solve(1) # expected to contain 16 actions

# (ii) LA-2 with unlimited stack size
puts ''
puts 'LA-2'
puts '*****'
instance = Instance.new Float::INFINITY, [
  [6,7,9],
  [1,3,4],
  [2,8,5]
]
puts instance.solve(2) # expected to contain 15 actions

# (iii) LA-2 with stack size limited to 5
puts ''
puts 'LA-2 with limited stack height'
puts '*******************************'
instance = Instance.new 5, [
  [6,7,9],
  [1,3,4],
  [2,8,5]
]
puts instance.solve(2) # expected to contain 17 actions
