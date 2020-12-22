active_search_space = []
nums = []
File.open("input.txt").each.with_index do |line, idx|
  if idx < 25
    active_search_space << line.to_i
    nums << line.to_i
  else
    nums << line.to_i
  end
end

invalid_number = nil
nums[25..-1].each do |num|
  is_valid = false
  active_search_space.combination(2).each do |pair|
    if pair.sum == num
      is_valid = true
      break
    end
  end

  if is_valid
    active_search_space.delete_at(0)
    active_search_space.push(num)
  else
    invalid_number = num
    break
  end
end

puts invalid_number

nums[0..-2].each.with_index do |num, idx|
  num_set = []
  sum = num
  is_contiguous = false
  nums[idx + 1 .. -1].each  do |consecutive_num|
    num_set << consecutive_num
    sum += consecutive_num
    if sum == invalid_number
      is_contiguous = true
    elsif sum > invalid_number
      break
    end
  end

  if is_contiguous
    puts num_set.min + num_set.max
  end
end
