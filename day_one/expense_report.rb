MATCHING_SUM = 2020

file = File.open("input.txt")
nums = file.readlines.map(&:chomp).map(&:to_i)
file.close

nums.combination(2) do |pair|
  first_num, second_num = pair
  if first_num + second_num == MATCHING_SUM
    output = first_num * second_num
    break
  end
end

def fetch_nums_from_input(file_name)
  file = File.open(file_name)
  content = file.readlines.map(&:chomp).map(&:to_i)
  file.close
  return content
end

def product_of_pairs_with_matching_sum(nums)
  output = nil
  nums.combination(2) do |pair|
    first_num, second_num = pair
    if first_num + second_num == MATCHING_SUM
      output = first_num * second_num
      break
    end
  end
end

def product_of_triplets_with_matching_sum(nums)
  output = nil
  nums.combination(3) do |triplet|
    first_num, second_num, third_num = triplet
    if first_num + second_num + third_num == MATCHING_SUM
      output = first_num * second_num * third_num
      break
    end
  end

  output
end

nums = fetch_nums_from_input "input.txt"
puts product_of_triplets_with_matching_sum(nums)

