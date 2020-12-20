require 'set'
max_seat_id = 0
seat_ids = []
File.open("input.txt").each do |line|
  boarding_pass = line.chomp
  encoded_rows = boarding_pass[0..6]

  possible_start_range = 0
  possible_end_range = 127
  encoded_rows.chars.each do |val|
    if val == "F"
      # Lower Half
      possible_end_range = possible_start_range + ((possible_end_range - possible_start_range) / 2.0).floor
    elsif val == "B"
      # Upper Half
      possible_start_range  = possible_start_range + ((possible_end_range - possible_start_range) / 2.0).ceil
    end
  end

  boarding_pass_row = possible_start_range
  if possible_end_range != possible_start_range
    puts 'seems to be a problem'
  end

  encoded_cols = boarding_pass[-3..-1]
  possible_start_range = 0
  possible_end_range = 7
  encoded_cols.chars.each do |val|
    if val == "L"
      possible_end_range = possible_start_range + ((possible_end_range - possible_start_range) / 2.0).floor
    elsif val == "R"
      possible_start_range  = possible_start_range + ((possible_end_range - possible_start_range) / 2.0).ceil
    end
  end

  boarding_pass_col = possible_start_range
  if possible_end_range != possible_start_range
    puts 'seems to be a problem'
  end


  curr_seat_id = boarding_pass_row * 8 + boarding_pass_col

  seat_ids << curr_seat_id

  if curr_seat_id >= max_seat_id
    max_seat_id = curr_seat_id
  end
end

puts max_seat_id
ids = Set.new(seat_ids)
missing_id =  (ids.min..ids.max).find do |id|
  ids.include?(id - 1) && ids.include?(id + 1) && !ids.include?(id)
end
puts missing_id
