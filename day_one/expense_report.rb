MATCHING_SUM = 2020

def fetch_nums_from_input(file_name)
  file = File.open(file_name)
  content = file.readlines.map(&:chomp).map(&:to_i)
  file.close
  content
end

def product_of_sets_with_matching_sum(nums, set_size = 2)
  nums.combination(set_size) do |set|
    return(set.reduce(&:*)) if set.sum == MATCHING_SUM
  end
  nil
end

nums = fetch_nums_from_input 'input.txt'
puts product_of_sets_with_matching_sum(nums, 3)
