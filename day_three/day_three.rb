map = []

File.open("input.txt").each do |line|
  map << line.chomp.chars.map { |sym| sym == "#" }
end

num_trees = 0

num_rows = map.length
num_cols = map[0].length

curr_row, curr_col = 0, 0

while true do
  next_col = curr_col + 3

  if next_col >= num_cols
    next_col -= num_cols
  end

  next_row = curr_row + 1
  break if next_row >= num_rows

  num_trees += 1 if map[next_row][next_col]

  curr_col = next_col
  curr_row = next_row
end

puts num_trees
