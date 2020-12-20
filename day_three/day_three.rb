map = []

File.open("input.txt").each do |line|
  map << line.chomp.chars.map { |sym| sym == "#" }
end

def count_trees_with_traversal_strategy(right: 3, bottom: 1, map:)
  curr_row, curr_col = 0, 0
  num_trees = 0

  num_rows = map.length
  num_cols = map[0].length


  while true do
    next_col = curr_col + right
    next_col -= num_cols if next_col >= num_cols
    next_row = curr_row + bottom
    break if next_row >= num_rows
    num_trees += 1 if map[next_row][next_col]
    curr_col = next_col
    curr_row = next_row
  end

  num_trees
end

strats = [
  count_trees_with_traversal_strategy(right: 1, bottom: 1, map: map),
  count_trees_with_traversal_strategy(right: 3, bottom: 1, map: map),
  count_trees_with_traversal_strategy(right: 5, bottom: 1, map: map),
  count_trees_with_traversal_strategy(right: 7, bottom: 1, map: map),
  count_trees_with_traversal_strategy(right: 1, bottom: 2, map: map)
]

puts strats.inspect
puts strats.reduce(&:*)
