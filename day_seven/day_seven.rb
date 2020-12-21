bag_rule_base = {}

File.open("input.txt").each do |line|
  parent_bag, child_bags =line.chomp.split(' contain ')
  parent_bag = parent_bag.split(' ')[0..1].join(' ')
  if child_bags.include? 'no other bags'
    bag_rule_base[parent_bag] = nil
  else
    bag_rule_base[parent_bag] = child_bags.split(', ').map do |child|
      words = child.split(' ')
      { quantity:  words[0], color: words[1..2].join(' ') }
    end
  end
end

inverted_bag_rule_base = Hash.new()

bag_rule_base.each do |col, vals|
  next unless vals
  vals.each do |val|
    if inverted_bag_rule_base[val[:color]].nil?
      inverted_bag_rule_base[val[:color]] = [col]
    else
      inverted_bag_rule_base[val[:color]] << col
    end
  end
end

def find_ancestors(inverted_bag_rule_base, key)
  puts "finding -- #{key}"
  results = inverted_bag_rule_base[key]
  return [] unless results
  parents = results.map do |result|
    results += find_ancestors(inverted_bag_rule_base, result)
  end

  return results
end

def find_total_bags(bag_rule_base, key)
  results = bag_rule_base[key]
  return 0 unless results
  return total unless results
  return results.sum do |result|
    result[:quantity].to_i + (result[:quantity].to_i * find_total_bags(bag_rule_base, result[:color]))
  end
end

puts bag_rule_base.inspect

puts find_total_bags(bag_rule_base, 'shiny gold')
