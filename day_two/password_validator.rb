require 'ostruct'

passwords = []

count = 0

def matching_with_count?(password_entry)
  num_occurances_of_term = password_entry.pass.count(password_entry.term)
  num_occurances_of_term >= password_entry.min && num_occurances_of_term <= password_entry.max
end

def matching_with_updated_policy?(password_entry)
  (password_entry.pass[password_entry.min - 1] == password_entry.term) ^
    (password_entry.pass[password_entry.max - 1] == password_entry.term)
end

file = File.open("input.txt").each do |line|
  lines = line.strip.split(' ')
  password = OpenStruct.new
  password.min, password.max = lines[0].split('-').map(&:to_i)
  password.term = lines[1].gsub(':', '')
  password.pass = lines[2]


  #count += 1 if matching_with_count?(password)
  count += 1 if matching_with_updated_policy?(password)

end

puts count
