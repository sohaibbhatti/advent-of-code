operations = []
File.open("input.txt").each do |line|
  current_op = line.chomp.split(" ")
  operations << { op: current_op[0], val: current_op[1].to_i, visited: false }
end

total = 0
index = 0
should_exit = false

while !should_exit do
  if operations[index][:visited]
    break
  end
  operations[index][:visited] = true
  if operations[index][:op] == "acc"
    total += operations[index][:val]
  elsif operations[index][:op] == "jmp"
    index += operations[index][:val]
    next
  end

  index += 1
end

puts total
