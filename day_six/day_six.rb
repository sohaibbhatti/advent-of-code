require 'set'

def get_uniq_element_unions(set_collection)
  set_collection.reduce(&:union)
end

def get_uniq_element_intersections(set_collection)
  set_collection.reduce(&:intersection)
end


grouping = []
total_count = 0
File.open("input.txt").each.with_index do |line, idx|
  parsed_line = line.chomp

  if parsed_line != ""
    grouping << Set.new(parsed_line.chars)
  else
    total_count += get_uniq_element_intersections(grouping).size
    grouping.clear
  end
end

total_count += get_uniq_element_intersections(grouping).size unless grouping.empty?

puts total_count
