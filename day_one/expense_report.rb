
MATCHING_SUM = 2020

file = File.open("input.txt")
nums = file.readlines.map(&:chomp).map(&:to_i)
file.close

output = nil

nums.combination(2) do |pair|
  first_num, second_num = pair
  if first_num + second_num == MATCHING_SUM
    output = first_num * second_num
    break
  end
end

puts output
