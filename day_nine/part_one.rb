active_search_space = []
nums = []
File.open("input.txt").each.with_index do |line, idx|
  if idx < 25
    active_search_space << line.to_i
  else
    nums << line.to_i
  end
end

nums.each do |num|
  is_valid = false
  active_search_space.combination(2).each do |pair|
    if pair.sum == num
      is_valid = true
      break
    end
  end

  if is_valid
    puts "#{num} -- Valid"
    active_search_space.delete_at(0)
    active_search_space.push(num)
  else
    puts "#{num} -- INValid"
    break
  end
end
